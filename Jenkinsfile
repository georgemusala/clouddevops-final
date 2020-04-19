pipeline {
    agent any
    environment {
        APPNAME = "secretsanta"
        IMAGE_TAG = "${APPNAME}:${env.BUILD_NUMBER}"
    }
    tools { 
        maven 'Maven 3.6.3' 
        jdk 'jdk8' 
    }
    stages {
        stage('Build') { 
            steps {
                dir("SecretSanta") {
                    sh 'mvn -B -DskipTests clean package' 
                }
            }
        }
        stage('Build image') {
            steps {
                script {
                    image = docker.build("${IMAGE_TAG}")
                }
            }
        }
    }
}