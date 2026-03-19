allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val buildDir = File(rootProject.rootDir, "../build")
rootProject.layout.buildDirectory.set(buildDir)

subprojects {
    project.layout.buildDirectory.set(File(buildDir, project.name))
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
