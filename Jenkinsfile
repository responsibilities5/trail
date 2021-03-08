node {
    stage("Build") {
        echo "groovy build"
        withGradel(){
        sh "./gradlew --version"
        }
    }

    stage("Test") {
        echo "groovy test"
    }
}
