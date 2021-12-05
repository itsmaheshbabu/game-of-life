pipeline{
    agent any
    stages{
        stage('scm'){
            steps{
                git 'https://github.com/itsmaheshbabu/game-of-life.git'
            }
        }
        stage('mvn build'){
            steps{
                sh 'mvn package'
            }
        }
        stage('docker image'){
            steps{
                sh 'docker image build -t 10.160.0.4:8084/golproject:1.0 .' 
            }
           
        }
        stage('docker image push'){
            steps{
                withCredentials([string(credentialsId: 'private_repo', variable: 'private_repo')]) {
                    sh 'docker login -u admin -p ${private_repo} 10.160.0.4:8084'
                }
                sh 'docker push 10.160.0.4:8084/golproject:1.0'
            }
        }
        // remove local image from jenkins server
        stage('remove local image'){
            steps{
                sh 'docker rmi -f 10.160.0.4:8084/golproject:1.0'
            }
        }
        stage('deploy application in docker swarm'){
            steps{
                sshagent(['docker_swarm_Manager']) {
                    withCredentials([string(credentialsId: 'private_repo', variable: 'private_repo')]) {
                        
                        sh "ssh -o StrictHostKeyChecking=no mahesh@10.160.0.8 docker login -u admin -p ${private_repo} 10.160.0.4:8084" 
                    }
                    sh "ssh -o StrictHostKeyChecking=no mahesh@10.160.0.8 docker service rm golproject || true"
                    sh "ssh -o StrictHostKeyChecking=no mahesh@10.160.0.8 docker service create --name golproject -p 32001:8080 --replicas 2 --with-registry-auth 10.160.0.4:8084/golproject:1.0"
                }
            }
        }
    }
}