import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("com.google.firebase.firebase-perf")
    id("com.google.firebase.crashlytics")
    id("dev.flutter.flutter-gradle-plugin")
}

// Load local.properties
val localProperties = Properties().apply {
    val file = File(rootProject.projectDir, "local.properties")
    if (file.exists()) {
        load(FileInputStream(file))
    }
}
val keystoreProperties = Properties().apply {
    val keystoreFile = File(rootProject.projectDir, "key.properties")
    if (keystoreFile.exists()) {
        load(FileInputStream(keystoreFile))
    }
}

android {
    namespace = "com.manishsahu.myappixo.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.manishsahu.myappixo.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // ✅ Now localProperties is loaded properly
        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = localProperties.getProperty("GOOGLE_MAPS_API_KEY", "")
        manifestPlaceholders["GOOGLE_ADMOB_API_KEY"] = localProperties.getProperty("GOOGLE_ADMOB_API_KEY", "")
    }
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }




    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("dev") {
            dimension = "default"
            resValue("string", "app_name", "Ap_dev")
            applicationIdSuffix = ".dev"
            namespace = "com.manishsahu.myappixo.app.dev" // ✅ Add this
        }
        create("uat") {
            dimension = "default"
            resValue("string", "app_name", "Ap_uat")
            applicationIdSuffix = ".uat"
            namespace = "com.manishsahu.myappixo.app.uat" // ✅ Add this
        }
        create("prod") {
            dimension = "default"
            resValue("string", "app_name", "Appixo")
            namespace = "com.manishsahu.myappixo.app" // ✅ Add this
        }
    }
}

flutter {
    source = "../.."
}
