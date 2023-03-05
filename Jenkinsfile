pipeline {
  agent any
  environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('steam-glass-377712-e31899b0be73.json')
        // Replace 'gcr-service-account-key' with the ID of your Jenkins credentials containing the service account key JSON file.
    }
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
        steps {
                sh 'docker build -t gcr.io/steam-glass-377712/my-image .'
                sh 'docker push gcr.io/steam-glass-377712/my-image'
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

}



