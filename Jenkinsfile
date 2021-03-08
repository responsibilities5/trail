pipeline {

    agent any
    tools {
        gradle "Gradle"
    }
    
    stages {
        stage("BUILD") {
            steps {
                echo "building"
                sh "gradle --version"
            }
            
        }
        stage("DEPLOY") {
            steps {
                echo "deploying"
                nodejs("Node-15.11") {
                    sh "node --version"
                    sh "yarn --version"
                }
            }
        }
        
    }

}
