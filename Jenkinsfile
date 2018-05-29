pipeline {
  agent any
  stages {
    stage('ShowLog'){
      steps {
        sh 'git log --oneline --max-count=10' 
      }
    }
    stage('Build') {
      steps { 
        sh 'echo BUILD-ME' 
      }
    }
  }
}
