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

#include <filament/MaterialInstance.h>
#include <filament/Texture.h>
#include <filament/TextureSampler.h>

#include <math/mat3.h>
#include <math/mat4.h>
#include <math/vec2.h>
#include <math/vec3.h>
#include <math/vec4.h>

using namespace filament;
using namespace filament::math;

enum BooleanElement {
    BOOL,
    BOOL2,
    BOOL3,
    BOOL4
};

enum IntElement {
    INT,
    INT2,
    INT3,
    INT4
};

enum FloatElement {
    FLOAT,
    FLOAT2,
    FLOAT3,
    FLOAT4,
    MAT3,
    MAT4
};

template<typename T>
static void setParameter(jlong nativeMaterialInstance, const char* name, T v) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setParameter(name, v);
}

extern "C"
void nSetParameterBool(jlong nativeMaterialInstance, const char* name, jboolean x) {
    setParameter(nativeMaterialInstance, name, bool(x));
}

extern "C"
void nSetParameterBool2(jlong nativeMaterialInstance, const char* name, jboolean x, jboolean y) {
    setParameter(nativeMaterialInstance, name, bool2{x, y});
}

extern "C"
void nSetParameterBool3(jlong nativeMaterialInstance, const char* name, jboolean x, jboolean y, jboolean z) {
    setParameter(nativeMaterialInstance, name, bool3{x, y, z});
}

extern "C"
void nSetParameterBool4(jlong nativeMaterialInstance, const char* name,
        jboolean x, jboolean y, jboolean z, jboolean w) {
    setParameter(nativeMaterialInstance, name, bool4{x, y, z, w});
}

extern "C"
void nSetParameterInt(jlong nativeMaterialInstance, const char* name, jint x) {
    setParameter(nativeMaterialInstance, name, int32_t(x));
}

extern "C"
void nSetParameterInt2(jlong nativeMaterialInstance, const char* name, jint x, jint y) {
    setParameter(nativeMaterialInstance, name, int2{x, y});
}

extern "C"
void nSetParameterInt3(jlong nativeMaterialInstance, const char* name, jint x, jint y, jint z) {
    setParameter(nativeMaterialInstance, name, int3{x, y, z});
}

extern "C"
void nSetParameterInt4(jlong nativeMaterialInstance, const char* name,
        jint x, jint y, jint z, jint w) {
    setParameter(nativeMaterialInstance, name, int4{x, y, z, w});
}

extern "C"
void nSetParameterFloat(jlong nativeMaterialInstance, const char* name, jfloat x) {
    setParameter(nativeMaterialInstance, name, float(x));
}

extern "C"
void nSetParameterFloat2(jlong nativeMaterialInstance, const char* name, jfloat x, jfloat y) {
    setParameter(nativeMaterialInstance, name, float2{x, y});
}

extern "C"
void nSetParameterFloat3(jlong nativeMaterialInstance, const char* name, jfloat x, jfloat y, jfloat z) {
    setParameter(nativeMaterialInstance, name, float3{x, y, z});
}

extern "C"
void nSetParameterFloat4(jlong nativeMaterialInstance, const char* name,
        jfloat x, jfloat y, jfloat z, jfloat w) {
    setParameter(nativeMaterialInstance, name, float4{x, y, z, w});
}

extern "C"
void nSetBooleanParameterArray(jlong nativeMaterialInstance, const char* name, jint element,
        jboolean* v, jint offset, jint count) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;

    // NOTE: In C++, bool has an implementation-defined size. Here we assume
    // it has the same size as jboolean, which is 1 byte.

    switch ((BooleanElement) element) {
        case BOOL:
            instance->setParameter(name, ((const bool*) v) + offset, count);
            break;
        case BOOL2:
            instance->setParameter(name, ((const bool2*) v) + offset, count);
            break;
        case BOOL3:
            instance->setParameter(name, ((const bool3*) v) + offset, count);
            break;
        case BOOL4:
            instance->setParameter(name, ((const bool4*) v) + offset, count);
            break;
    }
}

