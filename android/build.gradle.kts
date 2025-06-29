import com.android.build.gradle.BaseExtension
import org.gradle.api.Project
import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    afterEvaluate {
        // this: Project
        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
            extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                compileSdkVersion(34)
                buildToolsVersion("34.0.0")
            }
        }

        if (extensions.findByName("android") != null) {
            extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                if (namespace == null) {
                    namespace = group.toString()
                }
            }
        }
    }

    val newSubprojectBuildDir = newBuildDir.dir(name)
    layout.buildDirectory.set(newSubprojectBuildDir)
}

subprojects { evaluationDependsOn(":app") }

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}