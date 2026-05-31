unit Filament.IndirectLight;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/IndirectLight.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong   -> Int64
  jint    -> Integer
  jfloat  -> Single
  float*  -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
procedure nBuilderReflections(nativeBuilder: Int64; nativeTexture: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderReflections';
procedure nIrradiance(nativeBuilder: Int64; bands: Integer; sh: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nIrradiance';
procedure nRadiance(nativeBuilder: Int64; bands: Integer; sh: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nRadiance';
procedure nIrradianceAsTexture(nativeBuilder: Int64; nativeTexture: Int64); cdecl; external LIB_FILAMENT_JNI name 'nIrradianceAsTexture';
procedure nIntensity(nativeBuilder: Int64; envIntensity: Single); cdecl; external LIB_FILAMENT_JNI name 'nIntensity';
procedure nRotation(nativeBuilder: Int64; v0: Single; v1: Single; v2: Single; v3: Single; v4: Single; v5: Single; v6: Single; v7: Single; v8: Single); cdecl; external LIB_FILAMENT_JNI name 'nRotation';
procedure nSetIntensity(nativeIndirectLight: Int64; intensity: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetIntensity';
function  nGetIntensity(nativeIndirectLight: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetIntensity';
procedure nSetRotation(nativeIndirectLight: Int64; v0: Single; v1: Single; v2: Single; v3: Single; v4: Single; v5: Single; v6: Single; v7: Single; v8: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetRotation';
procedure nGetRotation(nativeIndirectLight: Int64; outRotation: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetRotation';
procedure nGetDirectionEstimate(nativeIndirectLight: Int64; outDirection: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetDirectionEstimate';
procedure nGetColorEstimate(nativeIndirectLight: Int64; outColor: Pointer; x: Single; y: Single; z: Single); cdecl; external LIB_FILAMENT_JNI name 'nGetColorEstimate';
function  nGetReflectionsTexture(nativeIndirectLight: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetReflectionsTexture';
function  nGetIrradianceTexture(nativeIndirectLight: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetIrradianceTexture';
procedure nGetDirectionEstimateStatic(sh: Pointer; outDirection: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetDirectionEstimateStatic';
procedure nGetColorEstimateStatic(outColor: Pointer; sh: Pointer; x: Single; y: Single; z: Single); cdecl; external LIB_FILAMENT_JNI name 'nGetColorEstimateStatic';

{$ENDIF}

implementation

end.
