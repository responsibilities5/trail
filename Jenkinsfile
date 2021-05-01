pipeline {

    agent any

    environment {
        AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
        
        //ECR_PATH = credentials('ECR_PATH')
        //SSH_AUTH = credentials('SSH_AUTH')
        def ECR = "308682804621.dkr.ecr.us-east-1.amazonaws.com"
        
        IP = ''
        
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
	    
	stage("INFRASTRUCTURE PROVISIONING") {

            steps {

                sh "terraform init"
                
                sh "terraform destroy --auto-approve"

                script {
			
                    	def temp = sh(script: 'terraform apply -var "aws_access_key=$AWS_ACCESS_KEY" -var "aws_secret_key=$AWS_SECRET_KEY" --auto-approve | grep public_ip | xargs', returnStdout: true).trim()
			
			def s = temp.split()[2].trim().indexOf("[")
			if(s) {
				IP = temp[0..s-1].split()[2]
			
			}
			else {IP = temp.split()[2]}
                    	sh "echo ${IP} >> abc.txt"
                    
               } 
                
            }
        }    
	    
	    
        
        /*stage("DEPLOY") {

            steps {
                
                sh "echo deploy" 

                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR}"
                sh "docker build -t ${ECR}/project:app-V${BUILD_NUMBER} ."
                sh "docker push ${ECR}/project:app-V${BUILD_NUMBER}" 
            }
            
        }*/

       

        
        
        
        
    } 
        

    
}





