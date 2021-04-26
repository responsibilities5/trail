pipeline {

    agent any
    environment {
        AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
        def ip = ''
    }
    tools {
        gradle "Gradle"
        terraform "Terraform"
        
    }
    
    stages {
        stage("BUILD") {
            steps {
                echo "building"
                //sh "gradle --version"
                //sh "docker --version"
            }
            
        }
        stage("DEPLOY") {
            steps {
                echo "deploying"
                sh "terraform init"
                script {
                
                
                    ip = sh"terraform state show aws_eip.one"
                    echo "${ip}"
                    
                }
               
                
                sh "terraform destroy --auto-approve"
                nodejs("Node-15.11") {
                    sh "node --version"
                    sh "yarn --version"
                }
                
            }
        }
        
    }

}
