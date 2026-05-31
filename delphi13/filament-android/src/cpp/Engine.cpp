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
#include <filament/Engine.h>
#include <filament/MorphTargetBuffer.h>

#include <utils/Entity.h>
#include <utils/EntityManager.h>

using namespace filament;
using namespace utils;

extern "C" void nDestroyEngine(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    Engine::destroy(&engine);
}

// SwapChain
// Note: nCreateSwapChain accepts a raw ANativeWindow* pointer directly.

extern "C" jlong nGetBackend(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->getBackend();
}

extern "C" jlong nCreateSwapChain(jlong nativeEngine, void* nativeWindow, jlong flags) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->createSwapChain(nativeWindow, (uint64_t) flags);
}

extern "C" jlong nCreateSwapChainHeadless(jlong nativeEngine, jint width, jint height, jlong flags) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->createSwapChain(width, height, (uint64_t) flags);
}

extern "C" jlong nCreateSwapChainFromRawPointer(jlong nativeEngine, jlong pointer, jlong flags) {
     Engine* engine = (Engine*) nativeEngine;
     return (jlong) engine->createSwapChain((void*)pointer, (uint64_t) flags);
}

extern "C" jboolean nDestroySwapChain(jlong nativeEngine, jlong nativeSwapChain) {
    Engine* engine = (Engine*) nativeEngine;
    SwapChain* swapChain = (SwapChain*) nativeSwapChain;
    return engine->destroy(swapChain);
}

// View

extern "C" jlong nCreateView(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->createView();
}

extern "C" jboolean nDestroyView(jlong nativeEngine, jlong nativeView) {
    Engine* engine = (Engine*) nativeEngine;
    View* view = (View*) nativeView;
    return engine->destroy(view);
}

// Renderer

extern "C" jlong nCreateRenderer(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->createRenderer();
}

extern "C" jboolean nDestroyRenderer(jlong nativeEngine, jlong nativeRenderer) {
    Engine* engine = (Engine*) nativeEngine;
    Renderer* renderer = (Renderer*) nativeRenderer;
    return engine->destroy(renderer);
}

// Camera

extern "C" jlong nCreateCamera(jlong nativeEngine, jint entity_) {
    Engine* engine = (Engine*) nativeEngine;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    return (jlong) engine->createCamera(entity);
}

extern "C" jlong nGetCameraComponent(jlong nativeEngine, jint entity_) {
    Engine* engine = (Engine*) nativeEngine;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    return (jlong) engine->getCameraComponent(entity);
}

extern "C" void nDestroyCameraComponent(jlong nativeEngine, jint entity_) {
    Engine* engine = (Engine*) nativeEngine;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    engine->destroyCameraComponent(entity);
}

// Scene

extern "C" jlong nCreateScene(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->createScene();
}

extern "C" jboolean nDestroyScene(jlong nativeEngine, jlong nativeScene) {
    Engine* engine = (Engine*) nativeEngine;
    Scene* scene = (Scene*) nativeScene;
    return engine->destroy(scene);
}

// Fence

extern "C" jlong nCreateFence(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->createFence();
}

extern "C" jboolean nDestroyFence(jlong nativeEngine, jlong nativeFence) {
    Engine* engine = (Engine*) nativeEngine;
    Fence* fence = (Fence*) nativeFence;
    return engine->destroy(fence);
}

// Stream

extern "C" jboolean nDestroyStream(jlong nativeEngine, jlong nativeStream) {
    Engine* engine = (Engine*) nativeEngine;
    Stream* stream = (Stream*) nativeStream;
    return engine->destroy(stream);
}

// Others...

extern "C" jboolean nDestroyIndexBuffer(jlong nativeEngine, jlong nativeIndexBuffer) {
    Engine* engine = (Engine*) nativeEngine;
    IndexBuffer* indexBuffer = (IndexBuffer*) nativeIndexBuffer;
    return engine->destroy(indexBuffer);
}

extern "C" jboolean nDestroyVertexBuffer(jlong nativeEngine, jlong nativeVertexBuffer) {
    Engine* engine = (Engine*) nativeEngine;
    VertexBuffer* vertexBuffer = (VertexBuffer*) nativeVertexBuffer;
    return engine->destroy(vertexBuffer);
}

