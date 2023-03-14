val ktor_version = "2.2.3"

plugins {
    application
    kotlin("jvm")
    id("io.ktor.plugin") version "2.2.3"
    id("org.jetbrains.kotlin.plugin.serialization") version "1.8.0"
}

application {
    mainClass.set("io.ktor.server.netty.EngineMain")
}

dependencies {
    implementation("io.ktor:ktor-server-netty:2.2.3")
    implementation("io.ktor:ktor-client-core:2.2.3")
    implementation("io.ktor:ktor-client-json:2.2.3")
    implementation("io.ktor:ktor-serialization-kotlinx-json:2.2.3")
    implementation("io.ktor:ktor-server-content-negotiation:2.2.3")
    implementation("ch.qos.logback:logback-classic:1.2.11")

    implementation(project(":Multiplatform:DTO"))
    implementation(project(":Multiplatform:Serialization"))
    implementation(project(":Multiplatform:ClientNetwork"))
    implementation(project(":Multiplatform:Storage"))
    implementation(project(":Server:BeerStorage"))
}