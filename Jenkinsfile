pipeline {
  agent any
  environment {
     DOCKER_PASSWORD=credentials('docker-password')
     DOCKER_USERNAME=credentials('docker-username')
  }
  stages {  
     stage('Delete image') {
       
      steps {
        sh "chmod -R 777 ./delete-old-image.sh"
        sh ('./delete-old-image.sh $DOCKER_USERNAME $DOCKER_PASSWORD $DOCKER_REPOSITORY $DAYS_AGO')
      }
    }   
   }
}