extern "C" jboolean nDestroySkinningBuffer(jlong nativeEngine, jlong nativeSkinningBuffer) {
    Engine* engine = (Engine*) nativeEngine;
    SkinningBuffer* skinningBuffer = (SkinningBuffer*) nativeSkinningBuffer;
    return engine->destroy(skinningBuffer);
}

extern "C" jboolean nDestroyMorphTargetBuffer(jlong nativeEngine, jlong nativeMorphTargetBuffer) {
    Engine* engine = (Engine*) nativeEngine;
    MorphTargetBuffer* mtb = (MorphTargetBuffer*) nativeMorphTargetBuffer;
    return engine->destroy(mtb);
}

extern "C" jboolean nDestroyIndirectLight(jlong nativeEngine, jlong nativeIndirectLight) {
    Engine* engine = (Engine*) nativeEngine;
    IndirectLight* indirectLight = (IndirectLight*) nativeIndirectLight;
    return engine->destroy(indirectLight);
}

extern "C" jboolean nDestroyMaterial(jlong nativeEngine, jlong nativeMaterial) {
    Engine* engine = (Engine*) nativeEngine;
    Material* material = (Material*) nativeMaterial;
    return engine->destroy(material);
}

extern "C" jboolean nDestroyMaterialInstance(jlong nativeEngine, jlong nativeMaterialInstance) {
    Engine* engine = (Engine*) nativeEngine;
    MaterialInstance* materialInstance = (MaterialInstance*) nativeMaterialInstance;
    return engine->destroy(materialInstance);
}

extern "C" jboolean nDestroySkybox(jlong nativeEngine, jlong nativeSkybox) {
    Engine* engine = (Engine*) nativeEngine;
    Skybox* skybox = (Skybox*) nativeSkybox;
    return engine->destroy(skybox);
}

extern "C" jboolean nDestroyColorGrading(jlong nativeEngine, jlong nativeColorGrading) {
    Engine* engine = (Engine*) nativeEngine;
    ColorGrading* colorGrading = (ColorGrading*) nativeColorGrading;
    return engine->destroy(colorGrading);
}

extern "C" jboolean nDestroyTexture(jlong nativeEngine, jlong nativeTexture) {
    Engine* engine = (Engine*) nativeEngine;
    Texture* texture = (Texture*) nativeTexture;
    return engine->destroy(texture);
}

extern "C" jboolean nDestroyRenderTarget(jlong nativeEngine, jlong nativeTarget) {
    Engine* engine = (Engine*) nativeEngine;
    RenderTarget* target = (RenderTarget*) nativeTarget;
    return engine->destroy(target);
}

extern "C" void nDestroyEntity(jlong nativeEngine, jint entity_) {
    Engine* engine = (Engine*) nativeEngine;
    Entity& entity = *reinterpret_cast<Entity*>(&entity_);
    engine->destroy(entity);
}


extern "C" jboolean nIsValidRenderer(jlong nativeEngine, jlong nativeRenderer) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Renderer*)nativeRenderer);
}

extern "C" jboolean nIsValidView(jlong nativeEngine, jlong nativeView) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((View*)nativeView);
}

extern "C" jboolean nIsValidScene(jlong nativeEngine, jlong nativeScene) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Scene*)nativeScene);
}

extern "C" jboolean nIsValidFence(jlong nativeEngine, jlong nativeFence) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Fence*)nativeFence);
}

extern "C" jboolean nIsValidStream(jlong nativeEngine, jlong nativeStream) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Stream*)nativeStream);
}

extern "C" jboolean nIsValidIndexBuffer(jlong nativeEngine, jlong nativeIndexBuffer) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((IndexBuffer*)nativeIndexBuffer);
}

extern "C" jboolean nIsValidVertexBuffer(jlong nativeEngine, jlong nativeVertexBuffer) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((VertexBuffer*)nativeVertexBuffer);
}

extern "C" jboolean nIsValidSkinningBuffer(jlong nativeEngine, jlong nativeSkinningBuffer) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((SkinningBuffer*)nativeSkinningBuffer);
}

