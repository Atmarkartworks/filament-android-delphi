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

#include <filament/Color.h>

using namespace filament;

extern "C" void nCct(jfloat temperature, float* color) {
    const LinearColor cct = Color::cct(temperature);
    color[0] = cct.r;
    color[1] = cct.g;
    color[2] = cct.b;
}

extern "C" void nIlluminantD(jfloat temperature, float* color) {
    const LinearColor illuminantD = Color::illuminantD(temperature);
    color[0] = illuminantD.r;
    color[1] = illuminantD.g;
    color[2] = illuminantD.b;
}

