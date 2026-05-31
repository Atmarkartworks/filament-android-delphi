unit Filament.RenderTarget;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/RenderTarget.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong -> Int64
  jint  -> Integer
  long  -> Int64
  int   -> Integer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderTexture(nativeBuilder: Int64; attachment: Integer; nativeTexture: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderTexture';
procedure nBuilderMipLevel(nativeBuilder: Int64; attachment: Integer; level: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderMipLevel';
procedure nBuilderFace(nativeBuilder: Int64; attachment: Integer; face: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderFace';
procedure nBuilderLayer(nativeBuilder: Int64; attachment: Integer; layer: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderLayer';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nGetMipLevel(nativeTarget: Int64; attachment: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetMipLevel';
function  nGetFace(nativeTarget: Int64; attachment: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetFace';
function  nGetLayer(nativeTarget: Int64; attachment: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetLayer';

{$ENDIF}

implementation

end.
