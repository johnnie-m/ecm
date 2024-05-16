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
            }    
        }
        
        stage ('Fetch secrets') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'vault-2', passwordVariable: 'vltPwd', usernameVariable: 'vltUsr')]) {
                    script {
                        sh '''#!/bin/bash
                        # Fetch vault client token:
                        JSON=$( jq -n \
                            --arg password $vltPwd \
                            '$ARGS.named')
                        C_TOKEN=$(curl "${vltUrl}/v1/auth/userpass/login/${vltUsr}" --data "$JSON" 2</dev/null | jq -r '.auth.client_token')
                        
                        # Fetch secrets & export to env variables
                        export AMQP_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.AMQP_URL')
                        export ELMA365_AMQP_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_AMQP_URL')
                        export AMQP_URL2='asdfgdfsgdf'

                        # Substitute secrets to values.yaml file
                        envsubst < values.yml > values1.yml
                        echo "showing values1.yml"
                        echo "------------------------------------------------------"
                        cat values1.yml
                        echo "------------------------------------------------------"
                        
                        '''
                    }
                }
            }
        }
    }    
}
