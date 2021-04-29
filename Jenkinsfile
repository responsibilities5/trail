pipeline {

    agent any
    environment {
        AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
        def IP = ''
        ECR_PATH = "308682804621.dkr.ecr.us-east-1.amazonaws.com/project"
    }
    tools {
        
        terraform "Terraform"
        
    }
    
    stages {
        stage("BUILD") {
            steps {
                //sh "npm install"
                //sh "gradle --version"
                //sh "docker --version"
                echo "${ECR_PATH}"
            }
            
        }
        
        stage("TEST") {
            steps {
            
            }
        
        }
        
        stage("DEPLOY") {
            steps {
                echo "deploying"
                //sh "terraform init"
                
                
               
                
                //script {
                  //  def temp = sh(script: "terraform apply --auto-approve | grep 'public_ip'", returnStdout: true).trim()
                 //   IP = temp.split()[2]
                 //   echo "${IP}"
                    
               // }
                
               //sh "terraform destroy --auto-approve"
                
                
                //nodejs("Node-15.11") {
                 //   sh "node --version"
                 //  sh "yarn --version"
                }
                
            }
        }
        
    }

}
