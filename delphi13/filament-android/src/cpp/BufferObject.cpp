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

#include <filament/BufferObject.h>

#include <backend/BufferDescriptor.h>


using namespace filament;
using namespace backend;

extern "C" jlong nCreateBuilder() {
    return (jlong) new BufferObject::Builder();
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    BufferObject::Builder* builder = (BufferObject::Builder *) nativeBuilder;
    delete builder;
}

extern "C" void nBuilderSize(jlong nativeBuilder, jint byteCount) {
    BufferObject::Builder* builder = (BufferObject::Builder *) nativeBuilder;
    builder->size((uint32_t) byteCount);
}

extern "C" void nBuilderBindingType(jlong nativeBuilder, jint bindingType) {
    using BindingType = BufferObject::BindingType;
    BufferObject::Builder* builder = (BufferObject::Builder *) nativeBuilder;
    BindingType types[] = {BindingType::VERTEX};
    builder->bindingType(types[bindingType]);
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    BufferObject::Builder* builder = (BufferObject::Builder *) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

extern "C" jint nGetByteCount(jlong nativeBufferObject) {
    BufferObject *bufferObject = (BufferObject *) nativeBufferObject;
    return (jint) bufferObject->getByteCount();
}

extern "C" int nSetBuffer(jlong nativeBufferObject, jlong nativeEngine, const void* data, jint sizeInBytes,
        jint destOffsetInBytes) {
    BufferObject *bufferObject = (BufferObject *) nativeBufferObject;
    Engine *engine = (Engine *) nativeEngine;
    BufferDescriptor desc(data, (size_t)sizeInBytes);
    bufferObject->setBuffer(*engine, std::move(desc), (uint32_t) destOffsetInBytes);
    return 0;
}

