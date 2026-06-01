/*
 * Copyright (C) 2021 The Android Open Source Project
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

#include <gltfio/MaterialProvider.h>
#include <gltfio/materials/uberarchive.h>

#include <cstring>

using namespace filament;
using namespace filament::gltfio;

// Builds a MaterialKey from individual field parameters (Thermion flat-parameter pattern).
// memset ensures padding bits are zero-initialised (required by MurmurHashFn used internally
// by UbershaderProvider to key the material cache).
static void buildMaterialKey(MaterialKey& key,
        bool doubleSided, bool unlit, bool hasVertexColors,
        bool hasBaseColorTexture, bool hasNormalTexture, bool hasOcclusionTexture,
        bool hasEmissiveTexture, bool useSpecularGlossiness,
        int  alphaMode, bool enableDiagnostics,
        bool hasMetallicRoughnessTexture,
        uint8_t metallicRoughnessUV, uint8_t baseColorUV,
        bool hasClearCoatTexture, uint8_t clearCoatUV,
        bool hasClearCoatRoughnessTexture, uint8_t clearCoatRoughnessUV,
        bool hasClearCoatNormalTexture, uint8_t clearCoatNormalUV,
        bool hasClearCoat, bool hasTransmission, bool hasTextureTransforms,
        uint8_t emissiveUV, uint8_t aoUV, uint8_t normalUV,
        bool hasTransmissionTexture, uint8_t transmissionUV,
        bool hasSheenColorTexture, uint8_t sheenColorUV,
        bool hasSheenRoughnessTexture, uint8_t sheenRoughnessUV,
        bool hasVolumeThicknessTexture, uint8_t volumeThicknessUV,
        bool hasSheen, bool hasIOR,
        bool hasVolume, bool hasDispersion,
        bool hasSpecular, bool hasSpecularTexture, bool hasSpecularColorTexture,
        uint8_t specularTextureUV, uint8_t specularColorTextureUV) {
    memset(&key, 0, sizeof(MaterialKey));
    key.doubleSided                  = doubleSided;
    key.unlit                        = unlit;
    key.hasVertexColors              = hasVertexColors;
    key.hasBaseColorTexture          = hasBaseColorTexture;
    key.hasNormalTexture             = hasNormalTexture;
    key.hasOcclusionTexture          = hasOcclusionTexture;
    key.hasEmissiveTexture           = hasEmissiveTexture;
    key.useSpecularGlossiness        = useSpecularGlossiness;
    key.alphaMode                    = static_cast<AlphaMode>(alphaMode);
    key.enableDiagnostics            = enableDiagnostics;
    key.hasMetallicRoughnessTexture  = hasMetallicRoughnessTexture;  // union: also hasSpecularGlossinessTexture
    key.metallicRoughnessUV          = metallicRoughnessUV;          // union: also specularGlossinessUV
    key.baseColorUV                  = baseColorUV;
    key.hasClearCoatTexture          = hasClearCoatTexture;
    key.clearCoatUV                  = clearCoatUV;
    key.hasClearCoatRoughnessTexture = hasClearCoatRoughnessTexture;
    key.clearCoatRoughnessUV         = clearCoatRoughnessUV;
    key.hasClearCoatNormalTexture    = hasClearCoatNormalTexture;
    key.clearCoatNormalUV            = clearCoatNormalUV;
    key.hasClearCoat                 = hasClearCoat;
    key.hasTransmission              = hasTransmission;
    key.hasTextureTransforms         = hasTextureTransforms;
    key.emissiveUV                   = emissiveUV;
    key.aoUV                         = aoUV;
    key.normalUV                     = normalUV;
    key.hasTransmissionTexture       = hasTransmissionTexture;
    key.transmissionUV               = transmissionUV;
    key.hasSheenColorTexture         = hasSheenColorTexture;
    key.sheenColorUV                 = sheenColorUV;
    key.hasSheenRoughnessTexture     = hasSheenRoughnessTexture;
    key.sheenRoughnessUV             = sheenRoughnessUV;
    key.hasVolumeThicknessTexture    = hasVolumeThicknessTexture;
    key.volumeThicknessUV            = volumeThicknessUV;
    key.hasSheen                     = hasSheen;
    key.hasIOR                       = hasIOR;
    key.hasVolume                    = hasVolume;
    key.hasDispersion                = hasDispersion;
    key.hasSpecular                  = hasSpecular;
    key.hasSpecularTexture           = hasSpecularTexture;
    key.hasSpecularColorTexture      = hasSpecularColorTexture;
    key.specularTextureUV            = specularTextureUV;
    key.specularColorTextureUV       = specularColorTextureUV;
}

static void copyUvMap(const UvMap& src, int* dst) {
    if (dst) {
        for (int i = 0; i < (int) src.size(); i++) {
            dst[i] = src[i];
        }
    }
}

extern "C" jlong nCreateUbershaderProvider(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) createUbershaderProvider(engine, UBERARCHIVE_DEFAULT_DATA, UBERARCHIVE_DEFAULT_SIZE);
}

extern "C" void nDestroyUbershaderProvider(jlong nativeProvider) {
    auto provider = (MaterialProvider*) nativeProvider;
    delete provider;
}

extern "C" void nDestroyMaterials(jlong nativeProvider) {
    auto provider = (MaterialProvider*) nativeProvider;
    provider->destroyMaterials();
}

extern "C" long nCreateMaterialInstance(jlong nativeProvider,
        bool doubleSided, bool unlit, bool hasVertexColors,
        bool hasBaseColorTexture, bool hasNormalTexture, bool hasOcclusionTexture,
        bool hasEmissiveTexture, bool useSpecularGlossiness,
        int  alphaMode, bool enableDiagnostics,
        bool hasMetallicRoughnessTexture,
        uint8_t metallicRoughnessUV, uint8_t baseColorUV,
        bool hasClearCoatTexture, uint8_t clearCoatUV,
        bool hasClearCoatRoughnessTexture, uint8_t clearCoatRoughnessUV,
        bool hasClearCoatNormalTexture, uint8_t clearCoatNormalUV,
        bool hasClearCoat, bool hasTransmission, bool hasTextureTransforms,
        uint8_t emissiveUV, uint8_t aoUV, uint8_t normalUV,
        bool hasTransmissionTexture, uint8_t transmissionUV,
        bool hasSheenColorTexture, uint8_t sheenColorUV,
        bool hasSheenRoughnessTexture, uint8_t sheenRoughnessUV,
        bool hasVolumeThicknessTexture, uint8_t volumeThicknessUV,
        bool hasSheen, bool hasIOR,
        bool hasVolume, bool hasDispersion,
        bool hasSpecular, bool hasSpecularTexture, bool hasSpecularColorTexture,
        uint8_t specularTextureUV, uint8_t specularColorTextureUV,
        int* uvmap, const char* label, const char* extras) {
    MaterialKey key;
    UvMap uvMap = {};
    buildMaterialKey(key,
            doubleSided, unlit, hasVertexColors,
            hasBaseColorTexture, hasNormalTexture, hasOcclusionTexture,
            hasEmissiveTexture, useSpecularGlossiness,
            alphaMode, enableDiagnostics,
            hasMetallicRoughnessTexture, metallicRoughnessUV, baseColorUV,
            hasClearCoatTexture, clearCoatUV,
            hasClearCoatRoughnessTexture, clearCoatRoughnessUV,
            hasClearCoatNormalTexture, clearCoatNormalUV,
            hasClearCoat, hasTransmission, hasTextureTransforms,
            emissiveUV, aoUV, normalUV,
            hasTransmissionTexture, transmissionUV,
            hasSheenColorTexture, sheenColorUV,
            hasSheenRoughnessTexture, sheenRoughnessUV,
            hasVolumeThicknessTexture, volumeThicknessUV,
            hasSheen, hasIOR,
            hasVolume, hasDispersion,
            hasSpecular, hasSpecularTexture, hasSpecularColorTexture,
            specularTextureUV, specularColorTextureUV);
    auto* provider = (MaterialProvider*) nativeProvider;
    MaterialInstance* instance = provider->createMaterialInstance(&key, &uvMap, label, extras);
    copyUvMap(uvMap, uvmap);
    return (long) instance;
}

extern "C" long nGetMaterial(jlong nativeProvider,
        bool doubleSided, bool unlit, bool hasVertexColors,
        bool hasBaseColorTexture, bool hasNormalTexture, bool hasOcclusionTexture,
        bool hasEmissiveTexture, bool useSpecularGlossiness,
        int  alphaMode, bool enableDiagnostics,
        bool hasMetallicRoughnessTexture,
        uint8_t metallicRoughnessUV, uint8_t baseColorUV,
        bool hasClearCoatTexture, uint8_t clearCoatUV,
        bool hasClearCoatRoughnessTexture, uint8_t clearCoatRoughnessUV,
        bool hasClearCoatNormalTexture, uint8_t clearCoatNormalUV,
        bool hasClearCoat, bool hasTransmission, bool hasTextureTransforms,
        uint8_t emissiveUV, uint8_t aoUV, uint8_t normalUV,
        bool hasTransmissionTexture, uint8_t transmissionUV,
        bool hasSheenColorTexture, uint8_t sheenColorUV,
        bool hasSheenRoughnessTexture, uint8_t sheenRoughnessUV,
        bool hasVolumeThicknessTexture, uint8_t volumeThicknessUV,
        bool hasSheen, bool hasIOR,
        bool hasVolume, bool hasDispersion,
        bool hasSpecular, bool hasSpecularTexture, bool hasSpecularColorTexture,
        uint8_t specularTextureUV, uint8_t specularColorTextureUV,
        int* uvmap, const char* label) {
    MaterialKey key;
    UvMap uvMap = {};
    buildMaterialKey(key,
            doubleSided, unlit, hasVertexColors,
            hasBaseColorTexture, hasNormalTexture, hasOcclusionTexture,
            hasEmissiveTexture, useSpecularGlossiness,
            alphaMode, enableDiagnostics,
            hasMetallicRoughnessTexture, metallicRoughnessUV, baseColorUV,
            hasClearCoatTexture, clearCoatUV,
            hasClearCoatRoughnessTexture, clearCoatRoughnessUV,
            hasClearCoatNormalTexture, clearCoatNormalUV,
            hasClearCoat, hasTransmission, hasTextureTransforms,
            emissiveUV, aoUV, normalUV,
            hasTransmissionTexture, transmissionUV,
            hasSheenColorTexture, sheenColorUV,
            hasSheenRoughnessTexture, sheenRoughnessUV,
            hasVolumeThicknessTexture, volumeThicknessUV,
            hasSheen, hasIOR,
            hasVolume, hasDispersion,
            hasSpecular, hasSpecularTexture, hasSpecularColorTexture,
            specularTextureUV, specularColorTextureUV);
    auto* provider = (MaterialProvider*) nativeProvider;
    Material* material = provider->getMaterial(&key, &uvMap, label);
    copyUvMap(uvMap, uvmap);
    return (long) material;
}

extern "C" int nGetMaterialCount(jlong nativeProvider) {
    auto provider = (MaterialProvider*) nativeProvider;
    return provider->getMaterialsCount();
}

extern "C" void nGetMaterials(jlong nativeProvider, jlong* result, jint count) {
    auto provider = (MaterialProvider*) nativeProvider;
    auto materials = provider->getMaterials();
    for (int i = 0, n = std::min((size_t) count, provider->getMaterialsCount()); i < n; ++i) {
        result[i] = (jlong) materials[i];
    }
}
