/*
 * Copyright (C) 2021 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Delphi13 変換済み — JNI 除去版
// 変換: AutoBuffer (NioUtils) 除去 → const void* buffer + jint size に置換
//       JNI_OnLoad/RegisterNatives パターン除去
//       extern "C" nCreateHDRTexture として直接公開

#include <jni.h>

#include <filament/Engine.h>
#include <filament/Texture.h>

#include <imageio/HDRDecoder.h>

#include <utils/Log.h>

#include <sstream>

using namespace filament;
using namespace image;
using namespace utils;

using PixelBufferDescriptor = Texture::PixelBufferDescriptor;

// buffer: raw HDR file bytes; size: byte count
// internalFormat: Texture::InternalFormat as integer
extern "C" jlong nCreateHDRTexture(jlong nativeEngine,
        const void* buffer, jint size, jint internalFormat) {

    Engine* engine = (Engine*) nativeEngine;
    Texture::InternalFormat textureFormat = (Texture::InternalFormat) internalFormat;

    // Copy into a string stream for HDRDecoder
    std::string ins(static_cast<const char*>(buffer), (size_t) size);
    std::istringstream in(ins);

    LinearImage* image = new LinearImage(ImageDecoder::decode(in, "memory.hdr"));

    if (image->getChannels() != 3) {
        delete image;
        return 0;
    }

    Texture* texture = Texture::Builder()
        .width(image->getWidth())
        .height(image->getHeight())
        .levels(0xff)
        .sampler(Texture::Sampler::SAMPLER_2D)
        .usage(Texture::Usage::DEFAULT | Texture::Usage::GEN_MIPMAPPABLE)
        .format(textureFormat)
        .build(*engine);

    if (texture == nullptr) {
        slog.e << "Unable to create Filament Texture from HDR image." << io::endl;
        delete image;
        return 0;
    }

    PixelBufferDescriptor::Callback freeCallback = [](void* buf, size_t, void* userdata) {
        delete (LinearImage*) userdata;
    };

    PixelBufferDescriptor pbd(
        (void const*) image->getPixelRef(),
        image->getWidth() * image->getHeight() * 3 * sizeof(float),
        PixelBufferDescriptor::PixelDataFormat::RGB,
        PixelBufferDescriptor::PixelDataType::FLOAT,
        freeCallback,
        image);

    texture->setImage(*engine, 0, std::move(pbd));
    texture->generateMipmaps(*engine);

    return (jlong) texture;
}
