/*
 * Copyright (C) 2020 The Android Open Source Project
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

#include <gltfio/FilamentInstance.h>

#include <algorithm>

using namespace filament;
using namespace filament::gltfio;
using namespace utils;

extern "C" jint nInstanceGetRoot(jlong nativeInstance) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    return instance->getRoot().getId();
}

extern "C" jint nInstanceGetEntityCount(jlong nativeInstance) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    return instance->getEntityCount();
}

extern "C" void nInstanceGetEntities(jlong nativeInstance, jint* result, jint count) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    std::copy_n(instance->getEntities(),
            std::min((size_t) count, instance->getEntityCount()), (Entity*) result);
}

extern "C" jlong nGetAnimator(jlong nativeInstance) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    return (jlong) instance->getAnimator();
}

extern "C" void nApplyMaterialVariant(jlong nativeInstance, jint variantIndex) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    instance->applyMaterialVariant(variantIndex);
}

extern "C" jint nGetMaterialVariantCount(jlong nativeInstance) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    return (jint) instance->getMaterialVariantCount();
}

// Fills result[0..count-1] with per-index variant name pointers (valid while instance is alive).
extern "C" void nGetMaterialVariantNames(jlong nativeInstance, const char** result, jint count) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    for (int i = 0; i < count; ++i) {
        result[i] = instance->getMaterialVariantName(i);
    }
}

extern "C" jint nGetMaterialInstanceCount(jlong nativeInstance) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    return instance->getMaterialInstanceCount();
}

extern "C" void nGetMaterialInstances(jlong nativeInstance, jlong* result, jint count) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    jint copyCount = std::min((jint) instance->getMaterialInstanceCount(), count);
    const MaterialInstance* const* src = instance->getMaterialInstances();
    for (jint i = 0; i < copyCount; i++) {
        result[i] = (jlong) src[i];
    }
}

extern "C" void nAttachSkin(jlong nativeInstance, jint skinIndex, jint targetEntity) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    Entity target = Entity::import(targetEntity);
    instance->attachSkin(skinIndex, target);
}

extern "C" void nDetachSkin(jlong nativeInstance, jint skinIndex, jint targetEntity) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    Entity target = Entity::import(targetEntity);
    instance->detachSkin(skinIndex, target);
}

extern "C" jint nGetSkinCount(jlong nativeInstance) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    return (jint) instance->getSkinCount();
}

// Fills result[0..count-1] with per-index skin name pointers (valid while instance is alive).
extern "C" void nGetSkinNames(jlong nativeInstance, const char** result, jint count) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    for (int i = 0; i < count; ++i) {
        result[i] = instance->getSkinNameAt(i);
    }
}

extern "C" jint nGetJointCountAt(jlong nativeInstance, jint skinIndex) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    return (jint) instance->getJointCountAt(skinIndex);
}

extern "C" void nGetJointsAt(jlong nativeInstance, jint skinIndex, jint* result, jint count) {
    FilamentInstance* instance = (FilamentInstance*) nativeInstance;
    std::copy_n(instance->getJointsAt(skinIndex),
        std::min((size_t) count, instance->getJointCountAt(skinIndex)), (Entity*) result);
}
