pipeline {
  agent any
  environment {
     DOCKER_PASSWORD=credentials('docker-username')
     DOCKER_USERNAME=credentials('docker-password')
  }
  stages {
    stage('Docker Login') {
       
      steps {
        sh ('docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD')
      }
    }   
     stage('Delete image') {
       
      steps {
        sh "chmod -R 777 ./delete-old-image.sh"
        sh ('./delete-old-image.sh $DOCKER_USERNAME $DOCKER_PASSWORD $DOCKER_REPOSITORY $DAYS_AGO')
      }
    }   
   }
}
