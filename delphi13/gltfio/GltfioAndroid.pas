unit GltfioAndroid;

{$IFDEF ANDROID}

interface

const
  LIB_GLTFIO_JNI = 'gltfio-jni';  // libgltfio-jni.so

// =============================================================================
// Animator  (Animator.cpp)
// =============================================================================

procedure nApplyAnimation(nativeAnimator: Int64; index: Integer; time: Single);
  cdecl; external LIB_GLTFIO_JNI;

procedure nUpdateBoneMatrices(nativeAnimator: Int64);
  cdecl; external LIB_GLTFIO_JNI;

procedure nApplyCrossFade(nativeAnimator: Int64; previousAnimIndex: Integer;
  previousAnimTime: Single; alpha: Single);
  cdecl; external LIB_GLTFIO_JNI;

procedure nResetBoneMatrices(nativeAnimator: Int64);
  cdecl; external LIB_GLTFIO_JNI;

function nGetAnimationCount(nativeAnimator: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

function nGetAnimationDuration(nativeAnimator: Int64; index: Integer): Single;
  cdecl; external LIB_GLTFIO_JNI;

function nGetAnimationName(nativeAnimator: Int64; index: Integer): PAnsiChar;
  cdecl; external LIB_GLTFIO_JNI;

// =============================================================================
// FilamentAsset  (FilamentAsset.cpp)
//   NOTE: nGetRoot / nGetEntityCount / nGetEntities conflict with FilamentInstance
//         names, so they are distinguished using the nAsset* prefix.
//         The corresponding C++ symbol names have been renamed accordingly.
// =============================================================================

function nAssetGetRoot(nativeAsset: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

function nPopRenderable(nativeAsset: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

function nPopRenderables(nativeAsset: Int64; result: PInteger; count: Integer): Integer;
  cdecl; external LIB_GLTFIO_JNI;

function nAssetGetEntityCount(nativeAsset: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

procedure nAssetGetEntities(nativeAsset: Int64; result: PInteger; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetFirstEntityByName(nativeAsset: Int64; name: PAnsiChar): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// When result = nil: returns only the entity count (count query for retrieval)
function nGetEntitiesByName(nativeAsset: Int64; name: PAnsiChar;
  result: PInteger; count: Integer): Integer;
  cdecl; external LIB_GLTFIO_JNI;

function nGetEntitiesByPrefix(nativeAsset: Int64; prefix: PAnsiChar;
  result: PInteger; count: Integer): Integer;
  cdecl; external LIB_GLTFIO_JNI;

function nGetLightEntityCount(nativeAsset: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

procedure nGetLightEntities(nativeAsset: Int64; result: PInteger; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetRenderableEntityCount(nativeAsset: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

procedure nGetRenderableEntities(nativeAsset: Int64; result: PInteger; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetCameraEntityCount(nativeAsset: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

procedure nGetCameraEntities(nativeAsset: Int64; result: PInteger; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

// result[0..5]: center.xyz, extent.xyz (6 floats)
procedure nGetBoundingBox(nativeAsset: Int64; result: PSingle);
  cdecl; external LIB_GLTFIO_JNI;

function nGetName(nativeAsset: Int64; entityId: Integer): PAnsiChar;
  cdecl; external LIB_GLTFIO_JNI;

function nGetExtras(nativeAsset: Int64; entityId: Integer): PAnsiChar;
  cdecl; external LIB_GLTFIO_JNI;

function nGetInstance(nativeAsset: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

function nGetResourceUriCount(nativeAsset: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// Returns an array of C string pointers valid only while the asset is alive (PPAnsiChar)
function nGetResourceUris(nativeAsset: Int64): PPAnsiChar;
  cdecl; external LIB_GLTFIO_JNI;

function nGetMorphTargetCount(nativeAsset: Int64; entityId: Integer): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// result[0..count-1]: morph target name pointers (valid while the asset is alive)
procedure nGetMorphTargetNames(nativeAsset: Int64; entityId: Integer;
  result: PPAnsiChar; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

procedure nReleaseSourceData(nativeAsset: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// =============================================================================
// FilamentInstance  (FilamentInstance.cpp)
//   NOTE: nGetRoot / nGetEntityCount / nGetEntities are distinguished using nInstance*.
// =============================================================================

function nInstanceGetRoot(nativeInstance: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

function nInstanceGetEntityCount(nativeInstance: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

procedure nInstanceGetEntities(nativeInstance: Int64; result: PInteger; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetAnimator(nativeInstance: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

procedure nApplyMaterialVariant(nativeInstance: Int64; variantIndex: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetMaterialVariantCount(nativeInstance: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// result[0..count-1]: variant name pointers (valid while the instance is alive)
procedure nGetMaterialVariantNames(nativeInstance: Int64; result: PPAnsiChar; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetMaterialInstanceCount(nativeInstance: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

procedure nGetMaterialInstances(nativeInstance: Int64; result: PInt64; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

procedure nAttachSkin(nativeInstance: Int64; skinIndex: Integer; targetEntity: Integer);
  cdecl; external LIB_GLTFIO_JNI;

procedure nDetachSkin(nativeInstance: Int64; skinIndex: Integer; targetEntity: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetSkinCount(nativeInstance: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// result[0..count-1]: skin name pointers (valid while the instance is alive)
procedure nGetSkinNames(nativeInstance: Int64; result: PPAnsiChar; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nGetJointCountAt(nativeInstance: Int64; skinIndex: Integer): Integer;
  cdecl; external LIB_GLTFIO_JNI;

procedure nGetJointsAt(nativeInstance: Int64; skinIndex: Integer;
  result: PInteger; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

// =============================================================================
// AssetLoader  (AssetLoader.cpp)
// =============================================================================

// nativeEntities: EntityManager* (obtained from EntityManager)
function nCreateAssetLoader(nativeEngine: Int64; nativeMaterialProvider: Int64;
  nativeEntities: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

procedure nDestroyAssetLoader(nativeLoader: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// data: glTF binary data (Pointer), size: byte count
function nCreateAsset(nativeLoader: Int64; data: Pointer; size: Integer): Int64;
  cdecl; external LIB_GLTFIO_JNI;

// Stores and returns FilamentInstance pointers in instances[0..numInstances-1]
function nCreateInstancedAsset(nativeLoader: Int64; data: Pointer; size: Integer;
  instances: PInt64; numInstances: Integer): Int64;
  cdecl; external LIB_GLTFIO_JNI;

function nCreateInstance(nativeLoader: Int64; nativeAsset: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

procedure nEnableDiagnostics(nativeLoader: Int64; enable: Boolean);
  cdecl; external LIB_GLTFIO_JNI;

procedure nDestroyAsset(nativeLoader: Int64; nativeAsset: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// =============================================================================
// ResourceLoader  (ResourceLoader.cpp)
// =============================================================================

function nCreateResourceLoader(nativeEngine: Int64;
  normalizeSkinningWeights: Boolean): Int64;
  cdecl; external LIB_GLTFIO_JNI;

procedure nDestroyResourceLoader(nativeLoader: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// url: UTF-8 string. data/size: resource binary. The caller manages the buffer.
procedure nAddResourceData(nativeLoader: Int64; url: PAnsiChar;
  data: Pointer; size: Integer);
  cdecl; external LIB_GLTFIO_JNI;

function nHasResourceData(nativeLoader: Int64; url: PAnsiChar): Boolean;
  cdecl; external LIB_GLTFIO_JNI;

procedure nEvictResourceData(nativeLoader: Int64);
  cdecl; external LIB_GLTFIO_JNI;

procedure nLoadResources(nativeLoader: Int64; nativeAsset: Int64);
  cdecl; external LIB_GLTFIO_JNI;

function nAsyncBeginLoad(nativeLoader: Int64; nativeAsset: Int64): Boolean;
  cdecl; external LIB_GLTFIO_JNI;

function nAsyncGetLoadProgress(nativeLoader: Int64): Single;
  cdecl; external LIB_GLTFIO_JNI;

procedure nAsyncUpdateLoad(nativeLoader: Int64);
  cdecl; external LIB_GLTFIO_JNI;

procedure nAsyncCancelLoad(nativeLoader: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// TextureProvider factory
function nCreateStbProvider(nativeEngine: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

function nCreateKtx2Provider(nativeEngine: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

function nIsWebpSupported(): Boolean;
  cdecl; external LIB_GLTFIO_JNI;

function nCreateWebpProvider(nativeEngine: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

procedure nDestroyTextureProvider(nativeProvider: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// url: URL scheme processed by TextureProvider (e.g., "image/ktx2")
procedure nAddTextureProvider(nativeLoader: Int64; url: PAnsiChar;
  nativeProvider: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// =============================================================================
// UbershaderProvider  (UbershaderProvider.cpp)
// =============================================================================

function nCreateUbershaderProvider(nativeEngine: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

procedure nDestroyUbershaderProvider(nativeProvider: Int64);
  cdecl; external LIB_GLTFIO_JNI;

procedure nDestroyMaterials(nativeProvider: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// uvmap[0..7]: UvMap output (UvSet values; 0=UNUSED 1=UV0 2=UV1).
// constrainMaterial() is called internally; no separate nConstrainMaterial needed.
// Return value: MaterialInstance* (returned as Int64)
function nCreateMaterialInstance(nativeProvider: Int64;
  doubleSided: Boolean; unlit: Boolean; hasVertexColors: Boolean;
  hasBaseColorTexture: Boolean; hasNormalTexture: Boolean; hasOcclusionTexture: Boolean;
  hasEmissiveTexture: Boolean; useSpecularGlossiness: Boolean;
  alphaMode: Integer;
  enableDiagnostics: Boolean;
  hasMetallicRoughnessTexture: Boolean;
  metallicRoughnessUV: Byte; baseColorUV: Byte;
  hasClearCoatTexture: Boolean; clearCoatUV: Byte;
  hasClearCoatRoughnessTexture: Boolean; clearCoatRoughnessUV: Byte;
  hasClearCoatNormalTexture: Boolean; clearCoatNormalUV: Byte;
  hasClearCoat: Boolean; hasTransmission: Boolean; hasTextureTransforms: Boolean;
  emissiveUV: Byte; aoUV: Byte; normalUV: Byte;
  hasTransmissionTexture: Boolean; transmissionUV: Byte;
  hasSheenColorTexture: Boolean; sheenColorUV: Byte;
  hasSheenRoughnessTexture: Boolean; sheenRoughnessUV: Byte;
  hasVolumeThicknessTexture: Boolean; volumeThicknessUV: Byte;
  hasSheen: Boolean; hasIOR: Boolean;
  hasVolume: Boolean; hasDispersion: Boolean;
  hasSpecular: Boolean; hasSpecularTexture: Boolean; hasSpecularColorTexture: Boolean;
  specularTextureUV: Byte; specularColorTextureUV: Byte;
  uvmap: PInteger;
  label_: PAnsiChar; extras: PAnsiChar): Int64;
  cdecl; external LIB_GLTFIO_JNI;

// uvmap[0..7]: UvMap output. Return value: Material* (returned as Int64)
function nGetMaterial(nativeProvider: Int64;
  doubleSided: Boolean; unlit: Boolean; hasVertexColors: Boolean;
  hasBaseColorTexture: Boolean; hasNormalTexture: Boolean; hasOcclusionTexture: Boolean;
  hasEmissiveTexture: Boolean; useSpecularGlossiness: Boolean;
  alphaMode: Integer;
  enableDiagnostics: Boolean;
  hasMetallicRoughnessTexture: Boolean;
  metallicRoughnessUV: Byte; baseColorUV: Byte;
  hasClearCoatTexture: Boolean; clearCoatUV: Byte;
  hasClearCoatRoughnessTexture: Boolean; clearCoatRoughnessUV: Byte;
  hasClearCoatNormalTexture: Boolean; clearCoatNormalUV: Byte;
  hasClearCoat: Boolean; hasTransmission: Boolean; hasTextureTransforms: Boolean;
  emissiveUV: Byte; aoUV: Byte; normalUV: Byte;
  hasTransmissionTexture: Boolean; transmissionUV: Byte;
  hasSheenColorTexture: Boolean; sheenColorUV: Byte;
  hasSheenRoughnessTexture: Boolean; sheenRoughnessUV: Byte;
  hasVolumeThicknessTexture: Boolean; volumeThicknessUV: Byte;
  hasSheen: Boolean; hasIOR: Boolean;
  hasVolume: Boolean; hasDispersion: Boolean;
  hasSpecular: Boolean; hasSpecularTexture: Boolean; hasSpecularColorTexture: Boolean;
  specularTextureUV: Byte; specularColorTextureUV: Byte;
  uvmap: PInteger;
  label_: PAnsiChar): Int64;
  cdecl; external LIB_GLTFIO_JNI;

function nGetMaterialCount(nativeProvider: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// result[0..count-1]: Material* pointers
procedure nGetMaterials(nativeProvider: Int64; result: PInt64; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

implementation

{$ENDIF}
end.
