pipeline {
    agent any
    environment {
        aws_region = "us-east-1"
        ecr_app = "ecr-app"
        terraform_state_bucket = "terraform-state-file-storage-surepay"
	tag_name = sh(script: 'git tag --sort=-creatordate | head -n 1', returnStdout: true).trim()
        AWS_ACCOUNT_ID = "259004291460"
        }
    stages {

        stage('Bandit Code Analysis SAST') {
             steps {
   		sh '''echo Building "$tag_name"'''
   		sh '''echo Building "$tag_name"'''
                 
                 sh "cd build/flask-spa/;docker run --rm --volume \$(pwd) secfigo/bandit:latest"
        }
     }
   

	stage ("Dependency Check with Python Safety"){
         	steps{
	        	sh "docker run --rm --volume \$(pwd) pyupio/safety:latest safety check"
			sh "docker run --rm --volume \$(pwd) pyupio/safety:latest safety check --json > report.json"
			}
		}
        
     
        
        stage('Create Terraform State File Bucket and ECR Repo') {
            steps {
                withAWS(credentials: 'aws-credential', region: 'us-east-1') {
                    sh 'chmod +x bucket.sh'
                    sh "./bucket.sh"
                }
              }
            }

        stage('Build Image') {
            steps {
                withAWS(credentials: 'aws-credential', region: 'us-east-1') {
                    sh 'chmod +x build.sh'
                    sh "./build.sh"
                    
                }
	      }
            }            



        stage('Dynamic Application Security Testing DAST') {

      steps {

                withAWS(credentials: 'aws-credential', region: 'us-east-1') {
                     sh "chmod +x dast.sh"
                     sh "./dast.sh"

        }
      }
    }


	stage('Scan Image and Push to ECR') {

      steps {

                withAWS(credentials: 'aws-credential', region: 'us-east-1') {
		     sh "chmod +x scan_push.sh"
		     sh "./scan_push.sh"

        }
      }
    }


        stage('Create Two Tier Arch on AWS and Rolling Update') {
            steps {
                withAWS(credentials: 'aws-credential', region: 'us-east-1') {
                    sh "chmod +x aws_tier.sh"
                    sh "./aws_tier.sh"
                }
              }
            }

    }

    post {
        always {
            cleanWs()
        }
    success {
      mail to: "surepay@gmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Yay, we passed."
    }
    failure {
      mail to: "surepay@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Ohhhh, we failed."
    }

       }

}
