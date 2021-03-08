node {
    stage("Build") {
        steps{
        echo "groovy build"
        withGradel(){
        sh './gradlew --version'
        }
        }
    }

    stage("Test") {
        echo "groovy test"
    }
}
