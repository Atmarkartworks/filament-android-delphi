unit Filament.EntityManager;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/EntityManager.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  jint*    -> Pointer  (array of entity ids)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nGetEntityManager: Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetEntityManager';
procedure nCreateArray(nativeEntityManager: Int64; n: Integer; entities: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nCreateArray';
function  nCreate(nativeEntityManager: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nCreate';
procedure nDestroyArray(nativeEntityManager: Int64; n: Integer; entities: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nDestroyArray';
procedure nDestroy(nativeEntityManager: Int64; entity_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nDestroy';
function  nIsAlive(nativeEntityManager: Int64; entity_: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsAlive';

{$ENDIF}

implementation

end.
