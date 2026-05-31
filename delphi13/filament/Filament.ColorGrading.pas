unit Filament.ColorGrading;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/ColorGrading.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jfloat   -> Single
  jboolean -> Boolean
  float*   -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
procedure nBuilderQuality(nativeBuilder: Int64; quality_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderQuality';
procedure nBuilderFormat(nativeBuilder: Int64; format_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderFormat';
procedure nBuilderDimensions(nativeBuilder: Int64; dim_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderDimensions';
procedure nBuilderToneMapper(nativeBuilder: Int64; toneMapper_: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderToneMapper';
procedure nBuilderToneMapping(nativeBuilder: Int64; toneMapping_: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderToneMapping';
procedure nBuilderLuminanceScaling(nativeBuilder: Int64; luminanceScaling: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderLuminanceScaling';
procedure nBuilderGamutMapping(nativeBuilder: Int64; gamutMapping: Boolean); cdecl; external LIB_FILAMENT_JNI name 'nBuilderGamutMapping';
procedure nBuilderExposure(nativeBuilder: Int64; exposure: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderExposure';
procedure nBuilderNightAdaptation(nativeBuilder: Int64; adaptation: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderNightAdaptation';
procedure nBuilderWhiteBalance(nativeBuilder: Int64; temperature: Single; tint: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderWhiteBalance';
procedure nBuilderChannelMixer(nativeBuilder: Int64; outRed: Pointer; outGreen: Pointer; outBlue: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderChannelMixer';
procedure nBuilderShadowsMidtonesHighlights(nativeBuilder: Int64; shadows: Pointer; midtones: Pointer; highlights: Pointer; ranges: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderShadowsMidtonesHighlights';
procedure nBuilderSlopeOffsetPower(nativeBuilder: Int64; slope: Pointer; offset: Pointer; power: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSlopeOffsetPower';
procedure nBuilderContrast(nativeBuilder: Int64; contrast: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderContrast';
procedure nBuilderVibrance(nativeBuilder: Int64; vibrance: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderVibrance';
procedure nBuilderSaturation(nativeBuilder: Int64; saturation: Single); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSaturation';
procedure nBuilderCurves(nativeBuilder: Int64; gamma: Pointer; midPoint: Pointer; scale: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderCurves';

{$ENDIF}

implementation

end.
