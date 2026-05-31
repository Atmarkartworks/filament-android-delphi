unit Filament.Scene;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Scene.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  jint*    -> Pointer  (entity id array)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nSetSkybox(nativeScene: Int64; nativeSkybox: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetSkybox';
procedure nSetIndirectLight(nativeScene: Int64; nativeIndirectLight: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetIndirectLight';
procedure nAddEntity(nativeScene: Int64; entity: Integer); cdecl; external LIB_FILAMENT_JNI name 'nAddEntity';
procedure nAddEntities(nativeScene: Int64; entities: Pointer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nAddEntities';
procedure nRemove(nativeScene: Int64; entity: Integer); cdecl; external LIB_FILAMENT_JNI name 'nRemove';
procedure nRemoveEntities(nativeScene: Int64; entities: Pointer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nRemoveEntities';
function  nGetEntityCount(nativeScene: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetEntityCount';
function  nGetRenderableCount(nativeScene: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetRenderableCount';
function  nGetLightCount(nativeScene: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetLightCount';
function  nHasEntity(nativeScene: Int64; entityId: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nHasEntity';
function  nGetEntities(nativeScene: Int64; out_: Pointer; length: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nGetEntities';

{$ENDIF}

implementation

end.
