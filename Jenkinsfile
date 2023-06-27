pipeline {
    agent {docker 'image'}

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
                    docker.withRegistry('https://hub.docker.com', 'DockerCred') {
                        dockerImage = docker.image("fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}") // Assign the built image to the variable
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@ec2-44-204-250-147.compute-1.amazonaws.com << EOF
                    echo 'Logging in to Docker registry...'
                    docker login -u fquezado -p kappa-doc-Dunca1! https://hub.docker.com
                    echo 'Pulling Docker image...'
                    docker pull fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}
                    echo 'Stopping existing container...'
                    docker stop fernandosteampunkproject || true
                    echo 'Removing existing container...'
                    docker rm fernandosteampunkproject || true
                    echo 'Running Docker container...'
                    docker run -d -p 80:80 --name fernandosteampunkproject fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}
                    EOF
                    """
                }
            }
        }
    }
}
