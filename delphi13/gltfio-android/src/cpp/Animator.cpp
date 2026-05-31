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

#include <gltfio/Animator.h>

using namespace filament;
using namespace filament::math;
using namespace filament::gltfio;
using namespace utils;

extern "C" void nApplyAnimation(jlong nativeAnimator, jint index, jfloat time) {
    Animator* animator = (Animator*) nativeAnimator;
    animator->applyAnimation(static_cast<size_t>(index), time);
}

extern "C" void nUpdateBoneMatrices(jlong nativeAnimator) {
    Animator* animator = (Animator*) nativeAnimator;
    animator->updateBoneMatrices();
}

extern "C" void nApplyCrossFade(jlong nativeAnimator, jint previousAnimIndex, jfloat previousAnimTime, jfloat alpha) {
    Animator* animator = (Animator*) nativeAnimator;
    animator->applyCrossFade(previousAnimIndex, previousAnimTime, alpha);
}

extern "C" void nResetBoneMatrices(jlong nativeAnimator) {
    Animator* animator = (Animator*) nativeAnimator;
    animator->resetBoneMatrices();
}

extern "C" jint nGetAnimationCount(jlong nativeAnimator) {
    Animator* animator = (Animator*) nativeAnimator;
    return animator->getAnimationCount();
}

extern "C" float nGetAnimationDuration(jlong nativeAnimator, jint index) {
    Animator* animator = (Animator*) nativeAnimator;
    return animator->getAnimationDuration(static_cast<size_t>(index));
}

extern "C" const char* nGetAnimationName(jlong nativeAnimator, jint index) {
    Animator* animator = (Animator*) nativeAnimator;
    return animator->getAnimationName(static_cast<size_t>(index));
}
