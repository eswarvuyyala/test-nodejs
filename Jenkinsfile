pipeline {
    agent any

    environment {
        RECIPIENT = 'nageswara@logusims.com'
        IMAGE_NAME = 'nginx-app'
        IMAGE_TAG = 'V1.0.0'
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
               git url: 'https://github.com/eswarvuyyala/nginx-app.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🔧 Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                script {
                    echo "🔍 Running Trivy scan..."
                    sh "trivy image --format table --output trivy-report.txt ${IMAGE_NAME}:${IMAGE_TAG}"
                    archiveArtifacts artifacts: 'trivy-report.txt'
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

        stage('Send Trivy Scan Report') {
            steps {
                emailext(
                    to: "${RECIPIENT}",
                    subject: "🔍 Trivy Scan Report for ${IMAGE_NAME}:${IMAGE_TAG}",
                    body: "Please find attached the Trivy vulnerability scan report.",
                    attachmentsPattern: 'trivy-report.txt'
                )
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
