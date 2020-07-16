 echo "Loading deployment helpers"

def performApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE){
    script {
        deployStageNoEnv(sourceEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
        dir('tools/jenkins'){
            sh "curl https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-deployment/download-kc.sh | bash /dev/stdin \"${NAMESPACE}\""
        }
    }
    configMapSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    script{
      dir('tools/jenkins'){
        sh "curl https://raw.githubusercontent.com/bcgov/${repoName}/master/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\""
      }

      openshift.withCluster() {
        openshift.withProject("${projectEnv}") {
          def dcApp = openshift.selector('dc', "${appName}-${jobName}")
          dcApp.rollout().cancel()
          timeout(10) {
            try{
                dcApp.rollout().status('--watch=true')
            }catch(Exception e){
              //Do nothing
            }
          }
          openshift.selector('dc', "${appName}-${jobName}").rollout().latest()
        }
      }
    }
}

def performEmailApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String commonNamespace){
    script{
        deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
        dir('tools/jenkins'){
            sh "curl https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-deployment/download-kc.sh | bash /dev/stdin \"${NAMESPACE}\""
        }
    }
    configMapChesSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    script{
      dir('tools/jenkins'){
        sh "curl https://raw.githubusercontent.com/bcgov/${repoName}/master/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\" \"${commonNamespace}\""
      }

      openshift.withCluster() {
        openshift.withProject("${projectEnv}") {
          def dcApp = openshift.selector('dc', "${appName}-${jobName}")
          dcApp.rollout().cancel()
          timeout(10) {
            dcApp.rollout().status('--watch=true')
          }
          openshift.selector('dc', "${appName}-${jobName}").rollout().latest()
        }
      }
    }
}

def performSoamApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String DEV_EXCHANGE_REALM){
    script {
        deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem);
        dir('tools/jenkins'){
            sh "curl https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-deployment/download-kc.sh | bash /dev/stdin \"${NAMESPACE}\""
        }
    }
    configMapSetupSplunkOnly("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    script{
      dir('tools/jenkins'){
        sh "curl https://raw.githubusercontent.com/bcgov/${repoName}/master/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\" \"${DEV_EXCHANGE_REALM}\""
      }
      openshift.withCluster() {
        openshift.withProject("${projectEnv}") {
          def dcApp = openshift.selector('dc', "${appName}-${jobName}")
          dcApp.rollout().cancel()
          timeout(10) {
            dcApp.rollout().status('--watch=true')
          }
          openshift.selector('dc', "${appName}-${jobName}").rollout().latest()
          openshift.selector('dc', "sso-${targetEnv}").rollout().latest()
        }
      }
    }
}

def performUIDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String frontendDCRaw, String backendDCRaw, String minReplicasFE, String maxReplicasFE, String minCPUFE, String maxCPUFE, String minMemFE, String maxMemFE, String minReplicasBE, String maxReplicasBE, String minCPUBE, String maxCPUBE, String minMemBE, String maxMemBE, String targetEnv, String NAMESPACE, String commonNamespace){
    script {
        deployUIStage(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, frontendDCRaw, backendDCRaw, minReplicasFE, maxReplicasFE, minCPUFE, maxCPUFE, minMemFE, maxMemFE, minReplicasBE, maxReplicasBE, minCPUBE, maxCPUBE, minMemBE, maxMemBE)
        dir('tools/jenkins'){
            sh "curl https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-deployment/download-kc.sh | bash /dev/stdin \"${NAMESPACE}\""
        }
    }
    configMapSetupSplunkOnly("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    script{
      dir('tools/jenkins'){
        sh "curl https://raw.githubusercontent.com/bcgov/${repoName}/master/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\" \"${commonNamespace}\""
      }
      openshift.withCluster() {
        openshift.withProject("${projectEnv}") {
          def dcAppBE = openshift.selector('dc', "${appName}-backend-${jobName}")
          dcAppBE.rollout().cancel()
          timeout(10) {
            dcAppBE.rollout().status('--watch=true')
          }
          dcAppBE.rollout().latest()

          def dcAppFE = openshift.selector('dc', "${appName}-frontend-${jobName}")
          dcAppFE.rollout().cancel()
          timeout(10) {
            dcAppFE.rollout().status('--watch=true')
          }
          dcAppFE.rollout().latest()
        }
      }
    }
}

