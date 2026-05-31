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

#include <filament/Camera.h>


#include <utils/Entity.h>

#include <math/mat4.h>

using namespace filament;

extern "C" void nSetProjection(jlong nativeCamera,
        jint projection, jdouble left, jdouble right, jdouble bottom, jdouble top, jdouble near,
        jdouble far) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setProjection((Camera::Projection) projection, left, right, bottom, top, near, far);
}

extern "C" void nSetProjectionFov(jlong nativeCamera, jdouble fovInDegrees, jdouble aspect, jdouble near, jdouble far,
        jint fov) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setProjection(fovInDegrees, aspect, near, far, (Camera::Fov) fov);
}

extern "C" jdouble nGetFieldOfViewInDegrees(jlong nativeCamera, jint direction) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getFieldOfViewInDegrees((Camera::Fov) direction);
}

extern "C" void nSetLensProjection(jlong nativeCamera, jdouble focalLength, jdouble aspect, jdouble near, jdouble far) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setLensProjection(focalLength, aspect, near, far);
}

extern "C" void nSetCustomProjection(jlong nativeCamera, double* inProjection, double* inProjectionForCulling,
        jdouble near, jdouble far) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setCustomProjection(
            *reinterpret_cast<const filament::math::mat4 *>(inProjection),
            *reinterpret_cast<const filament::math::mat4 *>(inProjectionForCulling),
            near, far);
}

extern "C" void nSetCustomEyeProjection(jlong nativeCamera, double* inProjection, jint count, double* inProjectionForCulling,
        jdouble near, jdouble far) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setCustomEyeProjection(
            reinterpret_cast<const filament::math::mat4 *>(inProjection), (size_t) count,
            *reinterpret_cast<const filament::math::mat4 *>(inProjectionForCulling),
            near, far);
}

extern "C" void nSetScaling(jlong nativeCamera, jdouble x, jdouble y) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setScaling({(double)x, (double)y});
}

extern "C" void nSetShift(jlong nativeCamera, jdouble x, jdouble y) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setShift({(double)x, (double)y});
}

extern "C" void nGetShift(jlong nativeCamera, double* out) {
    Camera *camera = (Camera *) nativeCamera;
    filament::math::double2 s = camera->getShift();
    out[0] = s.x;
    out[1] = s.y;
}

extern "C" void nLookAt(jlong nativeCamera,
        jdouble eye_x, jdouble eye_y, jdouble eye_z, jdouble center_x, jdouble center_y,
        jdouble center_z, jdouble up_x, jdouble up_y, jdouble up_z) {
    Camera *camera = (Camera *) nativeCamera;
    camera->lookAt({eye_x, eye_y, eye_z}, {center_x, center_y, center_z}, {up_x, up_y, up_z});
}

extern "C" jdouble nGetNear(jlong nativeCamera) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getNear();
}

extern "C" jdouble nGetCullingFar(jlong nativeCamera) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getCullingFar();
}

extern "C" void nSetModelMatrix(jlong nativeCamera, float* in) {
    Camera* camera = (Camera *) nativeCamera;
    camera->setModelMatrix((math::mat4)*reinterpret_cast<const filament::math::mat4f*>(in));
}

extern "C" void nSetModelMatrixFp64(jlong nativeCamera, double* in) {
    Camera* camera = (Camera *) nativeCamera;
    camera->setModelMatrix(*reinterpret_cast<const filament::math::mat4*>(in));
}

extern "C" void nSetEyeModelMatrix(jlong nativeCamera, jint eyeId, double* model) {
    Camera* camera = (Camera *) nativeCamera;
    camera->setEyeModelMatrix((uint8_t)eyeId, *reinterpret_cast<const filament::math::mat4*>(model));
}

extern "C" void nGetProjectionMatrix(jlong nativeCamera, double* out) {
    Camera *camera = (Camera *) nativeCamera;
    const filament::math::mat4& m = camera->getProjectionMatrix();
    std::copy_n(&m[0][0], 16, out);
}

