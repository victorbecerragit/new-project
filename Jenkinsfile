pipeline {
agent any
    stages {
        stage('Clone API Builder project') {
            steps {
                git "${params.project_repo}"
            }
        }
        stage('Build Docker image') {
            steps{
                script {
                image = docker.build params.docker_repo + ":${params.tag_id}"
                }
            }
        }
        stage('Push Docker Image') {
            steps{
                script {
                docker.withRegistry( 'https://registry.hub.docker.com', 'docker-hub-credentials') {
                image.push()
                }
                }
            }
        }
        stage('Run Docker Container') {
            steps{
            sh "ssh ${params.deploy_user}@${params.deploy_ip} docker run -d --name myproject -p 888:80 $docker_repo:$tag_id"
            sh "ssh ${params.deploy_user}@${params.deploy_ip} docker ps"
            }
        }
        stage('Clean up') {
            steps{
            sh "docker rmi ${params.docker_repo}:${params.tag_id}"
            deleteDir()
            }
        }
    }
}
