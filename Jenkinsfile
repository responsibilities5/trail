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
        
    }

}
