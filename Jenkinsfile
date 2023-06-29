pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Your testing steps go here
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    // Build the Docker image
                    def dockerImage = docker.build("fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image...'
                    def dockerImage // Define the dockerImage variable at the top level
                    docker.withRegistry('https://registry.hub.docker.com', 'DockerCredentials') {
                        dockerImage = docker.image("fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}")
                        // Assign the built image to the variable
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'DockerCredentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh"""
                        echo 'Logging in to Docker registry...'
                        echo "$DOCKER_PASSWORD" | docker login -u $DOCKER_USERNAME --password-stdin docker.io
                        echo 'Pulling Docker image...'
                        docker pull fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}
                        echo 'Stopping existing container...'
                        docker stop fernandosteampunkproject || true
                        echo 'Removing existing container...'
                        docker rm fernandosteampunkproject || true
                        echo 'Running Docker container...'
                        docker run -d -p 80:80 --name fernandosteampunkproject fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}
                        """
                    }
                }
            }
        }
    }
}
