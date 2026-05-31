unit Filament.Camera;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Camera.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong    -> Int64
  jint     -> Integer
  jdouble  -> Double
  jfloat   -> Single
  double*  -> Pointer
  float*   -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

procedure nSetProjection(nativeCamera: Int64; projection: Integer; left: Double; right: Double; bottom: Double; top: Double; near: Double; far: Double); cdecl; external LIB_FILAMENT_JNI name 'nSetProjection';
procedure nSetProjectionFov(nativeCamera: Int64; fovInDegrees: Double; aspect: Double; near: Double; far: Double; fov: Integer); cdecl; external LIB_FILAMENT_JNI name 'nSetProjectionFov';
function  nGetFieldOfViewInDegrees(nativeCamera: Int64; direction: Integer): Double; cdecl; external LIB_FILAMENT_JNI name 'nGetFieldOfViewInDegrees';
procedure nSetLensProjection(nativeCamera: Int64; focalLength: Double; aspect: Double; near: Double; far: Double); cdecl; external LIB_FILAMENT_JNI name 'nSetLensProjection';
procedure nSetCustomProjection(nativeCamera: Int64; inProjection: Pointer; inProjectionForCulling: Pointer; near: Double; far: Double); cdecl; external LIB_FILAMENT_JNI name 'nSetCustomProjection';
procedure nSetCustomEyeProjection(nativeCamera: Int64; inProjection: Pointer; count: Integer; inProjectionForCulling: Pointer; near: Double; far: Double); cdecl; external LIB_FILAMENT_JNI name 'nSetCustomEyeProjection';
procedure nSetScaling(nativeCamera: Int64; x: Double; y: Double); cdecl; external LIB_FILAMENT_JNI name 'nSetScaling';
procedure nSetShift(nativeCamera: Int64; x: Double; y: Double); cdecl; external LIB_FILAMENT_JNI name 'nSetShift';
procedure nGetShift(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetShift';
procedure nLookAt(nativeCamera: Int64; eye_x: Double; eye_y: Double; eye_z: Double; center_x: Double; center_y: Double; center_z: Double; up_x: Double; up_y: Double; up_z: Double); cdecl; external LIB_FILAMENT_JNI name 'nLookAt';
function  nGetNear(nativeCamera: Int64): Double; cdecl; external LIB_FILAMENT_JNI name 'nGetNear';
function  nGetCullingFar(nativeCamera: Int64): Double; cdecl; external LIB_FILAMENT_JNI name 'nGetCullingFar';
procedure nSetModelMatrix(nativeCamera: Int64; in_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetModelMatrix';
procedure nSetModelMatrixFp64(nativeCamera: Int64; in_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetModelMatrixFp64';
procedure nSetEyeModelMatrix(nativeCamera: Int64; eyeId: Integer; model: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nSetEyeModelMatrix';
procedure nGetProjectionMatrix(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetProjectionMatrix';
procedure nGetCullingProjectionMatrix(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetCullingProjectionMatrix';
procedure nGetScaling(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetScaling';
procedure nGetModelMatrix(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetModelMatrix';
procedure nGetModelMatrixFp64(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetModelMatrixFp64';
procedure nGetViewMatrix(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetViewMatrix';
procedure nGetViewMatrixFp64(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetViewMatrixFp64';
procedure nGetPosition(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetPosition';
procedure nGetLeftVector(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetLeftVector';
procedure nGetUpVector(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetUpVector';
procedure nGetForwardVector(nativeCamera: Int64; out_: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nGetForwardVector';
procedure nSetExposure(nativeCamera: Int64; aperture: Single; shutterSpeed: Single; sensitivity: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetExposure';
function  nGetAperture(nativeCamera: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetAperture';
function  nGetShutterSpeed(nativeCamera: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetShutterSpeed';
function  nGetSensitivity(nativeCamera: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetSensitivity';
procedure nSetFocusDistance(nativeCamera: Int64; focusDistance: Single); cdecl; external LIB_FILAMENT_JNI name 'nSetFocusDistance';
function  nGetFocusDistance(nativeCamera: Int64): Single; cdecl; external LIB_FILAMENT_JNI name 'nGetFocusDistance';
function  nGetFocalLength(nativeCamera: Int64): Double; cdecl; external LIB_FILAMENT_JNI name 'nGetFocalLength';
function  nComputeEffectiveFocalLength(focalLength: Double; focusDistance: Double): Double; cdecl; external LIB_FILAMENT_JNI name 'nComputeEffectiveFocalLength';
function  nComputeEffectiveFov(fovInDegrees: Double; focusDistance: Double): Double; cdecl; external LIB_FILAMENT_JNI name 'nComputeEffectiveFov';

{$ENDIF}

implementation

end.
