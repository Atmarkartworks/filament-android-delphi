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

#include <filament/TransformManager.h>

#include <utils/Entity.h>

#include <math/mat4.h>

using namespace utils;
using namespace filament;

static_assert(sizeof(jint) == sizeof(Entity), "jint and Entity are not compatible!!");

extern "C" jboolean nHasComponent(jlong nativeTransformManager, jint entity_) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    return (jboolean) tm->hasComponent(entity);
}

extern "C" jint nGetInstance(jlong nativeTransformManager, jint entity_) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    return tm->getInstance(entity);
}

extern "C" jint nCreate(jlong nativeTransformManager, jint entity_) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    tm->create(entity);
    return tm->getInstance(entity);
}

extern "C" jint nCreateArray(jlong nativeTransformManager, jint entity_, jint parent,
        float* localTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    if (localTransform_) {
        tm->create(entity, (TransformManager::Instance) parent,
                *reinterpret_cast<const filament::math::mat4f *>(localTransform));
    } else {
        tm->create(entity, (TransformManager::Instance) parent);
    }
    return tm->getInstance(entity);
}

extern "C" jint nCreateArrayFp64(jlong nativeTransformManager, jint entity_, jint parent,
        double* localTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    if (localTransform_) {
        tm->create(entity, (TransformManager::Instance) parent,
                *reinterpret_cast<const filament::math::mat4 *>(localTransform));
    } else {
        tm->create(entity, (TransformManager::Instance) parent);
    }
    return tm->getInstance(entity);
}

extern "C" void nDestroy(jlong nativeTransformManager, jint entity_) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    tm->destroy(entity);
}

extern "C" void nSetParent(jlong nativeTransformManager, jint i, jint newParent) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    tm->setParent((TransformManager::Instance) i,
            (TransformManager::Instance) newParent);
}

extern "C" jint nGetParent(jlong nativeTransformManager, jint i) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    return tm->getParent((TransformManager::Instance) i).getId();
}

extern "C" jint nGetChildCount(jlong nativeTransformManager, jint i) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    return tm->getChildCount((TransformManager::Instance) i);
}

extern "C" void nGetChildren(jlong nativeTransformManager, jint i,
        jint* outEntities, jint count) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    // This is very very gross, we just pretend Entity is just like an jint
    // (which it is), but still.
    tm->getChildren((TransformManager::Instance) i,
            reinterpret_cast<Entity *>(entities), (size_t) count);
}

extern "C" void nSetTransform(jlong nativeTransformManager, jint i,
        float* localTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    tm->setTransform((TransformManager::Instance) i,
            *reinterpret_cast<const filament::math::mat4f *>(localTransform));
}

extern "C" void nSetTransformFp64(jlong nativeTransformManager, jint i,
        double* localTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    tm->setTransform((TransformManager::Instance) i,
            *reinterpret_cast<const filament::math::mat4 *>(localTransform));
}

extern "C" void nGetTransform(jlong nativeTransformManager, jint i,
        float* outLocalTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    *reinterpret_cast<filament::math::mat4f *>(outLocalTransform) = tm->getTransform(
            (TransformManager::Instance) i);
}

extern "C" void nGetTransformFp64(jlong nativeTransformManager, jint i,
        double* outLocalTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    *reinterpret_cast<filament::math::mat4 *>(outLocalTransform) = tm->getTransformAccurate(
            (TransformManager::Instance) i);
}

extern "C" void nGetWorldTransform(jlong nativeTransformManager, jint i,
        float* outWorldTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    *reinterpret_cast<filament::math::mat4f *>(outWorldTransform) = tm->getWorldTransform(
            (TransformManager::Instance) i);
}

extern "C" void nGetWorldTransformFp64(jlong nativeTransformManager, jint i,
        double* outWorldTransform) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    *reinterpret_cast<filament::math::mat4 *>(outWorldTransform) = tm->getWorldTransformAccurate(
            (TransformManager::Instance) i);
}

extern "C" void nOpenLocalTransformTransaction(
        JNIEnv*, jclass, jlong nativeTransformManager) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    tm->openLocalTransformTransaction();
}

extern "C" void nCommitLocalTransformTransaction(
        JNIEnv*, jclass, jlong nativeTransformManager) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    tm->commitLocalTransformTransaction();
}

extern "C"
void nSetAccurateTranslationsEnabled(jlong nativeTransformManager, jboolean enable) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    tm->setAccurateTranslationsEnabled((bool)enable);
}

extern "C"
jboolean nIsAccurateTranslationsEnabled(jlong nativeTransformManager) {
    TransformManager* tm = (TransformManager*) nativeTransformManager;
    return (jboolean)tm->isAccurateTranslationsEnabled();
}

