pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rajeshsvrn/pipeline1.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build("pipeline1")
                }
            }
        }
        stage('Push Docker Image to GCR') {
            steps {
                withCredentials([gcrCredential(credentialsId: 'gcr-creds', registryUrl: '')]) {
                    script {
                        docker.withRegistry("https://gcr.io", "gcr-creds") {
                            dockerImage.push()
                        }
                    }
                }
            }
        }
        stage('Pull Docker Image to GKE') {
            steps {
                withCredentials([gkeCredential(credentialsId: 'gke-creds', registryUrl: '')]) {
                    sh "gcloud container clusters get-credentials <cluster-name> --zone <zone> --project <project-id>"
                    sh "kubectl set image deployment/my-deployment my-container=gcr.io/my-project/my-image:latest"
                }
            }
        }
    }
}