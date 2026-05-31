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

#include <filament/Color.h>
#include <filament/View.h>
#include <filament/Viewport.h>


#include "private/backend/VirtualMachineEnv.h"

using namespace filament;

extern "C" void nSetName(jlong nativeView, const char* name) {
    View* view = (View*) nativeView;
    view->setName(name);
}

extern "C" void nSetScene(jlong nativeView, jlong nativeScene) {
    View* view = (View*) nativeView;
    Scene* scene = (Scene*) nativeScene;
    view->setScene(scene);
}

extern "C" void nSetCamera(jlong nativeView, jlong nativeCamera) {
    View* view = (View*) nativeView;
    Camera* camera = (Camera*) nativeCamera;
    view->setCamera(camera);
}

extern "C" jboolean nHasCamera(jlong nativeView) {
    View* view = (View*) nativeView;
    return (jboolean)view->hasCamera();
}

extern "C" void nSetColorGrading(jlong nativeView, jlong nativeColorGrading) {
    View* view = (View*) nativeView;
    ColorGrading* colorGrading = (ColorGrading*) nativeColorGrading;
    view->setColorGrading(colorGrading);
}

extern "C" void nSetViewport(jlong nativeView, jint left, jint bottom, jint width, jint height) {
    View* view = (View*) nativeView;
    view->setViewport({left, bottom, (uint32_t) width, (uint32_t) height});
}

extern "C" void nSetVisibleLayers(jlong nativeView, jint select, jint value) {
    View* view = (View*) nativeView;
    view->setVisibleLayers((uint8_t) select, (uint8_t) value);
}

extern "C" jint nGetVisibleLayers(jlong nativeView) {
    View* view = (View*) nativeView;
    return view->getVisibleLayers();
}

extern "C" void nSetShadowingEnabled(jlong nativeView, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setShadowingEnabled(enabled);
}

extern "C" void nSetRenderTarget(jlong nativeView, jlong nativeTarget) {
    View* view = (View*) nativeView;
    view->setRenderTarget((RenderTarget*) nativeTarget);
}

extern "C" void nSetSampleCount(jlong nativeView, jint count) {
    View* view = (View*) nativeView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    view->setSampleCount((uint8_t) count);
#pragma clang diagnostic pop
}

extern "C" jint nGetSampleCount(jlong nativeView) {
    View* view = (View*) nativeView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return view->getSampleCount();
#pragma clang diagnostic pop
}

extern "C" void nSetAntiAliasing(jlong nativeView, jint type) {
    View* view = (View*) nativeView;
    view->setAntiAliasing(View::AntiAliasing(type));
}

extern "C" jint nGetAntiAliasing(jlong nativeView) {
    View* view = (View*) nativeView;
    return (jint) view->getAntiAliasing();
}

extern "C" void nSetDithering(jlong nativeView, jint dithering) {
    View* view = (View*) nativeView;
    view->setDithering((View::Dithering) dithering);
}

extern "C" jint nGetDithering(jlong nativeView) {
    View* view = (View*) nativeView;
    return (jint)view->getDithering();
}

extern "C" void nSetDynamicResolutionOptions(jlong nativeView,
        jboolean enabled, jboolean homogeneousScaling,
        jfloat minScale, jfloat maxScale, jfloat sharpness, jint quality) {
    View* view = (View*)nativeView;
    View::DynamicResolutionOptions options;
    options.enabled = enabled;
    options.homogeneousScaling = homogeneousScaling;
    options.minScale = filament::math::float2{ minScale };
    options.maxScale = filament::math::float2{ maxScale };
    options.sharpness = sharpness;
    options.quality = (View::QualityLevel)quality;
    view->setDynamicResolutionOptions(options);
}

extern "C" void nGetLastDynamicResolutionScale(jlong nativeView, float* out) {
    View *view = (View *) nativeView;
    math::float2 result = view->getLastDynamicResolutionScale();
    std::copy_n(result.v, 2, out);
}

extern "C" void nSetShadowType(jlong nativeView, jint type) {
    View* view = (View*) nativeView;
    view->setShadowType((View::ShadowType) type);
}

extern "C" void nSetVsmShadowOptions(jlong nativeView,
        jint anisotropy, jboolean mipmapping, jboolean highPrecision, jfloat minVarianceScale,
        jfloat lightBleedReduction) {
    View* view = (View*) nativeView;
    View::VsmShadowOptions options;
    options.anisotropy = (uint8_t)anisotropy;
    options.mipmapping = (bool)mipmapping;
    options.highPrecision = (bool)highPrecision;
    options.minVarianceScale = minVarianceScale;
    options.lightBleedReduction = lightBleedReduction;
    view->setVsmShadowOptions(options);
}

