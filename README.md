# filament-android-delphi

A working example of integrating [Google Filament](https://github.com/google/filament) — a physically based rendering (PBR) engine — into a **Delphi FMX Android** application via a JNI bridge library.

## Demo

[![Demo on YouTube](https://img.youtube.com/vi/FL2EKga-oOc/hqdefault.jpg)](https://youtube.com/shorts/FL2EKga-oOc)

## Overview

This repository demonstrates how to host a native Android Filament rendering surface inside a Delphi FireMonkey (FMX) application. The architecture consists of two layers:

| Layer | Location | Role |
|---|---|---|
| **Android bridge library** | `delphi/bridge/mylibrary` | Kotlin/Java library that wraps the Filament Android SDK and exposes a JNI API |
| **Delphi FMX sample app** | `delphi/sample` | FMX application that calls the bridge through auto-generated Delphi JNI bindings |

Tapping **Open** in the sample app starts the Filament module; tapping **Close** shuts it down.

## Requirements

| Tool | Version / Notes |
|---|---|
| OS | Windows 10 Pro (10.0.19045) |
| Delphi | 12.3 or later (developed on 13.1) |
| Android Studio | Panda 4 — 2025.3.4 Patch 1 (Build #AI-253.32098.37.2534.15336583) |
| Gradle | 8.14.1 or later — [download](https://gradle.org/releases/) — must be added to `PATH` |
| Android SDK min | API 28 (Android 9.0) |
| Filament | 1.71.4 |

## Build Steps

### 1. Clone the repository

```powershell
git clone https://github.com/Atmarkartworks/filament-android-delphi.git
cd filament-android-delphi
```

### 2. Install Gradle and add it to PATH

Download Gradle from https://gradle.org/releases/ and add its `bin` directory to your `PATH` before running any scripts.

```powershell
# Example (adjust path to your installation)
$env:Path = "C:\usr\local\gradle\gradle-8.14.5\bin;" + $env:Path
```

> **Note:** If Gradle is not on the `PATH`, the `fetch_filament.PS1` script will fail.

### 3. Download prebuilt tools

**Run from the repository root.**

```powershell
PS Z:\dev\filament-android-delphi> .\DownloadToolsBin.PS1
```

> **Warning:** The download is over **700 MB** — ensure you have a stable connection and sufficient disk space before proceeding.

### 4. Fetch Filament binaries

**Change directory to `delphi/` first**, then run the script from there.

```powershell
PS Z:\dev\filament-android-delphi> cd delphi
PS Z:\dev\filament-android-delphi\delphi> .\fetch_filament.PS1
```

> **Important:** The script must be executed from the `delphi/` subdirectory. Running it from the repo root will fail because the output directory is resolved relative to the current working directory (`delphi\aar`).

On success you should see output similar to:

```
[1/3] Downloading Filament (AAR) and dependencies via Gradle...
BUILD SUCCESSFUL in 21s
1 actionable task: 1 executed
[2/3] Extracting artifacts from downloaded AAR...
 -> JAR extracted: filament-android-1.71.4.jar
 -> SO extracted: libfilament-jni.so
[3/3] All steps completed successfully!
Output directory: ...\delphi\aar\output
```

The following files are produced under `delphi/aar/output/`:

| File | Description |
|---|---|
| `filament-android-1.71.4.jar` | Filament Android Java API |
| `libfilament-jni.so` | Filament native shared library (JNI) |
| `unlit.filamat` | Compiled Filament unlit material |

### 5. Build the Android bridge library

1. Open **`delphi/bridge`** as a project in Android Studio.
2. Build the project (**Build → Make Project**).
3. Generate the Delphi JNI unit from the compiled JAR:

```bash
./gradlew :mylibrary:generateDelphiUnit
```

This produces `AAW.JNI.mylibrary.pas` — the auto-generated Delphi binding for the bridge library.

### 6. Build and deploy the Delphi sample app

1. Open **`delphi/sample/Project1.dproj`** in Delphi.
2. Select the **Android 64-bit** target platform.
3. Build and run the project.

> **Note:** `libfilament-jni.so`, `filament-android-1.71.4.jar`, and `unlit.filamat` are already registered in the project's deployment list. Verify the deployment settings before the first run to ensure all three files are included and set to the correct remote paths.

## Project Structure

```
filament-android-delphi/
├── DownloadToolsBin.PS1          # Downloads required binary tools (run from repo root)
├── delphi/
│   ├── fetch_filament.PS1        # Fetches Filament prebuilt binaries (run from delphi/)
│   ├── bridge/                   # Android Studio project (Kotlin/Java bridge)
│   │   └── mylibrary/            # AAR library wrapping Filament Android SDK
│   │       └── src/              # Bridge source code
│   └── sample/                   # Delphi FMX sample application
│       ├── Project1.dproj
│       ├── Unit1.pas             # Main form — calls bridge via JNI
│       └── Unit1.fmx
```

## How It Works

1. The **bridge library** (`mylibrary`) wraps the Filament Android SDK as a standard Android library module and exposes its API via JNI-callable methods.
2. The **`generateDelphiUnit`** Gradle task introspects the compiled JAR and emits a Delphi Pascal unit (`AAW.JNI.mylibrary.pas`) that mirrors the Java class/method signatures using Delphi's `Androidapi.JNIBridge` infrastructure.
3. The **Delphi FMX app** imports this generated unit, obtains a reference to the host `Activity`, and delegates Filament lifecycle calls (`open` / `close`) through the standard JNI bridge.

## License

Copyright 2026 Atmarkartworks

Licensed under the Apache License, Version 2.0 (the "License");  
you may not use this file except in compliance with the License.  
You may obtain a copy of the License at

&nbsp;&nbsp;&nbsp;&nbsp;http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software  
distributed under the License is distributed on an "AS IS" BASIS,  
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
See the License for the specific language governing permissions and  
limitations under the License.

The bundled Filament library is also licensed under the Apache License, Version 2.0.  
See https://github.com/google/filament/blob/main/LICENSE for details.
