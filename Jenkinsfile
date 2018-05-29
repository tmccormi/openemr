pipeline {
  agent any
  stages {
    stage('ShowLog'){
      steps {
        sh 'git log --oneline origin..HEAD' 
      }
    }
    stage('Build') {
      steps { 
        sh 'echo NO BUILD' 
      }
    }
  }
}
