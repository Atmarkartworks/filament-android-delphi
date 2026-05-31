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

#include <filament/LightManager.h>

#include <utils/Entity.h>

#include <algorithm>

using namespace filament;
using namespace utils;

extern "C" jint nGetComponentCount(jlong nativeLightManager) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return lm->getComponentCount();
}

extern "C" jboolean nHasComponent(jlong nativeLightManager, jint entity) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return (jboolean) lm->hasComponent((Entity &) entity);
}

extern "C" jint nGetInstance(jlong nativeLightManager, jint entity) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return lm->getInstance((Entity &) entity);
}

extern "C" void nDestroy(jlong nativeLightManager, jint entity) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->destroy((Entity &) entity);
}

extern "C" jlong nCreateBuilder(jint lightType) {
    return (jlong) new LightManager::Builder((LightManager::Type) lightType);
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    delete builder;
}

extern "C" void nBuilderCastShadows(jlong nativeBuilder, jboolean enable) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->castShadows(enable);
}

extern "C" void nBuilderShadowOptions(jlong nativeBuilder, jint mapSize, jint cascades,
        const float* splitPositions, jint splitCount,
        jfloat constantBias, jfloat normalBias, jfloat shadowFar, jfloat shadowNearHint,
        jfloat shadowFarHint, jboolean stable, jboolean lispsm,
        jfloat polygonOffsetConstant, jfloat polygonOffsetSlope,
        jboolean screenSpaceContactShadows, jint stepCount,
        jfloat maxShadowDistance, jboolean elvsm, jfloat blurWidth, jfloat shadowBulbRadius,
        const float* transform) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    LightManager::ShadowOptions shadowOptions {
            .mapSize = (uint32_t)mapSize,
            .shadowCascades = (uint8_t)cascades,
            .constantBias = constantBias,
            .normalBias = normalBias,
            .shadowFar = shadowFar,
            .shadowNearHint = shadowNearHint,
            .shadowFarHint = shadowFarHint,
            .stable = (bool)stable,
            .lispsm = (bool)lispsm,
            .polygonOffsetConstant = polygonOffsetConstant,
            .polygonOffsetSlope = polygonOffsetConstant,
            .screenSpaceContactShadows = (bool)screenSpaceContactShadows,
            .stepCount = uint8_t(stepCount),
            .maxShadowDistance = maxShadowDistance,
            .vsm = {
                    .elvsm = (bool)elvsm,
                    .blurWidth = blurWidth
            },
            .shadowBulbRadius = shadowBulbRadius
    };
    std::copy_n(splitPositions, std::min((jint)3, splitCount), shadowOptions.cascadeSplitPositions);
    std::copy_n(transform, 4, shadowOptions.transform.xyzw.v);
    builder->shadowOptions(shadowOptions);
}

extern "C" void nBuilderCastLight(jlong nativeBuilder, jboolean enabled) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->castLight(enabled);
}

extern "C" void nBuilderPosition(jlong nativeBuilder, jfloat x, jfloat y, jfloat z) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->position({x, y, z});
}

extern "C" void nBuilderDirection(jlong nativeBuilder, jfloat x, jfloat y, jfloat z) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->direction({x, y, z});
}

extern "C" void nBuilderColor(jlong nativeBuilder, jfloat linearR, jfloat linearG, jfloat linearB) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->color({linearR, linearG, linearB});
}

extern "C" void nBuilderIntensityCandela(jlong nativeBuilder, jfloat intensity) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->intensityCandela(intensity);
}

extern "C" void nBuilderIntensity__JF(jlong nativeBuilder, jfloat intensity) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->intensity(intensity);
}

extern "C" void nBuilderIntensity__JFF(jlong nativeBuilder, jfloat watts, jfloat efficiency) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->intensity(watts, efficiency);
}

extern "C" void nBuilderFalloff(jlong nativeBuilder, jfloat radius) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->falloff(radius);
}

extern "C" void nBuilderSpotLightCone(jlong nativeBuilder, jfloat inner, jfloat outer) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->spotLightCone(inner, outer);
}

extern "C" void nBuilderAngularRadius(jlong nativeBuilder, jfloat angularRadius) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->sunAngularRadius(angularRadius);
}

extern "C" void nBuilderHaloSize(jlong nativeBuilder, jfloat haloSize) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->sunHaloSize(haloSize);
}

extern "C" void nBuilderHaloFalloff(jlong nativeBuilder, jfloat haloFalloff) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->sunHaloFalloff(haloFalloff);
}

extern "C" void nBuilderLightChannel(jlong nativeBuilder, jint channel, jboolean enable) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    builder->lightChannel(channel, (bool)enable);
}

extern "C" jboolean nBuilderBuild(jlong nativeBuilder, jlong nativeEngine, jint entity) {
    LightManager::Builder *builder = (LightManager::Builder *) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return jboolean(builder->build(*engine, (Entity &) entity) == LightManager::Builder::Success);
}

// ------------------------------------------------------------------------------------------------

extern "C" void nComputeUniformSplits(float* splitPositions, jint cascades) {
    LightManager::ShadowCascades::computeUniformSplits(splitPositions, (uint8_t) cascades);
}

