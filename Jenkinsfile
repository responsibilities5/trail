pipeline {

    agent any

    environment {
        AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
        def IP = ''
        ECR_PATH = credentials('ECR_PATH')
    }

    tools {

        terraform "Terraform"
        nodejs "Node-15.11"
    }

    stages {

        // stage("BUILD") {
            
        //     steps {

        //         sh "npm install"
        //     }

        // }

        // stage("TEST") {

        //     steps {

        //     }

        // }

        stage("DEPLOY") {

            steps {

                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_PATH'
                sh 'docker build -t $ECR_PATH/project:app-V${BUILD_NUMBER} .'
                sh 'docker push $ECR_PATH/project:app-V${BUILD_NUMBER}'
            }
            
        }

        stage("INFRASTRUCTURE PROVISIONING") {

            steps {

                sh "terraform init"

                script {
                   def temp = sh(script: "terraform apply --auto-approve | grep 'public_ip'", returnStdout: true).trim()
                   IP = temp.split()[2]
                    
               }
            }
        }

        stage("RELEASE") {

            steps {
                
                //sh "terraform destroy --auto-approve"
                //sh "echo ${IP}"

                sshagent(['SSH_AUTH']) {

                    sh "ssh -o StrictHostKeyChecking=no ubuntu@'${IP}' docker stop $(docker ps -aq)"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@'${IP}' docker system prune -af || true"
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@'${IP}' docker run -d -p 8080:8080 --name container $ECR_PATH/project:app-V${BUILD_NUMBER}'
                    
               // }
            }
        }


    }


}







/*pipeline {

    agent any
    environment {
        AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
        def IP = ''
        ECR_PATH = credentials('ECR_PATH')
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
                echo '$ECR_PATH'
            }
            
        }
        
        
        
        stage("DEPLOY") {
            steps {
                echo "deploying"
                
                sh "aws --version"
                
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_PATH'
                sh 'docker build -t $ECR_PATH/project:app-V${BUILD_NUMBER} .'
                sh 'docker push $ECR_PATH/project:app-V${BUILD_NUMBER}'
                
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
                //}
                
            }
        }
        
        stage("RELEASE") {
            steps {
                sshagent(['SSH_AUTH']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@${IP}"
                    
                }
            }
        }
        
    }

} */
