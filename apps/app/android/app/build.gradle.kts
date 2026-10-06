plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.glyphora.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.glyphora.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

// Push notifications: only wire up Firebase once google-services.json exists,
// so builds without Firebase config keep working.
if (file("google-services.json").exists()) {
    apply(plugin = "com.google.gms.google-services")
}

// GLYPHORA_CRONET_NAMESPACE_FIX
// Cronet 141.7340.3 ships cronet-api / cronet-shared with the same Android
// namespace, which AGP 9 rejects. Force the fixed 143.7445.0 artifacts.
configurations.all {
    resolutionStrategy.eachDependency {
        if (requested.group == "org.chromium.net") {
            useVersion("143.7445.0")
            because("Cronet 141 has duplicate Android namespaces under AGP 9")
        }
    }
}
