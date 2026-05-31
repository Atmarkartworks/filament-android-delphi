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

#include <jni.h>

#include <functional>
#include <stdlib.h>
#include <string.h>

#include <filament/SkinningBuffer.h>


using namespace filament;
using namespace backend;

extern "C"
jlong nCreateBuilder() {
    return (jlong) new SkinningBuffer::Builder();
}

extern "C"
void nDestroyBuilder(jlong nativeBuilder) {
    SkinningBuffer::Builder* builder = (SkinningBuffer::Builder *) nativeBuilder;
    delete builder;
}

extern "C"
void nBuilderBoneCount(jlong nativeBuilder, jint boneCount) {
    SkinningBuffer::Builder* builder = (SkinningBuffer::Builder *) nativeBuilder;
    builder->boneCount((uint32_t)boneCount);
}

extern "C"
void nBuilderInitialize(jlong nativeBuilder, jboolean initialize) {
    SkinningBuffer::Builder* builder = (SkinningBuffer::Builder *) nativeBuilder;
    builder->initialize((bool)initialize);
}

extern "C"
jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    SkinningBuffer::Builder* builder = (SkinningBuffer::Builder *) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

// ------------------------------------------------------------------------------------------------

extern "C"
jint nSetBonesAsMatrices(jlong nativeSkinningBuffer, jlong nativeEngine, const void* matrices, jint boneCount,
        jint offset) {
    SkinningBuffer *skinningBuffer = (SkinningBuffer *) nativeSkinningBuffer;
    Engine *engine = (Engine *) nativeEngine;
    skinningBuffer->setBones(*engine,
            static_cast<filament::math::mat4f const *>(matrices), (size_t)boneCount, (size_t)offset);
    return 0;
}

extern "C"
jint nSetBonesAsQuaternions(jlong nativeSkinningBuffer, jlong nativeEngine, const void* quaternions,
        jint boneCount, jint offset) {
    SkinningBuffer *skinningBuffer = (SkinningBuffer *) nativeSkinningBuffer;
    Engine *engine = (Engine *) nativeEngine;
    skinningBuffer->setBones(*engine,
            static_cast<RenderableManager::Bone const *>(quaternions), (size_t)boneCount, (size_t)offset);
    return 0;
}

extern "C"
jint nGetBoneCount(jlong nativeSkinningBuffer) {
    SkinningBuffer *skinningBuffer = (SkinningBuffer *) nativeSkinningBuffer;
    return (jint)skinningBuffer->getBoneCount();
}

