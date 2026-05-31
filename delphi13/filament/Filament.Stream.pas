unit Filament.Stream;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Stream.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong  -> Int64
  jint   -> Integer
  void*  -> Pointer  (ANativeWindow surface, AHardwareBuffer)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeStreamBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderStreamSource(nativeStreamBuilder: Int64; surface: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderStreamSource';
procedure nBuilderWidth(nativeStreamBuilder: Int64; width: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderWidth';
procedure nBuilderHeight(nativeStreamBuilder: Int64; height: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderHeight';
function  nBuilderBuild(nativeStreamBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nGetStreamType(nativeStream: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetStreamType';
procedure nSetDimensions(nativeStream: Int64; width: Integer; height: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetDimensions';
function  nGetTimestamp(nativeStream: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nGetTimestamp';
procedure nSetAcquiredImage(nativeStream: Int64; nativeEngine: Int64; nativeBuffer: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetAcquiredImage';

{$ENDIF}

implementation

end.
