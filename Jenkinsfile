pipeline {

    agent any
    tools {
        gradle "Gradle"
        terraform "Terraform"
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
                sh "terraform plan"
                nodejs("Node-15.11") {
                    sh "node --version"
                    sh "yarn --version"
                }
                
            }
        }
        
    }

}
