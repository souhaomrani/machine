pipeline {
  agent any

  stages {
    stage('Clone Repository') {
      steps {
        script {
          // Cloner le dépôt GitHub
          git 'https://github.com/souhaomrani/machine.git'
        }
      }
    }

    stage('Terraform Init') {
      steps {
        script {
          // Initialiser Terraform
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        script {
          // Appliquer les changements Terraform
          sh 'terraform apply -auto-approve'
        }
      }
    }
  }

  post {
    always {
      // Nettoyer Terraform après l'exécution (détruire les ressources)
      script {
        sh 'terraform destroy -auto-approve'
      }
    }
  }
}