def configMapSetupSplunkOnly(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
    script {

      try{
        sh( script: "oc project ${namespace}-${targetEnv}", returnStdout: true)
        sh( script: "oc describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
        sh( script: "oc project ${sourceEnv}", returnStdout: true)
        echo 'Config map already exists. Moving to next stage...'
      } catch(e){
          configProperties = input(
          id: 'configProperties', message: "Please enter the required credentials to allow ${appName} to run:",
          parameters: [
              string(defaultValue: "",
                      description: "Token for ${appName} FluentBit sidecar to connect to the Splunk",
                      name: "SPLUNK_TOKEN"),
          ])
		sh """
		  set +x
		  echo Running curl command...
		  oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties} --dry-run -o yaml | oc apply -f -
		  oc project ${namespace}-tools
		"""
      }
    }
}

def configMapSetup(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
    script {

      try{
        sh( script: "oc project ${namespace}-${targetEnv}", returnStdout: true)
        sh( script: "oc describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
        sh( script: "oc project ${sourceEnv}", returnStdout: true)
        echo 'Config map already exists. Moving to next stage...'
      } catch(e){
          configProperties = input(
          id: 'configProperties', message: "Please enter the required credentials to allow ${appName} to run:",
          parameters: [
              string(defaultValue: "",
                      description: 'JDBC connect string for database',
                      name: 'DB_JDBC_CONNECT_STRING'),
              string(defaultValue: "",
                      description: "Username for ${appName} to connect to the database",
                      name: "DB_USER"),
              password(defaultValue: "",
                      description: "Password for ${appName} to connect to the database",
                      name: "DB_PWD"),
              string(defaultValue: "",
                      description: "Token for ${appName} FluentBit sidecar to connect to the Splunk",
                      name: "SPLUNK_TOKEN"),
          ])
		sh """
		  set +x
		  echo Running curl command...
		  oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties.SPLUNK_TOKEN} --from-literal=DB_JDBC_CONNECT_STRING=${configProperties.DB_JDBC_CONNECT_STRING} --from-literal=DB_USER_${appNameUpper}=${configProperties.DB_USER} --from-literal=DB_PWD_${appNameUpper}=${configProperties.DB_PWD} --dry-run -o yaml | oc apply -f -
		  oc project ${namespace}-tools
		"""
      }
    }
}

def configMapChesSetup(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
    script {
       try{
        sh( script: "oc project ${namespace}-${targetEnv}", returnStdout: true)
        sh( script: "oc describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
        sh( script: "oc project ${sourceEnv}", returnStdout: true)
        echo 'Config map already exists. Moving to next stage...'
      } catch(e){
          configProperties = input(
          id: 'configProperties', message: "Please enter the required credentials to allow ${appName} to run:",
          parameters: [
              string(defaultValue: "",
                      description: 'JDBC connect string for database',
                      name: 'CHES_CLIENT_ID'),
              string(defaultValue: "",
                      description: "Username for ${appName} to connect to the database",
                      name: "CHES_CLIENT_SECRET"),
              string(defaultValue: "",
                      description: "Password for ${appName} to connect to the database",
                      name: "CHES_ENDPOINT_URL"),
              string(defaultValue: "",
                      description: "Password for ${appName} to connect to the database",
                      name: "CHES_TOKEN_URL"),
              string(defaultValue: "",
                      description: 'JDBC connect string for database',
                      name: 'DB_JDBC_CONNECT_STRING'),
              string(defaultValue: "",
                      description: "Username for ${appName} to connect to the database",
                      name: "DB_USER"),
              password(defaultValue: "",
                      description: "Password for ${appName} to connect to the database",
                      name: "DB_PWD"),
              string(defaultValue: "",
                description: "Token for ${appName} FluentBit sidecar to connect to the Splunk",
                name: "SPLUNK_TOKEN"),
          ])
       sh """
         set +x
         echo Running curl command...
         oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties.SPLUNK_TOKEN} --from-literal=DB_JDBC_CONNECT_STRING=${configProperties.DB_JDBC_CONNECT_STRING} --from-literal=DB_USER_${appNameUpper}=${configProperties.DB_USER} --from-literal=DB_PWD_${appNameUpper}=${configProperties.DB_PWD} --from-literal=CHES_CLIENT_ID=${configProperties.CHES_CLIENT_ID} --from-literal=CHES_TOKEN_URL=${configProperties.CHES_TOKEN_URL} --from-literal=CHES_ENDPOINT_URL=${configProperties.CHES_ENDPOINT_URL} --from-literal=CHES_CLIENT_SECRET=${configProperties.CHES_CLIENT_SECRET} --dry-run -o yaml | oc apply -f -
         oc project ${namespace}-tools
       """
      }
    }
}

def deployStage(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging ${appName} image with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-${jobName}:latest", "${repoName}-${jobName}:${tag}")
     def dcTemplate = openshift.process('-f',
       "${rawApiDcURL}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${appName}-${targetEnvironment}.${appDomain}",
       "TAG=${tag}",
       "MIN_REPLICAS=${minReplicas}",
       "MAX_REPLICAS=${maxReplicas}",
       "MIN_CPU=${minCPU}",
       "MAX_CPU=${maxCPU}",
       "MIN_MEM=${minMem}",
       "MAX_MEM=${maxMem}",
       "ENV=${targetEnv}"
     )

     echo "Applying Deployment for ${appName}"
     def dc = openshift.apply(dcTemplate).narrow('dc')
   }
  }
}

def deployStageNoTag(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     def dcTemplate = openshift.process('-f',
       "${rawApiDcURL}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${appName}-${targetEnvironment}.${appDomain}",
       "TAG=${tag}",
       "MIN_REPLICAS=${minReplicas}",
       "MAX_REPLICAS=${maxReplicas}",
       "MIN_CPU=${minCPU}",
       "MAX_CPU=${maxCPU}",
       "MIN_MEM=${minMem}",
       "MAX_MEM=${maxMem}",
       "ENV=${targetEnv}"
     )

     echo "Applying Deployment for ${appName}"
     def dc = openshift.apply(dcTemplate).narrow('dc')
   }
  }
}

