unit Filament.SwapChain;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/SwapChain.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jboolean -> Boolean
  SwapChainCallback / FrameScheduledCallback -> Pointer (function pointer)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nSetFrameCompletedCallback(nativeSwapChain: Int64; callback: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetFrameCompletedCallback';
function  nIsSRGBSwapChainSupported(nativeEngine: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsSRGBSwapChainSupported';
function  nIsMSAASwapChainSupported(nativeEngine: Int64; samples: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsMSAASwapChainSupported';
function  nIsProtectedContentSupported(nativeEngine: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsProtectedContentSupported';
procedure nSetFrameScheduledCallback(nativeSwapChain: Int64; callback: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetFrameScheduledCallback';
function  nIsFrameScheduledCallbackSet(nativeSwapChain: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsFrameScheduledCallbackSet';

{$ENDIF}

implementation

end.
