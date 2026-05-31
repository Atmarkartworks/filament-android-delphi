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

// Delphi13 変換済み — JNI 除去版
// 変換: Java_com_google_android_filament_utils_RemoteServer_ プレフィックス除去
//       JNIEnv*, jclass 第1・第2引数除去
//       jstring 戻り値 → const char*  (内部ポインタ。呼び出し元はコピー必須)
//       jobject buffer (DirectByteBuffer) → void* buffer  (呼び出し元が確保)

#include <jni.h>

#include <viewer/RemoteServer.h>

#include <cstring>

using namespace filament::viewer;

extern "C" jlong nCreate(jint port) {
    RemoteServer* server = new RemoteServer(port);
    if (!server->isValid()) {
        delete server;
        return 0;
    }
    return (jlong) server;
}

extern "C" void nDestroy(jlong native) {
    RemoteServer* server = (RemoteServer*) native;
    delete server;
}

// Returns a pointer to the label string, or nullptr if no incoming message.
// The pointer is valid only until the next call — caller must copy the string.
extern "C" const char* nPeekIncomingLabel(jlong native) {
    RemoteServer* server = (RemoteServer*) native;
    return server->peekIncomingLabel();
}

// Returns a pointer to the label of the received message, or nullptr if none.
extern "C" const char* nPeekReceivedLabel(jlong native) {
    RemoteServer* server = (RemoteServer*) native;
    ReceivedMessage const* msg = server->peekReceivedMessage();
    return msg ? msg->label : nullptr;
}

extern "C" jint nPeekReceivedBufferLength(jlong native) {
    RemoteServer* server = (RemoteServer*) native;
    ReceivedMessage const* msg = server->peekReceivedMessage();
    return msg ? (jint) msg->bufferByteCount : 0;
}

// Copies the received message data into the caller-allocated buffer (length bytes).
// Releases the received message after copying.
extern "C" void nAcquireReceivedMessage(jlong native, void* buffer, jint length) {
    RemoteServer* server = (RemoteServer*) native;
    ReceivedMessage const* msg = server->acquireReceivedMessage();
    if (msg == nullptr || buffer == nullptr) {
        return;
    }
    memcpy(buffer, msg->buffer, (size_t) length);
    server->releaseReceivedMessage(msg);
}
