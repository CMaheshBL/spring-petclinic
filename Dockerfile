# Alpine Linux with OpenJDK JRE
FROM openjdk:8u342-jre-windowsservercore-ltsc2022

RUN apk --no-cache add curl

EXPOSE 8181

# copy jar into image
COPY target/spring-petclinic-*.jar /usr/bin/spring-petclinic.jar

# run application with this command line 
ENTRYPOINT ["java","-jar","/usr/bin/spring-petclinic.jar","--server.port=8181"]
