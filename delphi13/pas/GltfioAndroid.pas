unit GltfioAndroid;

{$IFDEF ANDROID}

interface

const
  LIB_GLTFIO_JNI = 'gltfio-jni';  // libgltfio-jni.so

// =============================================================================
// TMaterialKey
//   C++ 型: filament::gltfio::MaterialKey  (gltfio/MaterialProvider.h)
//   実体は C++ ビットフィールド構造体。Delphi では不透明バイト配列として渡す。
//   サイズは gltfio/MaterialProvider.h の定義と一致させること（通常 8 バイト）。
// =============================================================================

type
  TMaterialKey = record
    Data: array[0..7] of Byte;
    // NOTE: このフィールドは gltfio/MaterialProvider.h の MaterialKey bit-field
    //       構造体と正確に同じレイアウトが必要。ビルド時に SizeOf(MaterialKey)
    //       と比較して確認すること。
  end;
  PMaterialKey = ^TMaterialKey;

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
//   NOTE: nGetRoot / nGetEntityCount / nGetEntities は FilamentInstance と
//         名前が衝突するため nAsset* プレフィックスで区別する。
//         対応する C++ シンボル名も同様にリネーム済み。
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

// result = nil のとき: エンティティ数のみ返す（取得用カウント問い合わせ）
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

// アセット生存中のみ有効な C 文字列ポインタ配列を返す (PPAnsiChar)
function nGetResourceUris(nativeAsset: Int64): PPAnsiChar;
  cdecl; external LIB_GLTFIO_JNI;

function nGetMorphTargetCount(nativeAsset: Int64; entityId: Integer): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// result[0..count-1]: モーフターゲット名ポインタ (アセット生存中有効)
procedure nGetMorphTargetNames(nativeAsset: Int64; entityId: Integer;
  result: PPAnsiChar; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

procedure nReleaseSourceData(nativeAsset: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// =============================================================================
// FilamentInstance  (FilamentInstance.cpp)
//   NOTE: nGetRoot / nGetEntityCount / nGetEntities を nInstance* で区別。
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

// result[0..count-1]: バリアント名ポインタ (インスタンス生存中有効)
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

// result[0..count-1]: スキン名ポインタ (インスタンス生存中有効)
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

// nativeEntities: EntityManager* (EntityManager から取得)
function nCreateAssetLoader(nativeEngine: Int64; nativeMaterialProvider: Int64;
  nativeEntities: Int64): Int64;
  cdecl; external LIB_GLTFIO_JNI;

procedure nDestroyAssetLoader(nativeLoader: Int64);
  cdecl; external LIB_GLTFIO_JNI;

// data: glTF バイナリデータ (Pointer)、size: バイト数
function nCreateAsset(nativeLoader: Int64; data: Pointer; size: Integer): Int64;
  cdecl; external LIB_GLTFIO_JNI;

// instances[0..numInstances-1] に FilamentInstance ポインタを格納して返す
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

// url: UTF-8 文字列。data/size: リソースバイナリ。呼び出し元がバッファを管理する。
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

// TextureProvider ファクトリ
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

// url: TextureProvider が処理する URL スキーム (例: "image/ktx2")
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

// materialKey: in-out (constrain 後の値が書き戻される)
// uvmap[0..uvmapSize-1]: UvMap 出力（UvSet 整数値）
// 戻り値: MaterialInstance* (Int64 として返す)
function nCreateMaterialInstance(nativeProvider: Int64;
  materialKey: PMaterialKey; uvmap: PInteger; uvmapSize: Integer;
  label_: PAnsiChar; extras: PAnsiChar): Int64;
  cdecl; external LIB_GLTFIO_JNI;

// 戻り値: Material* (Int64 として返す)
function nGetMaterial(nativeProvider: Int64;
  materialKey: PMaterialKey; uvmap: PInteger; uvmapSize: Integer;
  label_: PAnsiChar): Int64;
  cdecl; external LIB_GLTFIO_JNI;

function nGetMaterialCount(nativeProvider: Int64): Integer;
  cdecl; external LIB_GLTFIO_JNI;

// result[0..count-1]: Material* ポインタ
procedure nGetMaterials(nativeProvider: Int64; result: PInt64; count: Integer);
  cdecl; external LIB_GLTFIO_JNI;

// =============================================================================
// MaterialProvider  (MaterialKey.cpp)
// =============================================================================

// materialKey: in-out (constrain 後の値が書き戻される)
// uvMap[0..uvMapSize-1]: UvMap 出力
procedure nConstrainMaterial(materialKey: PMaterialKey;
  uvMap: PInteger; uvMapSize: Integer);
  cdecl; external LIB_GLTFIO_JNI;

implementation

{$ENDIF}
end.
