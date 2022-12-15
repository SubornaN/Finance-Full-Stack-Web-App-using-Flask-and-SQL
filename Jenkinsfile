pipeline {
  agent{label 'awsDevelop'}
   stages {
    stage ('Develop') {
      steps {
        sh '''#!/bin/bash
        python3 -m venv test-env
        source test-env/bin/activate
        pip install pip --upgrade
        pip install -r requirements.txt
        export FLASK_APP=application
        flask run &
        sleep 30
        '''
     }
   }
}