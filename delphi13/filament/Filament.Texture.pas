unit Filament.Texture;
{
  Filament filament-android — Delphi import definitions
  Source : filament-android/src/cpp/Texture.cpp
  Library: libfilament-jni.so  (external 'filament-jni')
  Target : Android ARM64 / ARM32

  jlong       -> Int64
  jint        -> Integer
  jboolean    -> Boolean
  const void* -> Pointer
  jint*       -> Pointer  (faceOffsetsInBytes array of 6 ints)
  AHardwareBuffer* -> Pointer
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_JNI = 'filament-jni';

// Static Texture queries
function  nIsTextureFormatSupported(nativeEngine: Int64; internalFormat: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsTextureFormatSupported';
function  nIsTextureFormatMipmappable(nativeEngine: Int64; internalFormat: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsTextureFormatMipmappable';
function  nIsTextureSwizzleSupported(nativeEngine: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsTextureSwizzleSupported';
function  nGetMaxTextureSize(nativeEngine: Int64; sampler: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetMaxTextureSize';
function  nGetMaxArrayTextureLayers(nativeEngine: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetMaxArrayTextureLayers';
function  nValidatePixelFormatAndType(internalFormat: Integer; pixelDataFormat: Integer; pixelDataType: Integer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nValidatePixelFormatAndType';

// Builder
function  nCreateBuilder: Int64; cdecl; external LIB_FILAMENT_JNI name 'nCreateBuilder';
procedure nDestroyBuilder(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nDestroyBuilder';
procedure nBuilderWidth(nativeBuilder: Int64; width: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderWidth';
procedure nBuilderHeight(nativeBuilder: Int64; height: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderHeight';
procedure nBuilderDepth(nativeBuilder: Int64; depth: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderDepth';
procedure nBuilderLevels(nativeBuilder: Int64; levels: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderLevels';
procedure nBuilderSampler(nativeBuilder: Int64; sampler: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSampler';
procedure nBuilderFormat(nativeBuilder: Int64; format: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderFormat';
procedure nBuilderUsage(nativeBuilder: Int64; flags: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderUsage';
procedure nBuilderSwizzle(nativeBuilder: Int64; r: Integer; g: Integer; b: Integer; a: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSwizzle';
procedure nBuilderSamples(nativeBuilder: Int64; samples: Integer); cdecl; external LIB_FILAMENT_JNI name 'nBuilderSamples';
procedure nBuilderImportTexture(nativeBuilder: Int64; id: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderImportTexture';
procedure nBuilderExternal(nativeBuilder: Int64); cdecl; external LIB_FILAMENT_JNI name 'nBuilderExternal';
function  nBuilderBuild(nativeBuilder: Int64; nativeEngine: Int64): Int64; cdecl; external LIB_FILAMENT_JNI name 'nBuilderBuild';

// Texture getters
function  nGetWidth(nativeTexture: Int64; level: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetWidth';
function  nGetHeight(nativeTexture: Int64; level: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetHeight';
function  nGetDepth(nativeTexture: Int64; level: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetDepth';
function  nGetLevels(nativeTexture: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetLevels';
function  nGetTarget(nativeTexture: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetTarget';
function  nGetInternalFormat(nativeTexture: Int64): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGetInternalFormat';

// Image upload
function  nSetImage3D(nativeTexture: Int64; nativeEngine: Int64; level: Integer;
  xoffset: Integer; yoffset: Integer; zoffset: Integer;
  width: Integer; height: Integer; depth: Integer;
  data: Pointer; sizeInBytes: Integer;
  left: Integer; top: Integer; type_: Integer; alignment: Integer;
  stride: Integer; format: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetImage3D';
function  nSetImage3DCompressed(nativeTexture: Int64; nativeEngine: Int64; level: Integer;
  xoffset: Integer; yoffset: Integer; zoffset: Integer;
  width: Integer; height: Integer; depth: Integer;
  data: Pointer; sizeInBytes: Integer;
  compressedFormat: Integer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetImage3DCompressed';
function  nSetImageCubemap(nativeTexture: Int64; nativeEngine: Int64; level: Integer;
  data: Pointer; sizeInBytes: Integer;
  left: Integer; top: Integer; type_: Integer; alignment: Integer; stride: Integer; format: Integer;
  faceOffsetsInBytes: Pointer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetImageCubemap';
function  nSetImageCubemapCompressed(nativeTexture: Int64; nativeEngine: Int64; level: Integer;
  data: Pointer; sizeInBytes: Integer;
  compressedFormat: Integer; faceOffsetsInBytes: Pointer): Integer; cdecl; external LIB_FILAMENT_JNI name 'nSetImageCubemapCompressed';
procedure nSetExternalImage(nativeTexture: Int64; nativeEngine: Int64; eglImage: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetExternalImage';
function  nSetExternalImageByAHB(nativeTexture: Int64; nativeEngine: Int64; nativeBuffer: Pointer): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nSetExternalImageByAHB';
procedure nSetExternalStream(nativeTexture: Int64; nativeEngine: Int64; nativeStream: Int64); cdecl; external LIB_FILAMENT_JNI name 'nSetExternalStream';
procedure nGenerateMipmaps(nativeTexture: Int64; nativeEngine: Int64); cdecl; external LIB_FILAMENT_JNI name 'nGenerateMipmaps';
function  nIsStreamValidForTexture(nativeTexture: Int64; unused: Int64): Boolean; cdecl; external LIB_FILAMENT_JNI name 'nIsStreamValidForTexture';
function  nGeneratePrefilterMipmap(nativeTexture: Int64; nativeEngine: Int64; width: Integer; height: Integer;
  data: Pointer; sizeInBytes: Integer;
  left: Integer; top: Integer; type_: Integer; alignment: Integer; stride: Integer; format: Integer;
  faceOffsetsInBytes: Pointer; sampleCount: Integer; mirror: Boolean): Integer; cdecl; external LIB_FILAMENT_JNI name 'nGeneratePrefilterMipmap';

{$ENDIF}

implementation

end.