extern "C" jboolean nIsValidMorphTargetBuffer(jlong nativeEngine, jlong nativeMorphTargetBuffer) {
    Engine* engine = (Engine*) nativeEngine;
    return (jboolean) engine->isValid((MorphTargetBuffer*) nativeMorphTargetBuffer);
}

extern "C" jboolean nIsValidIndirectLight(jlong nativeEngine, jlong nativeIndirectLight) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((IndirectLight*)nativeIndirectLight);
}

extern "C" jboolean nIsValidMaterial(jlong nativeEngine, jlong nativeMaterial) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Material*)nativeMaterial);
}

extern "C" jboolean nIsValidMaterialInstance(jlong nativeEngine, jlong nativeMaterial, jlong nativeMaterialInstance) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Material*)nativeMaterial,
            (MaterialInstance*)nativeMaterialInstance);
}

extern "C" jboolean         nIsValidExpensiveMaterialInstance(jlong nativeEngine, jlong nativeMaterialInstance) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValidExpensive((MaterialInstance*)nativeMaterialInstance);
}

extern "C" jboolean nIsValidSkybox(jlong nativeEngine, jlong nativeSkybox) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Skybox*)nativeSkybox);
}

extern "C" jboolean nIsValidColorGrading(jlong nativeEngine, jlong nativeColorGrading) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((ColorGrading*)nativeColorGrading);
}

extern "C" jboolean nIsValidTexture(jlong nativeEngine, jlong nativeTexture) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((Texture*)nativeTexture);
}

extern "C" jboolean nIsValidRenderTarget(jlong nativeEngine, jlong nativeTarget) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((RenderTarget*)nativeTarget);
}

extern "C" jboolean nIsValidSwapChain(jlong nativeEngine, jlong nativeSwapChain) {
    Engine* engine = (Engine *)nativeEngine;
    return (jboolean)engine->isValid((SwapChain*)nativeSwapChain);
}

extern "C" jboolean nFlushAndWait(jlong nativeEngine, jlong timeout) {
    Engine* engine = (Engine*) nativeEngine;
    return engine->flushAndWait((uint64_t)timeout);
}

extern "C" void nFlush(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    engine->flush();
}

extern "C" jboolean nIsPaused(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jboolean)engine->isPaused();
}

extern "C" void nSetPaused(jlong nativeEngine, jboolean paused) {
    Engine* engine = (Engine*) nativeEngine;
    engine->setPaused(paused);
}

extern "C" void nUnprotected(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    engine->unprotected();
}

// Managers...

extern "C" jlong nGetTransformManager(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) &engine->getTransformManager();
}

extern "C" jlong nGetLightManager(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) &engine->getLightManager();
}

extern "C" jlong nGetRenderableManager(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) &engine->getRenderableManager();
}

extern "C" jlong nGetJobSystem(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) &engine->getJobSystem();
}

extern "C" jlong nGetEntityManager(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) &engine->getEntityManager();
}

extern "C" void nSetAutomaticInstancingEnabled(jlong nativeEngine, jboolean enable) {
    Engine* engine = (Engine*) nativeEngine;
    engine->setAutomaticInstancingEnabled(enable);
}

extern "C" jboolean nIsAutomaticInstancingEnabled(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jboolean)engine->isAutomaticInstancingEnabled();
}

extern "C" jlong nGetMaxStereoscopicEyes(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jlong) engine->getMaxStereoscopicEyes();
}


extern "C" jint nGetSupportedFeatureLevel(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jint)engine->getSupportedFeatureLevel();
}

extern "C" jint nSetActiveFeatureLevel(jlong nativeEngine, jint ordinal) {
    Engine* engine = (Engine*) nativeEngine;
    return (jint)engine->setActiveFeatureLevel((Engine::FeatureLevel)ordinal);
}

extern "C" jint nGetActiveFeatureLevel(jlong nativeEngine) {
    Engine* engine = (Engine*) nativeEngine;
    return (jint)engine->getActiveFeatureLevel();
}

