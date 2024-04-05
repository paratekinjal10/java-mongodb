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
        USER = "demokinjal"
        PASSWORD = "kinjal@parate2000"

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

        stage("Build docker image"){
    
           steps{
    
               script {
                       sh "docker build -t image:${VERSION} ."
                       sh "docker tag image:${VERSION} demokinjal/task1-java:${VERSION}"
                    
               }

           }

        }

        stage("Push docker image"){
    
           steps{
    
               script {
                       sh "docker login -u $USER -p $PASSWORD"
                       sh "docker push demokinjal/task1-java:${VERSION}"
                    
               }

           }

        }

        stage("K8 deploy"){
    
           steps{
    
           //     withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
           //          sh ('kubectl apply -f k8-aks.yaml')
           //          }

            
                script {
                    // Read the Kubernetes manifest template
                    def template = readFile('/var/lib/jenkins/workspace/task1/k8-aks-template.yaml')
                    
                    // Substitute the VERSION variable in the template
                    def substitutedTemplate = template.replaceAll('\\$\\{VERSION\\}', VERSION)
                    
                    // Write the substituted manifest to a temporary file
                    writeFile file: 'k8-aks.yaml', text: substitutedTemplate
                    
                    // Apply the modified Kubernetes manifest
                    withKubeConfig(credentialsId: 'K8') {
                        sh 'kubectl apply -f k8-aks.yaml'
                    }
                }
        }

    }
}
}
