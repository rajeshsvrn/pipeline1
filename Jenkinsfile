pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/rajeshsvrn/pipeline1.git']]])
      }
    }
    stage('Build Docker image') {
      steps {
        sh 'docker build -t my-image .'
      }
    }
    stage('Push to GCR') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'my-gcr-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh "docker login -u $USERNAME -p $PASSWORD https://gcr.io"
          sh "docker tag my-image gcr.io/my-project/my-image"
          sh "docker push gcr.io/my-project/my-image"
        }
      }
    }
    stage('Deploy to GKE') {
      steps {
        withCredentials([file(credentialsId: 'my-gke-credentials', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
          sh 'gcloud container clusters get-credentials my-cluster --zone us-central1-a --project my-project'
          sh 'kubectl apply -f kubernetes/deployment.yaml'
        }
      }
    }
  }
}