extern "C" jboolean nHasFeatureFlag(jlong nativeEngine, const char* name) {
    Engine* engine = (Engine*) nativeEngine;
    std::optional<bool> result = engine->getFeatureFlag(name);
    return result.has_value();
}
extern "C" jboolean nSetFeatureFlag(jlong nativeEngine, const char* name, jboolean value) {
    Engine* engine = (Engine*) nativeEngine;
    return engine->setFeatureFlag(name, (bool)value);
}
extern "C" jboolean nGetFeatureFlag(jlong nativeEngine, const char* name) {
    Engine* engine = (Engine*) nativeEngine;
    std::optional<bool> result = engine->getFeatureFlag(name);
    return result.value_or(false);
}

extern "C" jlong nCreateBuilder() {
    Engine::Builder* builder = new Engine::Builder{};
    return (jlong) builder;
}

extern "C" void nDestroyBuilder(jlong nativeBuilder) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    delete builder;
}

extern "C" void nSetBuilderBackend(jlong nativeBuilder, jlong backend) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    builder->backend((Engine::Backend) backend);
}

extern "C" void nSetBuilderConfig(jlong nativeBuilder, jlong commandBufferSizeMB, jlong perRenderPassArenaSizeMB,
        jlong driverHandleArenaSizeMB, jlong minCommandBufferSizeMB, jlong perFrameCommandsSizeMB,
        jlong jobSystemThreadCount, jboolean disableParallelShaderCompile,
        jint stereoscopicType, jlong stereoscopicEyeCount,
        jlong resourceAllocatorCacheSizeMB, jlong resourceAllocatorCacheMaxAge,
        jboolean disableHandleUseAfterFreeCheck,
        jint preferredShaderLanguage,
        jboolean forceGLES2Context, jboolean assertNativeWindowIsValid,
        jint gpuContextPriority,
        jlong sharedUboInitialSizeInBytes) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    Engine::Config config = {
            .commandBufferSizeMB = (uint32_t) commandBufferSizeMB,
            .perRenderPassArenaSizeMB = (uint32_t) perRenderPassArenaSizeMB,
            .driverHandleArenaSizeMB = (uint32_t) driverHandleArenaSizeMB,
            .minCommandBufferSizeMB = (uint32_t) minCommandBufferSizeMB,
            .perFrameCommandsSizeMB = (uint32_t) perFrameCommandsSizeMB,
            .jobSystemThreadCount = (uint32_t) jobSystemThreadCount,
            .disableParallelShaderCompile = (bool) disableParallelShaderCompile,
            .stereoscopicType = (Engine::StereoscopicType) stereoscopicType,
            .stereoscopicEyeCount = (uint8_t) stereoscopicEyeCount,
            .resourceAllocatorCacheSizeMB = (uint32_t) resourceAllocatorCacheSizeMB,
            .resourceAllocatorCacheMaxAge = (uint8_t) resourceAllocatorCacheMaxAge,
            .disableHandleUseAfterFreeCheck = (bool) disableHandleUseAfterFreeCheck,
            .preferredShaderLanguage = (Engine::Config::ShaderLanguage) preferredShaderLanguage,
            .forceGLES2Context = (bool) forceGLES2Context,
            .assertNativeWindowIsValid = (bool) assertNativeWindowIsValid,
            .gpuContextPriority = (Engine::GpuContextPriority) gpuContextPriority,
            .sharedUboInitialSizeInBytes = (uint32_t) sharedUboInitialSizeInBytes,
    };
    builder->config(&config);
}

extern "C" void nSetBuilderFeatureLevel(jlong nativeBuilder, jint ordinal) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    builder->featureLevel((Engine::FeatureLevel)ordinal);
}

extern "C" void nSetBuilderSharedContext(jlong nativeBuilder, jlong sharedContext) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    builder->sharedContext((void*) sharedContext);
}

extern "C" void nSetBuilderPaused(jlong nativeBuilder, jboolean paused) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    builder->paused((bool) paused);
}

extern "C" void nSetBuilderFeature(jlong nativeBuilder, const char* name, jboolean value) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    builder->feature(name, (bool)value);
}

extern "C" jlong nBuilderBuild(jlong nativeBuilder) {
    Engine::Builder* builder = (Engine::Builder*) nativeBuilder;
    return (jlong) builder->build();
}

extern "C"
jlong getSteadyClockTimeNano() {
    return (jlong)Engine::getSteadyClockTimeNano();
}