extern "C" void nSetSoftShadowOptions(jlong nativeView,
        jfloat penumbraScale, jfloat penumbraRatioScale) {
    View* view = (View*) nativeView;
    View::SoftShadowOptions options;
    options.penumbraScale = penumbraScale;
    options.penumbraRatioScale = penumbraRatioScale;
    view->setSoftShadowOptions(options);
}

extern "C"
void nSetRenderQuality(jlong nativeView, jint hdrColorBufferQuality) {
    View* view = (View*) nativeView;
    View::RenderQuality renderQuality;
    renderQuality.hdrColorBuffer = View::QualityLevel(hdrColorBufferQuality);
    view->setRenderQuality(renderQuality);
}

extern "C" void nSetDynamicLightingOptions(jlong nativeView, jfloat zLightNear, jfloat zLightFar) {
    View* view = (View*) nativeView;
    view->setDynamicLightingOptions(zLightNear, zLightFar);
}

extern "C" void nSetPostProcessingEnabled(jlong nativeView, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setPostProcessingEnabled(enabled);
}

extern "C" jboolean nIsPostProcessingEnabled(jlong nativeView) {
    View* view = (View*) nativeView;
    return static_cast<jboolean>(view->isPostProcessingEnabled());
}

extern "C" void nSetFrontFaceWindingInverted(jlong nativeView, jboolean inverted) {
    View* view = (View*) nativeView;
    view->setFrontFaceWindingInverted(inverted);
}

extern "C" jboolean nIsFrontFaceWindingInverted(jlong nativeView) {
    View* view = (View*) nativeView;
    return static_cast<jboolean>(view->isFrontFaceWindingInverted());
}

extern "C" void nSetTransparentPickingEnabled(jlong nativeView, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setTransparentPickingEnabled(enabled);
}

extern "C" jboolean nIsTransparentPickingEnabled(jlong nativeView) {
    View* view = (View*) nativeView;
    return static_cast<jboolean>(view->isTransparentPickingEnabled());
}

extern "C" void nSetAmbientOcclusion(jlong nativeView, jint ordinal) {
    View* view = (View*) nativeView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    view->setAmbientOcclusion((View::AmbientOcclusion) ordinal);
#pragma clang diagnostic pop
}

extern "C" jint nGetAmbientOcclusion(jlong nativeView) {
    View* view = (View*) nativeView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (jint)view->getAmbientOcclusion();
#pragma clang diagnostic pop
}

extern "C" void nSetAmbientOcclusionOptions(jlong nativeView, jfloat radius, jfloat bias, jfloat power, jfloat resolution, jfloat intensity,
    jfloat bilateralThreshold,
    jint quality, jint lowPassFilter, jint upsampling, jboolean enabled, jboolean bentNormals,
    jfloat minHorizonAngleRad) {
    View* view = (View*) nativeView;
    View::AmbientOcclusionOptions options = view->getAmbientOcclusionOptions();
    options.radius = radius;
    options.power = power;
    options.bias = bias;
    options.resolution = resolution;
    options.intensity = intensity;
    options.bilateralThreshold = bilateralThreshold;
    options.quality = (View::QualityLevel)quality;
    options.lowPassFilter = (View::QualityLevel)lowPassFilter;
    options.upsampling = (View::QualityLevel)upsampling;
    options.enabled = (bool)enabled;
    options.bentNormals = (bool)bentNormals;
    options.minHorizonAngleRad = minHorizonAngleRad;
    view->setAmbientOcclusionOptions(options);
}


extern "C" void nSetSSCTOptions(jlong nativeView,
        jfloat ssctLightConeRad, jfloat ssctShadowDistance, jfloat ssctContactDistanceMax,
        jfloat ssctIntensity, jfloat ssctLightDirX, jfloat ssctLightDirY, jfloat ssctLightDirZ,
        jfloat ssctDepthBias, jfloat ssctDepthSlopeBias, jint ssctSampleCount,
        jint ssctRayCount, jboolean ssctEnabled) {
    View* view = (View*) nativeView;
    View::AmbientOcclusionOptions options = view->getAmbientOcclusionOptions();
    options.ssct.lightConeRad = ssctLightConeRad;
    options.ssct.shadowDistance = ssctShadowDistance;
    options.ssct.contactDistanceMax = ssctContactDistanceMax;
    options.ssct.intensity = ssctIntensity;
    options.ssct.lightDirection = math::float3{ ssctLightDirX, ssctLightDirY, ssctLightDirZ };
    options.ssct.depthBias = ssctDepthBias;
    options.ssct.depthSlopeBias = ssctDepthSlopeBias;
    options.ssct.sampleCount = (uint8_t)ssctSampleCount;
    options.ssct.rayCount = (uint8_t)ssctRayCount;
    options.ssct.enabled = (bool)ssctEnabled;
    view->setAmbientOcclusionOptions(options);
}

