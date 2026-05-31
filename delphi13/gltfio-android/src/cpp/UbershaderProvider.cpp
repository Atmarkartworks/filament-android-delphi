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

#include <utils/debug.h>

#include "MaterialKey.h"

using namespace filament;
using namespace filament::gltfio;

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

extern "C" long nCreateMaterialInstance(jlong nativeProvider, MaterialKey* materialKey,
        jint* uvmap, jint uvmapSize, const char* label, const char* extras) {
    MaterialKey nativeKey = *materialKey;
    UvMap nativeUvMap = {};
    auto provider = (MaterialProvider*) nativeProvider;
    MaterialInstance* instance = provider->createMaterialInstance(&nativeKey, &nativeUvMap,
            label, extras);

    // Copy the UvMap results back.
    if (uvmap) {
        for (int i = 0, n = std::min((size_t) uvmapSize, nativeUvMap.size()); i < n; ++i) {
            uvmap[i] = nativeUvMap[i];
        }
    }

    // The config parameter is an in-out parameter.
    *materialKey = nativeKey;

    return (long) instance;
}

extern "C" long nGetMaterial(jlong nativeProvider, MaterialKey* materialKey,
        jint* uvmap, jint uvmapSize, const char* label) {
    MaterialKey nativeKey = *materialKey;
    UvMap nativeUvMap = {};
    auto provider = (MaterialProvider*) nativeProvider;
    Material* material = provider->getMaterial(&nativeKey, &nativeUvMap, label);

    // Copy the UvMap results back.
    if (uvmap) {
        for (int i = 0, n = std::min((size_t) uvmapSize, nativeUvMap.size()); i < n; ++i) {
            uvmap[i] = nativeUvMap[i];
        }
    }

    // The config parameter is an in-out parameter.
    *materialKey = nativeKey;

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
