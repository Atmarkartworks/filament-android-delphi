# delphi/sample

Place your Embarcadero Delphi project files here (.dproj, .pas, etc.).

## Expected contents

```
sample/
  FilamentSample.dproj        - Delphi project file
  FilamentSample.dpr          - Delphi program file
  MainForm.pas                - Main form unit
  MainForm.fmx                - FireMonkey form layout
  Android/                    - Android deployment output
```

## Setup

1. Build the bridge AAR first:
   ```
   cd ../bridge
   gradle assembleRelease
   ```
2. Add `filament-delphi-bridge.aar` to your Delphi project via
   Project > Options > Uses Permissions / SDK Manager > Import AAR.
3. Import `FilamentBridge` Java class using `Androidapi.JNI` wrappers.
