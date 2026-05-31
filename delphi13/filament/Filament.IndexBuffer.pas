unit Filament.IndexBuffer;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/IndexBuffer.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong       -> Int64
  jint        -> Integer
  const void* -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderIndexCount(nativeBuilder: Int64; indexCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderIndexCount';
procedure nBuilderBufferType(nativeBuilder: Int64; indexType: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderBufferType';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nGetIndexCount(nativeIndexBuffer: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetIndexCount';
function  nSetBuffer(nativeIndexBuffer: Int64; nativeEngine: Int64; data: Pointer; sizeInBytes: Integer; destOffsetInBytes: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetBuffer';

{$ENDIF}

implementation

end.
