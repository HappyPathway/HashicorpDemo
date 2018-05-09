pipeline {
  agent any
  stages {
    stage('Deploy Infrastructure') {
      steps {
        sh '''#!/bin/bash

source /etc/profile.d/terraform.sh
terraform init;
terraform apply -f;
'''
      }
    }
  }
}