/*
 * Copyright (C) 2026 The Android Open Source Project
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
// 変換: Java_com_google_android_filament_utils_ImageDiff_ プレフィックス除去
//       JNIEnv*, jclass 第1・第2引数除去
//       Android Bitmap (jobject) → 生ピクセルデータ (const void* pixels, jint width, jint height, jint stride)
//       jobject Result → ImageDiffResult_C 構造体ポインタ (out 引数)
//
// 注: android/bitmap.h への依存をすべて除去。
//     Delphi 側で ARGB_8888 形式のピクセルバッファを用意して渡すこと。

#include <jni.h>

#include <imagediff/ImageDiff.h>
#include <utils/Log.h>

#include <vector>

using namespace imagediff;
using namespace utils;

// =============================================================================
// Output struct (replaces Java Result jobject)
// status: 0=PASSED, 1=SIZE_MISMATCH, 2=PIXEL_DIFFERENCE
// =============================================================================

struct ImageDiffResult_C {
    jint  status;
    jlong failingPixelCount;
    float maxDiffFound[4];
};

// =============================================================================
// nCompareBasic
//   ref/cand/mask: ARGB_8888 raw pixel buffers; stride in bytes; mask may be nullptr
// =============================================================================

extern "C" void nCompareBasic(
        const void* refPixels,  jint refWidth,  jint refHeight,  jint refStride,
        const void* candPixels, jint candWidth, jint candHeight, jint candStride,
        jint mode, jint swizzle, jint channelMask,
        jfloat maxAbsDiff, jfloat maxFailingPixelsFraction,
        const void* maskPixels, jint maskWidth, jint maskHeight, jint maskStride,
        ImageDiffResult_C* outResult) {

    if (!outResult) return;

    if (!refPixels || !candPixels) {
        outResult->status           = 1; // SIZE_MISMATCH / invalid
        outResult->failingPixelCount = 0;
        outResult->maxDiffFound[0] = outResult->maxDiffFound[1] =
        outResult->maxDiffFound[2] = outResult->maxDiffFound[3] = 0.0f;
        return;
    }

    imagediff::Bitmap ref = {
        .width  = (uint32_t) refWidth,
        .height = (uint32_t) refHeight,
        .stride = (size_t)   refStride,
        .data   = const_cast<void*>(refPixels)
    };
    imagediff::Bitmap cand = {
        .width  = (uint32_t) candWidth,
        .height = (uint32_t) candHeight,
        .stride = (size_t)   candStride,
        .data   = const_cast<void*>(candPixels)
    };

    ImageDiffConfig config;
    config.mode                     = (ImageDiffConfig::Mode)    mode;
    config.swizzle                  = (ImageDiffConfig::Swizzle) swizzle;
    config.channelMask              = (uint8_t) channelMask;
    config.maxAbsDiff               = maxAbsDiff;
    config.maxFailingPixelsFraction = maxFailingPixelsFraction;

    imagediff::Bitmap const* maskPtr = nullptr;
    imagediff::Bitmap maskBitmap;
    if (maskPixels) {
        maskBitmap = {
            .width  = (uint32_t) maskWidth,
            .height = (uint32_t) maskHeight,
            .stride = (size_t)   maskStride,
            .data   = const_cast<void*>(maskPixels)
        };
        maskPtr = &maskBitmap;
    }

    ImageDiffResult result = compare(ref, cand, config, maskPtr, false);

    outResult->status            = (jint) result.status;
    outResult->failingPixelCount = (jlong) result.failingPixelCount;
    for (int i = 0; i < 4; ++i) outResult->maxDiffFound[i] = result.maxDiffFound[i];
}

// =============================================================================
// nCompareJson
//   jsonConfig: UTF-8 JSON config string; mask may be nullptr
// =============================================================================

extern "C" void nCompareJson(
        const void* refPixels,  jint refWidth,  jint refHeight,  jint refStride,
        const void* candPixels, jint candWidth, jint candHeight, jint candStride,
        const char* jsonConfig,
        const void* maskPixels, jint maskWidth, jint maskHeight, jint maskStride,
        ImageDiffResult_C* outResult) {

    if (!outResult) return;

    if (!refPixels || !candPixels || !jsonConfig) {
        outResult->status            = 1;
        outResult->failingPixelCount = 0;
        outResult->maxDiffFound[0]   = outResult->maxDiffFound[1] =
        outResult->maxDiffFound[2]   = outResult->maxDiffFound[3] = 0.0f;
        return;
    }

    imagediff::Bitmap ref = {
        .width  = (uint32_t) refWidth,
        .height = (uint32_t) refHeight,
        .stride = (size_t)   refStride,
        .data   = const_cast<void*>(refPixels)
    };
    imagediff::Bitmap cand = {
        .width  = (uint32_t) candWidth,
        .height = (uint32_t) candHeight,
        .stride = (size_t)   candStride,
        .data   = const_cast<void*>(candPixels)
    };

    ImageDiffConfig config;
    bool parsed = parseConfig(jsonConfig, strlen(jsonConfig), &config);
    if (!parsed) {
        slog.e << "ImageDiff: Failed to parse JSON config" << io::endl;
        outResult->status            = 1;
        outResult->failingPixelCount = 0;
        outResult->maxDiffFound[0]   = outResult->maxDiffFound[1] =
        outResult->maxDiffFound[2]   = outResult->maxDiffFound[3] = 0.0f;
        return;
    }

    imagediff::Bitmap const* maskPtr = nullptr;
    imagediff::Bitmap maskBitmap;
    if (maskPixels) {
        maskBitmap = {
            .width  = (uint32_t) maskWidth,
            .height = (uint32_t) maskHeight,
            .stride = (size_t)   maskStride,
            .data   = const_cast<void*>(maskPixels)
        };
        maskPtr = &maskBitmap;
    }

    ImageDiffResult result = compare(ref, cand, config, maskPtr, false);

    outResult->status            = (jint)  result.status;
    outResult->failingPixelCount = (jlong) result.failingPixelCount;
    for (int i = 0; i < 4; ++i) outResult->maxDiffFound[i] = result.maxDiffFound[i];
}
