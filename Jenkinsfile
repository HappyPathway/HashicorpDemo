pipeline {
  agent any
  stages {
    stage('init') {
      parallel {
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
        stage('Validate') {
          steps {
            sh 'terraform validate'
          }
        }
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
  }
}