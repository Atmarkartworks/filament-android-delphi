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

#include <filament/ColorGrading.h>
#include <filament/ToneMapper.h>

#include <math/vec3.h>
#include <math/vec4.h>

using namespace filament;
using namespace math;

extern "C" jlong nCreateBuilder() {
    return (jlong) new ColorGrading::Builder();
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    delete builder;
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

extern "C" void nBuilderQuality(jlong nativeBuilder, jint quality_) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    ColorGrading::QualityLevel quality = (ColorGrading::QualityLevel) quality_;
    builder->quality(quality);
}

extern "C" void nBuilderFormat(jlong nativeBuilder, jint format_) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    ColorGrading::LutFormat format = (ColorGrading::LutFormat) format_;
    builder->format(format);
}

extern "C" void nBuilderDimensions(jlong nativeBuilder, jint dim_) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->dimensions((uint8_t)dim_);
}

extern "C" void nBuilderToneMapper(jlong nativeBuilder, jlong toneMapper_) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    const ToneMapper* toneMapper = (const ToneMapper*) toneMapper_;
    builder->toneMapper(toneMapper);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
extern "C" void nBuilderToneMapping(jlong nativeBuilder, jint toneMapping_) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    ColorGrading::ToneMapping toneMapping = (ColorGrading::ToneMapping) toneMapping_;
    builder->toneMapping(toneMapping);
}
#pragma clang diagnostic pop

extern "C" void nBuilderLuminanceScaling(jlong nativeBuilder, jboolean luminanceScaling) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->luminanceScaling(luminanceScaling);
}

extern "C" void nBuilderGamutMapping(jlong nativeBuilder, jboolean gamutMapping) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->gamutMapping(gamutMapping);
}

extern "C" void nBuilderExposure(jlong nativeBuilder, jfloat exposure) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->exposure(exposure);
}

extern "C" void nBuilderNightAdaptation(jlong nativeBuilder, jfloat adaptation) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->nightAdaptation(adaptation);
}

extern "C" void nBuilderWhiteBalance(jlong nativeBuilder, jfloat temperature, jfloat tint) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->whiteBalance(temperature, tint);
}

extern "C" void nBuilderChannelMixer(jlong nativeBuilder, float* outRed, float* outGreen, float* outBlue) {


    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->channelMixer(
            *reinterpret_cast<float3*>(outRed),
            *reinterpret_cast<float3*>(outGreen),
            *reinterpret_cast<float3*>(outBlue));

}

extern "C"
void nBuilderShadowsMidtonesHighlights(jlong nativeBuilder,
        float* shadows, float* midtones, float* highlights, float* ranges) {


    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->shadowsMidtonesHighlights(
            *reinterpret_cast<float4*>(shadows),
            *reinterpret_cast<float4*>(midtones),
            *reinterpret_cast<float4*>(highlights),
            *reinterpret_cast<float4*>(ranges));

}

extern "C" void nBuilderSlopeOffsetPower(jlong nativeBuilder, float* slope, float* offset, float* power) {


    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->slopeOffsetPower(
            *reinterpret_cast<float3*>(slope),
            *reinterpret_cast<float3*>(offset),
            *reinterpret_cast<float3*>(power));

}

extern "C"
void nBuilderContrast(jlong nativeBuilder, jfloat contrast) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->contrast(contrast);
}

extern "C"
void nBuilderVibrance(jlong nativeBuilder, jfloat vibrance) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->vibrance(vibrance);
}

extern "C"
void nBuilderSaturation(jlong nativeBuilder, jfloat saturation) {
    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->saturation(saturation);
}

extern "C" void nBuilderCurves(jlong nativeBuilder, float* gamma, float* midPoint, float* scale) {


    ColorGrading::Builder* builder = (ColorGrading::Builder*) nativeBuilder;
    builder->curves(
            *reinterpret_cast<float3*>(gamma),
            *reinterpret_cast<float3*>(midPoint),
            *reinterpret_cast<float3*>(scale));

}

