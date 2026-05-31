unit Filament.Renderer;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Renderer.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jfloat   -> Single
  jdouble  -> Double
  jboolean -> Boolean
  void*    -> Pointer  (pixel buffer)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nSkipFrame(nativeRenderer: Int64; vsyncSteadyClockTimeNano: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSkipFrame';
function  nShouldRenderFrame(nativeRenderer: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nShouldRenderFrame';
function  nBeginFrame(nativeRenderer: Int64; nativeSwapChain: Int64; frameTimeNanos: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nBeginFrame';
procedure nEndFrame(nativeRenderer: Int64); cdecl; external LIB_FILAMENT_JNI name 'nEndFrame';
procedure nRender(nativeRenderer: Int64; nativeView: Int64); cdecl; external LIB_FILAMENT_JNI name 'nRender';
procedure nRenderStandaloneView(nativeRenderer: Int64; nativeView: Int64); cdecl; external LIB_FILAMENT_JNI name 'nRenderStandaloneView';
procedure nCopyFrame(nativeRenderer: Int64; nativeDstSwapChain: Int64;
  dstLeft: Integer; dstBottom: Integer; dstWidth: Integer; dstHeight: Integer;
  srcLeft: Integer; srcBottom: Integer; srcWidth: Integer; srcHeight: Integer;
  flags: Integer); cdecl; external LIB_FILAMENT_JNI name 'nCopyFrame';
function  nReadPixels(nativeRenderer: Int64; nativeEngine: Int64;
  xoffset: Integer; yoffset: Integer; width: Integer; height: Integer;
  buffer: Pointer; sizeInBytes: Integer;
  left: Integer; top: Integer; type_: Integer; alignment: Integer; stride: Integer; format: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nReadPixels';
function  nReadPixelsEx(nativeRenderer: Int64; nativeEngine: Int64; nativeRenderTarget: Int64;
  xoffset: Integer; yoffset: Integer; width: Integer; height: Integer;
  buffer: Pointer; sizeInBytes: Integer;
  left: Integer; top: Integer; type_: Integer; alignment: Integer; stride: Integer; format: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nReadPixelsEx';
function  nGetUserTime(nativeRenderer: Int64): Double; cdecl; external LIB_FILAMENT_JNI name 'nGetUserTime';
procedure nResetUserTime(nativeRenderer: Int64); cdecl; external LIB_FILAMENT_JNI name 'nResetUserTime';
procedure nSetDisplayInfo(nativeRenderer: Int64; refreshRate: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetDisplayInfo';
procedure nSetFrameRateOptions(nativeRenderer: Int64; interval: Single; headRoomRatio: Single; scaleRate: Single; history: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetFrameRateOptions';
procedure nSetClearOptions(nativeRenderer: Int64; r: Single; g: Single; b: Single; a: Single; clear: Boolean; discard: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nSetClearOptions';
procedure nSetPresentationTime(nativeRenderer: Int64; monotonicClockNanos: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetPresentationTime';
procedure nSetVsyncTime(nativeRenderer: Int64; steadyClockTimeNano: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetVsyncTime';

{$ENDIF}

implementation

end.