def deployStageNoEnv(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging ${appName} image with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-${jobName}:latest", "${repoName}-${jobName}:${tag}")
     def dcTemplate = openshift.process('-f',
       "${rawApiDcURL}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${appName}-${targetEnvironment}.${appDomain}",
       "TAG=${tag}",
       "MIN_REPLICAS=${minReplicas}",
       "MAX_REPLICAS=${maxReplicas}",
       "MIN_CPU=${minCPU}",
       "MAX_CPU=${maxCPU}",
       "MIN_MEM=${minMem}",
       "MAX_MEM=${maxMem}"
     )

     echo "Applying Deployment for ${appName}"
     def dc = openshift.apply(dcTemplate).narrow('dc')
   }
  }
}

def deployStageNoTagNoEnv(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     def dcTemplate = openshift.process('-f',
       "${rawApiDcURL}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${appName}-${targetEnvironment}.${appDomain}",
       "TAG=${tag}",
       "MIN_REPLICAS=${minReplicas}",
       "MAX_REPLICAS=${maxReplicas}",
       "MIN_CPU=${minCPU}",
       "MAX_CPU=${maxCPU}",
       "MIN_MEM=${minMem}",
       "MAX_MEM=${maxMem}"
     )

     echo "Applying Deployment for ${appName}"
     def dc = openshift.apply(dcTemplate).narrow('dc')
   }
  }
}

def deployUIStage(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURLFrontend, String rawApiDcURLBackend, String minReplicasFE, String maxReplicasFE, String minCPUFE, String maxCPUFE, String minMemFE, String maxMemFE, String minReplicasBE, String maxReplicasBE, String minCPUBE, String maxCPUBE, String minMemBE, String maxMemBE) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging Image ${repoName}-backend:${jobName} with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-backend:latest", "${repoName}-backend:${tag}")

     echo "Tagging Image ${repoName}-frontend-static:${jobName} with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-frontend-static:latest", "${repoName}-frontend-static:${tag}")

     echo "Processing DeploymentConfig ${appName}-backend..."
     def dcBackendTemplate = openshift.process('-f',
       "${rawApiDcURLBackend}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${appName}-${targetEnvironment}.${appDomain}",
       "TAG=${tag}",
       "MIN_REPLICAS=${minReplicasBE}",
       "MAX_REPLICAS=${maxReplicasBE}",
       "MIN_CPU=${minCPUBE}",
       "MAX_CPU=${maxCPUBE}",
       "MIN_MEM=${minMemBE}",
       "MAX_MEM=${maxMemBE}"
     )

     def dcBackend = openshift.apply(dcBackendTemplate).narrow('dc')

     echo "Processing DeploymentConfig ${appName}-frontend-static..."
     def dcFrontendStaticTemplate = openshift.process('-f',
       "${rawApiDcURLFrontend}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${appName}-${targetEnvironment}.${appDomain}",
       "TAG=${tag}",
       "MIN_REPLICAS=${minReplicasFE}",
       "MAX_REPLICAS=${maxReplicasFE}",
       "MIN_CPU=${minCPUFE}",
       "MAX_CPU=${maxCPUFE}",
       "MIN_MEM=${minMemFE}",
       "MAX_MEM=${maxMemFE}"
     )

     echo "Applying Deployment ${appName}-frontend-static..."
     def dcFrontendStatic = openshift.apply(dcFrontendStaticTemplate).narrow('dc')
   }
  }
}

