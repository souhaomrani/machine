pipeline {
  agent any

  stages {
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
      // Nettoyer Terraform après l'exécution
      script {
        sh 'terraform destroy -auto-approve'
      }
    }
  }
}


      
