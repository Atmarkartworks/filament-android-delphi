unit Filament.LightManager;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/LightManager.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jfloat   -> Single
  jboolean -> Boolean
  float*   -> Pointer
  const float* -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nGetComponentCount(nativeLightManager: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetComponentCount';
function  nHasComponent(nativeLightManager: Int64; entity: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nHasComponent';
function  nGetInstance(nativeLightManager: Int64; entity: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetInstance';
procedure nDestroy(nativeLightManager: Int64; entity: Integer); cdecl; external LIB_FILAMENT_JNI name 'nDestroy';
function  nCreateBuilder(lightType: Integer): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderCastShadows(nativeBuilder: Int64; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderCastShadows';
procedure nBuilderShadowOptions(nativeBuilder: Int64; mapSize: Integer; cascades: Integer;
  splitPositions: Pointer; splitCount: Integer;
  constantBias: Single; normalBias: Single; shadowFar: Single; shadowNearHint: Single;
  shadowFarHint: Single; stable: Boolean; lispsm: Boolean;
  polygonOffsetConstant: Single; polygonOffsetSlope: Single;
  screenSpaceContactShadows: Boolean; stepCount: Integer;
  maxShadowDistance: Single; elvsm: Boolean; blurWidth: Single; shadowBulbRadius: Single;
  transform: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderShadowOptions';
procedure nBuilderCastLight(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderCastLight';
procedure nBuilderPosition(nativeBuilder: Int64; x: Single; y: Single; z: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderPosition';
procedure nBuilderDirection(nativeBuilder: Int64; x: Single; y: Single; z: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderDirection';
procedure nBuilderColor(nativeBuilder: Int64; linearR: Single; linearG: Single; linearB: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderColor';
procedure nBuilderIntensityCandela(nativeBuilder: Int64; intensity: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderIntensityCandela';
procedure nBuilderIntensity__JF(nativeBuilder: Int64; intensity: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderIntensity__JF';
procedure nBuilderIntensity__JFF(nativeBuilder: Int64; watts: Single; efficiency: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderIntensity__JFF';
procedure nBuilderFalloff(nativeBuilder: Int64; radius: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderFalloff';
procedure nBuilderSpotLightCone(nativeBuilder: Int64; inner: Single; outer: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSpotLightCone';
procedure nBuilderAngularRadius(nativeBuilder: Int64; angularRadius: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderAngularRadius';
procedure nBuilderHaloSize(nativeBuilder: Int64; haloSize: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderHaloSize';
procedure nBuilderHaloFalloff(nativeBuilder: Int64; haloFalloff: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderHaloFalloff';
procedure nBuilderLightChannel(nativeBuilder: Int64; channel: Integer; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderLightChannel';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64; entity: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
procedure nComputeUniformSplits(splitPositions: Pointer; cascades: Integer); cdecl; external LIB_FILAMENT_JNI name 'nComputeUniformSplits';
procedure nComputeLogSplits(splitPositions: Pointer; cascades: Integer; near: Single; far: Single); cdecl; external LIB_FILAMENT_JNI name 'nComputeLogSplits';
procedure nComputePracticalSplits(splitPositions: Pointer; cascades: Integer; near: Single; far: Single; lambda: Single); cdecl; external LIB_FILAMENT_JNI name 'nComputePracticalSplits';
function  nGetType(nativeLightManager: Int64; i: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetType';
procedure nSetPosition(nativeLightManager: Int64; i: Integer; x: Single; y: Single; z: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetPosition';
procedure nGetPosition(nativeLightManager: Int64; i: Integer; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetPosition';
procedure nSetDirection(nativeLightManager: Int64; i: Integer; x: Single; y: Single; z: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetDirection';
procedure nGetDirection(nativeLightManager: Int64; i: Integer; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetDirection';
procedure nSetColor(nativeLightManager: Int64; i: Integer; linearR: Single; linearG: Single; linearB: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetColor';
procedure nGetColor(nativeLightManager: Int64; i: Integer; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetColor';
procedure nSetIntensity__JIF(nativeLightManager: Int64; i: Integer; intensity: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetIntensity__JIF';
procedure nSetIntensity__JIFF(nativeLightManager: Int64; i: Integer; watts: Single; efficiency: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetIntensity__JIFF';
procedure nSetIntensityCandela(nativeLightManager: Int64; i: Integer; intensity: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetIntensityCandela';
function  nGetIntensity(nativeLightManager: Int64; i: Integer): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetIntensity';
procedure nSetFalloff(nativeLightManager: Int64; i: Integer; falloff: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetFalloff';
function  nGetFalloff(nativeLightManager: Int64; i: Integer): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetFalloff';
procedure nSetSpotLightCone(nativeLightManager: Int64; i: Integer; inner: Single; outer: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetSpotLightCone';
procedure nSetSunAngularRadius(nativeLightManager: Int64; i: Integer; angularRadius: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetSunAngularRadius';
function  nGetSunAngularRadius(nativeLightManager: Int64; i: Integer): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetSunAngularRadius';
procedure nSetSunHaloSize(nativeLightManager: Int64; i: Integer; haloSize: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetSunHaloSize';
function  nGetSunHaloSize(nativeLightManager: Int64; i: Integer): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetSunHaloSize';
procedure nSetSunHaloFalloff(nativeLightManager: Int64; i: Integer; haloFalloff: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetSunHaloFalloff';
function  nGetSunHaloFalloff(nativeLightManager: Int64; i: Integer): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetSunHaloFalloff';
procedure nSetShadowCaster(nativeLightManager: Int64; i: Integer; shadowCaster: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetShadowCaster';
function  nIsShadowCaster(nativeLightManager: Int64; i: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsShadowCaster';
function  nGetOuterConeAngle(nativeLightManager: Int64; i: Integer): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetOuterConeAngle';
function  nGetInnerConeAngle(nativeLightManager: Int64; i: Integer): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetInnerConeAngle';

{$ENDIF}

implementation

end.
