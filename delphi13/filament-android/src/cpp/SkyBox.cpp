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

#include <filament/Skybox.h>

#include <math/vec4.h>

using namespace filament;

extern "C" jlong nCreateBuilder() {
    return (jlong) new Skybox::Builder{};
}

extern "C" void nDestroyBuilder(jlong nativeSkyBoxBuilder) {
    Skybox::Builder *builder = (Skybox::Builder *) nativeSkyBoxBuilder;
    delete builder;
}

extern "C" void nBuilderEnvironment(jlong nativeSkyBoxBuilder, jlong nativeTexture) {
    Skybox::Builder *builder = (Skybox::Builder *) nativeSkyBoxBuilder;
    Texture *texture = (Texture *) nativeTexture;
    builder->environment(texture);
}

extern "C" void nBuilderShowSun(jlong nativeSkyBoxBuilder, jboolean show) {
    Skybox::Builder *builder = (Skybox::Builder *) nativeSkyBoxBuilder;
    builder->showSun(show);
}

extern "C" void nBuilderIntensity(jlong nativeSkyBoxBuilder, jfloat intensity) {
    Skybox::Builder *builder = (Skybox::Builder *) nativeSkyBoxBuilder;
    builder->intensity(intensity);
}

extern "C" void nBuilderColor(jlong nativeSkyBoxBuilder, jfloat r, jfloat g, jfloat b, jfloat a) {
    Skybox::Builder *builder = (Skybox::Builder *) nativeSkyBoxBuilder;
    builder->color({r, g, b, a});
}

extern "C"
void nBuilderPriority(jlong nativeSkyBoxBuilder, jint priority) {
    Skybox::Builder *builder = (Skybox::Builder *) nativeSkyBoxBuilder;
    builder->priority(uint8_t(priority));
}

extern "C" jlong nBuilderBuild(jlong nativeSkyBoxBuilder, jlong nativeEngine) {
    Skybox::Builder *builder = (Skybox::Builder *) nativeSkyBoxBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return (jlong) builder->build(*engine);
}

extern "C" void nSetLayerMask(jlong nativeSkybox,
        jint select, jint value) {
    Skybox *skybox = (Skybox *) nativeSkybox;
    skybox->setLayerMask((uint8_t) select, (uint8_t) value);
}

extern "C" jint nGetLayerMask(jlong nativeSkybox) {
    Skybox *skybox = (Skybox *) nativeSkybox;
    return static_cast<jint>(skybox->getLayerMask());
}

extern "C" jfloat nGetIntensity(jlong nativeSkybox) {
    Skybox *skybox = (Skybox *) nativeSkybox;
    return static_cast<jint>(skybox->getIntensity());
}

extern "C" void nSetColor(jlong nativeSkybox, jfloat r, jfloat g, jfloat b, jfloat a) {
    Skybox *skybox = (Skybox *) nativeSkybox;
    skybox->setColor({r, g, b, a});
}

extern "C" jlong nGetTexture(jlong nativeSkybox) {
    Skybox *skybox = (Skybox *) nativeSkybox;
    Texture const *tex = skybox->getTexture();
    return (jlong) tex;
}

