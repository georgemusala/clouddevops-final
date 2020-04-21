pipeline {
    agent any
    environment {
        APPNAME = "secretsanta"
        IMAGE_TAG = "${APPNAME}:${env.BUILD_NUMBER}"
        DOCKER_CREDS = credentials('docker-hub-credentials')
    }
    tools { 
        maven 'Maven 3.6.3' 
        jdk 'jdk8' 
    }
    stages {
        stage('Compile') { 
            steps {
                dir("SecretSanta") {
                    sh 'mvn -B clean compile' 
                }
            }
        }
        stage('Build package') { 
            steps {
                dir("SecretSanta") {
                    sh 'mvn -B package' 
                }
            }
        }
        stage('Build image') {
            steps {
                sh """
                docker build -t ${IMAGE_TAG} . 
                docker tag ${IMAGE_TAG} $DOCKER_CREDS_USR/${IMAGE_TAG}
                docker image ls
                """
            }
        }
        stage('Test image') {
            steps {
                sh """
                docker run -p 8080:8080 ${IMAGE_TAG}
                """
            }
        }
        stage('Push image') {
            steps {
                sh """
                docker login --username $DOCKER_CREDS_USR --password $DOCKER_CREDS_PSW
                docker push $DOCKER_CREDS_USR/${IMAGE_TAG}
                """
            }
        }
    }
}