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

      stage('Building Image') {
              steps{
                script {
                  bat './mvnw spring-boot:build-image'
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
   
       /* stage("Docker Build & Push"){
            steps{
                script{
                        bat './mvnw spring-boot:build-image'
                        dockerImage = docker.build registry + ":latest"
                        docker.withRegistry( '', registryCredential ) {
                           dockerImage.push()
                        }
                        //withDockerRegistry(credentialsId: 'dockercred', toolName: 'docker') {
                            // bat "docker build -t cmaheshbl/pet-clinic ."
                            // bat "docker tag cmaheshbl/pet-clinic cmaheshbl/pet-clinic:latest "
                            // bat "docker push cmaheshbl/pet-clinic:latest "
                    
                    //}
                }
            }
        }
    */
    }
}
