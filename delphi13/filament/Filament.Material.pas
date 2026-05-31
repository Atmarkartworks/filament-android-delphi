unit Filament.Material;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Material.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong       -> Int64
  jint        -> Integer
  jfloat      -> Single
  jboolean    -> Boolean
  const void* -> Pointer
  const char* -> PAnsiChar

  TParameterInfo mirrors the local ParameterInfo struct in Material.cpp
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

type
  TParameterInfo = record
    name      : PAnsiChar;
    type_     : Integer;
    precision : Integer;
    count     : Integer;
  end;
  PParameterInfo = ^TParameterInfo;

function  nBuilderBuild(nativeEngine: Int64; data: Pointer; size: Integer; shBandCount: Integer; shadowQuality: Integer; uboBatchingMode: Integer): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nGetDefaultInstance(nativeMaterial: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetDefaultInstance';
function  nCreateInstance(nativeMaterial: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateInstance';
function  nCreateInstanceWithName(nativeMaterial: Int64; name: PAnsiChar): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateInstanceWithName';
function  nGetName(nativeMaterial: Int64): PAnsiChar; cdecl; external LIB_FILAMENT_JNI name 'nGetName';
function  nGetShading(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetShading';
function  nGetInterpolation(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetInterpolation';
function  nGetBlendingMode(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetBlendingMode';
function  nGetTransparencyMode(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetTransparencyMode';
function  nGetRefractionMode(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetRefractionMode';
function  nGetRefractionType(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetRefractionType';
function  nGetReflectionMode(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetReflectionMode';
function  nGetFeatureLevel(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetFeatureLevel';
function  nGetVertexDomain(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetVertexDomain';
function  nGetCullingMode(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetCullingMode';
function  nIsColorWriteEnabled(nativeMaterial: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsColorWriteEnabled';
function  nIsDepthWriteEnabled(nativeMaterial: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsDepthWriteEnabled';
function  nIsDepthCullingEnabled(nativeMaterial: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsDepthCullingEnabled';
function  nIsDoubleSided(nativeMaterial: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsDoubleSided';
function  nIsAlphaToCoverageEnabled(nativeMaterial: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsAlphaToCoverageEnabled';
function  nGetMaskThreshold(nativeMaterial: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetMaskThreshold';
function  nGetSpecularAntiAliasingVariance(nativeMaterial: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetSpecularAntiAliasingVariance';
function  nGetSpecularAntiAliasingThreshold(nativeMaterial: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetSpecularAntiAliasingThreshold';
function  nGetParameterCount(nativeMaterial: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetParameterCount';
procedure nGetParameters(nativeMaterial: Int64; output: PParameterInfo; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nGetParameters';

{$ENDIF}

implementation

end.