extern "C" void nComputeLogSplits(float* splitPositions, jint cascades, jfloat near, jfloat far) {
    LightManager::ShadowCascades::computeLogSplits(splitPositions, (uint8_t) cascades, near, far);
}

extern "C" void nComputePracticalSplits(float* splitPositions, jint cascades, jfloat near, jfloat far, jfloat lambda) {
    LightManager::ShadowCascades::computePracticalSplits(splitPositions, (uint8_t) cascades, near, far, lambda);
}

// ------------------------------------------------------------------------------------------------

extern "C" jint nGetType(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return (jint)lm->getType((LightManager::Instance) i);
}

extern "C" void nSetPosition(jlong nativeLightManager, jint i, jfloat x, jfloat y, jfloat z) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setPosition((LightManager::Instance) i, {x, y, z});
}

extern "C" void nGetPosition(jlong nativeLightManager, jint i, float* out) {
    LightManager *lm = (LightManager *) nativeLightManager;
    *reinterpret_cast<filament::math::float3 *>(out) = lm->getPosition((LightManager::Instance) i);
}

extern "C" void nSetDirection(jlong nativeLightManager, jint i, jfloat x, jfloat y, jfloat z) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setDirection((LightManager::Instance) i, {x, y, z});
}

extern "C" void nGetDirection(jlong nativeLightManager, jint i, float* out) {
    LightManager *lm = (LightManager *) nativeLightManager;
    *reinterpret_cast<filament::math::float3 *>(out) = lm->getDirection((LightManager::Instance) i);
}

extern "C" void nSetColor(jlong nativeLightManager, jint i, jfloat linearR, jfloat linearG, jfloat linearB) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setColor((LightManager::Instance) i, {linearR, linearG, linearB});
}

extern "C" void nGetColor(jlong nativeLightManager, jint i, float* out) {
    LightManager *lm = (LightManager *) nativeLightManager;
    *reinterpret_cast<filament::math::float3 *>(out) = lm->getColor((LightManager::Instance) i);
}

extern "C" void nSetIntensity__JIF(jlong nativeLightManager, jint i, jfloat intensity) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setIntensity((LightManager::Instance) i, intensity);
}

extern "C" void nSetIntensity__JIFF(jlong nativeLightManager, jint i, jfloat watts, jfloat efficiency) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setIntensity((LightManager::Instance) i, watts, efficiency);
}

extern "C" void nSetIntensityCandela(jlong nativeLightManager, jint i, jfloat intensity) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setIntensityCandela((LightManager::Instance) i, intensity);
}

extern "C" jfloat nGetIntensity(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return lm->getIntensity((LightManager::Instance) i);
}

extern "C" void nSetFalloff(jlong nativeLightManager, jint i, jfloat falloff) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setFalloff((LightManager::Instance) i, falloff);
}

extern "C" jfloat nGetFalloff(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return lm->getFalloff((LightManager::Instance) i);
}

extern "C" void nSetSpotLightCone(jlong nativeLightManager, jint i, jfloat inner, jfloat outer) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setSpotLightCone((LightManager::Instance) i, inner, outer);
}

extern "C" void nSetSunAngularRadius(jlong nativeLightManager, jint i, jfloat angularRadius) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setSunAngularRadius((LightManager::Instance) i, angularRadius);
}

extern "C" jfloat nGetSunAngularRadius(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return lm->getSunAngularRadius((LightManager::Instance) i);
}

extern "C" void nSetSunHaloSize(jlong nativeLightManager, jint i, jfloat haloSize) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setSunHaloSize((LightManager::Instance) i, haloSize);
}

extern "C" jfloat nGetSunHaloSize(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return lm->getSunHaloSize((LightManager::Instance) i);
}

extern "C" void nSetSunHaloFalloff(jlong nativeLightManager, jint i, jfloat haloFalloff) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setSunHaloFalloff((LightManager::Instance) i, haloFalloff);
}

extern "C" jfloat nGetSunHaloFalloff(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return lm->getSunHaloFalloff((LightManager::Instance) i);
}

extern "C" void nSetShadowCaster(jlong nativeLightManager, jint i, jboolean shadowCaster) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setShadowCaster((LightManager::Instance) i, shadowCaster);
}

extern "C" jboolean nIsShadowCaster(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return (jboolean)lm->isShadowCaster((LightManager::Instance) i);
}

extern "C" jfloat nGetOuterConeAngle(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return (jfloat)lm->getSpotLightOuterCone((LightManager::Instance) i);
}

extern "C" jfloat nGetInnerConeAngle(jlong nativeLightManager, jint i) {
    LightManager *lm = (LightManager *) nativeLightManager;
    return (jfloat)lm->getSpotLightInnerCone((LightManager::Instance) i);
}

extern "C" void nSetLightChannel(jlong nativeLightManager, jint i, jint channel, jboolean enable) {
    LightManager *lm = (LightManager *) nativeLightManager;
    lm->setLightChannel((LightManager::Instance) i, channel, (bool)enable);
}

extern "C" jboolean nGetLightChannel(jlong nativeLightManager, jint i, jint channel) {
    LightManager const *lm = (LightManager const *) nativeLightManager;
    return lm->getLightChannel((LightManager::Instance) i, channel);
}
