pipeline 
    {agent any 
        stages {
                stage('Checkout') {
                    steps {
                        git 'https://github.com/KristerRistvedt/fooproject.git'
                        
                    }
                    
                }
                stage('Build') {
                    steps {
                        sh "mvn compile"
                        
                    }
                    
                }
                stage('Test') {
                    steps {
                        sh "mvn test"
                        
                    }
                    post {always {junit '**/TEST*.xml'
                        
                    }
                          
                    }
                    
                }
                //stage('newman') {
                    //steps {
                        //sh 'newman run Restful_Booker.postman_collection.json --environment Restful_Booker.postman_environment.json --reporters junit'
                    //}
                        //post {always {junit '**/*xml'
                    //}
                         
                 //}
            //}
            
       stage('Robot Framework System tests with Selenium') {
            steps {
                sh 'robot --variable BROWSER:headlessfirefox -d Results  Tests'
            }
            post {
                always {
                    script {
                          step(
                                [
                                  $class              : 'RobotPublisher',
                                  outputPath          : 'results',
                                  outputFileName      : '**/output.xml',
                                  reportFileName      : '**/report.html',
                                  logFileName         : '**/log.html',
                                  disableArchiveOutput: false,
                                  passThreshold       : 50,
                                  unstableThreshold   : 40,
                                  otherFiles          : "**/*.png,**/*.jpg",
                                ]
                          )
                          chuckNorris()
                    }
                }
            }
        }
    }
    post {
         always {
            junit '**/TEST*.xml'
            emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
            body: 'Bod-DAy!', recipientProviders: [culprits()], subject:
            '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'
         }
    }
    
}
