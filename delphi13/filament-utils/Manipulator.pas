unit Filament.Utils.Manipulator;
{
  filament-utils-android — Manipulator  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/Manipulator.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  Type mapping:
    jlong    -> Int64    (native pointers are 64-bit on Android 64-bit)
    jint     -> Integer
    jfloat   -> Single
    jdouble  -> Double
    jboolean -> Boolean  (8-bit)
    float*   -> PSingle  (caller allocates array; e.g. PSingle(@arr[0]))
    double*  -> PDouble

  nGetLookAtFloat / nGetLookAtDouble:
    eyePosition[3], targetPosition[3], upward[3] — each PSingle/PDouble
    pointing to a caller-allocated array of 3 elements.

  nRaycast:
    result[3] — PSingle pointing to a caller-allocated float[3].

  Enum constants derived from Manipulator.java / camutils/Manipulator.h
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

// =============================================================================
// Enum constants — Manipulator.Mode
// =============================================================================
const
  MANIP_MODE_ORBIT       = 0;
  MANIP_MODE_MAP         = 1;
  MANIP_MODE_FREE_FLIGHT = 2;

// Manipulator.Fov
const
  MANIP_FOV_VERTICAL   = 0;
  MANIP_FOV_HORIZONTAL = 1;

// Manipulator flight key codes
const
  MANIP_KEY_FORWARD  = 0;
  MANIP_KEY_LEFT     = 1;
  MANIP_KEY_BACKWARD = 2;
  MANIP_KEY_RIGHT    = 3;
  MANIP_KEY_UP       = 4;
  MANIP_KEY_DOWN     = 5;

// =============================================================================
// Builder — lifecycle
// =============================================================================

function  nCreateBuilder(): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nDestroyBuilder(nativeBuilder: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// Builder — configuration
// =============================================================================

procedure nBuilderViewport(nativeBuilder: Int64; width, height: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderTargetPosition(nativeBuilder: Int64; x, y, z: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderUpVector(nativeBuilder: Int64; x, y, z: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderZoomSpeed(nativeBuilder: Int64; arg: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderOrbitHomePosition(nativeBuilder: Int64; x, y, z: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderOrbitSpeed(nativeBuilder: Int64; x, y: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// fovDirection: MANIP_FOV_*
procedure nBuilderFovDirection(nativeBuilder: Int64; arg: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFovDegrees(nativeBuilder: Int64; arg: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFarPlane(nativeBuilder: Int64; distance: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderMapExtent(nativeBuilder: Int64; width, height: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderMapMinDistance(nativeBuilder: Int64; arg: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFlightStartPosition(nativeBuilder: Int64; x, y, z: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFlightStartOrientation(nativeBuilder: Int64; pitch, yaw: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFlightMaxMoveSpeed(nativeBuilder: Int64; maxSpeed: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFlightSpeedSteps(nativeBuilder: Int64; steps: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFlightPanSpeed(nativeBuilder: Int64; x, y: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderFlightMoveDamping(nativeBuilder: Int64; damping: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderGroundPlane(nativeBuilder: Int64; a, b, c, d: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nBuilderPanning(nativeBuilder: Int64; enabled: Boolean);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// mode: MANIP_MODE_*
// Returns native Manipulator pointer.
function  nBuilderBuild(nativeBuilder: Int64; mode: Integer): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// Manipulator — operations
// =============================================================================

procedure nDestroyManipulator(nativeManip: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// Returns MANIP_MODE_*
function  nGetMode(nativeManip: Int64): Integer;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nSetViewport(nativeManip: Int64; width, height: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// eyePosition, targetPosition, upward: each points to a caller-allocated Single[3]
procedure nGetLookAtFloat(nativeManip: Int64;
  eyePosition, targetPosition, upward: PSingle);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// eyePosition, targetPosition, upward: each points to a caller-allocated Double[3]
procedure nGetLookAtDouble(nativeManip: Int64;
  eyePosition, targetPosition, upward: PDouble);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// result: PSingle pointing to a caller-allocated Single[3]
procedure nRaycast(nativeManip: Int64; x, y: Integer; result: PSingle);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nGrabBegin(nativeManip: Int64; x, y: Integer; strafe: Boolean);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nGrabUpdate(nativeManip: Int64; x, y: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nGrabEnd(nativeManip: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// key: MANIP_KEY_*
procedure nKeyDown(nativeManip: Int64; key: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nKeyUp(nativeManip: Int64; key: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nScroll(nativeManip: Int64; x, y: Integer; scrolldelta: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nUpdate(nativeManip: Int64; deltaTime: Single);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

// =============================================================================
// Bookmark access
// =============================================================================

// Returns a native Bookmark pointer (must be freed with nDestroyBookmark).
function  nGetCurrentBookmark(nativeManip: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nGetHomeBookmark(nativeManip: Int64): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nJumpToBookmark(nativeManip: Int64; nativeBookmark: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
