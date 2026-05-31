unit Filament.BufferObject;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/BufferObject.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  void*    -> Pointer
  const void* -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderSize(nativeBuilder: Int64; byteCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSize';
procedure nBuilderBindingType(nativeBuilder: Int64; bindingType: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderBindingType';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nGetByteCount(nativeBufferObject: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetByteCount';
function  nSetBuffer(nativeBufferObject: Int64; nativeEngine: Int64; data: Pointer; sizeInBytes: Integer; destOffsetInBytes: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetBuffer';

{$ENDIF}

implementation

end.
