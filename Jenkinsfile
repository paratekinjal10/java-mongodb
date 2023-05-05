pipeline {
    
    agent any
    
    tools{
        maven 'maven-3.9.1'
    }
    
    // environment{
    
    //     registry = 'demokinjal/trial'
    //     registryCredential = 'demokinjal'
    //     dockerImage = ''

    // }

    environment{
    
        VERSION = "${env.BUILD_ID}"

    }

    stages {
        

        stage ('Build') {

            steps {
                
                sh 'mvn clean package'
                
            }
        }

        stage("Sonar quality check") {

            steps {

              script{

                    withSonarQubeEnv(installationName: 'sonar-server2' , credentialsId: 'jenkins2') {
                    sh 'mvn sonar:sonar'
                    }        

                }
            }
        }

        stage("Quality gate") {

            steps {
                script {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to Quality Gate failure: ${qg.status}"
                    } 
                
                }
                        
            }
        }

        // stage("Build docker image"){
    
        //    steps{
    
        //        script {
        //            dockerImage = docker.build registry + ":$BUILD_NUMBER"
        //        }

        //    }

        //}

        stage("Push docker image to Nexus repo"){
    
            steps{
    
                script{
                    
                    withCredentials([string(credentialsId: 'nexus', variable: 'nexus-cred')]) {
                    
                    sh '''
                    
                    docker build -t 4.188.224.23:8083/app:${VERSION} .
                    docker login -u admin -p nexus 4.188.224.23:8083
                    docker push 4.188.224.23:8083/app:${VERSION}
                    docker rmi 4.188.224.23:8083/app:${VERSION}
                    '''
                    
                    }
                                        

                }

            }

        }


         stage("Run image on remote server"){
            steps{
    
                script {

                    withCredentials([string(credentialsId: 'nexus', variable: 'nexus-cred')]) {
                    
                        

                    withCredentials([sshUserPrivateKey(credentialsId: 'deploy', keyFileVariable: 'key', usernameVariable: 'deploy')]) {
                    def remote = [:]
                    remote.user = 'deploy'
                    remote.host = '20.232.209.34'
                    remote.name = 'deploy'
                    remote.password = 'deploy@12345678'
                    remote.allowAnyHosts = 'true'
                    //sshCommand remote: remote, command: "docker container rm -f db", tty: true
                    //sshCommand remote: remote, command: "docker container rm -f app", tty: true
                    sshCommand remote: remote, command: "sudo docker login -u admin -p nexus 4.188.224.23:8083", tty: true
                    sshCommand remote: remote, command: "sudo docker pull 4.188.224.23:8083/app:${VERSION}", tty: true
                    sshCommand remote: remote, command: "sudo docker pull mongo:latest", tty: true
                    sshCommand remote: remote, command: "sudo docker run -d --name db -p 27017:27017 mongo:latest", tty: true
                    sshCommand remote: remote, command: "sudo docker run -d --name app -p 8080:8080 --link db:mongo 4.188.224.23:8083/app:${VERSION}", tty: true
                    }
                }

                }
            }
        }

        //stage('Approval Gateway') {
        //    steps {
        //        // prompt user for approval
        //        input "Please approve the deployment"
        //    }
        //
        //    post {
        //        always {
        //            // send email notification
        //            emailext body: 'The deployment has been approved and will now proceed',
        //                     subject: 'Deployment Approved',
        //                     to: 'devops473@gmail.com'
        //        }
        //    }
        //}

        //stage('Send Approval Email') {
            //steps {
                //script {
                    //def approvalBody = """
                       // Please approve this deployment request.
                       // Click the following link to approve or reject:
                        
                      //  ${Jenkins.getInstance().getRootUrl()}${env.JOB_URL}input/approval?email=true
                    //"""
                    
                    //emailext (
                   //     to: 'devops473@gmail.com',
                  //      subject: 'Deployment Approval',
                 //       body: approvalBody,
                //        recipientProviders: [[$class: 'DevelopersRecipientProvider']]
              //      )
            //    }
          //  }
        //}
        
        //stage('Wait for Approval') {
        //    steps {
        //        input 'Deployment Approval'
        //    }
        //}
    }
}
