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
terraform init;'''
      }
    }
    stage('Test') {
      steps {
        sh 'terraform validate'
      }
    }
    stage('refresh') {
      steps {
        sh 'terraform workspace select staging'
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
terraform refresh;'''
        sh 'source environments/staging'
      }
    }
    stage('plan') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
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
terraform apply -auto-approve;'''
      }
    }
    stage('destroy') {
      steps {
        sh '''#!/bin/bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
source /etc/profile.d/terraform.sh
terraform destroy -force;'''
        input(message: 'Should we Destroy ?', id: 'go')
      }
    }
  }
}