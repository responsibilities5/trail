pipeline {

    agent any

    environment {
        AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
        
        //ECR_PATH = credentials('ECR_PATH')
        //SSH_AUTH = credentials('SSH_AUTH')
        def ECR = "308682804621.dkr.ecr.us-east-1.amazonaws.com"
        
        def IP = ''
        
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
                
                sh "echo deploy" 

                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR}"
                sh "docker build -t ${ECR}/project:app-V${BUILD_NUMBER} ."
                sh "docker push ${ECR}/project:app-V${BUILD_NUMBER}"
            }
            
        }

       

        stage("INFRASTRUCTURE PROVISIONING") {

            steps {

                sh "terraform init"
                
                sh "terraform apply --auto-approve"

               // script {
                //   def temp = sh(script: "terraform apply --auto-approve | grep 'public_ip'", returnStdout: true).trim()
                //   IP = temp[0..30].split()[2]
                    
              // }
               // sh "echo ${IP}"
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
