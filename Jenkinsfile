pipeline {
  agent any
  stages {
    stage('Deploy Infrastructure') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
terraform init;
terraform apply -auto-approve;
'''
        input(message: 'Whats the plan?', id: 'plan')
      }
    }
  }
}