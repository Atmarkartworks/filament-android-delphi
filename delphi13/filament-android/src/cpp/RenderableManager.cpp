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

#include <filament/RenderableManager.h>
#include <filament/MaterialInstance.h>

#include <utils/Entity.h>


using namespace filament;
using namespace utils;

extern "C" jboolean nHasComponent(jlong nativeRenderableManager, jint entity) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jboolean) rm->hasComponent((Entity &) entity);
}

extern "C" jint nGetInstance(jlong nativeRenderableManager, jint entity) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return rm->getInstance((Entity &) entity);
}

extern "C" void nDestroy(jlong nativeRenderableManager, jint entity) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->destroy((Entity &) entity);
}



extern "C" jlong nCreateBuilder(jint count) {
    return (jlong) new RenderableManager::Builder((size_t) count);
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    delete builder;
}

extern "C" jboolean nBuilderBuild(jlong nativeBuilder, jlong nativeEngine, jint entity) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    Engine *engine = (Engine *) nativeEngine;
    return jboolean(builder->build(*engine, (Entity &) entity) == RenderableManager::Builder::Success);
}

extern "C" void nBuilderGeometry__JIIJJ(jlong nativeBuilder, jint index, jint primitiveType, jlong nativeVertexBuffer,
        jlong nativeIndexBuffer) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    VertexBuffer *vertexBuffer = (VertexBuffer *) nativeVertexBuffer;
    IndexBuffer *indexBuffer = (IndexBuffer *) nativeIndexBuffer;
    builder->geometry((size_t) index, (RenderableManager::PrimitiveType) primitiveType,
            vertexBuffer, indexBuffer);
}

extern "C" void nBuilderGeometry__JIIJJII(jlong nativeBuilder, jint index, jint primitiveType, jlong nativeVertexBuffer,
        jlong nativeIndexBuffer, jint offset, jint count) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    VertexBuffer *vertexBuffer = (VertexBuffer *) nativeVertexBuffer;
    IndexBuffer *indexBuffer = (IndexBuffer *) nativeIndexBuffer;
    builder->geometry((size_t) index, (RenderableManager::PrimitiveType) primitiveType,
            vertexBuffer, indexBuffer, (size_t) offset, (size_t) count);
}

extern "C" void nBuilderGeometry__JIIJJIIII(jlong nativeBuilder, jint index, jint primitiveType, jlong nativeVertexBuffer,
        jlong nativeIndexBuffer, jint offset, jint minIndex, jint maxIndex, jint count) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    VertexBuffer *vertexBuffer = (VertexBuffer *) nativeVertexBuffer;
    IndexBuffer *indexBuffer = (IndexBuffer *) nativeIndexBuffer;
    builder->geometry((size_t) index, (RenderableManager::PrimitiveType) primitiveType,
            vertexBuffer, indexBuffer, (size_t) offset, (size_t) minIndex, (size_t) maxIndex,
            (size_t) count);
}

extern "C"
void nBuilderGeometryType(jlong nativeBuilder, int type) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->geometryType((RenderableManager::Builder::GeometryType)type);
}

extern "C"
void nBuilderMaterial(jlong nativeBuilder, jint index, jlong nativeMaterialInstance) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->material((size_t) index, (const MaterialInstance*) nativeMaterialInstance);
}

extern "C"
void nBuilderBlendOrder(jlong nativeBuilder, jint index, jint blendOrder) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->blendOrder((size_t) index, (uint16_t) blendOrder);
}

extern "C"
void nBuilderGlobalBlendOrderEnabled(jlong nativeBuilder, jint index, jboolean enabled) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->globalBlendOrderEnabled((size_t) index, (bool) enabled);
}

extern "C" void nBuilderBoundingBox(jlong nativeBuilder, jfloat cx, jfloat cy, jfloat cz, jfloat ex, jfloat ey, jfloat ez) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->boundingBox({{cx, cy, cz},
                          {ex, ey, ez}});
}

