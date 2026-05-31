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

#include <filament/Engine.h>
#include <filament/Renderer.h>
#include <filament/Viewport.h>
#include <backend/PixelBufferDescriptor.h>


using namespace filament;
using namespace backend;


extern "C" void nSkipFrame(jlong nativeRenderer,
        jlong vsyncSteadyClockTimeNano) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->skipFrame(uint64_t(vsyncSteadyClockTimeNano));
}

extern "C" jboolean nShouldRenderFrame(jlong nativeRenderer) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    return (jboolean) renderer->shouldRenderFrame();
}

extern "C" jboolean nBeginFrame(jlong nativeRenderer,
        jlong nativeSwapChain, jlong frameTimeNanos) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    SwapChain *swapChain = (SwapChain *) nativeSwapChain;
    return (jboolean) renderer->beginFrame(swapChain, uint64_t(frameTimeNanos));
}

extern "C" void nEndFrame(jlong nativeRenderer) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->endFrame();
}

extern "C" void nRender(jlong nativeRenderer,
        jlong nativeView) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    View *view = (View *) nativeView;
    renderer->render(view);
}

extern "C" void nRenderStandaloneView(jlong nativeRenderer,
        jlong nativeView) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    View *view = (View *) nativeView;
    renderer->renderStandaloneView(view);
}

extern "C" void nCopyFrame(jlong nativeRenderer,
        jlong nativeDstSwapChain,
        jint dstLeft, jint dstBottom, jint dstWidth, jint dstHeight,
        jint srcLeft, jint srcBottom, jint srcWidth, jint srcHeight,
        jint flags) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    SwapChain *dstSwapChain = (SwapChain *) nativeDstSwapChain;
    const filament::Viewport dstViewport {dstLeft, dstBottom, (uint32_t) dstWidth, (uint32_t) dstHeight};
    const filament::Viewport srcViewport {srcLeft, srcBottom, (uint32_t) srcWidth, (uint32_t) srcHeight};
    renderer->copyFrame(dstSwapChain, dstViewport, srcViewport, (uint32_t) flags);
}

extern "C" jint nReadPixels(jlong nativeRenderer, jlong nativeEngine,
        jint xoffset, jint yoffset, jint width, jint height,
        void* buffer, jint sizeInBytes,
        jint left, jint top, jint type, jint alignment, jint stride, jint format) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    Engine *engine = (Engine *) nativeEngine;
    stride = stride ? stride : width;
    PixelBufferDescriptor desc(buffer, (size_t)sizeInBytes, (backend::PixelDataFormat) format,
            (backend::PixelDataType) type, (uint8_t) alignment, (uint32_t) left, (uint32_t) top,
            (uint32_t) stride);
    renderer->readPixels(uint32_t(xoffset), uint32_t(yoffset), uint32_t(width), uint32_t(height),
            std::move(desc));
    return 0;
}

extern "C" jint nReadPixelsEx(jlong nativeRenderer, jlong nativeEngine, jlong nativeRenderTarget,
        jint xoffset, jint yoffset, jint width, jint height,
        void* buffer, jint sizeInBytes,
        jint left, jint top, jint type, jint alignment, jint stride, jint format) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    Engine *engine = (Engine *) nativeEngine;
    RenderTarget *renderTarget = (RenderTarget *) nativeRenderTarget;
    stride = stride ? stride : width;
    PixelBufferDescriptor desc(buffer, (size_t)sizeInBytes, (backend::PixelDataFormat) format,
            (backend::PixelDataType) type, (uint8_t) alignment, (uint32_t) left, (uint32_t) top,
            (uint32_t) stride);
    renderer->readPixels(renderTarget,
            uint32_t(xoffset), uint32_t(yoffset), uint32_t(width), uint32_t(height),
            std::move(desc));
    return 0;
}

extern "C" jdouble nGetUserTime(jlong nativeRenderer) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    return renderer->getUserTime();
}

extern "C" void nResetUserTime(jlong nativeRenderer) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->resetUserTime();
}

extern "C" void nSetDisplayInfo(jlong nativeRenderer, jfloat refreshRate) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->setDisplayInfo({ .refreshRate = refreshRate });
}

extern "C" void nSetFrameRateOptions(jlong nativeRenderer, jfloat interval, jfloat headRoomRatio, jfloat scaleRate, jint history) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->setFrameRateOptions({ .headRoomRatio = headRoomRatio,
                                     .scaleRate = scaleRate,
                                     .history = (uint8_t)history,
                                     .interval = (uint8_t)interval });
}

extern "C" void nSetClearOptions(jlong nativeRenderer, jfloat r, jfloat g, jfloat b, jfloat a,
        jboolean clear, jboolean discard) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->setClearOptions({ .clearColor = {r, g, b, a},
                                .clear = (bool) clear,
                                .discard = (bool) discard});
}

extern "C" void nSetPresentationTime(jlong nativeRenderer, jlong monotonicClockNanos) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->setPresentationTime(monotonicClockNanos);
}

extern "C" void nSetVsyncTime(jlong nativeRenderer, jlong steadyClockTimeNano) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->setVsyncTime(steadyClockTimeNano);
}

extern "C"
void nSkipNextFrames(jlong nativeRenderer, jint frameCount) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    renderer->skipNextFrames(frameCount);
}

extern "C"
jint nGetFrameToSkipCount(jlong nativeRenderer) {
    Renderer *renderer = (Renderer *) nativeRenderer;
    return renderer->getFrameToSkipCount();
}

