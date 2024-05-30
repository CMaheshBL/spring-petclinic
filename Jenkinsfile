pipeline {
    environment {
        registry = "cmaheshbl/pet-clinic"
        registryCredential = 'dockercred'
        dockerImage = ''
        BUILD_NUMBER = '1'
    }
    agent any 
    tools {
        jdk 'jdk17'
        maven 'maven_home'
        jfrog 'jfrog-cli'
    } 
    stages{
        
        stage("Git Checkout"){
            steps{
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/CMaheshBL/spring-petclinic.git'
            }
        }
        
        stage("Compile"){
            steps{
                bat "mvn compile"
            }
        }

     /*
        stage("Test Cases"){
            steps{
                bat "mvn test"
            }
        }
    
        stage('Building Jar') {
             steps{
                script {
                    try {
                         //Build jar and image file
                         bat './mvnw spring-boot:build-image'
                    } catch (Exception e) {
                        // Handle the error
                        //currentBuild.result = 'FAILURE'
                        echo "Error Message" + err.getMessage()
                        //echo currentBuild.result
                        //error("Build failed: ${e.message}")
                    }                 
                }
            }
         }
     */
        stage('Building Image') {
              steps{
                script {
                  dockerImage = docker.build registry + ":latest"
                }
              }
        }
   /*     
        stage('Deploy Image') {
          steps{
             script {
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
              }
            }
          }
        }
    */
        stage ('Push Image to JFrog Artifactory') {
            steps {
               // jf 'docker push cmaheshbl/pet-clinic:latest'
                
                 rtDockerPush(
                    serverId: "chandra2024",
                    image: "chandra2024.jfrog.io/docker/" + dockerImage,
                    targetRepo: 'release-docker-local',
                    properties: 'project-name=jfrog-blog-post;status=stable'
                )
              
            }
        }
    }
}
