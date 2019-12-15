# SonarQube Analysis

SonarQube analysis of a project provides insight into test coverage and code quality of a given project.

## JavaScript Reporting

To add SonarQube reporting to your JavaScript project, you must follow these steps:

1. Add the jest sonar reporter plugin to your package.json and configure it.
``` javascript
"dependencies" : {
  "jest-sonar-reporter": "^2.0.0"
},
"jest": {
  "testResultsProcessor": "jest-sonar-reporter"
},
"jestSonar": {
  "reportPath": "coverage"
},
```

2. Generate a project token for you JavaScript project at {YOUR SONARQUBE URL}/account/security (keep this token for later)

3. Configure your sonarqube project in Jenkins. To do this, go to your Jenkins instance and make sure you have the SonarQube Scanner plugin installed. Once the plugin is installed, go to manage Jenkins --> Configure Jenkins. From here, click "Add SonarQube" under the SonarQube Server section. Enter your internal SonarQube service url (should look like "http://sonarqube.{YOUR_ENVIRONMENT}.svc.cluster.local:9000", give the instance a unique name, and set up the server authentication token to use the token you obtained in step 2. (Credential kind should be "Secret Text")

4. Add the Sonar Scanner step to your pipeline. You will need to perform unit testing before your sonarqube scanning stage. Example:

Define the test stashes at the top of your Jenkinsfile:
``` groovy
def BE_COV_STASH = 'backend-coverage'
def FE_COV_STASH = 'frontend-coverage'
```

Stash and unstash your coverage metrics for SonarQube reporting:
``` groovy
stage('Unit Test'){
    steps{
      {DO YOUR UNIT TESTING HERE}
    }
    post {
        success {
            stash name: BE_COV_STASH, includes: 'backend/coverage/**'
            stash name: FE_COV_STASH, includes: 'frontend/coverage/**'

            echo 'All Lint Checks and Tests passed'
        }
        failure {
            echo 'Some Lint Checks and Tests failed'
        }
    }
}
stage('SonarQube Analysis'){
    agent any

    environment {
        scannerHome = tool 'SonarQubeScanner'
    }

    steps {
        script {
            openshift.withCluster() {
                openshift.withProject(TOOLS) {
                    if(DEBUG_OUTPUT.equalsIgnoreCase('true')) {
                        echo "DEBUG - Using project: ${openshift.project()}"
                    }

                    unstash BE_COV_STASH
                    unstash FE_COV_STASH
                    echo 'Performing SonarQube static code analysis...'
                    withSonarQubeEnv('sonarqube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }

            }
        }
    }
}
```
5. Add a sonar-project.properties file to your project root. The file should look something like this:
``` sh
#SonarQube Host Url
sonar.host.url={YOUR SONAR URL}

# Must be unique in a given SonarQube instance
sonar.projectKey={YOUR SONAR PROJECT KEY}

# This is the name and version displayed in the SonarQube UI. Was mandatory prior to SonarQube 6.1.
sonar.projectName={YOUR SONAR PROJECT NAME}
sonar.projectVersion=1.0.0

# Encoding of the source code. Default is default system encoding
sonar.sourceEncoding=UTF-8
sonar.exclusions=**/node_modules/**, **/coverage/**
sonar.verbose=false

# Path is relative to the sonar-project.properties file. Replace "\" by "/" on Windows.
sonar.sources=backend/src, frontend/src

# Test configurations
sonar.tests=frontend/tests, backend/tests
sonar.test.inclusions=**/tests/**/*.spec.**
sonar.javascript.lcov.reportPaths=backend/coverage/lcov.info, frontend/coverage/lcov.info
sonar.testExecutionReportPaths=backend/coverage/test-report.xml, frontend/coverage/test-report.xml
```


## Java Reporting

To add SonarQube reporting to your Java application you must complete the following steps:

1.Generate a project token for you Java project at {YOUR SONARQUBE URL}/account/security (keep this token for later)

2. Add the SonarQube dependency to your POM
``` java
<plugin>
    <groupId>org.sonarsource.scanner.maven</groupId>
    <artifactId>sonar-maven-plugin</artifactId>
    <version>3.7.0.1746</version>
</plugin>
```

3. Add the SonarQube analysis step to your Jenkinsfile
``` groovy
    stage('Report to SonarQube') {
        steps {
            script{
                dir('api'){
                    sh "mvn sonar:sonar -Dsonar.host.url={YOUR_INTERNAL_SVC_URL} -Dsonar.login={YOUR TOKEN FROM STEP 1}"
                }
            }
        }
    }
```
