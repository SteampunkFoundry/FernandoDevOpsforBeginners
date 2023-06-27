pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                // Your testing steps go here
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
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
                    docker login -u fquezado -p kappa-doc-Dunca1! https://hub.docker.com
                    docker pull fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}
                    docker stop fernandosteampunkproject || true
                    docker rm fernandosteampunkproject || true
                    docker run -d -p 80:80 --name fernandosteampunkproject fquezado/fernandosteampunkproject:${env.BUILD_NUMBER}
                    EOF
                    """
                }
            }
        }
    }
}