extern "C" void nBuilderLayerMask(jlong nativeBuilder, jint select, jint value) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->layerMask((uint8_t) select, (uint8_t) value);
}

extern "C" void nBuilderPriority(jlong nativeBuilder, jint priority) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->priority((uint8_t) priority);
}

extern "C" void nBuilderChannel(jlong nativeBuilder, jint channel) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->channel((uint8_t) channel);
}

extern "C" void nBuilderCulling(jlong nativeBuilder, jboolean enabled) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->culling(enabled);
}

extern "C" void nBuilderCastShadows(jlong nativeBuilder, jboolean enabled) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->castShadows(enabled);
}

extern "C" void nBuilderReceiveShadows(jlong nativeBuilder, jboolean enabled) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->receiveShadows(enabled);
}

extern "C" void nBuilderScreenSpaceContactShadows(jlong nativeBuilder, jboolean enabled) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->screenSpaceContactShadows(enabled);
}

extern "C" void nBuilderSkinningBuffer(jlong nativeBuilder, jlong nativeSkinningBuffer, jint boneCount, jint offset) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    SkinningBuffer *skinningBuffer = (SkinningBuffer *) nativeSkinningBuffer;
    builder->skinning(skinningBuffer, boneCount, offset);
}

extern "C" void nBuilderSkinning(jlong nativeBuilder, jint boneCount) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->skinning((size_t)boneCount);
}

extern "C" void nBuilderEnableSkinningBuffers(jlong nativeBuilder, jboolean enabled) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->enableSkinningBuffers(enabled);
}

extern "C" void nBuilderFog(jlong nativeBuilder, jboolean enabled) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->fog(enabled);
}

extern "C" jint nBuilderSkinningBones(jlong nativeBuilder, jint boneCount, const void* bones) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->skinning((size_t)boneCount, static_cast<RenderableManager::Bone const*>(bones));
    return 0;
}

extern "C" void nBuilderMorphing(jlong nativeBuilder, jint targetCount) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->morphing(targetCount);
}

extern "C" void nBuilderMorphingStandard(jlong nativeBuilder, jlong nativeMorphTargetBuffer) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    MorphTargetBuffer *morphTargetBuffer = (MorphTargetBuffer *) nativeMorphTargetBuffer;
    builder->morphing(morphTargetBuffer);
}

extern "C" void nBuilderSetMorphTargetBufferOffsetAt(jlong nativeBuilder, int level, int primitiveIndex, int offset) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->morphing(level, primitiveIndex, offset);
}

extern "C" void nBuilderLightChannel(jlong nativeBuilder, jint channel, jboolean enable) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->lightChannel(channel, (bool)enable);
}

extern "C" void nBuilderInstances(jlong nativeBuilder, jint instanceCount) {
    RenderableManager::Builder *builder = (RenderableManager::Builder *) nativeBuilder;
    builder->instances(instanceCount);
}

// ------------------------------------------------------------------------------------------------

extern "C" void nSetSkinningBuffer(jlong nativeRenderableManager, jint i, jlong nativeSkinningBuffer, jint count, jint offset) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    SkinningBuffer *sb = (SkinningBuffer *) nativeSkinningBuffer;
    rm->setSkinningBuffer(i, sb, count, offset);
}

extern "C" jint nSetBonesAsMatrices(jlong nativeRenderableManager, jint i, const void* matrices,
        jint boneCount, jint offset) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setBones((RenderableManager::Instance)i,
            static_cast<filament::math::mat4f const *>(matrices), (size_t)boneCount, (size_t)offset);
    return 0;
}

extern "C" jint nSetBonesAsQuaternions(jlong nativeRenderableManager, jint i, const void* quaternions,
        jint boneCount, jint offset) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setBones((RenderableManager::Instance)i,
            static_cast<RenderableManager::Bone const *>(quaternions), (size_t)boneCount, (size_t)offset);
    return 0;
}

