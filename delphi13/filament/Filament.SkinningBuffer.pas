unit Filament.SkinningBuffer;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/SkinningBuffer.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  const void* -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderBoneCount(nativeBuilder: Int64; boneCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderBoneCount';
procedure nBuilderInitialize(nativeBuilder: Int64; initialize: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderInitialize';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nSetBonesAsMatrices(nativeSkinningBuffer: Int64; nativeEngine: Int64; matrices: Pointer; boneCount: Integer; offset: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetBonesAsMatrices';
function  nSetBonesAsQuaternions(nativeSkinningBuffer: Int64; nativeEngine: Int64; quaternions: Pointer; boneCount: Integer; offset: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetBonesAsQuaternions';
function  nGetBoneCount(nativeSkinningBuffer: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetBoneCount';

{$ENDIF}

implementation

end.
