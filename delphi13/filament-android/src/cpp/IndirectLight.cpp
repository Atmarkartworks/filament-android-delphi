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

#include <filament/IndirectLight.h>
#include <filament/Texture.h>
#include <math/mat4.h>

using namespace filament;

extern "C" jlong nCreateBuilder() {
    return (jlong) new IndirectLight::Builder();
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    IndirectLight::Builder* builder = (IndirectLight::Builder*) nativeBuilder;
    delete builder;
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jlong nativeEngine) {
    IndirectLight::Builder* builder = (IndirectLight::Builder*) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

extern "C" void nBuilderReflections(jlong nativeBuilder, jlong nativeTexture) {
    IndirectLight::Builder* builder = (IndirectLight::Builder*) nativeBuilder;
    const Texture *texture = (const Texture *) nativeTexture;
    builder->reflections(texture);
}

extern "C" void nIrradiance(jlong nativeBuilder, jint bands, float* sh) {
    IndirectLight::Builder* builder = (IndirectLight::Builder*) nativeBuilder;
    builder->irradiance((uint8_t) bands, (const filament::math::float3*) sh);
}

extern "C" void nRadiance(jlong nativeBuilder, jint bands, float* sh) {
    IndirectLight::Builder* builder = (IndirectLight::Builder*) nativeBuilder;
    builder->radiance((uint8_t) bands, (const filament::math::float3*) sh);
}

extern "C" void nIrradianceAsTexture(jlong nativeBuilder, jlong nativeTexture) {
    IndirectLight::Builder* builder = (IndirectLight::Builder*) nativeBuilder;
    const Texture* texture = (const Texture*) nativeTexture;
    builder->irradiance(texture);
}

extern "C" void nIntensity(jlong nativeBuilder, jfloat envIntensity) {
    IndirectLight::Builder* builder = (IndirectLight::Builder*) nativeBuilder;
    builder->intensity(envIntensity);
}

extern "C" void nRotation(jlong nativeBuilder,
        jfloat v0, jfloat v1, jfloat v2, jfloat v3, jfloat v4, jfloat v5, jfloat v6, jfloat v7,
        jfloat v8) {
    IndirectLight::Builder *builder = (IndirectLight::Builder *) nativeBuilder;
    builder->rotation(filament::math::mat3f{v0, v1, v2, v3, v4, v5, v6, v7, v8});
}

extern "C" void nSetIntensity(jlong nativeIndirectLight, jfloat intensity) {
    IndirectLight* indirectLight = (IndirectLight*) nativeIndirectLight;
    indirectLight->setIntensity(intensity);
}

extern "C" jfloat nGetIntensity(jlong nativeIndirectLight) {
    IndirectLight* indirectLight = (IndirectLight*) nativeIndirectLight;
    return indirectLight->getIntensity();
}

extern "C" void nSetRotation(jlong nativeIndirectLight, jfloat v0, jfloat v1, jfloat v2,
        jfloat v3, jfloat v4, jfloat v5, jfloat v6, jfloat v7, jfloat v8) {
    IndirectLight *indirectLight = (IndirectLight *) nativeIndirectLight;
    indirectLight->setRotation(filament::math::mat3f{v0, v1, v2, v3, v4, v5, v6, v7, v8});
}

extern "C" void nGetRotation(jlong nativeIndirectLight, float* outRotation) {
    IndirectLight *indirectLight = (IndirectLight *) nativeIndirectLight;
    *reinterpret_cast<filament::math::mat3f*>(outRotation) = indirectLight->getRotation();

}

extern "C" [[deprecated]] void nGetDirectionEstimate(jlong nativeIndirectLight, float* outDirection) {
    IndirectLight *indirectLight = (IndirectLight *) nativeIndirectLight;
    *reinterpret_cast<filament::math::float3*>(outDirection) = indirectLight->getDirectionEstimate();
}

extern "C" [[deprecated]] void nGetColorEstimate(jlong nativeIndirectLight, float* outColor, jfloat x, jfloat y, jfloat z) {
    IndirectLight *indirectLight = (IndirectLight *) nativeIndirectLight;
    *reinterpret_cast<filament::math::float4*>(outColor) =
            indirectLight->getColorEstimate(math::float3{x, y, z});
}

extern "C" jlong nGetReflectionsTexture(jlong nativeIndirectLight) {
    IndirectLight *indirectLight = (IndirectLight *) nativeIndirectLight;
    Texture const *tex = indirectLight->getReflectionsTexture();
    return (jlong) tex;
}

extern "C" jlong nGetIrradianceTexture(jlong nativeIndirectLight) {
    IndirectLight *indirectLight = (IndirectLight *) nativeIndirectLight;
    Texture const *tex = indirectLight->getIrradianceTexture();
    return (jlong) tex;
}

extern "C" void nGetDirectionEstimateStatic(float* sh, float* outDirection) {
    *reinterpret_cast<filament::math::float3*>(outDirection) = IndirectLight::getDirectionEstimate((filament::math::float3*)sh);
}

extern "C" void nGetColorEstimateStatic(float* outColor, float* sh, jfloat x, jfloat y, jfloat z) {
    *reinterpret_cast<filament::math::float4*>(outColor) =
            IndirectLight::getColorEstimate((filament::math::float3*)sh, math::float3{x, y, z});
}

