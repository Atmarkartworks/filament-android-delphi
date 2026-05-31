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

#include <filament/Material.h>

using namespace filament;

extern "C" jlong nBuilderBuild(jlong nativeEngine, const void* data, jint size, jint shBandCount, jint shadowQuality, jint uboBatchingMode) {
    Engine* engine = (Engine*) nativeEngine;
    auto builder = Material::Builder();
    if (shBandCount) {
        builder.sphericalHarmonicsBandCount(shBandCount);
    }
    builder.shadowSamplingQuality((Material::Builder::ShadowSamplingQuality)shadowQuality);
    builder.uboBatching((Material::UboBatchingMode)uboBatchingMode);
    Material* material = builder
            .package(data, (size_t)size)
            .build(*engine);

    return (jlong) material;
}

extern "C" jlong nGetDefaultInstance(jlong nativeMaterial) {
    Material const* material = (Material const*) nativeMaterial;
    return (jlong) material->getDefaultInstance();
}

extern "C" jlong nCreateInstance(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jlong) material->createInstance();
}

extern "C" jlong nCreateInstanceWithName(jlong nativeMaterial, const char* name) {
    Material* material = (Material*) nativeMaterial;
    return (jlong) material->createInstance(name);
}

extern "C"
const char* nGetName(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return material->getName();
}

extern "C"
jint nGetShading(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getShading();
}

extern "C"
jint nGetInterpolation(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getInterpolation();
}

extern "C"
jint nGetBlendingMode(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getBlendingMode();
}

extern "C"
jint nGetTransparencyMode(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getTransparencyMode();
}

extern "C"
jint nGetRefractionMode(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint)material->getRefractionMode();
}

extern "C"
jint nGetRefractionType(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getRefractionType();
}

extern "C"
jint nGetReflectionMode(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getReflectionMode();
}

extern "C"
jint nGetFeatureLevel(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getFeatureLevel();
}

extern "C"
jint nGetVertexDomain(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getVertexDomain();
}

extern "C"
jint nGetCullingMode(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getCullingMode();
}

extern "C"
jboolean nIsColorWriteEnabled(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jboolean) material->isColorWriteEnabled();
}

extern "C"
jboolean nIsDepthWriteEnabled(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jboolean) material->isDepthWriteEnabled();
}

extern "C"
jboolean nIsDepthCullingEnabled(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jboolean) material->isDepthCullingEnabled();
}

extern "C"
jboolean nIsDoubleSided(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jboolean) material->isDoubleSided();
}

extern "C"
jboolean nIsAlphaToCoverageEnabled(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jboolean) material->isAlphaToCoverageEnabled();
}

extern "C"
jfloat nGetMaskThreshold(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return material->getMaskThreshold();
}

extern "C"
jfloat nGetSpecularAntiAliasingVariance(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return material->getSpecularAntiAliasingVariance();
}

extern "C"
jfloat nGetSpecularAntiAliasingThreshold(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return material->getSpecularAntiAliasingThreshold();
}

extern "C"
jint nGetParameterCount(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return (jint) material->getParameterCount();
}

struct ParameterInfo {
    const char* name;
    jint type;
    jint precision;
    jint count;
};

extern "C"
void nGetParameters(jlong nativeMaterial, ParameterInfo* output, jint count) {
    Material* material = (Material*) nativeMaterial;
    Material::ParameterInfo* info = new Material::ParameterInfo[(size_t)count];
    size_t received = material->getParameters(info, (size_t) count);
    for (size_t i = 0; i < received; i++) {
        jint type;
        if (info[i].isSampler) {
            type = (jint) info[i].samplerType;
        } else if (info[i].isSubpass) {
            type = -1;
        } else {
            type = (jint) info[i].type;
        }
        output[i].name = info[i].name;
        output[i].type = type;
        output[i].precision = (jint) info[i].precision;
        output[i].count = (jint) info[i].count;
    }
    delete[] info;
}

extern "C"
jint nGetRequiredAttributes(jlong nativeMaterial) {
    Material* material = (Material*) nativeMaterial;
    return material->getRequiredAttributes().getValue();
}

extern "C" jboolean nHasParameter(jlong nativeMaterial, const char* name) {
    Material* material = (Material*) nativeMaterial;
    return (jboolean) material->hasParameter(name);
}

extern "C" const char* nGetParameterTransformName(jlong nativeMaterial, const char* samplerName) {
    Material* material = (Material*) nativeMaterial;
    return material->getParameterTransformName(samplerName);
}

extern "C"
void nCompile(jlong nativeMaterial, jint priority, jint variants) {
    Material* material = (Material*) nativeMaterial;
    material->compile(
            (Material::CompilerPriorityQueue) priority,
            (UserVariantFilterBit) variants,
            nullptr, [](Material*){});
}
