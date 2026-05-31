unit Filament.MaterialInstance;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/MaterialInstance.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong     -> Int64
  jint      -> Integer
  jfloat    -> Single
  jboolean  -> Boolean
  const char* -> PAnsiChar
  jboolean* -> Pointer
  jint*     -> Pointer
  float*    -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nSetParameterBool(nativeMaterialInstance: Int64; name: PAnsiChar; x: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterBool';
procedure nSetParameterBool2(nativeMaterialInstance: Int64; name: PAnsiChar; x: Boolean; y: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterBool2';
procedure nSetParameterBool3(nativeMaterialInstance: Int64; name: PAnsiChar; x: Boolean; y: Boolean; z: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterBool3';
procedure nSetParameterBool4(nativeMaterialInstance: Int64; name: PAnsiChar; x: Boolean; y: Boolean; z: Boolean; w: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterBool4';
procedure nSetParameterInt(nativeMaterialInstance: Int64; name: PAnsiChar; x: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterInt';
procedure nSetParameterInt2(nativeMaterialInstance: Int64; name: PAnsiChar; x: Integer; y: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterInt2';
procedure nSetParameterInt3(nativeMaterialInstance: Int64; name: PAnsiChar; x: Integer; y: Integer; z: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterInt3';
procedure nSetParameterInt4(nativeMaterialInstance: Int64; name: PAnsiChar; x: Integer; y: Integer; z: Integer; w: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterInt4';
procedure nSetParameterFloat(nativeMaterialInstance: Int64; name: PAnsiChar; x: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterFloat';
procedure nSetParameterFloat2(nativeMaterialInstance: Int64; name: PAnsiChar; x: Single; y: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterFloat2';
procedure nSetParameterFloat3(nativeMaterialInstance: Int64; name: PAnsiChar; x: Single; y: Single; z: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterFloat3';
procedure nSetParameterFloat4(nativeMaterialInstance: Int64; name: PAnsiChar; x: Single; y: Single; z: Single; w: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterFloat4';
procedure nSetBooleanParameterArray(nativeMaterialInstance: Int64; name: PAnsiChar; element: Integer; v: Pointer; offset: Integer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetBooleanParameterArray';
procedure nSetIntParameterArray(nativeMaterialInstance: Int64; name: PAnsiChar; element: Integer; v: Pointer; offset: Integer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetIntParameterArray';
procedure nSetFloatParameterArray(nativeMaterialInstance: Int64; name: PAnsiChar; element: Integer; v: Pointer; offset: Integer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetFloatParameterArray';
procedure nSetParameterTexture(nativeMaterialInstance: Int64; name: PAnsiChar; nativeTexture: Int64; sampler_: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetParameterTexture';
procedure nSetScissor(nativeMaterialInstance: Int64; left: Integer; bottom: Integer; width: Integer; height: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetScissor';
procedure nUnsetScissor(nativeMaterialInstance: Int64); cdecl; external LIB_FILAMENT_JNI name 'nUnsetScissor';
procedure nSetPolygonOffset(nativeMaterialInstance: Int64; scale: Single; constant: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetPolygonOffset';
procedure nSetMaskThreshold(nativeMaterialInstance: Int64; threshold: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetMaskThreshold';
procedure nSetSpecularAntiAliasingVariance(nativeMaterialInstance: Int64; variance: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetSpecularAntiAliasingVariance';
procedure nSetSpecularAntiAliasingThreshold(nativeMaterialInstance: Int64; threshold: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetSpecularAntiAliasingThreshold';
procedure nSetDoubleSided(nativeMaterialInstance: Int64; doubleSided: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetDoubleSided';
procedure nSetCullingMode(nativeMaterialInstance: Int64; cullingMode: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetCullingMode';
procedure nSetCullingModeSeparate(nativeMaterialInstance: Int64; colorPassCullingMode: Int64; shadowPassCullingMode: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetCullingModeSeparate';
procedure nSetColorWrite(nativeMaterialInstance: Int64; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetColorWrite';
procedure nSetDepthWrite(nativeMaterialInstance: Int64; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetDepthWrite';
procedure nSetStencilWrite(nativeMaterialInstance: Int64; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetStencilWrite';
procedure nSetDepthCulling(nativeMaterialInstance: Int64; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetDepthCulling';

{$ENDIF}

implementation

end.
