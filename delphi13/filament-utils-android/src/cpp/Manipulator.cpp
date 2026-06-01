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

#include <math/mat3.h>
#include <math/vec3.h>

#include <camutils/Manipulator.h>

using namespace filament::camutils;
using namespace filament::math;

using Builder = Manipulator<float>::Builder;

extern "C" jlong nCreateBuilder() {
    return (jlong) new Builder {};
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    Builder* builder = (Builder*) nativeBuilder;
    delete builder;
}

extern "C" void nBuilderViewport(jlong nativeBuilder, jint width, jint height) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->viewport(width, height);
}

extern "C" void nBuilderTargetPosition(jlong nativeBuilder, jfloat x, jfloat y, jfloat z) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->targetPosition(x, y, z);
}

extern "C" void nBuilderUpVector(jlong nativeBuilder, jfloat x, jfloat y, jfloat z) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->upVector(x, y, z);
}

extern "C" void nBuilderZoomSpeed(jlong nativeBuilder, jfloat arg) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->zoomSpeed(arg);
}

extern "C" void nBuilderOrbitHomePosition(jlong nativeBuilder, jfloat x, jfloat y, jfloat z) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->orbitHomePosition(x, y, z);
}

extern "C" void nBuilderOrbitSpeed(jlong nativeBuilder, jfloat x, jfloat y) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->orbitSpeed(x, y);
}

extern "C" void nBuilderFovDirection(jlong nativeBuilder, jint arg) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->fovDirection((Fov) arg);
}

extern "C" void nBuilderFovDegrees(jlong nativeBuilder, jfloat arg) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->fovDegrees(arg);
}

extern "C" void nBuilderFarPlane(jlong nativeBuilder, jfloat distance) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->farPlane(distance);
}

extern "C" void nBuilderMapExtent(jlong nativeBuilder, jfloat width, jfloat height) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->mapExtent(width, height);
}

extern "C" void nBuilderMapMinDistance(jlong nativeBuilder, jfloat arg) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->mapMinDistance(arg);
}

extern "C" void nBuilderFlightStartPosition(jlong nativeBuilder, jfloat x, jfloat y, jfloat z) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->flightStartPosition(x, y, z);
}

extern "C" void nBuilderFlightStartOrientation(jlong nativeBuilder, jfloat pitch, jfloat yaw) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->flightStartOrientation(pitch, yaw);
}

extern "C" void nBuilderFlightMaxMoveSpeed(jlong nativeBuilder, jfloat maxSpeed) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->flightMaxMoveSpeed(maxSpeed);
}

extern "C" void nBuilderFlightSpeedSteps(jlong nativeBuilder, jint steps) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->flightSpeedSteps(steps);
}

extern "C" void nBuilderFlightPanSpeed(jlong nativeBuilder, jfloat x, jfloat y) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->flightPanSpeed(x, y);
}

extern "C" void nBuilderFlightMoveDamping(jlong nativeBuilder, jfloat damping) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->flightMoveDamping(damping);
}

extern "C" void nBuilderGroundPlane(jlong nativeBuilder, jfloat a, jfloat b, jfloat c, jfloat d) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->groundPlane(a, b, c, d);
}

extern "C" void nBuilderPanning(jlong nativeBuilder, jboolean enabled) {
    Builder* builder = (Builder*) nativeBuilder;
    builder->panning(enabled);
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder, jint mode) {
    Builder* builder = (Builder*) nativeBuilder;
    return (jlong) builder->build((Mode) mode);
}

extern "C" void nDestroyManipulator(jlong nativeManip) {
    auto manip = (Manipulator<float>*) nativeManip;
    delete manip;
}

extern "C" jint nGetMode(jlong nativeManip) {
    auto manip = (Manipulator<float>*) nativeManip;
    return (int) manip->getMode();
}

extern "C" void nSetViewport(jlong nativeManip, jint width, jint height) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->setViewport(width, height);
}

// getLookAt (float): each out-parameter is a caller-allocated float[3] buffer
extern "C" void nGetLookAtFloat(jlong nativeManip, float* eyePosition, float* targetPosition, float* upward) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->getLookAt((float3*) eyePosition, (float3*) targetPosition, (float3*) upward);
}

// getLookAt (double): each out-parameter is a caller-allocated double[3] buffer;
// Manipulator<float> result is widened to double on the way out
extern "C" void nGetLookAtDouble(jlong nativeManip, double* eyePosition, double* targetPosition, double* upward) {
    auto manip = (Manipulator<float>*) nativeManip;
    float3 eyef, targetf, upf;
    manip->getLookAt(&eyef, &targetf, &upf);
    *((double3*) eyePosition) = eyef;
    *((double3*) targetPosition) = targetf;
    *((double3*) upward) = upf;
}

// raycast: result is a caller-allocated float[3] buffer; returns JNI_TRUE if a point was found
extern "C" jboolean nRaycast(jlong nativeManip, jint x, jint y, float* result) {
    auto manip = (Manipulator<float>*) nativeManip;
    return (jboolean) manip->raycast(x, y, (float3*) result);
}

extern "C" void nGrabBegin(jlong nativeManip, jint x, jint y, jboolean strafe) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->grabBegin(x, y, (bool) strafe);
}

extern "C" void nGrabUpdate(jlong nativeManip, jint x, jint y) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->grabUpdate(x, y);
}

extern "C" void nGrabEnd(jlong nativeManip) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->grabEnd();
}

extern "C" void nKeyDown(jlong nativeManip, jint key) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->keyDown((Manipulator<float>::Key) key);
}

extern "C" void nKeyUp(jlong nativeManip, jint key) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->keyUp((Manipulator<float>::Key) key);
}

extern "C" void nScroll(jlong nativeManip, jint x, jint y, jfloat scrolldelta) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->scroll(x, y, scrolldelta);
}

extern "C" void nUpdate(jlong nativeManip, jfloat deltaTime) {
    auto manip = (Manipulator<float>*) nativeManip;
    manip->update(deltaTime);
}

extern "C" jlong nGetCurrentBookmark(jlong nativeManip) {
    auto manip = (Manipulator<float>*) nativeManip;
    return (jlong) new Bookmark<float>(manip->getCurrentBookmark());
}

extern "C" jlong nGetHomeBookmark(jlong nativeManip) {
    auto manip = (Manipulator<float>*) nativeManip;
    return (jlong) new Bookmark<float>(manip->getHomeBookmark());
}

extern "C" void nJumpToBookmark(jlong nativeManip, jlong nativeBookmark) {
    auto manip = (Manipulator<float>*) nativeManip;
    auto bookmark = (Bookmark<float>*) nativeBookmark;
    manip->jumpToBookmark(*bookmark);
}

