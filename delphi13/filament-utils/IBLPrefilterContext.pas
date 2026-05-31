unit Filament.Utils.IBLPrefilterContext;
{
  filament-utils-android — IBLPrefilterContext  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/IBLPrefilterContext.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  IBLPrefilterContext converts equirectangular or cubemap textures to
  pre-filtered IBL textures (specular / irradiance maps).

  Type mapping:
    jlong -> Int64  (all native object pointers)

  Class hierarchy:
    IBLPrefilterContext           — nCreate / nDestroy
    IBLPrefilterContext::EquirectangularToCubemap — nCreateEquirectHelper / nEquirectHelperRun / nDestroyEquirectHelper
    IBLPrefilterContext::SpecularFilter           — nCreateSpecularFilter / nSpecularFilterRun / nDestroySpecularFilter
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

// =============================================================================
// IBLPrefilterContext
// =============================================================================

function  nCreate(nativeEngine: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nDestroy(native: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// EquirectangularToCubemap helper
// =============================================================================

function  nCreateEquirectHelper(nativeContext: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// nativeEquirect: equirectangular source Texture pointer
// Returns: new cubemap Texture pointer
function  nEquirectHelperRun(nativeHelper: Int64; nativeEquirect: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nDestroyEquirectHelper(nativeObject: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// SpecularFilter helper
// =============================================================================

function  nCreateSpecularFilter(nativeContext: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// nativeSkybox: source cubemap Texture pointer
// Returns: filtered specular cubemap Texture pointer
function  nSpecularFilterRun(nativeHelper: Int64; nativeSkybox: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nDestroySpecularFilter(nativeObject: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
