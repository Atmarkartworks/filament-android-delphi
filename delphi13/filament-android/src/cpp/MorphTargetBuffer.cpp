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

#include <filament/MorphTargetBuffer.h>


using namespace filament;
using namespace backend;

extern "C"
jlong nCreateBuilder() {
    return (jlong) new MorphTargetBuffer::Builder();
}

extern "C"
void nDestroyBuilder(jlong nativeBuilder) {
    MorphTargetBuffer::Builder* builder = (MorphTargetBuffer::Builder *) nativeBuilder;
    delete builder;
}

extern "C"
void nBuilderVertexCount(jlong nativeBuilder, jint vertexCount) {
    MorphTargetBuffer::Builder* builder = (MorphTargetBuffer::Builder *) nativeBuilder;
    builder->vertexCount((size_t) vertexCount);
}

extern "C"
void nBuilderCount(jlong nativeBuilder, jint count) {
    MorphTargetBuffer::Builder* builder = (MorphTargetBuffer::Builder *) nativeBuilder;
    builder->count((size_t) count);
}

extern "C" void         nBuilderWithPositions(jlong nativeBuilder, jboolean enabled) {
    MorphTargetBuffer::Builder* builder = (MorphTargetBuffer::Builder*) nativeBuilder;
    builder->withPositions(enabled);
}

extern "C" void         nBuilderWithTangents(jlong nativeBuilder, jboolean enabled) {
    MorphTargetBuffer::Builder* builder = (MorphTargetBuffer::Builder*) nativeBuilder;
    builder->withTangents(enabled);
}

extern "C" void         nBuilderEnableCustomMorphing(jlong nativeBuilder, jboolean enabled) {
    MorphTargetBuffer::Builder* builder = (MorphTargetBuffer::Builder*) nativeBuilder;
    builder->enableCustomMorphing(enabled);
}

extern "C"
jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    MorphTargetBuffer::Builder* builder = (MorphTargetBuffer::Builder *) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

// ------------------------------------------------------------------------------------------------

extern "C"
jint nSetPositionsAt(jlong nativeObject, jlong nativeEngine,
        jint targetIndex, const float* positions, jint count) {
    MorphTargetBuffer *morphTargetBuffer = (MorphTargetBuffer *) nativeObject;
    Engine *engine = (Engine *) nativeEngine;
    morphTargetBuffer->setPositionsAt(*engine, targetIndex,
            (math::float4*) positions, size_t(count));
    return 0;
}

extern "C"
jint nSetTangentsAt(jlong nativeObject, jlong nativeEngine,
        jint targetIndex, const jshort* tangents, jint count) {
    MorphTargetBuffer *morphTargetBuffer = (MorphTargetBuffer *) nativeObject;
    Engine *engine = (Engine *) nativeEngine;
    morphTargetBuffer->setTangentsAt(*engine, targetIndex,
            (math::short4*) tangents, size_t(count));
    return 0;
}

extern "C"
jint nGetVertexCount(jlong nativeObject) {
    MorphTargetBuffer *morphTargetBuffer = (MorphTargetBuffer *) nativeObject;
    return (jint)morphTargetBuffer->getVertexCount();
}

extern "C"
jint nGetCount(jlong nativeObject) {
    MorphTargetBuffer *morphTargetBuffer = (MorphTargetBuffer *) nativeObject;
    return (jint)morphTargetBuffer->getCount();
}

extern "C" jboolean         nHasPositions(jlong nativeObject) {
    MorphTargetBuffer* morphTargetBuffer = (MorphTargetBuffer*) nativeObject;
    return (jboolean) morphTargetBuffer->hasPositions();
}

extern "C" jboolean         nHasTangents(jlong nativeObject) {
    MorphTargetBuffer* morphTargetBuffer = (MorphTargetBuffer*) nativeObject;
    return (jboolean) morphTargetBuffer->hasTangents();
}

extern "C" jboolean         nIsCustomMorphingEnabled(jlong nativeObject) {
    MorphTargetBuffer* morphTargetBuffer = (MorphTargetBuffer*) nativeObject;
    return (jboolean) morphTargetBuffer->isCustomMorphingEnabled();
}