extern "C" void nSetMorphWeights(jlong nativeRenderableManager, jint instance, const float* weights, jint count, jint offset) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setMorphWeights((RenderableManager::Instance)instance, weights, count, offset);
}

extern "C" void nSetMorphTargetBufferOffsetAt(jlong nativeRenderableManager, jint i, int level, jint primitiveIndex,
        jlong, jint offset) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setMorphTargetBufferOffsetAt((RenderableManager::Instance) i, (uint8_t) level,
            (size_t) primitiveIndex, (size_t) offset);
}

extern "C" jint nGetMorphTargetCount(jlong nativeRenderableManager, jint instance) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return rm->getMorphTargetCount((RenderableManager::Instance)instance);
}

extern "C" void nSetAxisAlignedBoundingBox(jlong nativeRenderableManager, jint i, jfloat cx, jfloat cy, jfloat cz,
        jfloat ex, jfloat ey, jfloat ez) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setAxisAlignedBoundingBox((RenderableManager::Instance) i, {{cx, cy, cz},
                                                                    {ex, ey, ez}});
}

extern "C" void nSetLayerMask(jlong nativeRenderableManager, jint i, jint select, jint value) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setLayerMask((RenderableManager::Instance) i, (uint8_t) select, (uint8_t) value);
}

extern "C" void nSetPriority(jlong nativeRenderableManager, jint i, jint priority) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setPriority((RenderableManager::Instance) i, (uint8_t) priority);
}

extern "C" jint nGetPriority(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jint) rm->getPriority((RenderableManager::Instance) i);
}

extern "C" void nSetChannel(jlong nativeRenderableManager, jint i, jint channel) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setChannel((RenderableManager::Instance) i, (uint8_t) channel);
}

extern "C" jint nGetChannel(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jint) rm->getChannel((RenderableManager::Instance) i);
}

extern "C" void nSetCulling(jlong nativeRenderableManager, jint i, jboolean enabled) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setCulling((RenderableManager::Instance) i, enabled);
}

extern "C" jboolean nIsCullingEnabled(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jboolean) rm->isCullingEnabled((RenderableManager::Instance) i);
}

extern "C" void nSetFogEnabled(jlong nativeRenderableManager, jint i, jboolean enabled) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setFogEnabled((RenderableManager::Instance) i, enabled);
}

extern "C" jboolean nGetFogEnabled(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jboolean)rm->getFogEnabled((RenderableManager::Instance) i);
}

extern "C" void nSetCastShadows(jlong nativeRenderableManager, jint i, jboolean enabled) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setCastShadows((RenderableManager::Instance) i, enabled);
}

extern "C" void nSetReceiveShadows(jlong nativeRenderableManager, jint i, jboolean enabled) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setReceiveShadows((RenderableManager::Instance) i, enabled);
}

extern "C" void nSetScreenSpaceContactShadows(jlong nativeRenderableManager, jint i, jboolean enabled) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setScreenSpaceContactShadows((RenderableManager::Instance) i, enabled);
}

extern "C" jboolean nIsShadowCaster(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jboolean) rm->isShadowCaster((RenderableManager::Instance) i);
}

extern "C" jboolean nIsShadowReceiver(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jboolean) rm->isShadowReceiver((RenderableManager::Instance) i);
}

extern "C" jboolean nIsScreenSpaceContactShadowsEnabled(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jboolean) rm->isScreenSpaceContactShadowsEnabled((RenderableManager::Instance) i);
}

extern "C" void nGetAxisAlignedBoundingBox(jlong nativeRenderableManager, jint i, float* center,
        float* halfExtent) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    Box const &aabb = rm->getAxisAlignedBoundingBox((RenderableManager::Instance) i);
    *reinterpret_cast<filament::math::float3 *>(center) = aabb.center;
    *reinterpret_cast<filament::math::float3 *>(halfExtent) = aabb.halfExtent;
}

