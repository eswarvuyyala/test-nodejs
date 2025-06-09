stages {

    stage('Notify Build Start') {
        steps {
            mail(
                to: "${RECIPIENT}",
                subject: "🚀 Jenkins Build Started: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """The build has started.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
URL: ${env.BUILD_URL}
"""
            )
        }
    }

    stage('Checkout Code') {
        steps {
            git url: 'https://github.com/eswarvuyyala/nodejs.git', branch: 'main'
        }
    }

}
