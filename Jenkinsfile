pipeline {
  agent any
   stages {
    stage ('Develop') {
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
          flask run --host=0.0.0.0
          '''
        }
      }
   }
  }
}
