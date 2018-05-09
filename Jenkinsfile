pipeline {
  agent any
  stages {
    stage('Deploy Infrastructure') {
      steps {
        sh '''terraform init
terraform apply'''
      }
    }
  }
}