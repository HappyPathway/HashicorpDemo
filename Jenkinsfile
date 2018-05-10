pipeline {
  agent any
  stages {
    stage('init') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
rm -rf .terraform;
terraform init -upgrade;'''
      }
    }
    stage('Test') {
      steps {
        sh '''#!/bin/bash
source environments/staging
terraform workspace select staging
terraform validate'''
      }
    }
    stage('refresh') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
source environments/staging
terraform refresh;'''
      }
    }
    stage('plan') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
source environments/staging
terraform plan;
'''
        input(message: 'All Systems Go?', id: 'go')
      }
    }
    stage('apply') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
source environments/staging
terraform apply -auto-approve;'''
      }
    }
    stage('destroy') {
      steps {
        input(message: 'Should we Destroy ?', id: 'go')
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
source environments/staging
terraform destroy -force;'''
      }
    }
  }
}