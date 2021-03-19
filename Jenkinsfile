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
                withTerraform() {
                
                    sh "terraform --version"
                }
                nodejs("Node-15.11") {
                    sh "node --version"
                    sh "yarn --version"
                }
                
            }
        }
        
    }

}
