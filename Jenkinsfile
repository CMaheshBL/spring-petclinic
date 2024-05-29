pipeline {
    environment {
        registry = "cmaheshbl/pet-clinic"
        registryCredential = 'dockercred'
        dockerImage = ''
    }
    agent any 
    tools {
        jdk 'jdk17'
        maven 'maven_home'
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
    */
        stage('Building Jar') {
             steps{
                script {
                    try {
                         //Build jar and image file
                         bat './mvnw spring-boot:build-image'
                    } catch (Exception e) {
                        // Handle the error
                        //currentBuild.result = 'FAILURE'
                        echo err.getMessage()
                        echo currentBuild.result
                        //error("Build failed: ${e.message}")
                    }                 
                }
            }
         }
     
        stage('Building Image') {
              steps{
                script {
                  dockerImage = docker.build registry + ":latest"
                }
              }
        }
        
        stage('Deploy Image') {
          steps{
             script {
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
              }
            }
          }
        }
    }
}
