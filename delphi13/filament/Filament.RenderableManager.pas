unit Filament.RenderableManager;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/RenderableManager.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  const void* -> Pointer
  float*   -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nHasComponent(nativeRenderableManager: Int64; entity: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nHasComponent';
function  nGetInstance(nativeRenderableManager: Int64; entity: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetInstance';
procedure nDestroy(nativeRenderableManager: Int64; entity: Integer); cdecl; external LIB_FILAMENT_JNI name 'nDestroy';
function  nCreateBuilder(count: Integer): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64; entity: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
procedure nBuilderGeometry__JIIJJ(nativeBuilder: Int64; index: Integer; primitiveType: Integer; nativeVertexBuffer: Int64; nativeIndexBuffer: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderGeometry__JIIJJ';
procedure nBuilderGeometry__JIIJJII(nativeBuilder: Int64; index: Integer; primitiveType: Integer; nativeVertexBuffer: Int64; nativeIndexBuffer: Int64; offset: Integer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderGeometry__JIIJJII';
procedure nBuilderGeometry__JIIJJIIII(nativeBuilder: Int64; index: Integer; primitiveType: Integer; nativeVertexBuffer: Int64; nativeIndexBuffer: Int64; offset: Integer; minIndex: Integer; maxIndex: Integer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderGeometry__JIIJJIIII';
procedure nBuilderGeometryType(nativeBuilder: Int64; type_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderGeometryType';
procedure nBuilderMaterial(nativeBuilder: Int64; index: Integer; nativeMaterialInstance: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderMaterial';
procedure nBuilderBlendOrder(nativeBuilder: Int64; index: Integer; blendOrder: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderBlendOrder';
procedure nBuilderGlobalBlendOrderEnabled(nativeBuilder: Int64; index: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderGlobalBlendOrderEnabled';
procedure nBuilderBoundingBox(nativeBuilder: Int64; cx: Single; cy: Single; cz: Single; ex: Single; ey: Single; ez: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderBoundingBox';
procedure nBuilderLayerMask(nativeBuilder: Int64; select: Integer; value: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderLayerMask';
procedure nBuilderPriority(nativeBuilder: Int64; priority: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderPriority';
procedure nBuilderChannel(nativeBuilder: Int64; channel: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderChannel';
procedure nBuilderCulling(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderCulling';
procedure nBuilderCastShadows(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderCastShadows';
procedure nBuilderReceiveShadows(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderReceiveShadows';
procedure nBuilderScreenSpaceContactShadows(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderScreenSpaceContactShadows';
procedure nBuilderSkinningBuffer(nativeBuilder: Int64; nativeSkinningBuffer: Int64; boneCount: Integer; offset: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSkinningBuffer';
procedure nBuilderSkinning(nativeBuilder: Int64; boneCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSkinning';
procedure nBuilderEnableSkinningBuffers(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderEnableSkinningBuffers';
procedure nBuilderFog(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderFog';
function  nBuilderSkinningBones(nativeBuilder: Int64; boneCount: Integer; bones: Pointer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nBuilderSkinningBones';
procedure nBuilderMorphing(nativeBuilder: Int64; targetCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderMorphing';
procedure nBuilderMorphingStandard(nativeBuilder: Int64; nativeMorphTargetBuffer: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderMorphingStandard';
procedure nBuilderSetMorphTargetBufferOffsetAt(nativeBuilder: Int64; level: Integer; primitiveIndex: Integer; offset: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSetMorphTargetBufferOffsetAt';
procedure nBuilderLightChannel(nativeBuilder: Int64; channel: Integer; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderLightChannel';
procedure nBuilderInstances(nativeBuilder: Int64; instanceCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderInstances';
procedure nSetSkinningBuffer(nativeRenderableManager: Int64; i: Integer; nativeSkinningBuffer: Int64; count: Integer; offset: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetSkinningBuffer';
function  nSetBonesAsMatrices(nativeRenderableManager: Int64; i: Integer; matrices: Pointer; boneCount: Integer; offset: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetBonesAsMatrices';
function  nSetBonesAsQuaternions(nativeRenderableManager: Int64; i: Integer; quaternions: Pointer; boneCount: Integer; offset: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetBonesAsQuaternions';
procedure nSetMorphWeights(nativeRenderableManager: Int64; instance: Integer; weights: Pointer; count: Integer; offset: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetMorphWeights';
procedure nSetMorphTargetBufferOffsetAt(nativeRenderableManager: Int64; i: Integer; level: Integer; primitiveIndex: Integer; unused: Int64; offset: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetMorphTargetBufferOffsetAt';
function  nGetMorphTargetCount(nativeRenderableManager: Int64; instance: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetMorphTargetCount';
procedure nSetAxisAlignedBoundingBox(nativeRenderableManager: Int64; i: Integer; cx: Single; cy: Single; cz: Single; ex: Single; ey: Single; ez: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetAxisAlignedBoundingBox';
procedure nSetLayerMask(nativeRenderableManager: Int64; i: Integer; select: Integer; value: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetLayerMask';
procedure nSetPriority(nativeRenderableManager: Int64; i: Integer; priority: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetPriority';
function  nGetPriority(nativeRenderableManager: Int64; i: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetPriority';
procedure nSetChannel(nativeRenderableManager: Int64; i: Integer; channel: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetChannel';
function  nGetChannel(nativeRenderableManager: Int64; i: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetChannel';
procedure nSetCulling(nativeRenderableManager: Int64; i: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetCulling';
function  nIsCullingEnabled(nativeRenderableManager: Int64; i: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsCullingEnabled';
procedure nSetFogEnabled(nativeRenderableManager: Int64; i: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetFogEnabled';
function  nGetFogEnabled(nativeRenderableManager: Int64; i: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nGetFogEnabled';
procedure nSetCastShadows(nativeRenderableManager: Int64; i: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetCastShadows';
procedure nSetReceiveShadows(nativeRenderableManager: Int64; i: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetReceiveShadows';
procedure nSetScreenSpaceContactShadows(nativeRenderableManager: Int64; i: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetScreenSpaceContactShadows';
function  nIsShadowCaster(nativeRenderableManager: Int64; i: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsShadowCaster';
function  nIsShadowReceiver(nativeRenderableManager: Int64; i: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsShadowReceiver';
function  nIsScreenSpaceContactShadowsEnabled(nativeRenderableManager: Int64; i: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsScreenSpaceContactShadowsEnabled';
procedure nGetAxisAlignedBoundingBox(nativeRenderableManager: Int64; i: Integer; center: Pointer; halfExtent: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetAxisAlignedBoundingBox';
function  nGetPrimitiveCount(nativeRenderableManager: Int64; i: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetPrimitiveCount';
function  nGetInstanceCount(nativeRenderableManager: Int64; i: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetInstanceCount';
procedure nSetMaterialInstanceAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer; nativeMaterialInstance: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetMaterialInstanceAt';
procedure nClearMaterialInstanceAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer); cdecl; external LIB_FILAMENT_JNI name 'nClearMaterialInstanceAt';
function  nGetMaterialInstanceAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetMaterialInstanceAt';
procedure nSetGeometryAt__JIIIJJII(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer; primitiveType: Integer; nativeVertexBuffer: Int64; nativeIndexBuffer: Int64; offset: Integer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetGeometryAt__JIIIJJII';
procedure nSetBlendOrderAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer; blendOrder: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetBlendOrderAt';
function  nGetBlendOrderAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetBlendOrderAt';
procedure nSetGlobalBlendOrderEnabledAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetGlobalBlendOrderEnabledAt';
function  nIsGlobalBlendOrderEnabledAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsGlobalBlendOrderEnabledAt';
function  nGetEnabledAttributesAt(nativeRenderableManager: Int64; i: Integer; primitiveIndex: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetEnabledAttributesAt';

{$ENDIF}

implementation

end.