extern "C" void nSetBloomOptions(jlong nativeView, jlong nativeTexture,
        jfloat dirtStrength, jfloat strength, jint resolution, jint levels,
        jint blendMode, jboolean threshold, jboolean enabled, jfloat highlight,
        jboolean lensFlare, jboolean starburst, jfloat chromaticAberration, jint ghostCount,
        jfloat ghostSpacing, jfloat ghostThreshold, jfloat haloThickness, jfloat haloRadius,
        jfloat haloThreshold) {
    View* view = (View*) nativeView;
    Texture* dirt = (Texture*) nativeTexture;
    View::BloomOptions options = {
            .dirt = dirt,
            .dirtStrength = dirtStrength,
            .strength = strength,
            .resolution = (uint32_t)resolution,
            .levels = (uint8_t)levels,
            .blendMode = (View::BloomOptions::BlendMode)blendMode,
            .threshold = (bool)threshold,
            .enabled = (bool)enabled,
            .highlight = highlight,
            .lensFlare = (bool)lensFlare,
            .starburst = (bool)starburst,
            .chromaticAberration = chromaticAberration,
            .ghostCount = (uint8_t)ghostCount,
            .ghostSpacing = ghostSpacing,
            .ghostThreshold = ghostThreshold,
            .haloThickness = haloThickness,
            .haloRadius = haloRadius,
            .haloThreshold = haloThreshold
    };
    view->setBloomOptions(options);
}

extern "C" void nSetFogOptions(jlong nativeView,
        jfloat distance, jfloat maximumOpacity, jfloat height, jfloat heightFalloff, jfloat cutOffDistance,
        jfloat r, jfloat g, jfloat b, jfloat density, jfloat inScatteringStart,
        jfloat inScatteringSize, jboolean fogColorFromIbl, jlong skyColorNativeObject, jboolean enabled) {
    View* view = (View*) nativeView;
    Texture* skyColor = (Texture*) skyColorNativeObject;
    View::FogOptions options = {
             .distance = distance,
             .cutOffDistance = cutOffDistance,
             .maximumOpacity = maximumOpacity,
             .height = height,
             .heightFalloff = heightFalloff,
             .color = math::float3{r, g, b},
             .density = density,
             .inScatteringStart = inScatteringStart,
             .inScatteringSize = inScatteringSize,
             .fogColorFromIbl = (bool)fogColorFromIbl,
             .skyColor = skyColor,
             .enabled = (bool)enabled
    };
    view->setFogOptions(options);
}


extern "C" void nSetBlendMode(jlong nativeView, jint blendMode) {
    View* view = (View*) nativeView;
    view->setBlendMode((View::BlendMode)blendMode);
}

extern "C" void nSetDepthOfFieldOptions(jlong nativeView, jfloat cocScale, jfloat maxApertureDiameter, jboolean enabled, jint filter,
        jboolean nativeResolution, jint foregroundRingCount, jint backgroundRingCount, jint fastGatherRingCount,
        jint maxForegroundCOC, jint maxBackgroundCOC) {
    View* view = (View*) nativeView;
    View::DepthOfFieldOptions::Filter eFilter{};
    if (filter == 1) {
        // View::DepthOfFieldOptions::Filter::MEDIAN value is actually 2
        eFilter = View::DepthOfFieldOptions::Filter::MEDIAN;
    }
    view->setDepthOfFieldOptions({.cocScale = cocScale,
            .maxApertureDiameter = maxApertureDiameter, .enabled = (bool)enabled, .filter = eFilter,
            .nativeResolution = (bool)nativeResolution,
            .foregroundRingCount = (uint8_t)foregroundRingCount,
            .backgroundRingCount = (uint8_t)backgroundRingCount,
            .fastGatherRingCount = (uint8_t)fastGatherRingCount,
            .maxForegroundCOC = (uint8_t)maxForegroundCOC,
            .maxBackgroundCOC = (uint8_t)maxBackgroundCOC,
    });
}

extern "C"
void nSetVignetteOptions(jlong nativeView, jfloat midPoint, jfloat roundness,
        jfloat feather, jfloat r, jfloat g, jfloat b, jfloat a, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setVignetteOptions({.midPoint = midPoint, .roundness = roundness, .feather = feather,
            .color = LinearColorA{r, g, b, a}, .enabled = (bool)enabled});
}

