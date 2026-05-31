unit Filament.MathUtils;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/MathUtils.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jfloat -> Single
  float* -> Pointer  (output quaternion float[4])
  jint   -> Integer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nPackTangentFrame(
  tangentX: Single; tangentY: Single; tangentZ: Single;
  bitangentX: Single; bitangentY: Single; bitangentZ: Single;
  normalX: Single; normalY: Single; normalZ: Single;
  quaternion: Pointer; offset: Integer); cdecl; external LIB_FILAMENT_JNI name 'nPackTangentFrame';

{$ENDIF}

implementation

end.
