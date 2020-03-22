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
                        sh 'newman run Restful_Booker.postman_collection.json --environment Restful_Booker.postman_environment.json --reporters junit'
                        sh 'return 0'
                    }
                    post {always {junit '**/*.xml'}
                }
            }
                //stage('If success then exit 0') {
                    //steps {
                        //sh 'exit 0'
                    //}
                //}
            
        }
    }
