pipeline {
    agent any

    environment {
        RECIPIENT = 'nageswara@logusims.com'

        AWS_REGION = 'ap-south-1'
        ECR_ACCOUNT_ID = '923687682884'
        ECR_REPO = 'react-app'  // Your ECR repo name

        // Use a version tag like v1.0.${BUILD_NUMBER}
        IMAGE_TAG = "v1.0.${env.BUILD_NUMBER}"

        //h Docker image full name with version tag
        IMAGE_NAME = "react-app"
        ECR_IMAGE = "${ECR_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"
    }

    stages {
        stage('Notify Build Start') {
            steps {
                mail to: "${RECIPIENT}",
                     subject: "🚀 Jenkins Build Started: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                     body: """The build has started.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
URL: ${env.BUILD_URL}
"""
            }
        }

        stage('Checkout Code') {
            steps {
               git url: 'https://github.com/eswarvuyyala/react-app.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🔧 Building Docker image: ${IMAGE_NAME}"
                    // Build image with local tag
                    sh "docker build -t ${IMAGE_NAME} ."
                    // Tag with versioned tag for ECR
                    sh "docker tag ${IMAGE_NAME}:latest ${ECR_IMAGE}"
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    echo "🔑 Logging in to AWS ECR"
                    sh """
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    """
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    echo "🚀 Pushing Docker image to ECR: ${ECR_IMAGE}"
                    sh "docker push ${ECR_IMAGE}"
                }
            }
        }

        stage('Notify Build Success') {
            steps {
                mail to: "${RECIPIENT}",
                     subject: "✅ Jenkins Build Succeeded: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                     body: """The build completed successfully.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
URL: ${env.BUILD_URL}
"""
            }
        }
    }

    post {
        failure {
            mail to: "${RECIPIENT}",
                 subject: "❌ Jenkins Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: """The build has failed.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
URL: ${env.BUILD_URL}
"""
        }
    }
}
