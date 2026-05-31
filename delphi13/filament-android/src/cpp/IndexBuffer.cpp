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

#include <functional>
#include <stdlib.h>
#include <string.h>

#include <filament/IndexBuffer.h>

#include <backend/BufferDescriptor.h>


using namespace filament;
using namespace backend;

extern "C" jlong nCreateBuilder() {
    return (jlong) new IndexBuffer::Builder();
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    IndexBuffer::Builder* builder = (IndexBuffer::Builder *) nativeBuilder;
    delete builder;
}

extern "C" void nBuilderIndexCount(jlong nativeBuilder, jint indexCount) {
    IndexBuffer::Builder* builder = (IndexBuffer::Builder *) nativeBuilder;
    builder->indexCount((uint32_t) indexCount);
}

extern "C" void nBuilderBufferType(jlong nativeBuilder, jint indexType) {
    using IndexType = IndexBuffer::IndexType;
    IndexBuffer::Builder* builder = (IndexBuffer::Builder *) nativeBuilder;
    IndexType types[] = {IndexType::USHORT, IndexType::UINT};
    builder->bufferType(types[indexType & 1]);
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    IndexBuffer::Builder* builder = (IndexBuffer::Builder *) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

extern "C" jint nGetIndexCount(jlong nativeIndexBuffer) {
    IndexBuffer *indexBuffer = (IndexBuffer *) nativeIndexBuffer;
    return (jint) indexBuffer->getIndexCount();
}

extern "C" int nSetBuffer(jlong nativeIndexBuffer, jlong nativeEngine, const void* data, jint sizeInBytes,
        jint destOffsetInBytes) {
    IndexBuffer *indexBuffer = (IndexBuffer *) nativeIndexBuffer;
    Engine *engine = (Engine *) nativeEngine;
    BufferDescriptor desc(data, (size_t)sizeInBytes);
    indexBuffer->setBuffer(*engine, std::move(desc), (uint32_t) destOffsetInBytes);
    return 0;
}

