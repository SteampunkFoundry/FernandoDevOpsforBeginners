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
                    def dockerImage = docker.image('fernandosteampunkproject:latest')
                    if (!dockerImage.exists()) {
                        dockerImage = docker.build("fernandosteampunkproject:latest")
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
                    docker.withRegistry('https://registry.hub.docker.com', 'DockerCred') {
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
                    docker login -u fquezado -p kappa-doc-Dunca1! https://registry.hub.docker.com
                    docker pull fernandosteampunkproject:latest
                    docker run -d -p 80:80 --name fernandosteampunkproject fernandosteampunkproject:latest
                    EOF
                    """
                }
            }
        }
    }
}