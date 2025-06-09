
 stages {

        stage('Notify Build Start') {
            steps {
                mail to: "${RECIPIENT}",
                     subject: "🚀 Jenkins Build Started: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                     body: "The build has started.\n\nJob: ${env.JOB_NAME}\nBuild: #${env.BUILD_NUMBER}\nURL: ${env.BUILD_URL}"
            }
        }

        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/eswarvuyyala/nodejs.git', branch: 'main'
            }
        }
