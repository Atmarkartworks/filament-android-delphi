/*
 * Copyright (C) 2019 The Android Open Source Project
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

#include <functional>
#include <stdlib.h>
#include <string.h>

#include <filament/RenderTarget.h>

using namespace filament;
using namespace backend;

extern "C" jlong nCreateBuilder() {
    return (jlong) new RenderTarget::Builder();
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    RenderTarget::Builder* builder = (RenderTarget::Builder*) nativeBuilder;
    delete builder;
}

extern "C" void nBuilderTexture(jlong nativeBuilder, jint attachment, jlong nativeTexture) {
    RenderTarget::Builder* builder = (RenderTarget::Builder*) nativeBuilder;
    Texture* texture = (Texture*) nativeTexture;
    builder->texture(RenderTarget::AttachmentPoint(attachment), texture);
}

extern "C" void nBuilderMipLevel(jlong nativeBuilder, jint attachment, jint level) {
    RenderTarget::Builder* builder = (RenderTarget::Builder*) nativeBuilder;
    builder->mipLevel(RenderTarget::AttachmentPoint(attachment), level);
}

extern "C" void nBuilderFace(jlong nativeBuilder, jint attachment, jint face) {
    RenderTarget::Builder* builder = (RenderTarget::Builder*) nativeBuilder;
    RenderTarget::CubemapFace cubeface = (RenderTarget::CubemapFace) face;
    builder->face(RenderTarget::AttachmentPoint(attachment), cubeface);
}

extern "C" void nBuilderLayer(jlong nativeBuilder, jint attachment, jint layer) {
    RenderTarget::Builder* builder = (RenderTarget::Builder*) nativeBuilder;
    builder->layer(RenderTarget::AttachmentPoint(attachment), layer);
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    RenderTarget::Builder* builder = (RenderTarget::Builder*) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

extern "C" jint nGetMipLevel(jlong nativeTarget, jint attachment) {
    RenderTarget* target = (RenderTarget*) nativeTarget;
    return (jint) target->getMipLevel(RenderTarget::AttachmentPoint(attachment));
}

extern "C" jint nGetFace(long nativeTarget, int attachment) {
    RenderTarget* target = (RenderTarget*) nativeTarget;
    return (jint) target->getFace(RenderTarget::AttachmentPoint(attachment));
}

extern "C" jint nGetLayer(long nativeTarget, int attachment) {
    RenderTarget* target = (RenderTarget*) nativeTarget;
    return (jint) target->getLayer(RenderTarget::AttachmentPoint(attachment));
}

