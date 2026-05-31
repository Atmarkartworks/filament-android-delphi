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

#include <utils/EntityManager.h>

using namespace utils;

static_assert(sizeof(jint) == sizeof(Entity), "jint and Entity are not compatible!!");

extern "C" jlong nGetEntityManager() {
    return (jlong) &EntityManager::get();
}

extern "C" void nCreateArray(jlong nativeEntityManager, jint n, jint* entities) {
    EntityManager* em = (EntityManager *) nativeEntityManager;
    em->create((size_t) n, reinterpret_cast<Entity *>(entities));
}

extern "C" jint nCreate(jlong nativeEntityManager) {
    EntityManager* em = (EntityManager *) nativeEntityManager;
    return em->create().getId();
}

extern "C" void nDestroyArray(jlong nativeEntityManager, jint n, jint* entities) {
    EntityManager* em = (EntityManager *) nativeEntityManager;
    em->destroy((size_t) n, reinterpret_cast<Entity*>(entities));
}

extern "C" void nDestroy(jlong nativeEntityManager, jint entity_) {
    EntityManager *em = (EntityManager *) nativeEntityManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    em->destroy(entity);
}

extern "C" jboolean nIsAlive(jlong nativeEntityManager, jint entity_) {
    EntityManager *em = (EntityManager *) nativeEntityManager;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    return (jboolean) em->isAlive(entity);
}

