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

// Delphi13 変換済み — JNI 除去版
// 変換: Java_com_google_android_filament_utils_AutomationEngine_ プレフィックス除去
//       JNIEnv*, jclass/klass 第1・第2引数除去
//       jstring  → const char*  (呼び出し元が UTF-8 PAnsiChar を渡す)
//       jlongArray / jintArray → const jlong* / const jint* + count 引数
//       jobject result → FUViewerOptions* / FUCameraSettings* 構造体ポインタ

#include <jni.h>

#include <viewer/AutomationEngine.h>

using namespace filament;
using namespace filament::viewer;
using namespace utils;

// =============================================================================
// Output structs for nGetViewerOptions / nGetCameraSettings
// (replaces jobject JNI reflection pattern)
// =============================================================================

struct FUViewerOptions {
    jfloat  groundShadowStrength;
    jboolean groundPlaneEnabled;
    jboolean skyboxEnabled;
    jboolean autoScaleEnabled;
    jboolean autoInstancingEnabled;
};

struct FUCameraSettings {
    jfloat aperture;
    jfloat shutterSpeed;
    jfloat sensitivity;
    jfloat near_;
    jfloat far_;
    jfloat focalLength;
    jfloat focusDistance;
};

// =============================================================================
// Lifecycle
// =============================================================================

// spec: UTF-8 JSON specification string
extern "C" jlong nCreateAutomationEngine(const char* spec) {
    return (jlong) AutomationEngine::createFromJSON(spec, strlen(spec));
}

extern "C" jlong nCreateDefaultAutomationEngine() {
    return (jlong) AutomationEngine::createDefault();
}

extern "C" void nSetOptions(jlong nativeAutomation,
        jfloat sleepDuration, jint minFrameCount, jboolean verbose) {
    AutomationEngine* automation = (AutomationEngine*) nativeAutomation;
    AutomationEngine::Options options = {
        .sleepDuration    = sleepDuration,
        .minFrameCount    = minFrameCount,
        .verbose          = (bool) verbose,
        // Filesystem export disabled on Android — keep disabled on Delphi side too
        .exportScreenshots = false,
        .exportSettings    = false,
    };
    automation->setOptions(options);
}

extern "C" void nStartRunning(jlong nativeAutomation) {
    AutomationEngine* automation = (AutomationEngine*) nativeAutomation;
    automation->startRunning();
}

extern "C" void nStartBatchMode(jlong nativeAutomation) {
    AutomationEngine* automation = (AutomationEngine*) nativeAutomation;
    automation->startBatchMode();
}

// =============================================================================
// Tick — materials/assetLights passed as plain pointer + count
// =============================================================================

extern "C" void nTick(
        jlong nativeAutomation, jlong nativeEngine,
        jlong view,
        const jlong* materials, jint materialCount,
        jlong renderer, jlong nativeIbl, jint sunlightEntity,
        const jint* assetLights, jint lightCount,
        jlong nativeLm, jlong scene,
        jfloat deltaTime) {
    using MaterialPointer = MaterialInstance*;

    MaterialPointer* ptrMaterials = nullptr;
    if (materials && materialCount > 0) {
        ptrMaterials = new MaterialPointer[materialCount];
        for (jint i = 0; i < materialCount; i++) {
            ptrMaterials[i] = (MaterialPointer) materials[i];
        }
    }

    static_assert(sizeof(jint) == sizeof(Entity));

    AutomationEngine* automation = (AutomationEngine*) nativeAutomation;
    AutomationEngine::ViewerContent content = {
        .view            = (View*)          view,
        .renderer        = (Renderer*)      renderer,
        .materials       = ptrMaterials,
        .materialCount   = (size_t)         materialCount,
        .lightManager    = (LightManager*)  nativeLm,
        .scene           = (Scene*)         scene,
        .indirectLight   = (IndirectLight*) nativeIbl,
        .sunlight        = (Entity&)        sunlightEntity,
        .assetLights     = (Entity*)        assetLights,
        .assetLightCount = (size_t)         lightCount,
    };
    Engine* engine = (Engine*) nativeEngine;
    automation->tick(engine, content, deltaTime);

    delete[] ptrMaterials;
}