extern "C"
void nSetIntParameterArray(jlong nativeMaterialInstance, const char* name, jint element,
        jint* v, jint offset, jint count) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;


    switch ((IntElement) element) {
        case INT:
            instance->setParameter(name, ((const int32_t*) v) + offset, count);
            break;
        case INT2:
            instance->setParameter(name, ((const int2*) v) + offset, count);
            break;
        case INT3:
            instance->setParameter(name, ((const int3*) v) + offset, count);
            break;
        case INT4:
            instance->setParameter(name, ((const int4*) v) + offset, count);
            break;
    }


}

extern "C"
void nSetFloatParameterArray(jlong nativeMaterialInstance, const char* name, jint element,
        float* v, jint offset, jint count) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;


    switch ((FloatElement) element) {
        case FLOAT:
            instance->setParameter(name, ((const float*) v) + offset, count);
            break;
        case FLOAT2:
            instance->setParameter(name, ((const float2*) v) + offset, count);
            break;
        case FLOAT3:
            instance->setParameter(name, ((const float3*) v) + offset, count);
            break;
        case FLOAT4:
            instance->setParameter(name, ((const float4*) v) + offset, count);
            break;
        case MAT3:
            instance->setParameter(name, ((const mat3f*) v) + offset, count);
            break;
        case MAT4:
            instance->setParameter(name, ((const mat4f*) v) + offset, count);
            break;
    }


}

// defined in TextureSampler.cpp
namespace filament::JniUtils {
    TextureSampler from_long(jlong params) noexcept;
} // TextureSamplerJniUtils

extern "C"
void nSetParameterTexture(
        jlong nativeMaterialInstance, const char* name,
        jlong nativeTexture, jlong sampler_) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    Texture* texture = (Texture*) nativeTexture;

    instance->setParameter(name, texture, JniUtils::from_long(sampler_));
}

extern "C"
void nSetScissor(
        jlong nativeMaterialInstance, jint left,
        jint bottom, jint width, jint height) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setScissor(left, bottom, width, height);
}

extern "C"
void nUnsetScissor(
        jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->unsetScissor();
}

extern "C"
void nSetPolygonOffset(jlong nativeMaterialInstance, jfloat scale, jfloat constant) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setPolygonOffset(scale, constant);
}

extern "C"
void nSetMaskThreshold(jlong nativeMaterialInstance, jfloat threshold) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setMaskThreshold(threshold);
}

extern "C"
void nSetSpecularAntiAliasingVariance(jlong nativeMaterialInstance, jfloat variance) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setSpecularAntiAliasingVariance(variance);
}

extern "C"
void nSetSpecularAntiAliasingThreshold(jlong nativeMaterialInstance, jfloat threshold) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setSpecularAntiAliasingThreshold(threshold);
}

extern "C"
void nSetDoubleSided(jlong nativeMaterialInstance, jboolean doubleSided) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setDoubleSided(doubleSided);
}

extern "C"
void nSetCullingMode(jlong nativeMaterialInstance, jlong cullingMode) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setCullingMode((MaterialInstance::CullingMode) cullingMode);
}


extern "C"
void nSetCullingModeSeparate(jlong nativeMaterialInstance,
        jlong colorPassCullingMode, jlong shadowPassCullingMode) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setCullingMode(
            (MaterialInstance::CullingMode) colorPassCullingMode,
            (MaterialInstance::CullingMode) shadowPassCullingMode);
}

extern "C"
void nSetColorWrite(jlong nativeMaterialInstance, jboolean enable) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setColorWrite(enable);
}

extern "C"
void nSetDepthWrite(jlong nativeMaterialInstance, jboolean enable) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setDepthWrite(enable);
}

extern "C"
void nSetStencilWrite(jlong nativeMaterialInstance, jboolean enable) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilWrite(enable);
}

extern "C"
void nSetDepthCulling(jlong nativeMaterialInstance, jboolean enable) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setDepthCulling(enable);
}

