pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        ECR_ACCOUNT_ID = '923687682884'
        ECR_REPO = 'react-app'   // Your ECR repo name
        VERSION = "v1.0.${BUILD_NUMBER}"  // Auto-incremented version tag
        IMAGE_NAME = 'react-app'
        ECR_IMAGE = "${ECR_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${VERSION}"
        GIT_REPO = 'https://github.com/eswarvuyyala/react-app.git'
    }

    stages {
        stage('Clone Git Repo') {
            steps {
                git url: "${GIT_REPO}", branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🧹 Removing existing Docker image if exists"
                    sh "docker rmi -f ${IMAGE_NAME} || true"

                    echo "🐳 Building Docker image: ${IMAGE_NAME}"
                    sh "docker build -t ${IMAGE_NAME} ."

                    echo "🏷️ Tagging image with version: ${VERSION}"
                    sh "docker tag ${IMAGE_NAME} ${ECR_IMAGE}"
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CREDENTIALS']]) {
                    script {
                        echo "🔐 Logging into AWS ECR"
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                    }
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    echo "🚀 Pushing image to ECR: ${ECR_IMAGE}"
                    sh "docker push ${ECR_IMAGE}"
                }
            }
        }
    }
}
