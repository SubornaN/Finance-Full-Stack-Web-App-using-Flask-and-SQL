pipeline {
  agent any
   stages {
    stage ('Build') {
      agent{label 'awsDevelop'}
      steps {
        withCredentials([string(credentialsId: 'API_KEY', variable: 'API_KEY')])
        {
          sh '''#!/bin/bash
          python3 -m venv test-env
          source test-env/bin/activate
          pip install pip --upgrade
          pip install -r requirements.txt
          export FLASK_APP=application
          flask run &
          '''
        }
      }
   }
  stage ('dockerHub') {
            agent{label 'awsDevelop'}
            steps {
            withCredentials([string(credentialsId: 'API_KEY', variable: 'API_KEY')])
              {
                sh '''#!/bin/bash
                echo API_KEY=$API_KEY > apikey.txt
                sudo docker build . -t finance_app:v8 --no-cache
                sudo docker tag finance_app:v8 suborna/finance_app:v8
                sudo docker push suborna/web_app:v8
                #sudo docker run --rm -d -p 5000:5000 finance_app:v8
                sudo docker rmi suborna/web_app:v8
                '''
              }
            }
        }  

  }
}
