pipeline {
  agent any
  environment {
     DOCKER_PASSWORD=credentials('docker-username')
     DOCKER_USERNAME=credentials('docker-password')
  }
  stages {

     stage('Variable') {
      steps {
        sh 'chmod -R 777 ./delete-old-image.sh'
        sh ('./delete-old-image.sh $DOCKER_USERNAME $DOCKER_PASSWORD $DOCKER_REPOSITORY $DAYS_AGO')
      }
    }   
   }
}
