unit Filament.Utils.ImageDiff;
{
  filament-utils-android — ImageDiff  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/ImageDiff.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  Compares two ARGB_8888 images pixel-by-pixel.

  Pixel data format:
    All pixel buffers must be ARGB_8888 (4 bytes per pixel).
    stride is in bytes (typically width * 4 for tightly packed data).

  TImageDiffResult.status values:
    IMAGE_DIFF_STATUS_PASSED         = 0
    IMAGE_DIFF_STATUS_SIZE_MISMATCH  = 1
    IMAGE_DIFF_STATUS_PIXEL_DIFF     = 2

  maskPixels parameter: may be nil (no mask applied).

  Type mapping:
    jint    -> Integer
    jlong   -> Int64
    jfloat  -> Single
    const void* -> Pointer   (raw ARGB_8888 pixel data)
    jstring -> PAnsiChar     (UTF-8 JSON config)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

const
  IMAGE_DIFF_STATUS_PASSED        = 0;
  IMAGE_DIFF_STATUS_SIZE_MISMATCH = 1;
  IMAGE_DIFF_STATUS_PIXEL_DIFF    = 2;

  IMAGE_DIFF_MODE_BASIC           = 0;
  IMAGE_DIFF_SWIZZLE_RGBA         = 0;

// =============================================================================
// Output record (replaces Java Result jobject)
// =============================================================================

type
  TImageDiffMaxDiff = array[0..3] of Single;

  TImageDiffResult = packed record
    status           : Integer;  // IMAGE_DIFF_STATUS_*
    failingPixelCount: Int64;
    maxDiffFound     : TImageDiffMaxDiff;
  end;
  PImageDiffResult = ^TImageDiffResult;

// =============================================================================
// nCompareBasic
//   maskPixels may be nil (no mask)
//   outResult : caller-allocated TImageDiffResult
// =============================================================================

procedure nCompareBasic(
  refPixels               : Pointer;
  refWidth, refHeight     : Integer;
  refStride               : Integer;
  candPixels              : Pointer;
  candWidth, candHeight   : Integer;
  candStride              : Integer;
  mode                    : Integer;
  swizzle                 : Integer;
  channelMask             : Integer;
  maxAbsDiff              : Single;
  maxFailingPixelsFraction: Single;
  maskPixels              : Pointer;
  maskWidth, maskHeight   : Integer;
  maskStride              : Integer;
  outResult               : PImageDiffResult);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// nCompareJson
//   jsonConfig : UTF-8 JSON configuration string
//   maskPixels may be nil
//   outResult  : caller-allocated TImageDiffResult
// =============================================================================

procedure nCompareJson(
  refPixels              : Pointer;
  refWidth, refHeight    : Integer;
  refStride              : Integer;
  candPixels             : Pointer;
  candWidth, candHeight  : Integer;
  candStride             : Integer;
  jsonConfig             : PAnsiChar;
  maskPixels             : Pointer;
  maskWidth, maskHeight  : Integer;
  maskStride             : Integer;
  outResult              : PImageDiffResult);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
