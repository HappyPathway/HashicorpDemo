pipeline {
  agent any
  stages {
    stage('init') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
terraform init;'''
        input(message: 'Whats the plan?', id: 'plan')
      }
    }
    stage('refresh') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
terraform refresh;'''
      }
    }
    stage('apply') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
terraform apply -auto-approve;
'''
      }
    }
  }
}