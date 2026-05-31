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

#include <filament/Engine.h>

#include <utils/EntityManager.h>
#include <utils/NameComponentManager.h>

#include <gltfio/AssetLoader.h>
#include <gltfio/MaterialProvider.h>
#include <utils/debug.h>

#include "common/NioUtils.h"

#include "MaterialKey.h"

using namespace filament;
using namespace filament::gltfio;
using namespace utils;

extern "C" jlong nCreateAssetLoader(jlong nativeEngine, jlong nativeMaterialProvider,
        jlong nativeEntities) {
    Engine* engine = (Engine*) nativeEngine;
    MaterialProvider* materialProvider = (MaterialProvider*) nativeMaterialProvider;
    EntityManager* entities = (EntityManager*) nativeEntities;
    NameComponentManager* names = new NameComponentManager(*entities);
    return (jlong) AssetLoader::create({engine, materialProvider, names, entities});
}

extern "C" void nDestroyAssetLoader(jlong nativeLoader) {
    AssetLoader* loader = (AssetLoader*) nativeLoader;
    NameComponentManager* names = loader->getNames();
    AssetLoader::destroy(&loader);
    delete names;
}

extern "C" jlong nCreateAsset(jlong nativeLoader, const void* data, jint size) {
    AssetLoader* loader = (AssetLoader*) nativeLoader;
    return (jlong) loader->createAsset((const uint8_t*) data, (size_t) size);
}

extern "C" jlong nCreateInstancedAsset(jlong nativeLoader, const void* data, jint size,
        jlong* instances, jint numInstances) {
    AssetLoader* loader = (AssetLoader*) nativeLoader;
    using Handle = FilamentInstance*;
    Handle* ptrInstances = new Handle[numInstances];
    jlong asset = (jlong) loader->createInstancedAsset((const uint8_t*) data, (size_t) size,
            ptrInstances, numInstances);
    if (asset) {
        for (jint i = 0; i < numInstances; i++) {
            instances[i] = (jlong) ptrInstances[i];
        }
    }
    delete[] ptrInstances;
    return asset;
}

extern "C" jlong nCreateInstance(jlong nativeLoader, jlong nativeAsset) {
    AssetLoader* loader = (AssetLoader*) nativeLoader;
    FilamentAsset* primary = (FilamentAsset*) nativeAsset;
    return (jlong) loader->createInstance(primary);
}

extern "C" void nEnableDiagnostics(jlong nativeLoader, jboolean enable) {
    AssetLoader* loader = (AssetLoader*) nativeLoader;
    loader->enableDiagnostics(enable);
}

extern "C" void nDestroyAsset(jlong nativeLoader, jlong nativeAsset) {
    AssetLoader* loader = (AssetLoader*) nativeLoader;
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    loader->destroyAsset(asset);
}
