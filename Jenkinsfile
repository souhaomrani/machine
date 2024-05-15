pipeline {
  agent any

  stages {
    stage('Clone Repository') {
      steps {
        // Étape pour cloner le dépôt Git
        git 'https://github.com/souhaomrani/machine.git'
      }
    }

    stage('Terraform Init') {
      steps {
        // Étape pour initialiser Terraform
        script {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        // Étape pour appliquer les changements Terraform
        script {
          sh 'terraform apply -auto-approve'
        }
      }
    }
  }

  post {
    always {
      // Étape pour nettoyer les ressources Terraform après exécution
      script {
        sh 'terraform destroy -auto-approve'
      }
    }
  }
}
