pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        ECR_ACCOUNT_ID = '923687682884'
        ECR_REPO = 'react-app'
        VERSION = "v1.0.${BUILD_NUMBER}"
        IMAGE_NAME = 'react-app'
        ECR_URI = "${ECR_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
        ECR_IMAGE = "${ECR_URI}:${VERSION}"
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
                    echo "🧹 Removing existing image if any"
                    sh "docker rmi -f ${IMAGE_NAME} || true"

                    echo "🐳 Building image: ${IMAGE_NAME}"
                    sh "docker build -t ${IMAGE_NAME} ."

                    echo "🏷️ Tagging with version: ${VERSION}"
                    sh "docker tag ${IMAGE_NAME} ${ECR_IMAGE}"
                }
            }
        }

        stage('Trivy Scan Image') {
            steps {
                script {
                    echo "🔍 Scanning image with Trivy: ${ECR_IMAGE}"
                    sh "trivy image --exit-code 0 --severity HIGH,CRITICAL ${ECR_IMAGE}"
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CREDENTIALS']]) {
                    script {
                        echo "🔐 Logging in to AWS ECR"
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URI}"
                    }
                }
            }
        }

        stage('Push Image to ECR') {
            steps {
                script {
                    echo "🚀 Pushing to ECR: ${ECR_IMAGE}"
                    sh "docker push ${ECR_IMAGE}"
                }
            }
        }
    }
}
