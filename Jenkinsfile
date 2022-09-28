pipeline {
  agent any
  environment {
     DOCKER_PASSWORD=credentials('docker-username')
     DOCKER_USERNAME=credentials('docker-password')
  }
  stages {  
     stage('Delete image') {
       
      steps {
        sh "chmod -R 777 ./delete-old-image.sh"
        sh ('./delete-old-image.sh ahmetsaz 19051995Gs* $DOCKER_REPOSITORY $DAYS_AGO')
      }
    }   
   }
}
