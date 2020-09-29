import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

plugins {
    kotlin("multiplatform")
    id("co.touchlab.native.cocoapods")
    id("com.android.library")
}

android {
    compileSdkVersion(29)
    defaultConfig {
        minSdkVersion(21)
        targetSdkVersion(29)
        versionCode = 1
        versionName = "1.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
}

kotlin {
    android()
    //Revert to just ios() when gradle plugin can properly resolve it
    val onPhone = System.getenv("SDK_NAME")?.startsWith("iphoneos")?:false
    if(onPhone){
        iosArm64("ios")
    }else{
        iosX64("ios")
    }
    targets.getByName<KotlinNativeTarget>("ios").compilations["main"].kotlinOptions.freeCompilerArgs +=
        listOf("-Xobjc-generics", "-Xg0")

    version = "1.1"

    sourceSets {
        all {
            languageSettings.apply {
                useExperimentalAnnotation("kotlinx.coroutines.ExperimentalCoroutinesApi")
            }
        }

        val kotlinVersion: String by project
        val kalugaVersion: String by project
        val nativeCoroutinesVersion: String by project
        val appCompatVersion: String by project

        val commonMain by getting {
            dependencies {
                implementation(kotlin("stdlib-common", kotlinVersion))
                implementation("com.splendo.kaluga:base:$kalugaVersion")
                api("com.splendo.kaluga:architecture:$kalugaVersion")

                // Coroutines
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core-native:" +
                        nativeCoroutinesVersion
                )
            }
        }

        val androidMain by getting {
            dependsOn(commonMain)

            dependencies {
                // Android Deps
                implementation(kotlin("stdlib", kotlinVersion))
                implementation("androidx.appcompat:appcompat:$appCompatVersion")
            }
        }

        val iosMain by getting {
            dependsOn(commonMain)

            dependencies {
                // iOS Deps
            }
        }

    }

    cocoapodsext {
        val kalugaVersion: String by project
        summary = "Starter template for multiplatform Kaluga projects."
        homepage = "https://github.com/splendo/kaluga-starter"
        framework {
            baseName = "SampleCombineShared"
            export("com.splendo.kaluga:architecture:$kalugaVersion")
            isStatic = false
            transitiveExport = true
        }
    }

}
