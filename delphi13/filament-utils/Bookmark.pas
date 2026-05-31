unit Filament.Utils.Bookmark;
{
  filament-utils-android — Bookmark  Delphi import definitions
  Source : Filament/delphi13/filament-utils-android/src/cpp/Bookmark.cpp
  Library: libfilament-utils-jni.so  (external 'filament-utils-jni')
  Target : Android ARM64 / ARM32

  Bookmark stores a camera position/orientation for later recall via
  Manipulator.nJumpToBookmark.  Bookmark objects are created by
  Manipulator.nGetCurrentBookmark / nGetHomeBookmark.

  Type mapping:
    jlong -> Int64
}

{$IFDEF ANDROID}

interface

const
  LIB_FILAMENT_UTILS_JNI = 'filament-utils-jni';

// =============================================================================
// Bookmark
// =============================================================================

procedure nDestroyBookmark(nativeBookmark: Int64);
  cdecl; external LIB_FILAMENT_UTILS_JNI;

implementation

{$ENDIF}
end.
