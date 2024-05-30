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
                bat "mvn clean compile"
            }
        }
        
        stage ('Artifactory Configuration') {
            steps {
                rtMavenResolver (
                    id: 'maven-resolver',
                    serverId: 'chandra-server',
                    releaseRepo: 'libs-release',
                    snapshotRepo: 'libs-snapshot'
                )  
                 
                rtMavenDeployer (
                    id: 'maven-deployer',
                    serverId: 'chandra-server',
                    releaseRepo: 'libs-release-local',
                    snapshotRepo: 'libs-snapshot-local',
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
                    targetRepo: 'libs-release-local',
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
                    docker.build("chandra2024.jfrog.io/docker/" + "pet-clinic:1.0.${env.BUILD_NUMBER}")
                }
            }
        }

        stage ('Push Image to Artifactory') {
            steps {
                rtDockerPush(
                    serverId: "chandra-server",
                    image: "chandra2024.jfrog.io/docker/" + "pet-clinic:1.0.${env.BUILD_NUMBER}",
                    targetRepo: 'docker',
                    properties: 'project-name=jfrog-blog-post;status=stable'
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
        /*
        stage ('Setup JFrog CLI') {
            steps {
                withCredentials([[$class:'UsernamePasswordMultiBinding', credentialsId: 'admin.jfrog', usernameVariable:'ARTIFACTORY_USER', passwordVariable:'ARTIFACTORY_PASS']]) {
                     sh '''
                        ./jfrog rt config --url=https://chandra2024.jfrog.io/artifactory --dist-url=https://chandra2024.jfrog.io/distribution --interactive=false --user=${ARTIFACTORY_USER} --password=${ARTIFACTORY_PASS}
                        ./jfrog rt ping
                     '''
                 }
            }
        }  

        stage ('Create & Sign Release Bundle') {
            steps {
                 sh '''
                    ./jfrog rt rbc --sign EU-LISA-RB 1.0.0 "*.tgz"
                 '''
            }
        }

        //Optional stage - trigger the export process, so all that's left is downloading the Release Bundle
        
        stage ('Export Release Bundle') {
            steps {
                withCredentials([[$class:'UsernamePasswordMultiBinding', credentialsId: 'admin.jfrog', usernameVariable:'ARTIFACTORY_USER', passwordVariable:'ARTIFACTORY_PASS']]) {
                     sh '''
                        curl -XPOST 'https://talyi.jfrog.io/distribution/api/v1/export/release_bundle/EU-LISA-RB/1.0.0' -u${ARTIFACTORY_USER}:${ARTIFACTORY_PASS}
                     '''
                 }
            }
        }
        */
    }
}