// =============================================================================
// ApplySettings — json passed as const char* + length
// =============================================================================

extern "C" void nApplySettings(
        jlong nativeAutomation, jlong nativeEngine,
        const char* json, jint jsonLength,
        jlong view,
        const jlong* materials, jint materialCount,
        jlong nativeIbl, jint sunlightEntity,
        const jint* assetLights, jint lightCount,
        jlong nativeLm, jlong scene, jlong renderer) {
    using MaterialPointer = MaterialInstance*;

    MaterialPointer* ptrMaterials = nullptr;
    if (materials && materialCount > 0) {
        ptrMaterials = new MaterialPointer[materialCount];
        for (jint i = 0; i < materialCount; i++) {
            ptrMaterials[i] = (MaterialPointer) materials[i];
        }
    }

    static_assert(sizeof(jint) == sizeof(Entity));

    AutomationEngine* automation = (AutomationEngine*) nativeAutomation;
    size_t length = (jsonLength > 0) ? (size_t) jsonLength : strlen(json);

    AutomationEngine::ViewerContent content = {
        .view            = (View*)          view,
        .renderer        = (Renderer*)      renderer,
        .materials       = ptrMaterials,
        .materialCount   = (size_t)         materialCount,
        .lightManager    = (LightManager*)  nativeLm,
        .scene           = (Scene*)         scene,
        .indirectLight   = (IndirectLight*) nativeIbl,
        .sunlight        = (Entity&)        sunlightEntity,
        .assetLights     = (Entity*)        assetLights,
        .assetLightCount = (size_t)         lightCount,
    };
    Engine* engine = (Engine*) nativeEngine;
    automation->applySettings(engine, json, length, content);

    delete[] ptrMaterials;
}

// =============================================================================
// Query settings — jobject replaced with struct pointer
// =============================================================================

extern "C" void nGetViewerOptions(jlong nativeObject, FUViewerOptions* result) {
    AutomationEngine* automation = (AutomationEngine*) nativeObject;
    const auto& options = automation->getSettings().viewer;
    result->groundShadowStrength  = options.groundShadowStrength;
    result->groundPlaneEnabled    = (jboolean) options.groundPlaneEnabled;
    result->skyboxEnabled         = (jboolean) options.skyboxEnabled;
    result->autoScaleEnabled      = (jboolean) options.autoScaleEnabled;
    result->autoInstancingEnabled = (jboolean) options.autoInstancingEnabled;
}

extern "C" void nGetCameraSettings(jlong nativeObject, FUCameraSettings* result) {
    AutomationEngine* automation = (AutomationEngine*) nativeObject;
    const auto& camera = automation->getSettings().camera;
    result->aperture       = camera.aperture;
    result->shutterSpeed   = camera.shutterSpeed;
    result->sensitivity    = camera.sensitivity;
    result->near_          = camera.near;
    result->far_           = camera.far;
    result->focalLength    = camera.focalLength;
    result->focusDistance  = camera.focusDistance;
}

// =============================================================================
// Misc
// =============================================================================

extern "C" jlong nGetColorGrading(jlong nativeObject, jlong nativeEngine) {
    AutomationEngine* automation = (AutomationEngine*) nativeObject;
    return (jlong) automation->getColorGrading((Engine*) nativeEngine);
}

extern "C" void nSignalBatchMode(jlong native) {
    AutomationEngine* automation = (AutomationEngine*) native;
    automation->signalBatchMode();
}

extern "C" void nStopRunning(jlong native) {
    AutomationEngine* automation = (AutomationEngine*) native;
    automation->stopRunning();
}

extern "C" jboolean nShouldClose(jlong native) {
    AutomationEngine* automation = (AutomationEngine*) native;
    return automation->shouldClose();
}

extern "C" jint nGetTestCount(jlong native) {
    AutomationEngine* automation = (AutomationEngine*) native;
    return (jint) automation->testCount();
}

extern "C" jint nGetCurrentTest(jlong native) {
    AutomationEngine* automation = (AutomationEngine*) native;
    return (jint) automation->currentTest();
}

extern "C" void nDestroy(jlong native) {
    AutomationEngine* automation = (AutomationEngine*) native;
    delete automation;
}
