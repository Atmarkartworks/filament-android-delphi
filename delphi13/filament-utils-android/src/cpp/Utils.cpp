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

// Delphi13 変換済み — JNI 除去版
// 変換: JNI_OnLoad + RegisterNatives パターン → extern "C" 直接宣言に変更
//       AutoBuffer (NioUtils) 除去 → const void* buffer + jint size に置換
//       jfloatArray → float* (呼び出し元がバッファを確保)
//       KTX1Loader, HDRLoader の各関数を extern "C" で公開

#include <jni.h>

#include <filament/Engine.h>
#include <filament/IndirectLight.h>
#include <filament/Skybox.h>
#include <filament/Texture.h>

#include <ktxreader/Ktx1Reader.h>

using namespace filament;
using namespace filament::math;
using namespace image;
using namespace ktxreader;

// =============================================================================
// KTX1Loader
// =============================================================================

// buffer: raw KTX1 file bytes; size: byte count
extern "C" jlong nCreateKTXTexture(jlong nativeEngine,
        const void* buffer, jint size, jboolean srgb) {
    Engine* engine = (Engine*) nativeEngine;
    Ktx1Bundle* bundle = new Ktx1Bundle((const uint8_t*) buffer, (uint32_t) size);
    return (jlong) Ktx1Reader::createTexture(engine, *bundle, srgb, [](void* userdata) {
        Ktx1Bundle* bundle = (Ktx1Bundle*) userdata;
        delete bundle;
    }, bundle);
}

// sphericalHarmonics: float[9*3] = 27 floats (row-major float3[9])
extern "C" jlong nCreateIndirectLight(jlong nativeEngine, jlong ktxTexture,
        const float* sphericalHarmonics) {
    Engine* engine  = (Engine*)  nativeEngine;
    Texture* cubemap = (Texture*) ktxTexture;
    IndirectLight* indirectLight =
            IndirectLight::Builder()
                    .reflections(cubemap)
                    .irradiance(3, reinterpret_cast<const filament::math::float3*>(sphericalHarmonics))
                    .intensity(30000)
                    .build(*engine);
    return (jlong) indirectLight;
}

extern "C" jlong nCreateSkybox(jlong nativeEngine, jlong ktxTexture) {
    Engine*  engine  = (Engine*)  nativeEngine;
    Texture* cubemap = (Texture*) ktxTexture;
    return (jlong) Skybox::Builder().environment(cubemap).showSun(true).build(*engine);
}

// outSphericalHarmonics: caller-allocated float[27]
// Returns JNI_TRUE on success, JNI_FALSE on failure.
extern "C" jboolean nGetSphericalHarmonics(const void* buffer, jint size,
        float* outSphericalHarmonics) {
    Ktx1Bundle bundle((const uint8_t*) buffer, (uint32_t) size);
    return bundle.getSphericalHarmonics(
        reinterpret_cast<filament::math::float3*>(outSphericalHarmonics)
    ) ? JNI_TRUE : JNI_FALSE;
}
