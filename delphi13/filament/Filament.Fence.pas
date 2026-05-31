unit Filament.Fence;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Fence.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong -> Int64
  jint  -> Integer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function nWait(nativeFence: Int64; mode: Integer; timeoutNanoSeconds: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nWait';
function nWaitAndDestroy(nativeFence: Int64; mode: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nWaitAndDestroy';

{$ENDIF}

implementation

end.
