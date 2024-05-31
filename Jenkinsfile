pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven_home'
        jfrog 'jfrog-cli'
    } 

    stages {

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

        stage("Test Cases"){
            steps{
                bat "mvn test"
            }
        }
     
        stage ('Artifactory Configuration') {
            steps {
                rtMavenResolver (
                    id: 'maven-resolver',
                    serverId: 'chandra-server',
                    releaseRepo: 'jfrog-libs-release',
                    snapshotRepo: 'jfrog-libs-snapshot'
                )  
                 
                rtMavenDeployer (
                    id: 'maven-deployer',
                    serverId: 'chandra-server',
                    releaseRepo: 'jfrog-libs-release-local',
                    snapshotRepo: 'jfrog-libs-snapshot-local',
                    threads: 6,
                    properties: ['BinaryPurpose=Technical-BlogPost', 'Team=DevOps-Acceleration']
                )
            }
        }
       
        stage('Build Maven Project') {
            steps {
                rtMavenRun (
                    tool: 'maven_home',
                    pom: 'pom.xml',
                    goals: '-U clean install',
                    deployerId: "maven-deployer",
                    resolverId: "maven-resolver"
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "chandra-server"
                )
            }
        }

        stage ('Xray Maven Scan') {
            steps {
                xrayScan (
                    serverId: "chandra-server",
                    failBuild: true
                )
            }
        } 

        stage ('Promotion') {
            steps {
                rtPromote (
                    serverId: "chandra-server",
                    targetRepo: 'jfrog-libs-release-local',
                    comment: 'Passed Xray QualityGate',
                    status: 'Released',
                    includeDependencies: false,
                    failFast: true,
                    copy: true
                )
            }
        }

        stage ('Build Docker Image') {
            steps {
                script {
                    docker.build("chandra2024.jfrog.io/project-docker/" + "pet-clinic:1.0.${env.BUILD_NUMBER}")
                }
            }
        }

        stage ('Push Image to Artifactory') {
            steps {
                rtDockerPush(
                    serverId: "chandra-server",
                    image: "chandra2024.jfrog.io/project-docker/" + "pet-clinic:1.0.${env.BUILD_NUMBER}",
                    targetRepo: 'project-docker-local',
                    properties: 'project-name=pet-clinic;status=stable'
                )
            }
        }

        stage ('Publish Build Info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "chandra-server"
                )
            }
        }

        stage ('Xray Docker Image Scan') {
            steps {
                xrayScan (
                    serverId: "chandra-server",
                    failBuild: true
                )
            }
        }  
        
    }
}
