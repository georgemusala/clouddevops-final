pipeline {
    agent any
    environment {
        APPNAME = "secretsanta"
        IMAGE_TAG = "${APPNAME}:${env.BUILD_NUMBER}"
        DOCKER_CREDS = credentials('docker-hub-credentials')
        AWS_REGION = 'us-west-2'
        AWS_CREDENTIALS = "udacity"
        EKS_CLUSTER = "EKS-3UPGZ8SI"
    }
    tools { 
        maven 'Maven 3.6.3' 
        jdk 'jdk8' 
    }
    stages {
        stage('Lint code') { 
            steps {
                dir("SecretSanta") {
                    sh 'coala --files="src/**/*.java" --bears=SpaceConsistencyBear --non-interactive -S cli.use_spaces=false --save' 
                }
            }
        }
        stage('Build package') { 
            steps {
                dir("SecretSanta") {
                    sh 'mvn -B clean package' 
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
        stage('Test image') {
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
        stage('Config Env') {
          steps {
            withAWS(credentials: "${AWS_CREDENTIALS}", region: "${AWS_REGION}") {
              sh """
                aws eks --region eu-west-2 update-kubeconfig --name ${EKS_CLUSTER} --kubeconfig ~/kubeconfig
                current_role="\$(kubectl get services --kubeconfig ~/kubeconfig ${APPNAME}-service --output json | jq -r .spec.selector.role)"
                if [ "\$current_role" = null ]; then
                    echo "Unable to determine current environment"
                    exit 1
                fi
                echo "\$current_role" >current-env
              """  
            }
            script {
              currentEnv = readFile('current-env').trim()
              newEnv = currentEnv == 'blue' ? 'green' : 'blue'
              echo "Old environment: $currentEnv, New environment: ${newEnv}"

              currentBuild.displayName = newEnv + ' ' + IMAGE_TAG

              env.TARGET_ENV = newEnv
            }  

            withAWS(credentials: "${AWS_CREDENTIALS}", region: "${AWS_REGION}") {
              sh """
              kubectl --kubeconfig ~/kubeconfig delete --ignore-not-found deployment "${APPNAME}-deployment-\$TARGET_ENV"
              """ 
            }   
          }
        }
        stage('Deploy New Image') {
            steps {
                dir("infrastructure/k8s") {
                    withAWS(credentials: "${AWS_CREDENTIALS}", region: "${AWS_REGION}") {
                        script {
                            sh "envsubst < deployment.yml | kubectl --kubeconfig ~/kubeconfig apply -f -"
                            sh "envsubst < service-test.yml | kubectl --kubeconfig ~/kubeconfig apply -f -" 
                        }
                    }
                }
            }
        }
        stage('Test New Environment') {
            environment {
                service = "${APPNAME}-test-${newEnvironment}"
            }
            steps {
                withAWS(credentials: "${AWS_CREDENTIALS}", region: "${AWS_REGION}") {
                    sh """
                    count=0
                    while true; do
                        endpoint_ip="\$(kubectl get services '${service}' --kubeconfig ~/kubeconfig --output json | jq -r '.status.loadBalancer.ingress[0].hostname')"
                        count=\$(expr \$count + 1)
                        if curl -m 10 "http://\$endpoint_ip"; then
                            break;
                        fi
                        if [ "\$count" -gt 30 ]; then
                            echo 'Service failed'
                            exit 1
                        fi
                        echo "Service endpoint is not ready, waiting 5 seconds..."
                        sleep 5
                    done
                  """
                }
            }
        }
        stage('Swap envs') {
            steps {
                dir("infrastructure/k8s") {
                    withAWS(credentials: "${AWS_CREDENTIALS}", region: "${AWS_REGION}") {
                        script {
                            sh "envsubst < service.yml | kubectl --kubeconfig ~/kubeconfig apply -f -"
                        }
                    }
                }  
            }
        }  
    }
}