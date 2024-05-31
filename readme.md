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

GitHub link to the repo including (https://github.com/CMaheshBL/spring-petclinic)

  -  Jenkins file within that repo  - in the above repo
  -  Docker file within that repo - in the above repo
  -  readme.md file explaining the work and how to run the project - in the above repo
  -  Command to obtain and run the docker image
      -  Pull image from JFrog: docker pull chandra2024.jfrog.io/project-docker/pet-clinic:1.0.87
      -  Run docker image and assign local port: docker run -p 8282:8181 chandra2024.jfrog.io/project-docker/pet-clinic:1.0.87
      -  URL to access petclinic application: http://localhost:8282/


