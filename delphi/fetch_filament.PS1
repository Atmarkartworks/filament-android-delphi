# ==========================================
# Configuration
# ==========================================
$FILAMENT_VERSION = "1.71.4"
$WORK_DIR         = Join-Path $PSScriptRoot "aar"
$OUTPUT_DIR       = Join-Path $WORK_DIR "output"

# Clean up and create folders
if (Test-Path $WORK_DIR) { Remove-Item -Recurse -Force $WORK_DIR }
New-Item -ItemType Directory -Force -Path $WORK_DIR | Out-Null
New-Item -ItemType Directory -Force -Path $OUTPUT_DIR | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $OUTPUT_DIR "so") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $OUTPUT_DIR "jar") | Out-Null

Set-Location $WORK_DIR

# ==========================================
# 1. Generate minimal build.gradle
# ==========================================
$gradleContent = @"
plugins {
    id 'java'
}

repositories {
    google()
    mavenCentral()
}

configurations {
    filamentConfig
}

dependencies {
    filamentConfig 'com.google.android.filament:filament-android:$FILAMENT_VERSION'
}

tasks.register('copyDependencies', Copy) {
    from configurations.filamentConfig
    into 'downloads'
}
"@

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText((Join-Path $WORK_DIR "build.gradle"), $gradleContent, $utf8NoBom)

# ==========================================
# 2. Run Gradle to download AAR
# ==========================================
Write-Host "[1/3] Downloading Filament (AAR) and dependencies via Gradle..." -ForegroundColor Cyan
gradle copyDependencies --no-daemon

if ($LASTEXITCODE -ne 0) {
    Write-Error "Gradle execution failed. Please check your repository connection or JDK environment."
    exit
}

# ==========================================
# 3. Extract .jar and .so from AAR
# ==========================================
Write-Host "[2/3] Extracting artifacts from downloaded AAR..." -ForegroundColor Cyan
$aarFile = Get-ChildItem "downloads\filament-android-*.aar" | Select-Object -First 1

if (-not $aarFile) {
    Write-Error "AAR file for filament-android was not found."
    exit
}

# AAR is a ZIP archive, so rename and extract
$zipFile = Join-Path $WORK_DIR "filament.zip"
Copy-Item $aarFile.FullName $zipFile
$extractDir = Join-Path $WORK_DIR "extracted_aar"
Expand-Archive -Path $zipFile -DestinationPath $extractDir -Force

# --- Extract classes.jar ---
if (Test-Path (Join-Path $extractDir "classes.jar")) {
    $targetJarName = "filament-android-$FILAMENT_VERSION.jar"
    Copy-Item (Join-Path $extractDir "classes.jar") (Join-Path $OUTPUT_DIR "jar\$targetJarName")
    Write-Host " -> JAR extracted: $targetJarName" -ForegroundColor Green
}

# --- Extract arm64-v8a .so files ---
$soSrcDir = Join-Path $extractDir "jni\arm64-v8a"
if (Test-Path $soSrcDir) {
    Get-ChildItem (Join-Path $soSrcDir "*.so") | ForEach-Object {
        Copy-Item $_.FullName (Join-Path $OUTPUT_DIR "so\")
        Write-Host " -> SO extracted: $($_.Name)" -ForegroundColor Green
    }
}

# Clean up temporary files
Remove-Item $zipFile -Force
Remove-Item $extractDir -Recurse -Force

Write-Host "`n[3/3] All steps completed successfully!" -ForegroundColor Cyan
Write-Host "Output directory: $OUTPUT_DIR" -ForegroundColor Yellow

$jarFile = Join-Path $OUTPUT_DIR "jar\filament-android-$FILAMENT_VERSION.jar"
if (Test-Path $jarFile) {
    & "C:\Program Files (x86)\Embarcadero\Studio\37.0\bin\converters\java2op\java2op.exe" -jar $jarFile -unit filament_bindings
} else {
    Write-Warning "JAR file not found, skipping java2op: $jarFile"
}