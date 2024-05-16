pipeline {

    agent {label 'jnk-02.test'
    }

    environment {
    vltUrl='192.168.0.50:8200'
    }

    stages {

        stage ('Clone git repo') {
            steps {
                git branch: 'main', url: 'https://github.com/johnnie-m/ecm.git', credentialsId: 'jm_git'
                withCredentials([usernamePassword(credentialsId: 'vault-2', passwordVariable: 'vltPwd', usernameVariable: 'vltUsr')]) {
                    sh "sudo ./fetch_vault_secrets.sh"
                }
            }
        }
    }
}
