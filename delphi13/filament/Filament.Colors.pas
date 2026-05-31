unit Filament.Colors;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Colors.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jfloat  -> Single
  float*  -> Pointer  (output float[3])
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nCct(temperature: Single; color: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nCct';
procedure nIlluminantD(temperature: Single; color: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nIlluminantD';

{$ENDIF}

implementation

end.
