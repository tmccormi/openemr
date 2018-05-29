pipeline {
  agent any
  stages {
    stage('ShowLog'){
      steps {
        git log --oneline --max-count=10 
      }
    }
    stage('Build') {
      steps { 
        sh 'echo BUILD-ME' 
      }
    }
  }
}
