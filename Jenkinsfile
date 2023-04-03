
def buildUser = ''
def getBranchName(){
    return scm.branches[0].name;
}

pipeline {
	agent any 
	stages {
		stage("Checkout") {
			steps {
				checkout scm
			}
		}

        stage("Environment") {
            environment {
                BRANCH_NAME = getBranchName()
            }
            steps { 
                script{ 
                    sh "git --version"
                    echo "branch name : ${BRANCH_NAME}"
                    sh "docker --version"
                    sh "printenv"
                    wrap([$class : 'BuildUser']){
                        buildUser = env.BUILD_USER_ID + "-" + env.BUILD_USER 
                    }
                    echo "buildUser is : ${buildUser}"
                }
            }
        }
        
        stage("Installation") {
            agent {
                docker {
                    image 'node:16.20.0-alpine'
                    args '-p 5010:3000'
                }
            }
            steps{ 
                sh "node -v"
                sh "npm install"                
            }
        }       

	}	
}