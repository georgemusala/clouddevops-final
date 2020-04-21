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
                echo "Cleaning up all images and containers"
                docker stop \$(docker ps -a -q) || true && docker rm \$(docker ps -a -q) || true
                docker system prune -a -f
                docker build -t ${IMAGE_TAG} . 
                docker tag ${IMAGE_TAG} $DOCKER_CREDS_USR/${IMAGE_TAG}
                docker image ls
                """
            }
        }
        stage('Health check') {
            steps {
                sh """
                docker run -d -p 8080:8080 ${IMAGE_TAG}
                count=0
                while true; do
                    count=\$(expr \$count + 1)
                    if curl -m 10 -s -o /dev/null "http://localhost:8080/secret-santa/"; then
                        echo "Webapp is alive"
                        break;
                    fi

                    if [ "\$count" -gt 30 ]; then
                        echo 'Webapp did not respond'
                        exit 1
                    fi
                    echo "Webapp is not ready, wait 5 seconds..."
                    sleep 5
                done
                """
            }
        }
        stage('Push image') {
            steps {
                sh """
                docker login --username $DOCKER_CREDS_USR --password $DOCKER_CREDS_PSW
                docker push $DOCKER_CREDS_USR/${IMAGE_TAG}
                echo "Cleaning up all images and containers"
                docker stop \$(docker ps -a -q) || true && docker rm \$(docker ps -a -q) || true
                docker system prune -a -f
                """
            }
        }
    }
}