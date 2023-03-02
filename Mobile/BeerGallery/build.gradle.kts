plugins {
    kotlin("multiplatform")
    id("com.android.library")
}

kotlin {
    android()

    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "BeerGallery"
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(project(":Mobile:SharedNetwork"))
                implementation(project(":Multiplatform:DTO"))
                implementation(project(":Multiplatform:Serialization"))
                implementation(project(":Multiplatform:Architecture"))

            }
        }
        val androidMain by getting {
            dependencies {
                implementation(project(":Mobile:SharedNetwork"))
                implementation(project(":Multiplatform:DTO"))
            }
        }

        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependencies {}
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