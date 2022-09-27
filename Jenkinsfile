pipeline {
  agent any
  environment {
     DOCKER_PASSWORD=credentials('docker-password')
     DOCKER_USERNAME=credentials('docker-password')
  }
  stages {

     stage('Variable') {
      steps {
        sh './delete-old-image.sh $DOCKER_USERNAME $DOCKER_PASSWORD $DOCKER_REPOSITORY $DAYS_AGO'
      }
    }   
   }
}
