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

#include <jni.h>

#include <filament/Engine.h>

#include <gltfio/ResourceLoader.h>
#include <gltfio/TextureProvider.h>

#include <utils/Log.h>

#include "common/NioUtils.h"

using namespace filament;
using namespace filament::gltfio;
using namespace utils;

extern "C" jlong nCreateResourceLoader(jlong nativeEngine, jboolean normalizeSkinningWeights) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) new ResourceLoader({ engine, {}, (bool) normalizeSkinningWeights});
}

extern "C" void nDestroyResourceLoader(jlong nativeLoader) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    delete loader;
}

extern "C" void nAddResourceData(jlong nativeLoader, const char* url,
        const void* data, jint size) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    ResourceLoader::BufferDescriptor descriptor(data, size);
    loader->addResourceData(url, std::move(descriptor));
}

extern "C" jboolean nHasResourceData(jlong nativeLoader, const char* url) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    return loader->hasResourceData(url);
}

extern "C" void nEvictResourceData(jlong nativeLoader) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    loader->evictResourceData();
}

extern "C" void nLoadResources(jlong nativeLoader, jlong nativeAsset) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    loader->loadResources(asset);
}

extern "C" jboolean nAsyncBeginLoad(jlong nativeLoader, jlong nativeAsset) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return loader->asyncBeginLoad(asset);
}

extern "C" jfloat nAsyncGetLoadProgress(jlong nativeLoader) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    return loader->asyncGetLoadProgress();
}

extern "C" void nAsyncUpdateLoad(jlong nativeLoader) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    loader->asyncUpdateLoad();
}

extern "C" void nAsyncCancelLoad(jlong nativeLoader) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    loader->asyncCancelLoad();
}

extern "C" jlong nCreateStbProvider(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) createStbProvider(engine);
}

extern "C" jlong nCreateKtx2Provider(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) createKtx2Provider(engine);
}

extern "C" jboolean nIsWebpSupported() {
    return (jboolean) isWebpSupported();
}

extern "C" jlong nCreateWebpProvider(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) createWebpProvider(engine);
}

extern "C" void nDestroyTextureProvider(jlong nativeProvider) {
    TextureProvider* provider = (TextureProvider*) nativeProvider;
    delete provider;
}

extern "C" void nAddTextureProvider(jlong nativeLoader, const char* url, jlong nativeProvider) {
    ResourceLoader* loader = (ResourceLoader*) nativeLoader;
    TextureProvider* provider = (TextureProvider*) nativeProvider;
    loader->addTextureProvider(url, provider);
}
