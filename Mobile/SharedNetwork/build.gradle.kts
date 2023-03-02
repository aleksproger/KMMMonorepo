plugins {
    kotlin("multiplatform")
    kotlin("plugin.serialization") version "1.4.32"
    id("com.android.library")
}

val ktor_version = "2.2.3"

kotlin {
    android()

    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "SharedNetwork"
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(project(":Multiplatform:Serialization"))
                implementation("io.ktor:ktor-client-core:$ktor_version")
                // implementation("io.ktor:ktor-client-json:$ktor_version")
                // implementation("io.ktor:ktor-client-serialization:$ktor_version")
                implementation("io.ktor:ktor-serialization-kotlinx-json:$ktor_version")
                implementation("io.ktor:ktor-client-content-negotiation:$ktor_version")

            }
        }
        val androidMain by getting {
            dependencies {
                implementation(project(":Multiplatform:Serialization"))

            }
        }

        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependencies {
                implementation(project(":Multiplatform:Serialization"))
                implementation("io.ktor:ktor-client-ios:$ktor_version")


                // implementation("io.ktor:ktor-client-json-native:$ktor_version")
                // implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:$serialization_version")
            }
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