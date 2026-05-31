unit Filament.View;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/View.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jfloat   -> Single
  jboolean -> Boolean
  const char* -> PAnsiChar
  float*   -> Pointer
  PickingCallback -> Pointer (function pointer)

  TPickingResult mirrors the local PickingResult struct in View.cpp
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

type
  TPickingResult = record
    renderable  : Integer;
    depth       : Single;
    fragCoordsX : Single;
    fragCoordsY : Single;
    fragCoordsZ : Single;
  end;
  PPickingResult = ^TPickingResult;

procedure nSetName(nativeView: Int64; name: PAnsiChar); cdecl; external LIB_FILAMENT_JNI name 'nSetName';
procedure nSetScene(nativeView: Int64; nativeScene: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetScene';
procedure nSetCamera(nativeView: Int64; nativeCamera: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetCamera';
function  nHasCamera(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nHasCamera';
procedure nSetColorGrading(nativeView: Int64; nativeColorGrading: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetColorGrading';
procedure nSetViewport(nativeView: Int64; left: Integer; bottom: Integer; width: Integer; height: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetViewport';
procedure nSetVisibleLayers(nativeView: Int64; select: Integer; value: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetVisibleLayers';
function  nGetVisibleLayers(nativeView: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetVisibleLayers';
procedure nSetShadowingEnabled(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetShadowingEnabled';
procedure nSetRenderTarget(nativeView: Int64; nativeTarget: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetRenderTarget';
procedure nSetSampleCount(nativeView: Int64; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetSampleCount';
function  nGetSampleCount(nativeView: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetSampleCount';
procedure nSetAntiAliasing(nativeView: Int64; type_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetAntiAliasing';
function  nGetAntiAliasing(nativeView: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetAntiAliasing';
procedure nSetDithering(nativeView: Int64; dithering: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetDithering';
function  nGetDithering(nativeView: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetDithering';
procedure nSetDynamicResolutionOptions(nativeView: Int64;
  enabled: Boolean; homogeneousScaling: Boolean;
  minScale: Single; maxScale: Single; sharpness: Single; quality: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetDynamicResolutionOptions';
procedure nGetLastDynamicResolutionScale(nativeView: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetLastDynamicResolutionScale';
procedure nSetShadowType(nativeView: Int64; type_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetShadowType';
procedure nSetVsmShadowOptions(nativeView: Int64;
  anisotropy: Integer; mipmapping: Boolean; highPrecision: Boolean;
  minVarianceScale: Single; lightBleedReduction: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetVsmShadowOptions';
procedure nSetSoftShadowOptions(nativeView: Int64; penumbraScale: Single; penumbraRatioScale: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetSoftShadowOptions';
procedure nSetRenderQuality(nativeView: Int64; hdrColorBufferQuality: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetRenderQuality';
procedure nSetDynamicLightingOptions(nativeView: Int64; zLightNear: Single; zLightFar: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetDynamicLightingOptions';
procedure nSetPostProcessingEnabled(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetPostProcessingEnabled';
function  nIsPostProcessingEnabled(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsPostProcessingEnabled';
procedure nSetFrontFaceWindingInverted(nativeView: Int64; inverted: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetFrontFaceWindingInverted';
function  nIsFrontFaceWindingInverted(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsFrontFaceWindingInverted';
procedure nSetTransparentPickingEnabled(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetTransparentPickingEnabled';
function  nIsTransparentPickingEnabled(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsTransparentPickingEnabled';
procedure nSetAmbientOcclusion(nativeView: Int64; ordinal: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetAmbientOcclusion';
function  nGetAmbientOcclusion(nativeView: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetAmbientOcclusion';
procedure nSetAmbientOcclusionOptions(nativeView: Int64;
  radius: Single; bias: Single; power: Single; resolution: Single; intensity: Single;
  bilateralThreshold: Single;
  quality: Integer; lowPassFilter: Integer; upsampling: Integer;
  enabled: Boolean; bentNormals: Boolean;
  minHorizonAngleRad: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetAmbientOcclusionOptions';
procedure nSetSSCTOptions(nativeView: Int64;
  ssctLightConeRad: Single; ssctShadowDistance: Single; ssctContactDistanceMax: Single;
  ssctIntensity: Single; ssctLightDirX: Single; ssctLightDirY: Single; ssctLightDirZ: Single;
  ssctDepthBias: Single; ssctDepthSlopeBias: Single; ssctSampleCount: Integer;
  ssctRayCount: Integer; ssctEnabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetSSCTOptions';
procedure nSetBloomOptions(nativeView: Int64; nativeTexture: Int64;
  dirtStrength: Single; strength: Single; resolution: Integer; levels: Integer;
  blendMode: Integer; threshold: Boolean; enabled: Boolean; highlight: Single;
  lensFlare: Boolean; starburst: Boolean; chromaticAberration: Single; ghostCount: Integer;
  ghostSpacing: Single; ghostThreshold: Single; haloThickness: Single; haloRadius: Single;
  haloThreshold: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetBloomOptions';
procedure nSetFogOptions(nativeView: Int64;
  distance: Single; maximumOpacity: Single; height: Single; heightFalloff: Single; cutOffDistance: Single;
  r: Single; g: Single; b: Single; density: Single; inScatteringStart: Single;
  inScatteringSize: Single; fogColorFromIbl: Boolean; skyColorNativeObject: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetFogOptions';
procedure nSetBlendMode(nativeView: Int64; blendMode: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetBlendMode';
procedure nSetDepthOfFieldOptions(nativeView: Int64;
  cocScale: Single; maxApertureDiameter: Single; enabled: Boolean; filter: Integer;
  nativeResolution: Boolean; foregroundRingCount: Integer; backgroundRingCount: Integer;
  fastGatherRingCount: Integer; maxForegroundCOC: Integer; maxBackgroundCOC: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetDepthOfFieldOptions';
procedure nSetVignetteOptions(nativeView: Int64;
  midPoint: Single; roundness: Single; feather: Single;
  r: Single; g: Single; b: Single; a: Single; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetVignetteOptions';
procedure nSetMultiSampleAntiAliasingOptions(nativeView: Int64; enabled: Boolean; sampleCount: Integer; customResolve: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetMultiSampleAntiAliasingOptions';
procedure nSetTemporalAntiAliasingOptions(nativeView: Int64; feedback: Single; filterWidth: Single; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetTemporalAntiAliasingOptions';
procedure nSetScreenSpaceReflectionsOptions(nativeView: Int64; thickness: Single; bias: Single; maxDistance: Single; stride: Single; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetScreenSpaceReflectionsOptions';
function  nIsShadowingEnabled(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsShadowingEnabled';
procedure nSetFrustumCullingEnabled(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetFrustumCullingEnabled';
function  nIsFrustumCullingEnabled(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsFrustumCullingEnabled';
procedure nSetScreenSpaceRefractionEnabled(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetScreenSpaceRefractionEnabled';
function  nIsScreenSpaceRefractionEnabled(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsScreenSpaceRefractionEnabled';
procedure nPick(nativeView: Int64; x: Integer; y: Integer; callback: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nPick';
procedure nSetStencilBufferEnabled(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetStencilBufferEnabled';
function  nIsStencilBufferEnabled(nativeView: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsStencilBufferEnabled';
procedure nSetStereoscopicOptions(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetStereoscopicOptions';
procedure nSetGuardBandOptions(nativeView: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetGuardBandOptions';
procedure nSetMaterialGlobal(nativeView: Int64; index: Integer; x: Single; y: Single; z: Single; w: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetMaterialGlobal';
procedure nGetMaterialGlobal(nativeView: Int64; index: Integer; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetMaterialGlobal';
function  nGetFogEntity(nativeView: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetFogEntity';
procedure nClearFrameHistory(nativeView: Int64; nativeEngine: Int64); cdecl; external LIB_FILAMENT_JNI name 'nClearFrameHistory';
procedure nSetChannelDepthClearEnabled(nativeView: Int64; channel: Integer; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetChannelDepthClearEnabled';
function  nIsChannelDepthClearEnabled(nativeView: Int64; channel: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsChannelDepthClearEnabled';

{$ENDIF}

implementation

end.
