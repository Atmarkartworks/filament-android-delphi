unit Filament.ToneMapper;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/ToneMapper.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong  -> Int64
  jint   -> Integer
  jfloat -> Single
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nDestroyToneMapper(toneMapper_: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyToneMapper';
function  nCreateLinearToneMapper: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateLinearToneMapper';
function  nCreateACESToneMapper: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateACESToneMapper';
function  nCreateACESLegacyToneMapper: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateACESLegacyToneMapper';
function  nCreateFilmicToneMapper: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateFilmicToneMapper';
function  nCreatePBRNeutralToneMapper: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreatePBRNeutralToneMapper';
function  nCreateGT7ToneMapper: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateGT7ToneMapper';
function  nCreateAgxToneMapper(look: Integer): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateAgxToneMapper';
function  nCreateGenericToneMapper(contrast: Single; midGrayIn: Single; midGrayOut: Single; hdrMax: Single): Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateGenericToneMapper';
function  nGenericGetContrast(nativeObject: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGenericGetContrast';
function  nGenericGetMidGrayIn(nativeObject: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGenericGetMidGrayIn';
function  nGenericGetMidGrayOut(nativeObject: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGenericGetMidGrayOut';
function  nGenericGetHdrMax(nativeObject: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGenericGetHdrMax';
procedure nGenericSetContrast(nativeObject: Int64; contrast: Single); cdecl; external LIB_FILAMENT_JNI name 'nGenericSetContrast';
procedure nGenericSetMidGrayIn(nativeObject: Int64; midGrayIn: Single); cdecl; external LIB_FILAMENT_JNI name 'nGenericSetMidGrayIn';
procedure nGenericSetMidGrayOut(nativeObject: Int64; midGrayOut: Single); cdecl; external LIB_FILAMENT_JNI name 'nGenericSetMidGrayOut';
procedure nGenericSetHdrMax(nativeObject: Int64; hdrMax: Single); cdecl; external LIB_FILAMENT_JNI name 'nGenericSetHdrMax';

{$ENDIF}

implementation

end.
