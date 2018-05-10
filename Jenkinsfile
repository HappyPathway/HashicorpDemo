pipeline {
  agent any
  stages {
    stage('Build Image') {
      steps {
        sh '''#!/bin/bash
source /etc/profile.d/terraform.sh
./build/scripts/build.py'''
      }
    }
    stage('Test') {
      steps {
        sh 'terraform validate'
      }
    }
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
    stage('Promote') {
      steps {
        sh 'promoting...'
        input(message: 'Should we promote ?', id: 'go')
      }
    }
  }
}