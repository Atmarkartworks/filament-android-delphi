unit Filament.VertexBuffer;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/VertexBuffer.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong       -> Int64
  jint        -> Integer
  jboolean    -> Boolean
  const void* -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderVertexCount(nativeBuilder: Int64; vertexCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderVertexCount';
procedure nBuilderEnableBufferObjects(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderEnableBufferObjects';
procedure nBuilderBufferCount(nativeBuilder: Int64; bufferCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderBufferCount';
procedure nBuilderAttribute(nativeBuilder: Int64; attribute: Integer; bufferIndex: Integer; attributeType: Integer; byteOffset: Integer; byteStride: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderAttribute';
procedure nBuilderNormalized(nativeBuilder: Int64; attribute: Integer; normalized: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderNormalized';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nGetVertexCount(nativeVertexBuffer: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetVertexCount';
function  nSetBufferAt(nativeVertexBuffer: Int64; nativeEngine: Int64; bufferIndex: Integer; data: Pointer; sizeInBytes: Integer; destOffsetInBytes: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetBufferAt';
procedure nSetBufferObjectAt(nativeVertexBuffer: Int64; nativeEngine: Int64; bufferIndex: Integer; nativeBufferObject: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetBufferObjectAt';

{$ENDIF}

implementation

end.
