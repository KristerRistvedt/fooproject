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
                stage('newman') {
                    steps {
                        sh 'newman run Restful_Booker.postman_collection.json --environment Restful_Booker.postman_environment.json -r junitfull --reporter-junitfull-export -n 2'

                    }
                    post {always {junit '**/newman*.xml'}
                }
            }
            
        }
    }