extern "C"
void nSetMultiSampleAntiAliasingOptions(jlong nativeView, jboolean enabled, jint sampleCount, jboolean customResolve) {
    View* view = (View*) nativeView;
    view->setMultiSampleAntiAliasingOptions({
            .enabled = (bool)enabled,
            .sampleCount = (uint8_t)sampleCount,
            .customResolve = (bool)customResolve});
}

extern "C"
void nSetTemporalAntiAliasingOptions(jlong nativeView, jfloat feedback, jfloat filterWidth, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setTemporalAntiAliasingOptions({
            .filterWidth = filterWidth, .feedback = feedback, .enabled = (bool) enabled});
}

extern "C"
void nSetScreenSpaceReflectionsOptions(jlong nativeView, jfloat thickness, jfloat bias, jfloat maxDistance, jfloat stride, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setScreenSpaceReflectionsOptions({.thickness = thickness, .bias = bias,
            .maxDistance = maxDistance, .stride = stride, .enabled = (bool) enabled
    });
}

extern "C"
jboolean nIsShadowingEnabled(jlong nativeView) {
    View* view = (View*) nativeView;
    return (jboolean)view->isShadowingEnabled();
}

extern "C" void nSetFrustumCullingEnabled(jlong nativeView, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setFrustumCullingEnabled(enabled);
}

extern "C" jboolean nIsFrustumCullingEnabled(jlong nativeView) {
    View* view = (View*) nativeView;
    return (jboolean)view->isFrustumCullingEnabled();
}

extern "C"
void nSetScreenSpaceRefractionEnabled(jlong nativeView, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setScreenSpaceRefractionEnabled((bool)enabled);
}

extern "C"
jboolean nIsScreenSpaceRefractionEnabled(jlong nativeView) {
    View* view = (View*) nativeView;
    return (jboolean)view->isScreenSpaceRefractionEnabled();
}

struct PickingResult {
    jint renderable;
    jfloat depth;
    jfloat fragCoordsX;
    jfloat fragCoordsY;
    jfloat fragCoordsZ;
};

typedef void (*PickingCallback)(PickingResult* result);

extern "C"
void nPick(jlong nativeView,
        jint x, jint y, PickingCallback callback) {
    View* view = (View*) nativeView;
    view->pick(x, y, [callback](View::PickingQueryResult const& result) {
        PickingResult r;
        r.renderable = (jint)result.renderable.getId();
        r.depth = result.depth;
        r.fragCoordsX = result.fragCoords.x;
        r.fragCoordsY = result.fragCoords.y;
        r.fragCoordsZ = result.fragCoords.z;
        if (callback) callback(&r);
    }, nullptr);
}

extern "C"
void nSetStencilBufferEnabled(jlong nativeView,
        jboolean enabled) {
    View* view = (View*) nativeView;
    view->setStencilBufferEnabled(enabled);
}

extern "C"
jboolean nIsStencilBufferEnabled(jlong nativeView) {
    View* view = (View*) nativeView;
    return view->isStencilBufferEnabled();
}

extern "C"
void nSetStereoscopicOptions(jlong nativeView,
        jboolean enabled) {
    View* view = (View*) nativeView;
    View::StereoscopicOptions options {
        .enabled = (bool) enabled
    };
    view->setStereoscopicOptions(options);
}

extern "C"
void nSetGuardBandOptions(jlong nativeView, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setGuardBandOptions({ .enabled = (bool)enabled });
}

extern "C"
void nSetMaterialGlobal(jlong nativeView,
        jint index, jfloat x, jfloat y, jfloat z, jfloat w) {
    View *view = (View *) nativeView;
    view->setMaterialGlobal((uint32_t)index, { x, y, z, w });
}

extern "C"
void nGetMaterialGlobal(jlong nativeView, jint index, float* out) {
    View *view = (View *) nativeView;
    auto result = view->getMaterialGlobal(index);
    std::copy_n(result.v, 4, out);
}

extern "C"
int nGetFogEntity(jlong nativeView) {
    View *view = (View *) nativeView;
    return (jint)view->getFogEntity().getId();
}

extern "C"
void nClearFrameHistory(jlong nativeView, jlong nativeEngine) {
    View *view = (View *) nativeView;
    Engine *engine = (Engine *) nativeEngine;
    view->clearFrameHistory(*engine);
}

extern "C"
void nSetChannelDepthClearEnabled(jlong nativeView, jint channel, jboolean enabled) {
    View* view = (View*) nativeView;
    view->setChannelDepthClearEnabled((uint8_t) channel, (bool) enabled);
}

extern "C"
jboolean nIsChannelDepthClearEnabled(jlong nativeView, jint channel) {
    // TODO: implement nIsChannelDepthClearEnabled()
    View* view = (View*) nativeView;
    return (jboolean)view->isChannelDepthClearEnabled((uint8_t) channel);
}

