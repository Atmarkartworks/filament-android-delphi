plugins {
    alias(libs.plugins.android.library)
}

android {
    namespace = "com.gyabinet.filament.mylibrary"
    compileSdk = 35

    defaultConfig {
        minSdk = 28

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("consumer-rules.pro")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}


dependencies {
    implementation("com.google.android.filament:filament-android:1.71.4")
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.play.services.maps)
    implementation(libs.androidx.biometric)
    implementation(libs.okio)
    implementation(libs.androidx.exifinterface)

    //compileOnly(fileTree(mapOf("dir" to "libs/fillament", "include" to listOf("*.aar"))))
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
}


//  JAR output task (using module name dynamically)
tasks.register<Jar>("exportJar") {
    description = "Exports compiled classes as a JAR file."
    group = "build"

    archiveFileName.set("${project.name}-release.jar")
    destinationDirectory.set(layout.buildDirectory.dir("outputs/jar"))

    val variantName = "release"
    val compileTask = tasks.named<JavaCompile>("compile${variantName.replaceFirstChar { it.uppercase() }}JavaWithJavac")

    from(compileTask.flatMap { it.destinationDirectory })

    exclude("**/R.class")
    exclude("**/R$*.class")
    exclude("**/BuildConfig.class")

    dependsOn(compileTask)
}

// java2op execution task (using module name dynamically)
tasks.register<Exec>("generateDelphiUnit") {
    description = "Generates a Delphi unit from the JAR using java2op."
    group = "build"

    val exportJarTask = tasks.named<Jar>("exportJar")
    dependsOn(exportJarTask)

    val java2opPath = "C:\\Program Files (x86)\\Embarcadero\\Studio\\37.0\\bin\\converters\\java2op\\java2op.exe"
    val inputJar = exportJarTask.get().archiveFile.get().asFile
    
    // Build the unit name using the module name (project.name)
    val outputUnit = "AAW.JNI.${project.name}"

    executable = java2opPath
    args("-jar", inputJar.absolutePath, "-unit", outputUnit)

    workingDir = projectDir

    doFirst {
        if (!file(java2opPath).exists()) {
            throw GradleException("java2op.exe not found: $java2opPath")
        }
        println("Generating Delphi unit $outputUnit from ${inputJar.name}...")
    }

    doLast {
        println("Successfully generated: $outputUnit")
    }
}

// Filament material compilation configuration
val matcPath = File(rootDir, "../../bin/matc.exe")
val shaderSrcDir = file("shaderSrc")
//val assetsDir = file("src/main/assets")
val assetsDir = file("src/main/assets/materials")


val inExtension = "mat"
val outExtension = "filamat"

// Dynamically register an individual Exec task for each file in shaderSrc
if (shaderSrcDir.exists()) {
    shaderSrcDir.listFiles { f -> f.isFile && f.extension == inExtension }?.forEach { inputFile ->
        val taskName = "compileFilamentMaterial_${inputFile.nameWithoutExtension}"
        tasks.register<Exec>(taskName) {
            group = "filament"
            inputs.file(inputFile)
            
            // Generate output file name (convert extension)
            val outputFileName = "${inputFile.nameWithoutExtension}.$outExtension"
            val outputFile = File(assetsDir, outputFileName)
            outputs.file(outputFile)

            executable = matcPath.absolutePath
            args("-o", outputFile.absolutePath, inputFile.absolutePath)

            doFirst {
                if (!assetsDir.exists()) assetsDir.mkdirs()
                println("Compiling Filament material: ${inputFile.name} -> ${outputFile.name}")
            }
        }
    }
}
// Parent task aggregating all material build tasks
tasks.register("compileFilamentMaterials") {
    group = "build"
    description = "Builds all Filament materials."
    // Depend on all tasks whose name starts with "compileFilamentMaterial_"
    dependsOn(tasks.matching { it.name.startsWith("compileFilamentMaterial_") })
}

// Automatic integration with the Android build process
afterEvaluate {
    tasks.findByName("mergeDebugAssets")?.dependsOn("compileFilamentMaterials")
    tasks.findByName("mergeReleaseAssets")?.dependsOn("compileFilamentMaterials")

// ★ Added: automatically run JAR extraction and Delphi unit generation after AAR is produced
    // Obtain the AAR generation task (bundleReleaseAar) for release builds
    tasks.findByName("bundleReleaseAar")?.let { aarTask ->
        // Configure exportJar to run after AAR generation
        tasks.named("exportJar").configure {
            mustRunAfter(aarTask)
        }

        // Wire generateDelphiUnit to trigger AAR generation as part of the overall lifecycle
        tasks.named("generateDelphiUnit").configure {
            dependsOn(aarTask)
        }
    }

}
