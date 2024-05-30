# Windows with OpenJDK JRE
FROM openjdk:23-jdk-windowsservercore

# Alpine Linux with OpenJDK JRE
#FROM openjdk:23-slim-bullseye

EXPOSE 8181

# copy jar into image
COPY target/spring-petclinic-*.jar /usr/bin/spring-petclinic.jar

# run application with this command line 
ENTRYPOINT ["java","-jar","/usr/bin/spring-petclinic.jar","--server.port=8181"]
