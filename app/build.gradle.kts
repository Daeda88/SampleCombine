plugins {
    id("com.android.application")
    kotlin("android")
    kotlin("android.extensions")
}

android {

    packagingOptions {
        exclude("META-INF/*kotlin_module")
    }

    compileSdkVersion(29)
    buildToolsVersion = "29.0.3"

    defaultConfig {
        applicationId = "com.splendo.samplecombine"
        minSdkVersion(21)
        targetSdkVersion(29)
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {

    val kotlinVersion: String by project
    val coreKtxVersion: String by project
    val appCompatVersion: String by project
    val constraintLayoutVersion: String by project
    val kalugaVersion: String by project
    val googleMapsVersion: String by project
    val koinVersion: String by project

    val junitVersion: String by project
    val extJunitVersion: String by project
    val espressoCoreVersion: String by project
    val navVersion: String by project
    val materialVersion: String by project

    implementation(project(":shared"))

    implementation(fileTree(mapOf("dir" to "libs", "include" to listOf("*.jar"))))
    implementation(kotlin("stdlib-jdk7", kotlinVersion))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("androidx.core:core-ktx:$coreKtxVersion")
    implementation("androidx.appcompat:appcompat:$appCompatVersion")
    implementation(
        "androidx.constraintlayout:constraintlayout:$constraintLayoutVersion"
    )
    implementation("androidx.navigation:navigation-fragment-ktx:$navVersion")
    implementation("androidx.navigation:navigation-ui-ktx:$navVersion")
    implementation("com.google.android.material:material:$materialVersion")


    implementation("com.splendo.kaluga:base:$kalugaVersion")
    implementation("com.splendo.kaluga:location:$kalugaVersion")
    implementation("com.splendo.kaluga:architecture:$kalugaVersion")
    implementation("com.splendo.kaluga:permissions:$kalugaVersion")


    testImplementation("junit:junit:$junitVersion")
    androidTestImplementation("androidx.test.ext:junit:$extJunitVersion")
    androidTestImplementation (
        "androidx.test.espresso:espresso-core:$espressoCoreVersion"
    )
}
