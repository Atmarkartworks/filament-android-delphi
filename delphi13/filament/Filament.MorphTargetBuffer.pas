unit Filament.MorphTargetBuffer;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/MorphTargetBuffer.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jshort   -> SmallInt  (used as array element via Pointer)
  jboolean -> Boolean
  const float* -> Pointer
  const jshort* -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderVertexCount(nativeBuilder: Int64; vertexCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderVertexCount';
procedure nBuilderCount(nativeBuilder: Int64; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderCount';
procedure nBuilderWithPositions(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderWithPositions';
procedure nBuilderWithTangents(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderWithTangents';
procedure nBuilderEnableCustomMorphing(nativeBuilder: Int64; enabled: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderEnableCustomMorphing';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nSetPositionsAt(nativeObject: Int64; nativeEngine: Int64; targetIndex: Integer; positions: Pointer; count: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetPositionsAt';
function  nSetTangentsAt(nativeObject: Int64; nativeEngine: Int64; targetIndex: Integer; tangents: Pointer; count: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetTangentsAt';
function  nGetVertexCount(nativeObject: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetVertexCount';

{$ENDIF}

implementation

end.
