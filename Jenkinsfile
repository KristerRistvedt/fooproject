pipeline 
    {agent any 
        stages {
                stage('Checkout') {
                    steps {
                        git 'https://github.com/KristerRistvedt/fooproject.git'
                        
                    }
                    
                }
                stage('Build Maven Project(compile)') {
                    steps {
                        sh "mvn compile"
                        
                    }
                    
                }
                stage('Test Maven Project') {
                    steps {
                        sh "mvn test"
                        
                    }
                    post {always {junit '**/TEST*.xml'
                        
                    }
                          
                    }
                    
                }
                stage('newman: Postman cmd to run Postman tests') {
                    steps {
                        sh 'newman run Restful_Booker_Copy.postman_collection.json -e Restful_Booker.postman_environment.json --reporters junit'
                    }
                        post {always {junit '**/*xml'
                    }
                         
                 }
            }
            
       stage('Robot Framework System tests with Selenium on pycharm project') {
            steps {
                sh 'robot --variable BROWSER:headlessfirefox -d ./Tests/infotiv.robot'
            }
            post {
                always {
                    script {
                          step(
                                [
                                  $class              : 'RobotPublisher',
                                  outputPath          : 'Results',
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
