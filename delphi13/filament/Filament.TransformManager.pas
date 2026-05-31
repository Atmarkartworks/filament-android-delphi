unit Filament.TransformManager;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/TransformManager.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  float*   -> Pointer  (mat4f = 16 floats)
  double*  -> Pointer  (mat4  = 16 doubles)
  jint*    -> Pointer  (entity id array)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nHasComponent(nativeTransformManager: Int64; entity_: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nHasComponent';
function  nGetInstance(nativeTransformManager: Int64; entity_: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetInstance';
function  nCreate(nativeTransformManager: Int64; entity_: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nCreate';
function  nCreateArray(nativeTransformManager: Int64; entity_: Integer; parent: Integer; localTransform: Pointer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nCreateArray';
function  nCreateArrayFp64(nativeTransformManager: Int64; entity_: Integer; parent: Integer; localTransform: Pointer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nCreateArrayFp64';
procedure nDestroy(nativeTransformManager: Int64; entity_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nDestroy';
procedure nSetParent(nativeTransformManager: Int64; i: Integer; newParent: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetParent';
function  nGetParent(nativeTransformManager: Int64; i: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetParent';
function  nGetChildCount(nativeTransformManager: Int64; i: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetChildCount';
procedure nGetChildren(nativeTransformManager: Int64; i: Integer; outEntities: Pointer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nGetChildren';
procedure nSetTransform(nativeTransformManager: Int64; i: Integer; localTransform: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetTransform';
procedure nSetTransformFp64(nativeTransformManager: Int64; i: Integer; localTransform: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetTransformFp64';
procedure nGetTransform(nativeTransformManager: Int64; i: Integer; outLocalTransform: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetTransform';
procedure nGetTransformFp64(nativeTransformManager: Int64; i: Integer; outLocalTransform: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetTransformFp64';
procedure nGetWorldTransform(nativeTransformManager: Int64; i: Integer; outWorldTransform: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetWorldTransform';
procedure nGetWorldTransformFp64(nativeTransformManager: Int64; i: Integer; outWorldTransform: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetWorldTransformFp64';
procedure nOpenLocalTransformTransaction(nativeTransformManager: Int64); cdecl; external LIB_FILAMENT_JNI name 'nOpenLocalTransformTransaction';
procedure nCommitLocalTransformTransaction(nativeTransformManager: Int64); cdecl; external LIB_FILAMENT_JNI name 'nCommitLocalTransformTransaction';
procedure nSetAccurateTranslationsEnabled(nativeTransformManager: Int64; enable: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetAccurateTranslationsEnabled';
function  nIsAccurateTranslationsEnabled(nativeTransformManager: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsAccurateTranslationsEnabled';

{$ENDIF}

implementation

end.
