// Top-level build file where you can add configuration options common to all sub-projects/modules.
buildscript {

    val kotlin_version by extra("1.3.72")
    val kotlinVersion: String by project

    val buildGradleVersion: String by project
    val nativeCocoaPodsVersion: String by project
    repositories {
        mavenLocal()
        google()
        jcenter()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:$buildGradleVersion")
        classpath(kotlin("gradle-plugin", kotlinVersion))
        // Pods
        classpath("co.touchlab:kotlinnativecocoapods:$nativeCocoaPodsVersion")

        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

allprojects {
    repositories {
        mavenLocal()
        mavenCentral()
        google()
        jcenter()
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
