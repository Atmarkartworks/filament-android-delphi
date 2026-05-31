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

#include <assert.h>

#include <jni.h>

#include <filament/Stream.h>
#include <backend/PixelBufferDescriptor.h>


#ifdef __ANDROID__

#if __has_include(<android/hardware_buffer_jni.h>)
#include <android/hardware_buffer_jni.h>
#else
struct AHardwareBuffer;
typedef struct AHardwareBuffer AHardwareBuffer;
#endif

#endif

using namespace filament;
using namespace backend;

class StreamBuilder {
public:
    StreamBuilder() noexcept {
        mBuilder = new Stream::Builder{};
    }

    ~StreamBuilder() {
        delete mBuilder;
    }

    Stream::Builder* builder() const noexcept { return mBuilder; }

    void setStreamSource(void* surface) noexcept {
        mBuilder->stream(surface);
    }

private:
    Stream::Builder* mBuilder = nullptr;
};

extern "C" jlong nCreateBuilder() {
    return (jlong) new StreamBuilder{};
}

extern "C" void nDestroyBuilder(jlong nativeStreamBuilder) {
    StreamBuilder* builder = (StreamBuilder*) nativeStreamBuilder;
    delete builder;
}

extern "C" void nBuilderStreamSource(jlong nativeStreamBuilder, void* surface) {
    StreamBuilder* builder = (StreamBuilder*) nativeStreamBuilder;
    builder->setStreamSource(surface);
}

extern "C" void nBuilderWidth(jlong nativeStreamBuilder, jint width) {
    StreamBuilder* builder = (StreamBuilder*) nativeStreamBuilder;
    builder->builder()->width((uint32_t) width);
}

extern "C" void nBuilderHeight(jlong nativeStreamBuilder, jint height) {
    StreamBuilder* builder = (StreamBuilder*) nativeStreamBuilder;
    builder->builder()->height((uint32_t) height);
}

extern "C" jlong nBuilderBuild(jlong nativeStreamBuilder, jlong nativeEngine) {
    StreamBuilder* builder = (StreamBuilder*) nativeStreamBuilder;
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) builder->builder()->build(*engine);
}

extern "C" jint nGetStreamType(jlong nativeStream) {
    Stream* stream = (Stream*) nativeStream;
    return (jint) stream->getStreamType();
}

extern "C" void nSetDimensions(jlong nativeStream,
        jint width, jint height) {
    Stream* stream = (Stream*) nativeStream;
    stream->setDimensions((uint32_t) width, (uint32_t) height);
}

extern "C" jlong nGetTimestamp(jlong nativeStream) {
    Stream *stream = (Stream *) nativeStream;
    return stream->getTimestamp();
}

extern "C" void nSetAcquiredImage(jlong nativeStream,
        jlong nativeEngine, AHardwareBuffer* nativeBuffer) {
    Engine* engine = (Engine*) nativeEngine;
    Stream* stream = (Stream*) nativeStream;
    stream->setAcquiredImage((void*) nativeBuffer, nullptr, nullptr, nullptr);
}

