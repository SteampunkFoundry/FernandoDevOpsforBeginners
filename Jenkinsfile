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
                    // Check if the Docker image already exists
                    def dockerImage = docker.image('fquezado/fernandosteampunkproject:latest')
                    if (!dockerImage.exists()) {
                        dockerImage = docker.build("fquezado/fernandosteampunkproject:latest")
                    } else {
                        // The image already exists, skip building
                        echo "Docker image already exists. Skipping build..."
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def dockerImage // Define the dockerImage variable at the top level
                    docker.withRegistry('https://hub.docker.com', 'DockerCred') {
                        dockerImage = docker.image('fquezado/fernandosteampunkproject:latest') // Assign the existing image to the variable
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
                    docker pull fquezado/fernandosteampunkproject:latest
                    docker run -d -p 80:80 --name fernandosteampunkproject fquezado/fernandosteampunkproject:latest
                    EOF
                    """
                }
            }
        }
    }
}
