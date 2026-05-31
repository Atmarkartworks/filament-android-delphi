unit Filamat.MaterialBuilder;
{
  Filament filamat-android — Delphi import definitions
  Source : Filament/delphi13/filamat-android/src/cpp/MaterialBuilder.cpp
  Library: libfilamat-jni.so  (external 'filamat-jni')
  Target : Android ARM64 / ARM32

  Enum constants are derived from
    filamat-android/src/main/java/.../MaterialBuilder.java
  All enums use Java ordinal() except TargetApi which uses bitfield (.number).

  jstring  -> PAnsiChar  (caller passes UTF-8 encoded PAnsiChar)
  jlong    -> Int64      (native pointers are 64-bit on Android 64-bit)
  jboolean -> Boolean    (8-bit in JNI; Delphi Boolean is also 8-bit)
  jfloat   -> Single
  jint     -> Integer
  nGetPackageBytes returns Pointer and writes byte count via PInteger outSize.
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMAT_JNI = 'filamat-jni';

// =============================================================================
// Enum constants — MaterialBuilder.Shading
// =============================================================================
const
  FILAMAT_SHADING_UNLIT             = 0;
  FILAMAT_SHADING_LIT               = 1;
  FILAMAT_SHADING_SUBSURFACE        = 2;
  FILAMAT_SHADING_CLOTH             = 3;
  FILAMAT_SHADING_SPECULAR_GLOSSINESS = 4;

// MaterialBuilder.Interpolation
const
  FILAMAT_INTERPOLATION_SMOOTH      = 0;
  FILAMAT_INTERPOLATION_FLAT        = 1;

// MaterialBuilder.UniformType
const
  FILAMAT_UNIFORM_BOOL              = 0;
  FILAMAT_UNIFORM_BOOL2             = 1;
  FILAMAT_UNIFORM_BOOL3             = 2;
  FILAMAT_UNIFORM_BOOL4             = 3;
  FILAMAT_UNIFORM_FLOAT             = 4;
  FILAMAT_UNIFORM_FLOAT2            = 5;
  FILAMAT_UNIFORM_FLOAT3            = 6;
  FILAMAT_UNIFORM_FLOAT4            = 7;
  FILAMAT_UNIFORM_INT               = 8;
  FILAMAT_UNIFORM_INT2              = 9;
  FILAMAT_UNIFORM_INT3              = 10;
  FILAMAT_UNIFORM_INT4              = 11;
  FILAMAT_UNIFORM_UINT              = 12;
  FILAMAT_UNIFORM_UINT2             = 13;
  FILAMAT_UNIFORM_UINT3             = 14;
  FILAMAT_UNIFORM_UINT4             = 15;
  FILAMAT_UNIFORM_MAT3              = 16;
  FILAMAT_UNIFORM_MAT4              = 17;

// MaterialBuilder.SamplerType
const
  FILAMAT_SAMPLER_2D                = 0;
  FILAMAT_SAMPLER_2D_ARRAY          = 1;
  FILAMAT_SAMPLER_CUBEMAP           = 2;
  FILAMAT_SAMPLER_EXTERNAL          = 3;
  FILAMAT_SAMPLER_3D                = 4;

// MaterialBuilder.SamplerFormat
const
  FILAMAT_SAMPLER_FORMAT_INT        = 0;
  FILAMAT_SAMPLER_FORMAT_UINT       = 1;
  FILAMAT_SAMPLER_FORMAT_FLOAT      = 2;
  FILAMAT_SAMPLER_FORMAT_SHADOW     = 3;

// MaterialBuilder.ParameterPrecision
const
  FILAMAT_PRECISION_LOW             = 0;
  FILAMAT_PRECISION_MEDIUM          = 1;
  FILAMAT_PRECISION_HIGH            = 2;
  FILAMAT_PRECISION_DEFAULT         = 3;

// MaterialBuilder.Variable
const
  FILAMAT_VARIABLE_CUSTOM0          = 0;
  FILAMAT_VARIABLE_CUSTOM1          = 1;
  FILAMAT_VARIABLE_CUSTOM2          = 2;
  FILAMAT_VARIABLE_CUSTOM3          = 3;

// MaterialBuilder.VertexAttribute
const
  FILAMAT_ATTR_POSITION             = 0;
  FILAMAT_ATTR_TANGENTS             = 1;
  FILAMAT_ATTR_COLOR                = 2;
  FILAMAT_ATTR_UV0                  = 3;
  FILAMAT_ATTR_UV1                  = 4;
  FILAMAT_ATTR_BONE_INDICES         = 5;
  FILAMAT_ATTR_BONE_WEIGHTS         = 6;
  FILAMAT_ATTR_UNUSED               = 7;
  FILAMAT_ATTR_CUSTOM0              = 8;   // MORPH_POSITION_0
  FILAMAT_ATTR_CUSTOM1              = 9;   // MORPH_POSITION_1
  FILAMAT_ATTR_CUSTOM2              = 10;  // MORPH_POSITION_2
  FILAMAT_ATTR_CUSTOM3              = 11;  // MORPH_POSITION_3
  FILAMAT_ATTR_CUSTOM4              = 12;  // MORPH_TANGENTS_0
  FILAMAT_ATTR_CUSTOM5              = 13;  // MORPH_TANGENTS_1
  FILAMAT_ATTR_CUSTOM6              = 14;  // MORPH_TANGENTS_2
  FILAMAT_ATTR_CUSTOM7              = 15;  // MORPH_TANGENTS_3

// MaterialBuilder.BlendingMode
const
  FILAMAT_BLENDING_OPAQUE           = 0;
  FILAMAT_BLENDING_TRANSPARENT      = 1;
  FILAMAT_BLENDING_ADD              = 2;
  FILAMAT_BLENDING_MASKED           = 3;
  FILAMAT_BLENDING_FADE             = 4;
  FILAMAT_BLENDING_MULTIPLY         = 5;
  FILAMAT_BLENDING_SCREEN           = 6;

// MaterialBuilder.VertexDomain
const
  FILAMAT_VERTEX_DOMAIN_OBJECT      = 0;
  FILAMAT_VERTEX_DOMAIN_WORLD       = 1;
  FILAMAT_VERTEX_DOMAIN_VIEW        = 2;
  FILAMAT_VERTEX_DOMAIN_DEVICE      = 3;

// MaterialBuilder.CullingMode
const
  FILAMAT_CULLING_NONE              = 0;
  FILAMAT_CULLING_FRONT             = 1;
  FILAMAT_CULLING_BACK              = 2;
  FILAMAT_CULLING_FRONT_AND_BACK    = 3;

// MaterialBuilder.TransparencyMode
const
  FILAMAT_TRANSPARENCY_DEFAULT          = 0;
  FILAMAT_TRANSPARENCY_TWO_PASSES_ONE_SIDE  = 1;
  FILAMAT_TRANSPARENCY_TWO_PASSES_TWO_SIDES = 2;

// MaterialBuilder.MaterialDomain
const
  FILAMAT_MATERIAL_DOMAIN_SURFACE       = 0;
  FILAMAT_MATERIAL_DOMAIN_POST_PROCESS  = 1;

// MaterialBuilder.SpecularAmbientOcclusion
const
  FILAMAT_SPECULAR_AO_NONE          = 0;
  FILAMAT_SPECULAR_AO_SIMPLE        = 1;
  FILAMAT_SPECULAR_AO_BENT_NORMALS  = 2;

// MaterialBuilder.RefractionMode
const
  FILAMAT_REFRACTION_NONE           = 0;
  FILAMAT_REFRACTION_CUBEMAP        = 1;
  FILAMAT_REFRACTION_SCREEN_SPACE   = 2;

// MaterialBuilder.ReflectionMode
const
  FILAMAT_REFLECTION_DEFAULT        = 0;
  FILAMAT_REFLECTION_SCREEN_SPACE   = 1;

// MaterialBuilder.RefractionType
const
  FILAMAT_REFRACTION_TYPE_SOLID     = 0;
  FILAMAT_REFRACTION_TYPE_THIN      = 1;

// MaterialBuilder.Platform
const
  FILAMAT_PLATFORM_DESKTOP          = 0;
  FILAMAT_PLATFORM_MOBILE           = 1;
  FILAMAT_PLATFORM_ALL              = 2;

// MaterialBuilder.TargetApi  — bitfield (.number), NOT ordinal
const
  FILAMAT_TARGET_API_OPENGL         = $01;
  FILAMAT_TARGET_API_VULKAN         = $02;
  FILAMAT_TARGET_API_METAL          = $04;
  FILAMAT_TARGET_API_WEBGPU         = $08;
  FILAMAT_TARGET_API_ALL            = $15;

// MaterialBuilder.Optimization
const
  FILAMAT_OPTIMIZATION_NONE         = 0;
  FILAMAT_OPTIMIZATION_PREPROCESSOR = 1;
  FILAMAT_OPTIMIZATION_SIZE         = 2;
  FILAMAT_OPTIMIZATION_PERFORMANCE  = 3;

// =============================================================================
// MaterialBuilder — lifecycle
// =============================================================================

procedure nMaterialBuilderInit();
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderShutdown();
  cdecl; external LIB_FILAMAT_JNI;

function nCreateMaterialBuilder(): Int64;
  cdecl; external LIB_FILAMAT_JNI;

procedure nDestroyMaterialBuilder(nativeBuilder: Int64);
  cdecl; external LIB_FILAMAT_JNI;

// =============================================================================
// Package — build / query / destroy
// =============================================================================

// nativeJobSystem=0 to let the C++ side create a transient JobSystem internally.
function nBuilderBuild(nativeBuilder: Int64; nativeJobSystem: Int64): Int64;
  cdecl; external LIB_FILAMAT_JNI;

// Returns a pointer to the compiled package data.
// *outSize receives the byte length.  The pointer is valid until nDestroyPackage.
function nGetPackageBytes(nativePackage: Int64; outSize: PInteger): Pointer;
  cdecl; external LIB_FILAMAT_JNI;

function nGetPackageIsValid(nativePackage: Int64): Boolean;
  cdecl; external LIB_FILAMAT_JNI;

procedure nDestroyPackage(nativePackage: Int64);
  cdecl; external LIB_FILAMAT_JNI;

// =============================================================================
// MaterialBuilder — properties
// =============================================================================

procedure nMaterialBuilderName(nativeBuilder: Int64; name: PAnsiChar);
  cdecl; external LIB_FILAMAT_JNI;

// domain: FILAMAT_MATERIAL_DOMAIN_*
procedure nMaterialBuilderMaterialDomain(nativeBuilder: Int64; domain: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// shading: FILAMAT_SHADING_*
procedure nMaterialBuilderShading(nativeBuilder: Int64; shading: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// interpolation: FILAMAT_INTERPOLATION_*
procedure nMaterialBuilderInterpolation(nativeBuilder: Int64; interpolation: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// uniformType: FILAMAT_UNIFORM_*   precision: FILAMAT_PRECISION_*
procedure nMaterialBuilderUniformParameter(nativeBuilder: Int64;
  uniformType: Integer; precision: Integer; name: PAnsiChar);
  cdecl; external LIB_FILAMAT_JNI;

// size: array element count
procedure nMaterialBuilderUniformParameterArray(nativeBuilder: Int64;
  uniformType: Integer; size: Integer; precision: Integer; name: PAnsiChar);
  cdecl; external LIB_FILAMAT_JNI;

// samplerType: FILAMAT_SAMPLER_*  format: FILAMAT_SAMPLER_FORMAT_*
procedure nMaterialBuilderSamplerParameter(nativeBuilder: Int64;
  samplerType: Integer; format: Integer; precision: Integer; name: PAnsiChar);
  cdecl; external LIB_FILAMAT_JNI;

// variable: FILAMAT_VARIABLE_CUSTOM*
procedure nMaterialBuilderVariable(nativeBuilder: Int64;
  variable: Integer; name: PAnsiChar);
  cdecl; external LIB_FILAMAT_JNI;

// attribute: FILAMAT_ATTR_*
procedure nMaterialBuilderRequire(nativeBuilder: Int64; attribute: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// GLSL material code for the fragment stage
procedure nMaterialBuilderMaterial(nativeBuilder: Int64; code: PAnsiChar);
  cdecl; external LIB_FILAMAT_JNI;

// GLSL material code for the vertex stage
procedure nMaterialBuilderMaterialVertex(nativeBuilder: Int64; code: PAnsiChar);
  cdecl; external LIB_FILAMAT_JNI;

// mode: FILAMAT_BLENDING_*
procedure nMaterialBuilderBlending(nativeBuilder: Int64; mode: Integer);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderPostLightingBlending(nativeBuilder: Int64; mode: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// vertexDomain: FILAMAT_VERTEX_DOMAIN_*
procedure nMaterialBuilderVertexDomain(nativeBuilder: Int64; vertexDomain: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// mode: FILAMAT_CULLING_*
procedure nMaterialBuilderCulling(nativeBuilder: Int64; mode: Integer);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderColorWrite(nativeBuilder: Int64; enable: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderDepthWrite(nativeBuilder: Int64; depthWrite: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderDepthCulling(nativeBuilder: Int64; depthCulling: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderDoubleSided(nativeBuilder: Int64; doubleSided: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderMaskThreshold(nativeBuilder: Int64; maskThreshold: Single);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderAlphaToCoverage(nativeBuilder: Int64; enable: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderShadowMultiplier(nativeBuilder: Int64; shadowMultiplier: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderTransparentShadow(nativeBuilder: Int64; transparentShadow: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderSpecularAntiAliasing(nativeBuilder: Int64; specularAntiAliasing: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderSpecularAntiAliasingVariance(nativeBuilder: Int64; variance: Single);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderSpecularAntiAliasingThreshold(nativeBuilder: Int64; threshold: Single);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderClearCoatIorChange(nativeBuilder: Int64; clearCoatIorChange: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderFlipUV(nativeBuilder: Int64; flipUV: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderCustomSurfaceShading(nativeBuilder: Int64; customSurfaceShading: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderMultiBounceAmbientOcclusion(nativeBuilder: Int64; multiBounceAO: Boolean);
  cdecl; external LIB_FILAMAT_JNI;

// specularAO: FILAMAT_SPECULAR_AO_*
procedure nMaterialBuilderSpecularAmbientOcclusion(nativeBuilder: Int64; specularAO: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// mode: FILAMAT_REFRACTION_*
procedure nMaterialBuilderRefractionMode(nativeBuilder: Int64; mode: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// mode: FILAMAT_REFLECTION_*
procedure nMaterialBuilderReflectionMode(nativeBuilder: Int64; mode: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// type_: FILAMAT_REFRACTION_TYPE_*
procedure nMaterialBuilderRefractionType(nativeBuilder: Int64; type_: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// mode: FILAMAT_TRANSPARENCY_*
procedure nMaterialBuilderTransparencyMode(nativeBuilder: Int64; mode: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// platform: FILAMAT_PLATFORM_*
procedure nMaterialBuilderPlatform(nativeBuilder: Int64; platform: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// targetApi: FILAMAT_TARGET_API_* (bitfield, combinable with OR)
procedure nMaterialBuilderTargetApi(nativeBuilder: Int64; targetApi: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// optimization: FILAMAT_OPTIMIZATION_*
procedure nMaterialBuilderOptimization(nativeBuilder: Int64; optimization: Integer);
  cdecl; external LIB_FILAMAT_JNI;

// variantFilter: bitmask, caller-defined variant bits to exclude
procedure nMaterialBuilderVariantFilter(nativeBuilder: Int64; variantFilter: Integer);
  cdecl; external LIB_FILAMAT_JNI;

procedure nMaterialBuilderUseLegacyMorphing(nativeBuilder: Int64);
  cdecl; external LIB_FILAMAT_JNI;

implementation

{$ENDIF} // ANDROID

end.
