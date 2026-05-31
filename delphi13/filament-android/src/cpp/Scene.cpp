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

#include <filament/Scene.h>

#include <utils/Entity.h>

using namespace filament;
using namespace utils;

extern "C" void nSetSkybox(jlong nativeScene,
        jlong nativeSkybox) {
    Scene* scene = (Scene*) nativeScene;
    Skybox* skybox = (Skybox*) nativeSkybox;
    scene->setSkybox(skybox);
}

extern "C" void nSetIndirectLight(jlong nativeScene, jlong nativeIndirectLight) {
    Scene *scene = (Scene *) nativeScene;
    IndirectLight* indirectLight = (IndirectLight*) nativeIndirectLight;
    scene->setIndirectLight(indirectLight);
}

extern "C" void nAddEntity(jlong nativeScene,
        jint entity) {
    Scene* scene = (Scene*) nativeScene;
    scene->addEntity((Entity&) entity);
}

extern "C" void nAddEntities(jlong nativeScene,
        jint* entities, jint count) {
    Scene* scene = (Scene*) nativeScene;
    for (jint i = 0; i < count; i++) {
        scene->addEntity((Entity&) entities[i]);
    }
}

extern "C" void nRemove(jlong nativeScene,
        jint entity) {
    Scene* scene = (Scene*) nativeScene;
    scene->remove((Entity&) entity);
}

extern "C" void nRemoveEntities(jlong nativeScene,
        jint* entities, jint count) {
    Scene* scene = (Scene*) nativeScene;
    for (jint i = 0; i < count; i++) {
        scene->remove((Entity&) entities[i]);
    }
}

extern "C" jint nGetEntityCount(jlong nativeScene) {
    Scene* scene = (Scene*) nativeScene;
    return (jint) scene->getEntityCount();
}

extern "C" jint nGetRenderableCount(jlong nativeScene) {
    Scene* scene = (Scene*) nativeScene;
    return (jint) scene->getRenderableCount();
}

extern "C" jint nGetLightCount(jlong nativeScene) {
    Scene* scene = (Scene*) nativeScene;
    return (jint) scene->getLightCount();
}

extern "C" jboolean nHasEntity(jlong nativeScene,
        jint entityId) {
    Scene* scene = (Scene*) nativeScene;
    Entity entity = Entity::import(entityId);
    return (jboolean) scene->hasEntity(entity);
}

extern "C"
jboolean nGetEntities(jlong nativeScene, jint* out, jint length) {
    Scene const* const scene = (Scene*) nativeScene;
    if (length < (jint)scene->getEntityCount()) {
        return JNI_FALSE;
    }
    int i = 0;
    scene->forEach([out, length, &i](Entity entity) {
        if (i < length) {
            out[i++] = (jint) entity.getId();
        }
    });
    return JNI_TRUE;
}

