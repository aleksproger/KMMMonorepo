plugins {
    application
    kotlin("jvm")
    id("com.squareup.sqldelight") version "1.5.4"
}

dependencies { 
    implementation("com.squareup.sqldelight:sqlite-driver:1.5.4")
    implementation(project(":Multiplatform:Storage"))
}

sqldelight {
  database("BeerStorageSQL") { // This will be the name of the generated database class.
    packageName = "Server.BeerStorage"
  }
}
