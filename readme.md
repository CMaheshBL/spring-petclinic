**Task - Build a Pipeline:**

Use Spring pet-clinic (https://github.com/spring-projects/spring-petclinic) as your project source code

Build a Jenkins pipeline with the following steps:

  -  Compile the code
  -  Run the tests
  -  Run XRay Scan
  -  Package the project as a runnable Docker image
  -  Publish the image to JFrog Artifactory in your pipeline
  -  Make sure all dependencies are resolved from Maven Central


**Deliverables:**

The above repo is copied to my account.

GitHub link to the repo including (https://github.com/CMaheshBL/spring-petclinic)

  -  Jenkins file within that repo  - in the above repo
  -  Docker file within that repo - in the above repo
  -  readme.md file explaining the work and how to run the project - in the above repo
  -  Command to obtain and run the docker image
      -  Pull image from JFrog: docker pull chandra2024.jfrog.io/project-docker/pet-clinic:1.0.87
      -  Run docker image and assign local port: docker run -p 8282:8181 chandra2024.jfrog.io/project-docker/pet-clinic:1.0.87
      -  URL to access petclinic application: http://localhost:8282/

**Steps:**

The current testing is done on Windows 11 OS.
  - Register in JFrog cloud https://jfrog.com/start-free/
      - In Artifactory create a repository using pre-built setup - Maven and Docker
  - Have Docker Desktop installed.
  - Ensure Docker Engine is running.
      - If not then go to the folder where docker is installed. cd "C:\Program Files\Docker\Docker\"
      - run this command DockerCli.exe -SwitchDaemon
  - Have Jenkins installed
  - In Jenkins go to Manage Plugins and installed the below plugins
      - Docker plugin
      - Docker pipeline
      - Docker Commons Plugin
      - docker-build-step
      - Artifactory plugin
  - In Manage Plugins --> Tools -> Configure JFrog CLI installations and Docker installations
  - In Manage Plugins --> System -> Configure JFrog - provide Server/Instance ID and use credentials (secret text). In advanced config - provide JFrog Artifactory URL and JFrog Distribution URL and test connection
  - Create new project petClinic-test - select pipeline option. In configuration --> pipeline select "Pipeline from SCM" and Script path as Jenkinsfile
  - Initiate Build
  - After the build is successful use the commands provided above to pull image from JFrog and run the app as container
  
  Troubleshooting
  - If docker engine is not running, ensure docker engine is started and restart jenkins
  - Issue in step Push Image to Artifactory due to npipe - unsupported protocol
    - Open Docker Desktop. Go to Settings and enable "Expose daemon on tcp://localhost:2375 without TLS"
    - Go to C:\ProgramData\docker\config\daemon.json and update the file as given below and restart Docker engine ane jenkins after docker engine is started.
        ```bash
         {
          "experimental": false,
          "hosts": [
        	"npipe:////./pipe/docker_engine_windows",
            "tcp://0.0.0.0:2375"
          ]
        }
        ```
    - In Dockerfile - using openjdk for windows as it was tested and deployed in windows 11 laptop with windows engine. if linux engine use openjdk for linux. The same is commented in the file.





