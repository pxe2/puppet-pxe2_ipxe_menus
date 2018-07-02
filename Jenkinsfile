def SUFFIX = ''

pipeline {
    agent any
    parameters {
        string (name: 'VERSION_PREFIX', defaultValue: '0.0.0', description: 'pxe.to version')
    }
    environment {
        BUILD_TAG = "${env.BUILD_TAG}".replaceAll('%2F','_')
        BRANCH = "${env.BRANCH_NAME}".replaceAll('/','_')
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '30'))
    }
    stages {
        stage ('Checkout and build iPXE Menus Container') {
            steps {
                dir('build_menu') {

                    sh 'rm -rf build'
                    sh './build.sh'
                }
            } 
        }
        
        stage ('Execute Container and Generate files.') {
            steps {
                sh './menus.sh'
            }
        }
        stage ('Code signing') {
            steps {
                sh 'cd build/script'
                sh './descrypt-secrets.sh'
                sh 'cd .. && ./script/prep-release.sh'
            }
        }
        stage ('Upload to GitHub') {
            steps {
                sh ''
            }
        }

    } 
}
