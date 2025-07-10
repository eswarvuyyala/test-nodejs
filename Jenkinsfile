pipeline {
    agent any

    environment {
        IMAGE_NAME = 'react-app'
        GIT_REPO = 'https://github.com/eswarvuyyala/react-app.git'
        GIT_BRANCH = 'main'
    }

    stages {
        stage('Clone Git Repo') {
            steps {
                git url: "${GIT_REPO}", branch: "${GIT_BRANCH}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🧹 Checking for existing Docker image: ${IMAGE_NAME}"
                    sh "docker rmi -f ${IMAGE_NAME} || true"

                    echo "🐳 Building Docker image: ${IMAGE_NAME}"
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }
    }
}
