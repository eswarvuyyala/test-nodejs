pipeline {
    agent any

    environment {
        SONAR_HOST_URL = 'http://13.201.203.112:9000'
    }

    stages {
        stage('Clone Git Repo') {
            steps {
                git url: 'https://github.com/eswarvuyyala/react-app.git', branch: 'main'
            }
        }

        stage('SonarQube Scan') {
            steps {
                withCredentials([string(credentialsId: 'Sonar-token-scanning-test', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        sonar-scanner \
                          -Dsonar.projectKey=react-app \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=$SONAR_HOST_URL \
                          -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }
    }
}
