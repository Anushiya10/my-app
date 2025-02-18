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
          // Build the Docker image
          docker.build("my-java-app:${env.BUILD_ID}")
        }
      }
    }

    stage('Deploy to Docker') {
      steps {
        script {
          // Log in to Docker Hub and push the image
          docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
            // Tag the image with your Docker Hub username and repository name
            sh "docker tag my-java-app:${env.BUILD_ID} /my-java-app:${env.BUILD_ID}"

            // Push the image to Docker Hub
            sh "docker push my-java-app:${env.BUILD_ID}"
          }

          // Stop and remove the existing container (if it exists)
          sh 'docker stop my-java-container || true'
          sh 'docker rm my-java-container || true'

          // Run the new container using the image from Docker Hub
          sh "docker run -d -p 8080:8080 --name my-java-container my-java-app:${env.BUILD_ID}"
        }
      }
    }
  }
}
