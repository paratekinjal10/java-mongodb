pipeline {
    
    agent any
    
    // tools{
    //     maven 'maven-3.6.3'
    // }
    
    // environment{
    
    //     registry = 'demokinjal/task1-java'
    //     registryCredential = 'demokinjal'
    //     dockerImage = ''

    // }

    environment{
    
        VERSION = "${env.BUILD_ID}"

    }

    stages {
        
        stage ('Git Checkout') {

            steps {
                
                git branch: 'java-new', url: 'https://github.com/paratekinjal10/java-mongodb.git'
                
            }
        }

        stage ('Unit Test') {

            steps {
                
                sh "mvn test"
                
            }
        }
        stage ('Build') {

            steps {
                
                sh 'mvn clean package'
                
            }
        }

        // stage("Sonar quality check") {

        //     steps {

        //       script{

        //             withSonarQubeEnv(installationName: 'sonar-server2' , credentialsId: 'jenkins2') {
        //             sh 'mvn sonar:sonar'
        //             }        

        //         }
        //     }
        // }

        // stage("Quality gate") {

        //     steps {
        //         script {
        //             def qg = waitForQualityGate()
        //             if (qg.status != 'OK') {
        //                 error "Pipeline aborted due to Quality Gate failure: ${qg.status}"
        //             } 
                
        //         }
                        
        //     }
        // }

        stage("Build docker image"){
    
           steps{
    
               script {
                       sh "docker build -t image:${VERSION} ."
                       sh "docker tag image:${VERSION} demokinjal/task1-java:${VERSION}"
                       sh "docker push demokinjal/task1-java:${VERSION}"
                    
               }

           }

        }

        // stage("Build & Push Image"){
    
        //     steps{
    
        //         script{
                    
        //             withCredentials([string(credentialsId: 'nexus', variable: 'nexus-cred')]) {
                    
        //             sh '''
                    
        //             docker build -t 4.188.224.23:8083/app:${VERSION} .
        //             docker login -u admin -p nexus 4.188.224.23:8083
        //             docker push 4.188.224.23:8083/app:${VERSION}
        //             docker rmi 4.188.224.23:8083/app:${VERSION}
        //             '''
                    
        //             }
                                        

        //         }

        //     }

        // }


         // stage("Run image on remote server"){
         //    steps{
    
         //        script {

         //            withCredentials([string(credentialsId: 'nexus', variable: 'nexus-cred')]) {
                    
                        

         //            withCredentials([sshUserPrivateKey(credentialsId: 'deploy', keyFileVariable: 'key', usernameVariable: 'deploy')]) {
         //            def remote = [:]
         //            remote.user = 'deploy'
         //            remote.host = '20.232.209.34'
         //            remote.name = 'deploy'
         //            remote.password = 'deploy@12345678'
         //            remote.allowAnyHosts = 'true'
         //            //sshCommand remote: remote, command: "docker container rm -f db", tty: true
         //            //sshCommand remote: remote, command: "docker container rm -f app", tty: true
         //            sshCommand remote: remote, command: "sudo docker login -u admin -p nexus 4.188.224.23:8083", tty: true
         //            sshCommand remote: remote, command: "sudo docker pull 4.188.224.23:8083/app:${VERSION}", tty: true
         //            sshCommand remote: remote, command: "sudo docker pull mongo:latest", tty: true
         //            sshCommand remote: remote, command: "sudo docker run -d --name db -p 27017:27017 mongo:latest", tty: true
         //            sshCommand remote: remote, command: "sudo docker run -d --name app -p 8080:8080 --link db:mongo 4.188.224.23:8083/app:${VERSION}", tty: true
         //            }
         //        }

         //        }
         //    }
        }

        
    }
//}
