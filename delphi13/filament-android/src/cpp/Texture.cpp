/*
 * Copyright (C) 2017 The Android Open Source Project
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

#include <jni.h>

#include <algorithm>
#include <functional>

#ifdef __ANDROID__
#include <android/bitmap.h>
#include <android/hardware_buffer_jni.h>
#include <backend/platforms/PlatformEGLAndroid.h>
#   if FILAMENT_SUPPORTS_VULKAN
#       include <backend/platforms/VulkanPlatformAndroid.h>
#   endif
#endif

#include <filament/Engine.h>
#include <filament/Stream.h>
#include <filament/Texture.h>

#include <filament-generatePrefilterMipmap/generatePrefilterMipmap.h>

#include <backend/BufferDescriptor.h>


using namespace filament;
using namespace backend;

extern "C" jboolean nIsTextureFormatSupported(jlong nativeEngine, jint internalFormat) {
    Engine *engine = (Engine *) nativeEngine;
    return (jboolean) Texture::isTextureFormatSupported(*engine,
            (Texture::InternalFormat) internalFormat);
}

extern "C" jboolean nIsTextureFormatMipmappable(jlong nativeEngine, jint internalFormat) {
    Engine *engine = (Engine *) nativeEngine;
    return (jboolean) Texture::isTextureFormatMipmappable(*engine,
            (Texture::InternalFormat) internalFormat);
}

extern "C" jboolean nIsTextureSwizzleSupported(jlong nativeEngine) {
    Engine *engine = (Engine *) nativeEngine;
    return (jboolean) Texture::isTextureSwizzleSupported(*engine);
}


extern "C" jint nGetMaxTextureSize(jlong nativeEngine, jint sampler) {
    Engine *engine = (Engine *) nativeEngine;
    return Texture::getMaxTextureSize(*engine, (Texture::Sampler)sampler);
}

extern "C" jint nGetMaxArrayTextureLayers(jlong nativeEngine) {
    Engine *engine = (Engine *) nativeEngine;
    return Texture::getMaxArrayTextureLayers(*engine);
}

extern "C" jboolean nValidatePixelFormatAndType(jint internalFormat, jint pixelDataFormat, jint pixelDataType) {
    return (jboolean) Texture::validatePixelFormatAndType(
        (Texture::InternalFormat) internalFormat,
        (Texture::Format) pixelDataFormat,
        (Texture::Type) pixelDataType
    );
}

// Texture::Builder...

extern "C" jlong nCreateBuilder() {
    return (jlong) new Texture::Builder();
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    delete builder;
}

extern "C" void nBuilderWidth(jlong nativeBuilder, jint width) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->width((uint32_t) width);
}

extern "C" void nBuilderHeight(jlong nativeBuilder, jint height) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->height((uint32_t) height);
}

extern "C" void nBuilderDepth(jlong nativeBuilder, jint depth) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->depth((uint32_t) depth);
}

extern "C" void nBuilderLevels(jlong nativeBuilder, jint levels) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->levels((uint8_t) levels);
}

extern "C" void nBuilderSampler(jlong nativeBuilder, jint sampler) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->sampler((Texture::Sampler) sampler);
}

extern "C" void nBuilderFormat(jlong nativeBuilder, jint format) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->format((Texture::InternalFormat) format);
}

extern "C" void nBuilderUsage(jlong nativeBuilder, jint flags) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->usage((Texture::Usage) flags);
}

extern "C" void nBuilderSwizzle(jlong nativeBuilder, jint r, jint g, jint b, jint a) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->swizzle(
            (Texture::Swizzle)r, (Texture::Swizzle)g, (Texture::Swizzle)b, (Texture::Swizzle)a);
}

extern "C" void nBuilderSamples(jlong nativeBuilder, jint samples) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->samples((uint8_t) samples);
}

extern "C"
void nBuilderImportTexture(jlong nativeBuilder, jlong id) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->import((intptr_t)id);
}

extern "C"
void nBuilderExternal(jlong nativeBuilder) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    builder->external();
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    Texture::Builder *builder = (Texture::Builder *) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

// Texture...

extern "C" jint nGetWidth(jlong nativeTexture,
        jint level) {
    Texture *texture = (Texture *) nativeTexture;
    return (jint) texture->getWidth((size_t) level);
}

extern "C" jint nGetHeight(jlong nativeTexture,
        jint level) {
    Texture *texture = (Texture *) nativeTexture;
    return (jint) texture->getHeight((size_t) level);
}

extern "C" jint nGetDepth(jlong nativeTexture,
        jint level) {
    Texture *texture = (Texture *) nativeTexture;
    return (jint) texture->getDepth((size_t) level);
}

extern "C" jint nGetLevels(jlong nativeTexture) {
    Texture *texture = (Texture *) nativeTexture;
    return (jint) texture->getLevels();
}

extern "C" jint nGetTarget(jlong nativeTexture) {
    Texture *texture = (Texture *) nativeTexture;
    return (jint) texture->getTarget();
}

extern "C" jint nGetInternalFormat(jlong nativeTexture) {
    Texture *texture = (Texture *) nativeTexture;
    return (jint) texture->getFormat();
}

extern "C" jint nSetImage3D(jlong nativeTexture,
        jlong nativeEngine, jint level,
        jint xoffset, jint yoffset, jint zoffset,
        jint width, jint height, jint depth,
        const void* data, jint sizeInBytes,
        jint left, jint top, jint type, jint alignment,
        jint stride, jint format) {
    Texture* texture = (Texture*) nativeTexture;
    Engine* engine = (Engine*) nativeEngine;
    Texture::PixelBufferDescriptor desc(data, (size_t)sizeInBytes, (backend::PixelDataFormat) format,
            (backend::PixelDataType) type, (uint8_t) alignment, (uint32_t) left, (uint32_t) top,
            (uint32_t) stride);
    texture->setImage(*engine, (size_t) level,
            (uint32_t) xoffset, (uint32_t) yoffset, (uint32_t) zoffset,
            (uint32_t) width, (uint32_t) height, (uint32_t) depth,
            std::move(desc));
    return 0;
}

extern "C" jint nSetImage3DCompressed(jlong nativeTexture, jlong nativeEngine, jint level,
        jint xoffset, jint yoffset, jint zoffset,
        jint width, jint height, jint depth,
        const void* data, jint sizeInBytes,
        jint compressedFormat) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;
    Texture::PixelBufferDescriptor desc(data, (size_t)sizeInBytes,
            (backend::CompressedPixelDataType) compressedFormat, (uint32_t) sizeInBytes);
    texture->setImage(*engine, (size_t) level,
            (uint32_t) xoffset, (uint32_t) yoffset, (uint32_t) zoffset,
            (uint32_t) width, (uint32_t) height, (uint32_t) depth,
            std::move(desc));
    return 0;
}

extern "C" jint nSetImageCubemap(jlong nativeTexture, jlong nativeEngine, jint level,
        const void* data, jint sizeInBytes,
        jint left, jint top, jint type, jint alignment, jint stride, jint format,
        jint* faceOffsetsInBytes) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;
    Texture::FaceOffsets faceOffsets;
    std::copy_n(faceOffsetsInBytes, 6, faceOffsets.offsets);
    Texture::PixelBufferDescriptor desc(data, (size_t)sizeInBytes, (backend::PixelDataFormat) format,
            (backend::PixelDataType) type, (uint8_t) alignment, (uint32_t) left, (uint32_t) top,
            (uint32_t) stride);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    texture->setImage(*engine, (size_t) level, std::move(desc), faceOffsets);
#pragma clang diagnostic pop
    return 0;
}

extern "C" jint nSetImageCubemapCompressed(jlong nativeTexture, jlong nativeEngine, jint level,
        const void* data, jint sizeInBytes,
        jint compressedFormat, jint* faceOffsetsInBytes) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;
    Texture::FaceOffsets faceOffsets;
    std::copy_n(faceOffsetsInBytes, 6, faceOffsets.offsets);
    Texture::PixelBufferDescriptor desc(data, (size_t)sizeInBytes,
            (backend::CompressedPixelDataType) compressedFormat, (uint32_t) sizeInBytes);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    texture->setImage(*engine, (size_t) level, std::move(desc), faceOffsets);
#pragma clang diagnostic pop
    return 0;
}

extern "C" void nSetExternalImage(jlong nativeTexture,
        jlong nativeEngine, jlong eglImage) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;
    texture->setExternalImage(*engine, (void*)eglImage);
}

extern "C"
jboolean nSetExternalImageByAHB(jlong nativeTexture, jlong nativeEngine, AHardwareBuffer* nativeBuffer) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;

#ifdef __ANDROID__
    if (!nativeBuffer) {
        return JNI_FALSE;
    }
    Platform* platform = engine->getPlatform();
    if (engine->getBackend() == Backend::OPENGL) {
#if UTILS_HAS_RTTI
        if (!dynamic_cast<PlatformEGLAndroid*>(platform)) {
            return JNI_FALSE;
        }
#endif
        auto* eglPlatform = (PlatformEGLAndroid*) platform;
        auto ref = eglPlatform->createExternalImage(nativeBuffer, false);
        texture->setExternalImage(*engine, ref);
    }
#if FILAMENT_SUPPORTS_VULKAN
    else if (engine->getBackend() == Backend::VULKAN) {
#if UTILS_HAS_RTTI
        if (!dynamic_cast<VulkanPlatformAndroid*>(platform)) {
            return JNI_FALSE;
        }
#endif
        auto* vulkanPlatform = (VulkanPlatformAndroid*) platform;
        auto ref = vulkanPlatform->createExternalImage(nativeBuffer, false);
        texture->setExternalImage(*engine, ref);
    }
#endif // FILAMENT_SUPPORTS_VULKAN
    return JNI_TRUE;
#else
    return JNI_FALSE;
#endif // __ANDROID__
}

extern "C" void nSetExternalStream(jlong nativeTexture, jlong nativeEngine, jlong nativeStream) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;
    Stream *stream = (Stream *) nativeStream;
    texture->setExternalStream(*engine, stream);
}

extern "C" void nGenerateMipmaps(jlong nativeTexture, jlong nativeEngine) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;
    texture->generateMipmaps(*engine);
}

extern "C"
jboolean nIsStreamValidForTexture(jlong nativeTexture, jlong) {
    Texture* texture = (Texture*) nativeTexture;
    return (jboolean) (texture->getTarget() == SamplerType::SAMPLER_EXTERNAL);
}

extern "C" jint nGeneratePrefilterMipmap(jlong nativeTexture, jlong nativeEngine, jint width, jint height,
        const void* data, jint sizeInBytes, jint left,
        jint top, jint type, jint alignment, jint stride, jint format,
        jint* faceOffsetsInBytes, jint sampleCount,
        jboolean mirror) {
    Texture *texture = (Texture *) nativeTexture;
    Engine *engine = (Engine *) nativeEngine;
    filament::FaceOffsets faceOffsets;
    std::copy_n(faceOffsetsInBytes, 6, faceOffsets.offsets);
    stride = stride ? stride : width;
    Texture::PixelBufferDescriptor desc(data, (size_t)sizeInBytes, (backend::PixelDataFormat) format,
            (backend::PixelDataType) type, (uint8_t) alignment,
            (uint32_t) left, (uint32_t) top, (uint32_t) stride);
    filament::PrefilterOptions options;
    options.sampleCount = sampleCount;
    options.mirror = mirror;
    filament::generatePrefilterMipmap(texture, *engine, std::move(desc), faceOffsets, &options);
    return 0;
}

// Android Bitmap functions (nSetBitmap, nSetBitmapWithCallback) removed —
// Android Bitmap is a Java object and cannot be used from native Delphi code.
