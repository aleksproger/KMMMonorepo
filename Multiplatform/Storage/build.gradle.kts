import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform")
    id("com.squareup.sqldelight") version "1.5.4"
    id("com.android.library")
}


// sqldelight {
//   Database { // This will be the name of the generated database class.
//     packageName = "Multiplatform.Storage"
//   }
// }

kotlin {
    android()
    jvm()

    val xcf = XCFramework()

    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "Storage"
            xcf.add(this)
        }
    }

    sourceSets {
        val commonMain by getting
        val jvmMain by getting {
            dependencies { 
                implementation("com.squareup.sqldelight:sqlite-driver:1.5.4")
            }
        }
        val androidMain by getting {
            dependencies {
                implementation("com.squareup.sqldelight:android-driver:1.5.4")
            }
        }
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)
        }
    }
}

android {
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    compileSdk = 31
    defaultConfig {
        minSdk = 21
        targetSdk = 31
    }
}