extern "C"
void nSetDepthFunc(jlong nativeMaterialInstance, jlong function) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setDepthFunc(static_cast<MaterialInstance::DepthFunc>(function));
}

extern "C"
void nSetStencilCompareFunction(jlong nativeMaterialInstance, jlong function, jlong face) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilCompareFunction(
            static_cast<MaterialInstance::StencilCompareFunc>(function),
            static_cast<MaterialInstance::StencilFace>(face));
}

extern "C"
void nSetStencilOpStencilFail(jlong nativeMaterialInstance, jlong op, jlong face) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilOpStencilFail(
            static_cast<MaterialInstance::StencilOperation>(op),
            static_cast<MaterialInstance::StencilFace>(face));
}

extern "C"
void nSetStencilOpDepthFail(jlong nativeMaterialInstance, jlong op, jlong face) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilOpDepthFail(
            static_cast<MaterialInstance::StencilOperation>(op),
            static_cast<MaterialInstance::StencilFace>(face));
}

extern "C"
void nSetStencilOpDepthStencilPass(jlong nativeMaterialInstance, jlong op, jlong face) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilOpDepthStencilPass(
            static_cast<MaterialInstance::StencilOperation>(op),
            static_cast<MaterialInstance::StencilFace>(face));
}

extern "C"
void nSetStencilReferenceValue(jlong nativeMaterialInstance, jint value, jlong face) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilReferenceValue(value, static_cast<MaterialInstance::StencilFace>(face));
}

extern "C"
void nSetStencilReadMask(jlong nativeMaterialInstance, jint readMask, jlong face) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilReadMask(readMask, static_cast<MaterialInstance::StencilFace>(face));
}

extern "C"
void nSetStencilWriteMask(jlong nativeMaterialInstance, jint writeMask, jlong face) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setStencilWriteMask(writeMask, static_cast<MaterialInstance::StencilFace>(face));
}

extern "C"
const char* nGetName(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    return instance->getName();
}

extern "C"
jlong nGetMaterial(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    return (jlong) instance->getMaterial();
}

extern "C"
jlong nDuplicate(jlong otherNativeMaterialInstance, const char* name) {
    MaterialInstance* other = (MaterialInstance*) otherNativeMaterialInstance;
    MaterialInstance* mi = MaterialInstance::duplicate(other, name);
    return (jlong)mi;
}

extern "C"
jfloat nGetMaskThreshold(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->getMaskThreshold();
}

extern "C"
jfloat nGetSpecularAntiAliasingVariance(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->getSpecularAntiAliasingVariance();
}

extern "C"
jfloat nGetSpecularAntiAliasingThreshold(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->getSpecularAntiAliasingThreshold();
}

extern "C"
jboolean nIsDoubleSided(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->isDoubleSided();
}

extern "C"
jint nGetCullingMode(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return (jint)instance->getCullingMode();
}

extern "C"
jint nGetShadowCullingMode(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return (jint)instance->getShadowCullingMode();
}

extern "C"
jboolean nIsColorWriteEnabled(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->isColorWriteEnabled();
}

extern "C"
jboolean nIsDepthWriteEnabled(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->isDepthWriteEnabled();
}

extern "C"
jboolean nIsStencilWriteEnabled(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->isStencilWriteEnabled();
}

extern "C"
jboolean nIsDepthCullingEnabled(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return instance->isDepthCullingEnabled();
}

extern "C"
jint nGetDepthFunc(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*)nativeMaterialInstance;
    return (jint)instance->getDepthFunc();
}

extern "C"
void nSetTransparencyMode(jlong nativeMaterialInstance, jint mode) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    instance->setTransparencyMode((MaterialInstance::TransparencyMode) mode);
}

extern "C"
jint nGetTransparencyMode(jlong nativeMaterialInstance) {
    MaterialInstance* instance = (MaterialInstance*) nativeMaterialInstance;
    return (jint) instance->getTransparencyMode();
}

