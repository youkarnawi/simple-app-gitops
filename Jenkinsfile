pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yalkarnawi19/simple-java-app"
        DOCKER_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Build') {
            steps {
                sh '''
                cd /workspace
                docker build --no-cache -t $DOCKER_IMAGE:$DOCKER_TAG .
                '''
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                kubectl set image deployment/simple-java-app simple-java-app=$DOCKER_IMAGE:$DOCKER_TAG --insecure-skip-tls-verify
                '''
            }
        }

    }
}
