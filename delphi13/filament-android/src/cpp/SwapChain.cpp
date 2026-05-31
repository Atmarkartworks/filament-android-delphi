/*
 * Copyright (C) 2020 The Android Open Source Project
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

#include <filament/Engine.h>
#include <filament/SwapChain.h>

using namespace filament;

typedef void (*SwapChainCallback)(jlong nativeSwapChain);

extern "C" void nSetFrameCompletedCallback(jlong nativeSwapChain, SwapChainCallback callback) {
    SwapChain* swapChain = (SwapChain*) nativeSwapChain;
    swapChain->setFrameCompletedCallback(nullptr,
            [nativeSwapChain, callback](SwapChain*) {
                if (callback) callback(nativeSwapChain);
            });
}

extern "C" jboolean nIsSRGBSwapChainSupported(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jboolean)SwapChain::isSRGBSwapChainSupported(*engine);
}

extern "C" jboolean nIsMSAASwapChainSupported(jlong nativeEngine, jint samples) {
    Engine* engine = (Engine*) nativeEngine;
    return (jboolean)SwapChain::isMSAASwapChainSupported(*engine, samples);
}

extern "C" jboolean nIsProtectedContentSupported(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jboolean)SwapChain::isProtectedContentSupported(*engine);
}

typedef void (*FrameScheduledCallback)(jlong nativeSwapChain);

extern "C" void nSetFrameScheduledCallback(jlong nativeSwapChain, FrameScheduledCallback callback) {
    SwapChain* swapChain = (SwapChain*) nativeSwapChain;
    swapChain->setFrameScheduledCallback(nullptr,
            [nativeSwapChain, callback](backend::PresentCallable) {
                if (callback) callback(nativeSwapChain);
            });
}

extern "C" jboolean nIsFrameScheduledCallbackSet(jlong nativeSwapChain) {
    SwapChain* swapChain = (SwapChain*) nativeSwapChain;
    return (jboolean)swapChain->isFrameScheduledCallbackSet();
}