def deployPatroniSecrets(String stageEnv, String projectEnv) {
 openshift.withCluster() {
   openshift.withProject(projectEnv) {
     def patroni = openshift.selector('statefulset', "${APP_NAME}-pgsql-${stageEnv}")
     if(!patroni.exists()){
       def dcTemplate = openshift.process('-f',
         'https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/patroni/patroni-postgresql-secrets.yaml',
         "NAME=${APP_NAME}-pgsql",
         "SUFFIX=-${stageEnv}",
         "APP_DB_NAME=student_profile_saga",
         "APP_DB_USERNAME=student_profile_saga"
       )

       echo "Applying Deployment Patroni secrets"
       def template = openshift.apply(dcTemplate).narrow('dc')
        // Wait for deployments to roll out
       timeout(5) {
         template.rollout().status('--watch=true')
       }
     }
     else {
         echo "Deployment of patroni secrets already exists, so skipping to next step"
     }

   }
  }
}

def deployPatroni(String stageEnv, String projectEnv) {
 openshift.withCluster() {
   openshift.withProject(projectEnv) {
     def patroni = openshift.selector('statefulset', "${APP_NAME}-pgsql-${stageEnv}")
     if(!patroni.exists()){
       def dcTemplate = openshift.process('-f',
         'https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/patroni/patroni-postgresql.yaml',
         "NAME=${APP_NAME}-pgsql",
         "SUFFIX=-${stageEnv}",
         "INSTANCE=${APP_NAME}-pgsql-${stageEnv}"
       )

       echo "Applying Deployment patroni"
       def template = openshift.apply(dcTemplate).narrow('statefulset')
       timeout(5) {
         template.rollout().status('--watch=true')
       }
     } else {
       echo "Deployment of patroni already exists, so skipping to next step"
     }
   }
 }
}

def triggerWorkflow(String token) {
  def dispatchRequest = """
    {
      "event_type": "smoke-test-test-admin"
    }
  """
  def response = httpRequest customHeaders: [[name: 'Authorization', value: "token ${token}"], [name: 'Accept', value: "application/vnd.github.ant-man-preview+json"]], contentType: 'APPLICATION_JSON', httpMode: 'POST', requestBody: dispatchRequest, url: "https://api.github.com/repos/${OWNER}/${TESTS_REPO_NAME}/dispatches"
  echo "triggerWorkflow Status: ${response.status}"
  echo "triggered test workflow in Github Actions!"
}

def getLatestWorkflowRun(String token) {
  def response = httpRequest customHeaders: [[name: 'Authorization', value: "token ${token}"], [name: 'Accept', value: "application/vnd.github.ant-man-preview+json"]], url: "https://api.github.com/repos/${OWNER}/${TESTS_REPO_NAME}/actions/runs?branch=master&event=repository_dispatch"
  echo "getLatestWorkflowRun Status: ${response.status}"
  //echo "Content: ${response.content}"
  def jsonObj = readJSON text: response.content
  echo "Total count: ${jsonObj.total_count}"
  def latestRun = jsonObj.total_count > 0 ? jsonObj.workflow_runs.max { it.created_at } : null
  latestRun ? latestRun.id : null
}

def getWorkflowRunById(String token, long runId) {
  def response = httpRequest customHeaders: [[name: 'Authorization', value: "token ${token}"], [name: 'Accept', value: "application/vnd.github.ant-man-preview+json"]], url: "https://api.github.com/repos/${OWNER}/${TESTS_REPO_NAME}/actions/runs/${runId}"
  echo "getWorkflowRunById Status: ${response.status}"
  //echo "Content: ${response.content}"
  def jsonObj = readJSON text: response.content
  [jsonObj.status, jsonObj.conclusion]
}

def waitForWorkflowRunComplete(String token) {
  sleep(5)
  def latestRunId = getLatestWorkflowRun(token)
  if(!latestRunId) {
    error('No workflow run in Github Actions. Aborting the build!')
  } else {
    def count = 60  //timeout (60 * 10) seconds = 10 minutes
    def status, conclusion
    while(count-- > 0 && status != 'completed') {
      (status, conclusion) = getWorkflowRunById(token, latestRunId)
      if(status != 'completed') {
        echo "Waiting for workflow run complete: ${count}"
        sleep(10)
      }
    }

    if(status == 'completed' && conclusion != 'success') {
      error("Workflow run was ${conclusion}. Aborting the build!")
    } else if(count <= 0) {
      error('Workflow run query timed out. Aborting the build!')
    }
  }
}

return this;