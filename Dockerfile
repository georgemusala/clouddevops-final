  
FROM openjdk:8-jdk

## Step 1:
# Create tomcat dir
WORKDIR /opt/tomcat

## Step 2:
# Install tomcat
RUN curl -O http://mirror.evowise.com/apache/tomcat/tomcat-8/v8.5.54/bin/apache-tomcat-8.5.54.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.54/* /opt/tomcat/.

## Step 3:
# Deploy war to tomcat
COPY SecretSanta/target/secret-santa.war /opt/tomcat/webapps

## Step 4:
# Expose port 8080
EXPOSE 8080

## Step 5:
# Start Tomcat server
CMD ["/opt/tomcat/bin/catalina.sh","run"]