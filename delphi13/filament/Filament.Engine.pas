unit Filament.Engine;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Engine.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  void*    -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nDestroyEngine(nativeEngine: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyEngine';
function  nGetBackend(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetBackend';
function  nCreateSwapChain(nativeEngine: Int64; nativeWindow: Pointer; flags: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateSwapChain';
function  nCreateSwapChainHeadless(nativeEngine: Int64; width: Integer; height: Integer; flags: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateSwapChainHeadless';
function  nCreateSwapChainFromRawPointer(nativeEngine: Int64; pointer: Int64; flags: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateSwapChainFromRawPointer';
function  nDestroySwapChain(nativeEngine: Int64; nativeSwapChain: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroySwapChain';
function  nCreateView(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateView';
function  nDestroyView(nativeEngine: Int64; nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyView';
function  nCreateRenderer(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateRenderer';
function  nDestroyRenderer(nativeEngine: Int64; nativeRenderer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyRenderer';
function  nCreateCamera(nativeEngine: Int64; entity_: Integer): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateCamera';
function  nGetCameraComponent(nativeEngine: Int64; entity_: Integer): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetCameraComponent';
procedure nDestroyCameraComponent(nativeEngine: Int64; entity_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nDestroyCameraComponent';
function  nCreateScene(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateScene';
function  nDestroyScene(nativeEngine: Int64; nativeScene: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyScene';
function  nCreateFence(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateFence';
function  nDestroyFence(nativeEngine: Int64; nativeFence: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyFence';
function  nDestroyStream(nativeEngine: Int64; nativeStream: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyStream';
function  nDestroyIndexBuffer(nativeEngine: Int64; nativeIndexBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyIndexBuffer';
function  nDestroyVertexBuffer(nativeEngine: Int64; nativeVertexBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyVertexBuffer';
function  nDestroySkinningBuffer(nativeEngine: Int64; nativeSkinningBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroySkinningBuffer';
function  nDestroyMorphTargetBuffer(nativeEngine: Int64; nativeMorphTargetBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyMorphTargetBuffer';
function  nDestroyIndirectLight(nativeEngine: Int64; nativeIndirectLight: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyIndirectLight';
function  nDestroyMaterial(nativeEngine: Int64; nativeMaterial: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyMaterial';
function  nDestroyMaterialInstance(nativeEngine: Int64; nativeMaterialInstance: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyMaterialInstance';
function  nDestroySkybox(nativeEngine: Int64; nativeSkybox: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroySkybox';
function  nDestroyColorGrading(nativeEngine: Int64; nativeColorGrading: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyColorGrading';
function  nDestroyTexture(nativeEngine: Int64; nativeTexture: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyTexture';
function  nDestroyRenderTarget(nativeEngine: Int64; nativeTarget: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nDestroyRenderTarget';
procedure nDestroyEntity(nativeEngine: Int64; entity_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nDestroyEntity';
function  nIsValidRenderer(nativeEngine: Int64; nativeRenderer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidRenderer';
function  nIsValidView(nativeEngine: Int64; nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidView';
function  nIsValidScene(nativeEngine: Int64; nativeScene: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidScene';
function  nIsValidFence(nativeEngine: Int64; nativeFence: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidFence';
function  nIsValidStream(nativeEngine: Int64; nativeStream: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidStream';
function  nIsValidIndexBuffer(nativeEngine: Int64; nativeIndexBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidIndexBuffer';
function  nIsValidVertexBuffer(nativeEngine: Int64; nativeVertexBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidVertexBuffer';
function  nIsValidSkinningBuffer(nativeEngine: Int64; nativeSkinningBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidSkinningBuffer';
function  nIsValidMorphTargetBuffer(nativeEngine: Int64; nativeMorphTargetBuffer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidMorphTargetBuffer';
function  nIsValidIndirectLight(nativeEngine: Int64; nativeIndirectLight: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidIndirectLight';
function  nIsValidMaterial(nativeEngine: Int64; nativeMaterial: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidMaterial';
function  nIsValidMaterialInstance(nativeEngine: Int64; nativeMaterial: Int64; nativeMaterialInstance: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidMaterialInstance';
function  nIsValidExpensiveMaterialInstance(nativeEngine: Int64; nativeMaterialInstance: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidExpensiveMaterialInstance';
function  nIsValidSkybox(nativeEngine: Int64; nativeSkybox: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidSkybox';
function  nIsValidColorGrading(nativeEngine: Int64; nativeColorGrading: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidColorGrading';
function  nIsValidTexture(nativeEngine: Int64; nativeTexture: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidTexture';
function  nIsValidRenderTarget(nativeEngine: Int64; nativeTarget: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidRenderTarget';
function  nIsValidSwapChain(nativeEngine: Int64; nativeSwapChain: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsValidSwapChain';
function  nFlushAndWait(nativeEngine: Int64; timeout: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nFlushAndWait';
procedure nFlush(nativeEngine: Int64); cdecl; external LIB_FILAMENT_JNI name 'nFlush';
function  nIsPaused(nativeEngine: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsPaused';
procedure nSetPaused(nativeEngine: Int64; paused: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetPaused';
procedure nUnprotected(nativeEngine: Int64); cdecl; external LIB_FILAMENT_JNI name 'nUnprotected';
function  nGetTransformManager(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetTransformManager';
function  nGetLightManager(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetLightManager';
function  nGetRenderableManager(nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetRenderableManager';

{$ENDIF}

implementation

end.
