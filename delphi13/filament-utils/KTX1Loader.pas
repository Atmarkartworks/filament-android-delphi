unit Filament.Utils.KTX1Loader;
{
  filament-utils-android — KTX1Loader  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/Utils.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  KTX1Loader creates Filament Texture / IndirectLight / Skybox from
  KTX1-format binary data.

  Type mapping:
    jlong    -> Int64
    jboolean -> Boolean
    jint     -> Integer
    const void* -> Pointer   (raw KTX1 file bytes)
    const float* -> PSingle  (spherical harmonics float array)

  nCreateIndirectLight:
    sphericalHarmonics: PSingle pointing to Single[27]  (9 x float3, row-major)

  nGetSphericalHarmonics:
    outSphericalHarmonics: PSingle pointing to caller-allocated Single[27]
    Returns True on success.
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

// =============================================================================
// KTX1Loader
// =============================================================================

// buffer: raw KTX1 file bytes; size: byte count; srgb: True for sRGB colour space
// Returns native Texture pointer, or 0 on failure.
function  nCreateKTXTexture(nativeEngine: Int64;
  buffer: Pointer; size: Integer; srgb: Boolean): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// ktxTexture: cubemap Texture pointer from nCreateKTXTexture
// sphericalHarmonics: PSingle -> Single[27]  (9 x float3)
// Returns native IndirectLight pointer.
function  nCreateIndirectLight(nativeEngine: Int64; ktxTexture: Int64;
  sphericalHarmonics: PSingle): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// ktxTexture: cubemap Texture pointer
// Returns native Skybox pointer.
function  nCreateSkybox(nativeEngine: Int64; ktxTexture: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// buffer: raw KTX1 file bytes; size: byte count
// outSphericalHarmonics: PSingle -> caller-allocated Single[27]
// Returns True on success.
function  nGetSphericalHarmonics(buffer: Pointer; size: Integer;
  outSphericalHarmonics: PSingle): Boolean;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