extern "C" jint nGetPrimitiveCount(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jint) rm->getPrimitiveCount((RenderableManager::Instance) i);
}

extern "C" jint nGetInstanceCount(jlong nativeRenderableManager, jint i) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jint) rm->getInstanceCount((RenderableManager::Instance) i);
}

extern "C" void nSetMaterialInstanceAt(jlong nativeRenderableManager, jint i, jint primitiveIndex, jlong nativeMaterialInstance) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    const MaterialInstance *materialInstance = (const MaterialInstance *) nativeMaterialInstance;
    rm->setMaterialInstanceAt((RenderableManager::Instance) i, (size_t) primitiveIndex,
            materialInstance);
}

extern "C" void nClearMaterialInstanceAt(jlong nativeRenderableManager, jint i, jint primitiveIndex) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->clearMaterialInstanceAt((RenderableManager::Instance) i, (size_t) primitiveIndex);
}

extern "C" jlong nGetMaterialInstanceAt(jlong nativeRenderableManager, jint i, jint primitiveIndex) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (long) rm->getMaterialInstanceAt((RenderableManager::Instance) i, (size_t) primitiveIndex);
}

extern "C" void nSetGeometryAt__JIIIJJII(jlong nativeRenderableManager, jint i, jint primitiveIndex, jint primitiveType,
        jlong nativeVertexBuffer, jlong nativeIndexBuffer, jint offset, jint count) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    VertexBuffer *vertexBuffer = (VertexBuffer *) nativeVertexBuffer;
    IndexBuffer *indexBuffer = (IndexBuffer *) nativeIndexBuffer;
    rm->setGeometryAt((RenderableManager::Instance) i, (size_t) primitiveIndex,
            (RenderableManager::PrimitiveType) primitiveType, vertexBuffer, indexBuffer,
            (size_t) offset, (size_t) count);
}

extern "C" void nSetBlendOrderAt(jlong nativeRenderableManager, jint i, jint primitiveIndex, jint blendOrder) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setBlendOrderAt((RenderableManager::Instance) i, (size_t) primitiveIndex,
            (uint16_t) blendOrder);
}

extern "C" jint nGetBlendOrderAt(jlong nativeRenderableManager, jint i, jint primitiveIndex) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jint) rm->getBlendOrderAt((RenderableManager::Instance) i, (size_t) primitiveIndex);
}

extern "C" void nSetGlobalBlendOrderEnabledAt(jlong nativeRenderableManager, jint i, jint primitiveIndex, jboolean enabled) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setGlobalBlendOrderEnabledAt((RenderableManager::Instance) i, (size_t) primitiveIndex,
            (bool) enabled);
}

extern "C" jboolean nIsGlobalBlendOrderEnabledAt(jlong nativeRenderableManager, jint i, jint primitiveIndex) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    return (jboolean) rm->isGlobalBlendOrderEnabledAt((RenderableManager::Instance) i, (size_t) primitiveIndex);
}

extern "C" jint nGetEnabledAttributesAt(jlong nativeRenderableManager, jint i, jint primitiveIndex) {
    RenderableManager const *rm = (RenderableManager const *) nativeRenderableManager;
    AttributeBitset enabled = rm->getEnabledAttributesAt((RenderableManager::Instance) i, (size_t) primitiveIndex);
    return enabled.getValue();
}

extern "C" void nSetLightChannel(jlong nativeRenderableManager, jint i, jint channel, jboolean enable) {
    RenderableManager *rm = (RenderableManager *) nativeRenderableManager;
    rm->setLightChannel((RenderableManager::Instance) i, channel, (bool)enable);
}

extern "C" jboolean nGetLightChannel(jlong nativeRenderableManager, jint i, jint channel) {
    RenderableManager const *rm = (RenderableManager const *) nativeRenderableManager;
    return rm->getLightChannel((RenderableManager::Instance) i, channel);
}
