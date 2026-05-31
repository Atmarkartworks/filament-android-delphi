unit Filament.Utils.RemoteServer;
{
  filament-utils-android -- RemoteServer  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/RemoteServer.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  nPeekIncomingLabel / nPeekReceivedLabel:
    Return an internal const char* pointer.  Copy to AnsiString before next call.
  nAcquireReceivedMessage:
    buffer: caller-allocated Pointer of at least 'length' bytes.
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

function  nCreate(port: Integer): Int64;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nDestroy(native: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nPeekIncomingLabel(native: Int64): PAnsiChar;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nPeekReceivedLabel(native: Int64): PAnsiChar;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

function  nPeekReceivedBufferLength(native: Int64): Integer;
  cdecl; external LIB_FILAMENT_UTILS_JNI;

procedure nAcquireReceivedMessage(native: Int64; buffer: Pointer; length: Integer);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
