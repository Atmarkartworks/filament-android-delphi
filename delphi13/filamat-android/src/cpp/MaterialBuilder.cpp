/*
 * Copyright (C) 2019 The Android Open Source Project
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

// Delphi13: JNI layer removed. Functions are plain extern "C" cdecl entries
// callable directly from Delphi via external 'filamat-jni'.
// jstring replaced with const char* (caller passes UTF-8 PAnsiChar).
// nGetPackageBytes: returns const void* and writes size via jint* outSize.

#include <jni.h>

#include <filamat/MaterialBuilder.h>

#include <utils/JobSystem.h>

using namespace filament;
using namespace filamat;

extern "C" void nMaterialBuilderInit() {
    MaterialBuilder::init();
}

extern "C" void nMaterialBuilderShutdown() {
    MaterialBuilder::shutdown();
}

extern "C" jlong nCreateMaterialBuilder() {
    return (jlong) new MaterialBuilder();
}

extern "C" void nDestroyMaterialBuilder(jlong nativeBuilder) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    delete builder;
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jlong nativeJobSystem) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    auto jobSystem = (utils::JobSystem*) nativeJobSystem;

    if (nativeJobSystem == 0) {
        jobSystem = new utils::JobSystem;
        jobSystem->adopt();
    }

    jlong result = (jlong) new Package(builder->build(*jobSystem));

    if (nativeJobSystem == 0) {
        jobSystem->emancipate();
        delete jobSystem;
    }

    return result;
}

// Returns a pointer to the package data; writes byte count into *outSize.
// Delphi: function nGetPackageBytes(nativePackage: Int64; outSize: PInteger): Pointer;
extern "C" const void* nGetPackageBytes(jlong nativePackage, jint* outSize) {
    auto package = (Package*) nativePackage;
    *outSize = (jint) package->getSize();
    return package->getData();
}

extern "C" jboolean nGetPackageIsValid(jlong nativePackage) {
    auto* package = (Package*) nativePackage;
    return jboolean(package->isValid());
}

extern "C" void nDestroyPackage(jlong nativePackage) {
    Package* package = (Package*) nativePackage;
    delete package;
}

extern "C" void nMaterialBuilderName(jlong nativeBuilder, const char* name) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->name(name);
}

extern "C" void nMaterialBuilderMaterialDomain(jlong nativeBuilder, jint domain) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->materialDomain((MaterialBuilder::MaterialDomain) domain);
}

extern "C" void nMaterialBuilderShading(jlong nativeBuilder, jint shading) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->shading((MaterialBuilder::Shading) shading);
}

extern "C" void nMaterialBuilderInterpolation(jlong nativeBuilder, jint interpolation) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->interpolation((MaterialBuilder::Interpolation) interpolation);
}

extern "C" void nMaterialBuilderUniformParameter(
        jlong nativeBuilder, jint uniformType, jint precision, const char* name) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->parameter(name, (MaterialBuilder::UniformType) uniformType,
            (MaterialBuilder::ParameterPrecision) precision);
}

extern "C" void nMaterialBuilderUniformParameterArray(
        jlong nativeBuilder, jint uniformType, jint size, jint precision, const char* name) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->parameter(name, (size_t) size, (MaterialBuilder::UniformType) uniformType,
            (MaterialBuilder::ParameterPrecision) precision);
}

extern "C" void nMaterialBuilderSamplerParameter(
        jlong nativeBuilder, jint samplerType, jint format, jint precision, const char* name) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->parameter(name, (MaterialBuilder::SamplerType) samplerType,
            (MaterialBuilder::SamplerFormat) format, (MaterialBuilder::ParameterPrecision) precision);
}

extern "C" void nMaterialBuilderVariable(
        jlong nativeBuilder, jint variable, const char* name) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->variable((MaterialBuilder::Variable) variable, name);
}

extern "C" void nMaterialBuilderRequire(jlong nativeBuilder, jint attribute) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->require((VertexAttribute) attribute);
}

extern "C" void nMaterialBuilderMaterial(jlong nativeBuilder, const char* code) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->material(code);
}

extern "C" void nMaterialBuilderMaterialVertex(jlong nativeBuilder, const char* code) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->materialVertex(code);
}

extern "C" void nMaterialBuilderBlending(jlong nativeBuilder, jint mode) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->blending((MaterialBuilder::BlendingMode) mode);
}

extern "C" void nMaterialBuilderPostLightingBlending(jlong nativeBuilder, jint mode) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->postLightingBlending((MaterialBuilder::BlendingMode) mode);
}

extern "C" void nMaterialBuilderVertexDomain(jlong nativeBuilder, jint vertexDomain) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->vertexDomain((MaterialBuilder::VertexDomain) vertexDomain);
}

extern "C" void nMaterialBuilderCulling(jlong nativeBuilder, jint mode) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->culling((MaterialBuilder::CullingMode) mode);
}

extern "C" void nMaterialBuilderColorWrite(jlong nativeBuilder, jboolean enable) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->colorWrite(enable);
}

extern "C" void nMaterialBuilderDepthWrite(jlong nativeBuilder, jboolean depthWrite) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->depthWrite(depthWrite);
}

extern "C" void nMaterialBuilderDepthCulling(jlong nativeBuilder, jboolean depthCulling) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->depthCulling(depthCulling);
}

extern "C" void nMaterialBuilderDoubleSided(jlong nativeBuilder, jboolean doubleSided) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->doubleSided(doubleSided);
}

extern "C" void nMaterialBuilderMaskThreshold(jlong nativeBuilder, jfloat maskThreshold) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->maskThreshold(maskThreshold);
}

extern "C" void nMaterialBuilderAlphaToCoverage(jlong nativeBuilder, jboolean enable) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->alphaToCoverage(enable);
}

extern "C" void nMaterialBuilderShadowMultiplier(jlong nativeBuilder, jboolean shadowMultiplier) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->shadowMultiplier(shadowMultiplier);
}

extern "C" void nMaterialBuilderTransparentShadow(jlong nativeBuilder, jboolean transparentShadow) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->transparentShadow(transparentShadow);
}

extern "C" void nMaterialBuilderSpecularAntiAliasing(jlong nativeBuilder, jboolean specularAntiAliasing) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->specularAntiAliasing(specularAntiAliasing);
}

extern "C" void nMaterialBuilderSpecularAntiAliasingVariance(jlong nativeBuilder, jfloat variance) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->specularAntiAliasingVariance(variance);
}

extern "C" void nMaterialBuilderSpecularAntiAliasingThreshold(jlong nativeBuilder, jfloat threshold) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->specularAntiAliasingThreshold(threshold);
}

extern "C" void nMaterialBuilderClearCoatIorChange(jlong nativeBuilder, jboolean clearCoatIorChange) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->clearCoatIorChange(clearCoatIorChange);
}

extern "C" void nMaterialBuilderFlipUV(jlong nativeBuilder, jboolean flipUV) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->flipUV(flipUV);
}

extern "C" void nMaterialBuilderCustomSurfaceShading(jlong nativeBuilder, jboolean customSurfaceShading) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->customSurfaceShading(customSurfaceShading);
}

extern "C" void nMaterialBuilderMultiBounceAmbientOcclusion(jlong nativeBuilder, jboolean multiBounceAO) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->multiBounceAmbientOcclusion(multiBounceAO);
}

extern "C" void nMaterialBuilderSpecularAmbientOcclusion(jlong nativeBuilder, jint specularAO) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->specularAmbientOcclusion((MaterialBuilder::SpecularAmbientOcclusion) specularAO);
}

extern "C" void nMaterialBuilderRefractionMode(jlong nativeBuilder, jint mode) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->refractionMode((MaterialBuilder::RefractionMode) mode);
}

extern "C" void nMaterialBuilderReflectionMode(jlong nativeBuilder, jint mode) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->reflectionMode((MaterialBuilder::ReflectionMode) mode);
}

extern "C" void nMaterialBuilderRefractionType(jlong nativeBuilder, jint type) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->refractionType((MaterialBuilder::RefractionType) type);
}

extern "C" void nMaterialBuilderTransparencyMode(jlong nativeBuilder, jint mode) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->transparencyMode((MaterialBuilder::TransparencyMode) mode);
}

extern "C" void nMaterialBuilderPlatform(jlong nativeBuilder, jint platform) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->platform((MaterialBuilder::Platform) platform);
}

extern "C" void nMaterialBuilderTargetApi(jlong nativeBuilder, jint targetApi) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->targetApi((MaterialBuilder::TargetApi) targetApi);
}

extern "C" void nMaterialBuilderOptimization(jlong nativeBuilder, jint optimization) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->optimization((MaterialBuilder::Optimization) optimization);
}

extern "C" void nMaterialBuilderVariantFilter(jlong nativeBuilder, jint variantFilter) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->variantFilter((uint8_t) variantFilter);
}

extern "C" void nMaterialBuilderUseLegacyMorphing(jlong nativeBuilder) {
    auto builder = (MaterialBuilder*) nativeBuilder;
    builder->useLegacyMorphing();
}
