pipeline {
    agent any

    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    def dockerImage = docker.build("fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}")

                    // Push the Docker image to the repository
                    docker.withRegistry('https://hub.docker.com', 'DockerCred') {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
