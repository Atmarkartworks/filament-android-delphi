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

#include <geometry/SurfaceOrientation.h>

#include <algorithm>

using namespace filament;
using namespace filament::geometry;
using namespace filament::math;

namespace {
    struct JniWrapper {
        SurfaceOrientation::Builder* builder;
    };
}

extern "C" jlong nCreateBuilder() {
    JniWrapper* wrapper = new JniWrapper();
    wrapper->builder = new SurfaceOrientation::Builder();
    return (jlong) wrapper;
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    auto wrapper = (JniWrapper*) nativeBuilder;
    delete wrapper->builder;
    delete wrapper;
}

extern "C" void nBuilderVertexCount(jlong nativeBuilder, int vertexCount) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->vertexCount(vertexCount);
}

extern "C" void nBuilderTriangleCount(jlong nativeBuilder, int triangleCount) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->triangleCount(triangleCount);
}

extern "C" void nBuilderNormals(jlong nativeBuilder, const void* data, int stride) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->normals((const float3 *) data, stride);
}

extern "C" void nBuilderTangents(jlong nativeBuilder, const void* data, int stride) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->tangents((const float4 *) data, stride);
}

extern "C" void nBuilderUVs(jlong nativeBuilder, const void* data, int stride) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->uvs((const float2 *) data, stride);
}

extern "C" void nBuilderPositions(jlong nativeBuilder, const void* data, int stride) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->positions((const float3 *) data, stride);
}

extern "C" void nBuilderTriangles16(jlong nativeBuilder, const void* data) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->triangles((const ushort3 *) data);
}

extern "C" void nBuilderTriangles32(jlong nativeBuilder, const void* data) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    wrapper->builder->triangles((const uint3 *) data);
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder) {
    auto wrapper = (JniWrapper *) nativeBuilder;
    return (jlong) wrapper->builder->build();
}

extern "C" jint nGetVertexCount(jlong nativeObject) {
    SurfaceOrientation* helper = (SurfaceOrientation*) nativeObject;
    return helper->getVertexCount();
}

extern "C" void nGetQuatsAsFloat(jlong nativeObject, void* buffer, int count) {
    SurfaceOrientation* helper = (SurfaceOrientation*) nativeObject;
    helper->getQuats((quatf*) buffer, (size_t) count);
}

extern "C" void nGetQuatsAsHalf(jlong nativeObject, void* buffer, int count) {
    SurfaceOrientation* helper = (SurfaceOrientation*) nativeObject;
    helper->getQuats((quath*) buffer, (size_t) count);
}

extern "C" void nGetQuatsAsShort(jlong nativeObject, void* buffer, int count) {
    SurfaceOrientation* helper = (SurfaceOrientation*) nativeObject;
    helper->getQuats((short4*) buffer, (size_t) count);
}

extern "C" void nDestroy(jlong nativeSurfaceOrientation) {
    SurfaceOrientation* helper = (SurfaceOrientation*) nativeSurfaceOrientation;
    delete helper;
}

