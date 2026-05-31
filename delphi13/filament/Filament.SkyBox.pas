unit Filament.SkyBox;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/SkyBox.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jfloat   -> Single
  jboolean -> Boolean
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeSkyBoxBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderEnvironment(nativeSkyBoxBuilder: Int64; nativeTexture: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderEnvironment';
procedure nBuilderShowSun(nativeSkyBoxBuilder: Int64; show: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderShowSun';
procedure nBuilderIntensity(nativeSkyBoxBuilder: Int64; intensity: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderIntensity';
procedure nBuilderColor(nativeSkyBoxBuilder: Int64; r: Single; g: Single; b: Single; a: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderColor';
procedure nBuilderPriority(nativeSkyBoxBuilder: Int64; priority: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderPriority';
function  nBuilderBuild(nativeSkyBoxBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
procedure nSetLayerMask(nativeSkybox: Int64; select: Integer; value: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetLayerMask';
function  nGetLayerMask(nativeSkybox: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetLayerMask';
function  nGetIntensity(nativeSkybox: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetIntensity';
procedure nSetColor(nativeSkybox: Int64; r: Single; g: Single; b: Single; a: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetColor';
function  nGetTexture(nativeSkybox: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetTexture';

{$ENDIF}

implementation

end.
