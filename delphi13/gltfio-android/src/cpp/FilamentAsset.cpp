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

#include <gltfio/FilamentAsset.h>

using namespace filament;
using namespace filament::math;
using namespace filament::gltfio;
using namespace utils;

extern "C" jint nAssetGetRoot(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getRoot().getId();
}

extern "C" jint nPopRenderable(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->popRenderable().getId();
}

extern "C" jint nPopRenderables(jlong nativeAsset, jint* result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return (jint) asset->popRenderables((Entity*) result, (size_t) count);
}

extern "C" jint nAssetGetEntityCount(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getEntityCount();
}

extern "C" void nAssetGetEntities(jlong nativeAsset, jint* result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    std::copy_n(asset->getEntities(),
            std::min((size_t) count, asset->getEntityCount()), (Entity*) result);
}

extern "C" jint nGetFirstEntityByName(jlong nativeAsset, const char* name) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getFirstEntityByName(name).getId();
}

extern "C" jint nGetEntitiesByName(jlong nativeAsset, const char* name, jint* result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    if (result == nullptr) {
        return (jint) asset->getEntitiesByName(name, nullptr, 0);
    }
    size_t numEntities = asset->getEntitiesByName(name, (Entity*) result, (size_t) count);
    return (jint) numEntities;
}

extern "C" jint nGetEntitiesByPrefix(jlong nativeAsset, const char* prefix, jint* result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    if (result == nullptr) {
        return (jint) asset->getEntitiesByPrefix(prefix, nullptr, 0);
    }
    size_t numEntities = asset->getEntitiesByPrefix(prefix, (Entity*) result, (size_t) count);
    return (jint) numEntities;
}

extern "C" jint nGetLightEntityCount(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getLightEntityCount();
}

extern "C" void nGetLightEntities(jlong nativeAsset, jint* result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    const size_t minCount = std::min((size_t) count, asset->getLightEntityCount());
    if (minCount == 0) {
        return;
    }
    std::copy_n(asset->getLightEntities(), minCount, (Entity*) result);
}

extern "C" jint nGetRenderableEntityCount(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getRenderableEntityCount();
}

extern "C" void nGetRenderableEntities(jlong nativeAsset, jint* result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    const size_t minCount = std::min((size_t) count, asset->getRenderableEntityCount());
    if (minCount == 0) {
        return;
    }
    std::copy_n(asset->getRenderableEntities(), minCount, (Entity*) result);
}

extern "C" void nGetCameraEntities(jlong nativeAsset, jint* result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    const size_t minCount = std::min((size_t) count, asset->getCameraEntityCount());
    if (minCount == 0) {
        return;
    }
    std::copy_n(asset->getCameraEntities(), minCount, (Entity*) result);
}

extern "C" jint nGetCameraEntityCount(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getCameraEntityCount();
}

extern "C" void nGetBoundingBox(jlong nativeAsset, jfloat* result) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    const filament::Aabb box = asset->getBoundingBox();
    const float3 center = box.center();
    const float3 extent = box.extent();
    result[0] = center.x;
    result[1] = center.y;
    result[2] = center.z;
    result[3] = extent.x;
    result[4] = extent.y;
    result[5] = extent.z;
}

extern "C" const char* nGetName(jlong nativeAsset, jint entityId) {
    Entity entity = Entity::import(entityId);
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getName(entity);
}

extern "C" const char* nGetExtras(jlong nativeAsset, jint entityId) {
    Entity entity = Entity::import(entityId);
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getExtras(entity);
}

extern "C" jlong nGetInstance(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return (jlong) asset->getInstance();
}

extern "C" jint nGetResourceUriCount(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return (jint) asset->getResourceUriCount();
}

// Returns pointer to the internal array of C strings (valid while asset is alive).
extern "C" const char* const* nGetResourceUris(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    return asset->getResourceUris();
}

extern "C" jint nGetMorphTargetCount(jlong nativeAsset, jint entityId) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    Entity entity = Entity::import(entityId);
    return (jint) asset->getMorphTargetCountAt(entity);
}

// Fills result[0..count-1] with per-index morph target name pointers (valid while asset is alive).
extern "C" void nGetMorphTargetNames(jlong nativeAsset, jint entityId, const char** result, jint count) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    Entity entity = Entity::import(entityId);
    for (int i = 0; i < count; ++i) {
        result[i] = asset->getMorphTargetNameAt(entity, i);
    }
}

extern "C" void nReleaseSourceData(jlong nativeAsset) {
    FilamentAsset* asset = (FilamentAsset*) nativeAsset;
    asset->releaseSourceData();
}
