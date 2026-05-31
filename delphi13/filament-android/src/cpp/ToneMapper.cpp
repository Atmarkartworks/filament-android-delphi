/*
 * Copyright (C) 2021 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <jni.h>

#include <filament/ToneMapper.h>

using namespace filament;

extern "C" void nDestroyToneMapper(jlong toneMapper_) {
    ToneMapper* toneMapper = (ToneMapper*) toneMapper_;
    delete toneMapper;
}

extern "C" jlong nCreateLinearToneMapper() {
    return (jlong) new LinearToneMapper();
}

extern "C" jlong nCreateACESToneMapper() {
    return (jlong) new ACESToneMapper();
}

extern "C" jlong nCreateACESLegacyToneMapper() {
    return (jlong) new ACESLegacyToneMapper();
}

extern "C" jlong nCreateFilmicToneMapper() {
    return (jlong) new FilmicToneMapper();
}

extern "C" jlong nCreatePBRNeutralToneMapper() {
    return (jlong) new PBRNeutralToneMapper();
}

extern "C" jlong nCreateGT7ToneMapper() {
    return (jlong) new GT7ToneMapper();
}

extern "C" jlong nCreateAgxToneMapper(jint look) {
    return (jlong) new AgxToneMapper(AgxToneMapper::AgxLook(look));
}

extern "C" jlong nCreateGenericToneMapper(jfloat contrast, jfloat midGrayIn, jfloat midGrayOut, jfloat hdrMax) {
    return (jlong) new GenericToneMapper(contrast, midGrayIn, midGrayOut, hdrMax);
}

extern "C" jfloat nGenericGetContrast(jlong nativeObject) {
    return ((GenericToneMapper*) nativeObject)->getContrast();
}

extern "C" jfloat nGenericGetMidGrayIn(jlong nativeObject) {
    return ((GenericToneMapper*) nativeObject)->getMidGrayIn();
}

extern "C" jfloat nGenericGetMidGrayOut(jlong nativeObject) {
    return ((GenericToneMapper*) nativeObject)->getMidGrayOut();
}

extern "C" jfloat nGenericGetHdrMax(jlong nativeObject) {
    return ((GenericToneMapper*) nativeObject)->getHdrMax();
}

extern "C" void nGenericSetContrast(jlong nativeObject, jfloat contrast) {
    ((GenericToneMapper*) nativeObject)->setContrast(contrast);
}

extern "C" void nGenericSetMidGrayIn(jlong nativeObject, jfloat midGrayIn) {
    ((GenericToneMapper*) nativeObject)->setMidGrayIn(midGrayIn);
}

extern "C" void nGenericSetMidGrayOut(jlong nativeObject, jfloat midGrayOut) {
    ((GenericToneMapper*) nativeObject)->setMidGrayOut(midGrayOut);
}

extern "C" void nGenericSetHdrMax(jlong nativeObject, jfloat hdrMax) {
    ((GenericToneMapper*) nativeObject)->setHdrMax(hdrMax);
}

