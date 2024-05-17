pipeline {

    agent {label 'jnk-02.test'
    }

    environment {
    vltUrl='192.168.0.50:8200'
    ENV='TEST'
    }

    stages {

        stage ('Clone git repo') {
            steps {
                git branch: 'main', url: 'https://github.com/johnnie-m/ecm.git', credentialsId: 'jm-git'
            }
        }

        stage ('Fetch secrets') {
            steps {
                withCredentials ([
                    file(credentialsId: 'envs_vault_creds', variable: 'CREDS')]) {
                    sh '''#!/bin/bash
                    source $CREDS
                    envUrl=${ENV}_URL; vltUrl=${!envUrl}; echo $vltUrl
                    envUsr=${ENV}_USER; vltUsr=${!envUsr}; echo $vltUsr
                    envPwd=${ENV}_PASS; vltPwd=${!envPwd}; echo $vltPwd
                    '''
                }

                script {
                    sh "chmod +x ./script.sh"
                    sh "./script.sh"
                }
            }
        }
    }
}
