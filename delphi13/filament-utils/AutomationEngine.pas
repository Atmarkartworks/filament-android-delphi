unit Filament.Utils.AutomationEngine;
{
  filament-utils-android — AutomationEngine  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/AutomationEngine.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  Type mapping:
    jlong    -> Int64
    jint     -> Integer
    jfloat   -> Single
    jboolean -> Boolean
    jstring  -> PAnsiChar  (caller passes UTF-8 encoded string)
    const jlong* -> PInt64 (pointer to Int64 array)
    const jint*  -> PInteger (pointer to Integer array)
    jobject ViewerOptions -> PFUViewerOptions (see struct below)
    jobject CameraSettings -> PFUCameraSettings (see struct below)

  nTick / nApplySettings:
    materials   : PInt64   pointing to Int64 array of native MaterialInstance pointers
    assetLights : PInteger pointing to Integer array of Entity IDs

  nGetViewerOptions / nGetCameraSettings:
    Caller allocates the record and passes its address.
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

// =============================================================================
// Output record types (replace jobject JNI reflection pattern)
// =============================================================================

type
  TFUViewerOptions = packed record
    groundShadowStrength  : Single;
    groundPlaneEnabled    : Boolean;
    skyboxEnabled         : Boolean;
    autoScaleEnabled      : Boolean;
    autoInstancingEnabled : Boolean;
  end;
  PFUViewerOptions = ^TFUViewerOptions;

  TFUCameraSettings = packed record
    aperture      : Single;
    shutterSpeed  : Single;
    sensitivity   : Single;
    near_         : Single;  // renamed from 'near' to avoid Pascal keyword conflict
    far_          : Single;  // renamed from 'far'
    focalLength   : Single;
    focusDistance : Single;
  end;
  PFUCameraSettings = ^TFUCameraSettings;

// =============================================================================
// AutomationEngine — lifecycle
// =============================================================================

// spec: UTF-8 JSON specification string
function  nCreateAutomationEngine(spec: PAnsiChar): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nCreateDefaultAutomationEngine(): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// sleepDuration: seconds between test frames
// minFrameCount: minimum frames per test step
// verbose: enable verbose logging
procedure nSetOptions(nativeAutomation: Int64;
  sleepDuration: Single; minFrameCount: Integer; verbose: Boolean);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nStartRunning(nativeAutomation: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nStartBatchMode(nativeAutomation: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// Tick — drive the automation loop each frame
//   materials    : PInt64   -> array[0..materialCount-1] of Int64 (MaterialInstance*)
//   assetLights  : PInteger -> array[0..lightCount-1] of Integer  (Entity)
// =============================================================================

procedure nTick(
  nativeAutomation : Int64;
  nativeEngine     : Int64;
  view             : Int64;
  materials        : PInt64;
  materialCount    : Integer;
  renderer         : Int64;
  nativeIbl        : Int64;
  sunlightEntity   : Integer;
  assetLights      : PInteger;
  lightCount       : Integer;
  nativeLm         : Int64;
  scene            : Int64;
  deltaTime        : Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// ApplySettings — apply JSON settings to the current scene
//   json      : UTF-8 JSON settings string
//   jsonLength: byte length (0 = use strlen internally)
// =============================================================================

procedure nApplySettings(
  nativeAutomation : Int64;
  nativeEngine     : Int64;
  json             : PAnsiChar;
  jsonLength       : Integer;
  view             : Int64;
  materials        : PInt64;
  materialCount    : Integer;
  nativeIbl        : Int64;
  sunlightEntity   : Integer;
  assetLights      : PInteger;
  lightCount       : Integer;
  nativeLm         : Int64;
  scene            : Int64;
  renderer         : Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// Query settings
// =============================================================================

// result: caller-allocated TFUViewerOptions record
procedure nGetViewerOptions(nativeObject: Int64; result: PFUViewerOptions);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// result: caller-allocated TFUCameraSettings record
procedure nGetCameraSettings(nativeObject: Int64; result: PFUCameraSettings);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// Returns native ColorGrading pointer
function  nGetColorGrading(nativeObject: Int64; nativeEngine: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// Control
// =============================================================================

procedure nSignalBatchMode(native: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nStopRunning(native: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nShouldClose(native: Int64): Boolean;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nGetTestCount(native: Int64): Integer;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nGetCurrentTest(native: Int64): Integer;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nDestroy(native: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