extern "C" void nGetCullingProjectionMatrix(jlong nativeCamera, double* out) {
    Camera *camera = (Camera *) nativeCamera;
    const filament::math::mat4& m = camera->getCullingProjectionMatrix();
    std::copy_n(&m[0][0], 16, out);
}

extern "C" void nGetScaling(jlong nativeCamera, double* out) {
    Camera *camera = (Camera *) nativeCamera;
    const filament::math::double4& s = camera->getScaling();
    std::copy_n(&s[0], 4, out);
}

extern "C" void nGetModelMatrix(jlong nativeCamera, float* out) {
    Camera *camera = (Camera *) nativeCamera;
    const filament::math::mat4f& m = (math::mat4f)camera->getModelMatrix();
    std::copy_n(&m[0][0], 16, out);
}

extern "C" void nGetModelMatrixFp64(jlong nativeCamera, double* out) {
    Camera *camera = (Camera *) nativeCamera;
    const filament::math::mat4& m = camera->getModelMatrix();
    std::copy_n(&m[0][0], 16, out);
}

extern "C" void nGetViewMatrix(jlong nativeCamera,
        float* out) {
    Camera *camera = (Camera *) nativeCamera;
    const filament::math::mat4f& m = (math::mat4f)camera->getViewMatrix();
    std::copy_n(&m[0][0], 16, out);
}

extern "C" void nGetViewMatrixFp64(jlong nativeCamera,
        double* out) {
    Camera *camera = (Camera *) nativeCamera;
    const filament::math::mat4& m = camera->getViewMatrix();
    std::copy_n(&m[0][0], 16, out);
}

extern "C" void nGetPosition(jlong nativeCamera,
        float* out) {
    Camera *camera = (Camera *) nativeCamera;
    reinterpret_cast<filament::math::float3&>(*out) = camera->getPosition();
}

extern "C" void nGetLeftVector(jlong nativeCamera,
        float* out) {
    Camera *camera = (Camera *) nativeCamera;
    reinterpret_cast<filament::math::float3&>(*out) = camera->getLeftVector();
}

extern "C" void nGetUpVector(jlong nativeCamera,
        float* out) {
    Camera *camera = (Camera *) nativeCamera;
    reinterpret_cast<filament::math::float3&>(*out) = camera->getUpVector();
}

extern "C" void nGetForwardVector(jlong nativeCamera, float* out) {
    Camera *camera = (Camera *) nativeCamera;
    reinterpret_cast<filament::math::float3&>(*out) = camera->getForwardVector();
}

extern "C" void nSetExposure(jlong nativeCamera,
        jfloat aperture, jfloat shutterSpeed, jfloat sensitivity) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setExposure(aperture, shutterSpeed, sensitivity);
}

extern "C" jfloat nGetAperture(jlong nativeCamera) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getAperture();
}

extern "C" jfloat nGetShutterSpeed(jlong nativeCamera) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getShutterSpeed();
}

extern "C" jfloat nGetSensitivity(jlong nativeCamera) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getSensitivity();
}

extern "C" void nSetFocusDistance(jlong nativeCamera, jfloat focusDistance) {
    Camera *camera = (Camera *) nativeCamera;
    camera->setFocusDistance(focusDistance);
}

extern "C" jfloat nGetFocusDistance(jlong nativeCamera) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getFocusDistance();
}

extern "C" jdouble nGetFocalLength(jlong nativeCamera) {
    Camera *camera = (Camera *) nativeCamera;
    return camera->getFocalLength();
}

extern "C" jdouble nComputeEffectiveFocalLength(jdouble focalLength, jdouble focusDistance) {
    return Camera::computeEffectiveFocalLength(focalLength, focusDistance);
}

extern "C" jdouble nComputeEffectiveFov(jdouble fovInDegrees, jdouble focusDistance) {
    return Camera::computeEffectiveFov(fovInDegrees, focusDistance);
}



