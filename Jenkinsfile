pipeline {
  agent any
   stages {

    stage('Init') {
            agent{label 'TerraformAgent'}
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                    string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key'),
                    string(credentialsId: 'MYSQL_USERNAME', variable: 'rds_username'),
                    string(credentialsId: 'MYSQL_PASSWORD', variable: 'rds_password'),
                    ]) {
                        dir('Terraform') {
                            sh 'terraform init' 
                        }
                    }
            }
        }
        stage('Plan') {
            agent{label 'TerraformAgent'}
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                    string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key'),
                    string(credentialsId: 'MYSQL_USERNAME', variable: 'rds_username'),
                    string(credentialsId: 'MYSQL_PASSWORD', variable: 'rds_password'),
                    ]) {
                        dir('Terraform') {
                            sh 'terraform plan -out plan.tfplan -var="aws_access_key=$aws_access_key" -var="aws_secret_key=$aws_secret_key" -var="rds_username=$rds_username" -var="rds_password=$rds_password"' 
                        }
                    }
            }
        }
        stage('Apply') {
            agent{label 'TerraformAgent'}
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                    string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key'),
                    string(credentialsId: 'MYSQL_USERNAME', variable: 'rds_username'),
                    string(credentialsId: 'MYSQL_PASSWORD', variable: 'rds_password'),
                    ]) {
                        dir('Terraform') {
                            sh 'terraform apply plan.tfplan' 
                        }
                    }
            }
        }
        stage('Destroy') {
            agent{label 'TerraformAgent'}
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                    string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key'),
                    string(credentialsId: 'MYSQL_USERNAME', variable: 'rds_username'),
                    string(credentialsId: 'MYSQL_PASSWORD', variable: 'rds_password'),
                    ]) {
                        dir('intTerraform') {
                            sh 'terraform destroy -auto-approve'
                        }
                    }
            }
        }  
  }
}
