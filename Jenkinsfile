pipeline {
    agent any
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
    }
}