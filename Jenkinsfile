pipeline {
  agent any
  stages {
    stage('Deploy Infrastructure') {
      steps {
        sh '''source /etc/profile.d/terraform.sh

terraform init;

terraform apply;

'''
      }
    }
  }
}