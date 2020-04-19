  
FROM openjdk:8-jdk

## Step 1:
# Deploy war to tomcat
COPY SecretSanta/target/secret-santa.war /usr/local/opt/tomcat/webapps

## Step 2:
# Expose port 80
EXPOSE 80

## Step 3:
# Change dir
WORKDIR /usr/local/opt/tomcat/bin

## Step 3:
# Start Tomcat server
CMD ["/startup.sh"]