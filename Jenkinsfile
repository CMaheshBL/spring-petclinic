pipeline {
    agent any
    stages {
        stage('source code'){
            steps {
               git url: 'https://github.com/Moez786/spring-petclinic.git',
               branch: 'REL_INT_1.0'
            }
        }
        stage('build'){
            steps {
                sh '/opt/apache-maven-3.8.6/mvn package'
            }
        }
        stage('Junit Results'){
            steps {
                junit '**/surefire-reports/*.xml'
                } 
            }   
    
        }

    }