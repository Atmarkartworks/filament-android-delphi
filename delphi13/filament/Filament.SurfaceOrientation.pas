unit Filament.SurfaceOrientation;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/SurfaceOrientation.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong       -> Int64
  int         -> Integer
  const void* -> Pointer  (float3/float4/float2 data arrays)
  void*       -> Pointer  (output quaternion buffer)
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderVertexCount(nativeBuilder: Int64; vertexCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderVertexCount';
procedure nBuilderTriangleCount(nativeBuilder: Int64; triangleCount: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderTriangleCount';
procedure nBuilderNormals(nativeBuilder: Int64; data: Pointer; stride: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderNormals';
procedure nBuilderTangents(nativeBuilder: Int64; data: Pointer; stride: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderTangents';
procedure nBuilderUVs(nativeBuilder: Int64; data: Pointer; stride: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderUVs';
procedure nBuilderPositions(nativeBuilder: Int64; data: Pointer; stride: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderPositions';
procedure nBuilderTriangles16(nativeBuilder: Int64; data: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderTriangles16';
procedure nBuilderTriangles32(nativeBuilder: Int64; data: Pointer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderTriangles32';
function  nBuilderBuild(nativeBuilder: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';
function  nGetVertexCount(nativeObject: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetVertexCount';
procedure nGetQuatsAsFloat(nativeObject: Int64; buffer: Pointer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nGetQuatsAsFloat';
procedure nGetQuatsAsHalf(nativeObject: Int64; buffer: Pointer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nGetQuatsAsHalf';
procedure nGetQuatsAsShort(nativeObject: Int64; buffer: Pointer; count: Integer); cdecl; external LIB_FILAMENT_JNI name 'nGetQuatsAsShort';
procedure nDestroy(nativeSurfaceOrientation: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroy';

{$ENDIF}

implementation

end.
