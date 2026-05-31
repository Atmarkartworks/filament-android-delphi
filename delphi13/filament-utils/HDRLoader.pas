unit Filament.Utils.HDRLoader;
{
  filament-utils-android — HDRLoader  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/HDRLoader.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  HDRLoader decodes an HDR (Radiance RGBE) image file and creates a
  Filament SAMPLER_2D Texture with floating-point internal format.

  Typical internalFormat values (Texture.InternalFormat):
    HDR_FORMAT_R11F_G11F_B10F = 33   -- compact HDR (recommended for most uses)
    HDR_FORMAT_RGB16F         = 34
    HDR_FORMAT_RGB32F         = 35

  Type mapping:
    jlong    -> Int64
    const void* -> Pointer   (raw HDR file bytes)
    jint     -> Integer

  Returns native Texture pointer, or 0 on failure (unsupported format, decode error).
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

// Texture.InternalFormat constants for HDR
const
  HDR_FORMAT_R11F_G11F_B10F = 33;
  HDR_FORMAT_RGB16F         = 34;
  HDR_FORMAT_RGB32F         = 35;

// =============================================================================
// HDRLoader
// =============================================================================

// buffer: raw HDR file bytes; size: byte count
// internalFormat: HDR_FORMAT_* constant
// Returns native Texture pointer (SAMPLER_2D), or 0 on failure.
function  nCreateHDRTexture(nativeEngine: Int64;
  buffer: Pointer; size: Integer; internalFormat: Integer): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
