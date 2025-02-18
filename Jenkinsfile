pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/Anushiya10/docker-project.git'
      }
    }

    stage('Build with Maven') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("my-java-app:${env.BUILD_ID}")
        }
      }
    }

    stage('Deploy to Docker') {
      steps {
        script {
          docker.withRegistry('', 'docker-hub-credentials') {
            docker.image("my-java-app:${env.BUILD_ID}").push()
          }
          sh 'docker stop my-java-container || true'
          sh 'docker rm my-java-container || true'
          sh "docker run -d -p 8080:8080 --name my-java-container my-java-app:${env.BUILD_ID}"
        }
      }
    }
  }
}
