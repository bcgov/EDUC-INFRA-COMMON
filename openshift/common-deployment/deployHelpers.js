 echo "Loading deployment helpers"

def performApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE){
    configMapSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    script{
      dir('tools/jenkins'){
          if(tag == "latest") {
              sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/master/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\""
          } else {
              sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/${tag}/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\""
          }
      }
    }
     script {
         deployStageNoEnv(sourceEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
     }
     performStandardRollout(appName, projectEnv, jobName)
}

def performEmailApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String commonNamespace){
     configMapChesSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
     performStandardUpdateConfigMapStep("${repoName}", "${tag}", "${targetEnv}", "${appName}", "${NAMESPACE}", "${commonNamespace}");
     script{
         deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
     }
     performStandardRollout(appName, projectEnv, jobName)
}

def performSagaApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String commonNamespace){
    script{
      openshift.withCluster() {
        openshift.withProject("${projectEnv}") {
          def patroni = openshift.selector('statefulset', "${appName}-pgsql-${targetEnv}")
          if(!patroni.exists()){
            deployPatroniSecrets("${targetEnv}", "${projectEnv}", "${appName}")
            deployPatroni("${targetEnv}", "${projectEnv}", "${appName}", "${sourceEnv}")
          }else {
            echo "Deployment of patroni secrets already exists, so skipping to next step"
          }
        }
      }
      deployStage(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem, targetEnv)
    }
    configMapSetupSplunkOnly("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    performStandardUpdateConfigMapStep("${repoName}", "${tag}", "${targetEnv}", "${appName}", "${NAMESPACE}", "${commonNamespace}");
    performStandardRollout(appName, projectEnv, jobName)
}

def performSoamApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String DEV_EXCHANGE_REALM){
    configMapSetupSplunkOnly("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    script{
      dir('tools/jenkins'){
          if(tag == "latest") {
              sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/master/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\" \"${DEV_EXCHANGE_REALM}\""
          } else {
              sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/${tag}/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\" \"${DEV_EXCHANGE_REALM}\""
          }
      }
      script {
         deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem);
      }
      echo "Rolling out ${appName}-${jobName}"
      try {
          sh(script: "oc -n ${projectEnv} rollout latest dc/${appName}-${jobName}", returnStdout: true)
      }
      catch(e){
          //Do nothing
      }
      echo "Rolling out sso-${targetEnv}"
      try {
          sh(script: "oc -n ${projectEnv} rollout latest dc/sso-${targetEnv}", returnStdout: true)
      }
      catch(e){
          //Do nothing
      }
    }
}

def performUIDeploy(String hostRoute, String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String frontendDCRaw, String backendDCRaw, String minReplicasFE, String maxReplicasFE, String minCPUFE, String maxCPUFE, String minMemFE, String maxMemFE, String minReplicasBE, String maxReplicasBE, String minCPUBE, String maxCPUBE, String minMemBE, String maxMemBE, String targetEnv, String NAMESPACE, String commonNamespace, String caCert, String cert, String privateKey){
    script {
        if(caCert == ""){
            deployUIStage(hostRoute, stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, frontendDCRaw, backendDCRaw, minReplicasFE, maxReplicasFE, minCPUFE, maxCPUFE, minMemFE, maxMemFE, minReplicasBE, maxReplicasBE, minCPUBE, maxCPUBE, minMemBE, maxMemBE)
        }else{
            deployUIStageWithCerts(hostRoute, stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, frontendDCRaw, backendDCRaw, minReplicasFE, maxReplicasFE, minCPUFE, maxCPUFE, minMemFE, maxMemFE, minReplicasBE, maxReplicasBE, minCPUBE, maxCPUBE, minMemBE, maxMemBE, caCert, cert, privateKey)
        }
    }
    configMapSetupSplunkOnly("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    performStandardUpdateConfigMapStep("${repoName}", "${tag}", "${targetEnv}", "${appName}", "${NAMESPACE}", "${commonNamespace}");
    script{
      openshift.withCluster() {
        openshift.withProject("${projectEnv}") {
          def dcAppBE = openshift.selector('dc', "${appName}-backend-${jobName}")
          dcAppBE.rollout().cancel()
          timeout(10) {
            try{
              dcAppBE.rollout().status('--watch=true')
            }catch(Exception e){
              //Do nothing
            }
          }
          dcAppBE.rollout().latest()

          def dcAppFE = openshift.selector('dc', "${appName}-frontend-${jobName}")
          dcAppFE.rollout().cancel()
          timeout(10) {
            try{
              dcAppFE.rollout().status('--watch=true')
            }catch(Exception e){
              //Do nothing
            }
          }
          dcAppFE.rollout().latest()
        }
      }
    }
}

def performStandardRollout(String appName, String projectEnv, String jobName){
  script{
     echo "Rolling out ${appName}-${jobName}"
     try {
         sh(script: "oc -n ${projectEnv} rollout latest dc/${appName}-${jobName}", returnStdout: true)
     }
     catch(e){
         //Do nothing
     }
  }
}

def configMapSetupSplunkOnly(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
    script {

      try{
        sh( script: "oc -n ${namespace}-${targetEnv} describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
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
		  echo Creating ${appName}-${targetEnv}-setup-config configmap...
		  oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties} --dry-run -o yaml | oc apply -f -
		"""
      }
    }
}

def configMapSetup(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
    script {

      try{
        sh( script: "oc -n ${namespace}-${targetEnv} describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
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
          echo Creating ${appName}-${targetEnv}-setup-config configmap...
		  oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties.SPLUNK_TOKEN} --from-literal=DB_JDBC_CONNECT_STRING=${configProperties.DB_JDBC_CONNECT_STRING} --from-literal=DB_USER_${appNameUpper}=${configProperties.DB_USER} --from-literal=DB_PWD_${appNameUpper}=${configProperties.DB_PWD} --dry-run -o yaml | oc apply -f -
		"""
      }
    }
}

def configMapChesSetup(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
    script {
       try{
        sh( script: "oc -n ${namespace}-${targetEnv} describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
        echo 'Config map already exists. Moving to next stage...'
      } catch(e){
          configProperties = input(
          id: 'configProperties', message: "Please enter the required CHES credentials to allow ${appName} to run. Credentials will be required from both CHES & ${appName}:",
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
         echo Creating ${appName}-${targetEnv}-setup-config configmap...
         oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties.SPLUNK_TOKEN} --from-literal=DB_JDBC_CONNECT_STRING=${configProperties.DB_JDBC_CONNECT_STRING} --from-literal=DB_USER_${appNameUpper}=${configProperties.DB_USER} --from-literal=DB_PWD_${appNameUpper}=${configProperties.DB_PWD} --from-literal=CHES_CLIENT_ID=${configProperties.CHES_CLIENT_ID} --from-literal=CHES_TOKEN_URL=${configProperties.CHES_TOKEN_URL} --from-literal=CHES_ENDPOINT_URL=${configProperties.CHES_ENDPOINT_URL} --from-literal=CHES_CLIENT_SECRET=${configProperties.CHES_CLIENT_SECRET} --dry-run -o yaml | oc apply -f -
       """
      }
    }
}

def deployStage(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging ${appName} image with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-${jobName}:${tag}", "${repoName}-${jobName}:${tag}")
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
    echo "Tagging ${appName} image with version ${tag}"
    sh( script: "oc tag ${sourceEnv}/${repoName}-${jobName}:${tag} ${projectEnv}/${repoName}-${jobName}:${tag}", returnStdout: true)
    echo "Applying Deployment for ${appName}"
    sh( script: "oc -n ${projectEnv} process -f ${rawApiDcURL} -p REPO_NAME=${repoName} -p JOB_NAME=${jobName} -p NAMESPACE=${projectEnv} -p APP_NAME=${appName} -p HOST_ROUTE=${appName}-${targetEnvironment}.${appDomain} -p TAG=${tag} -p MIN_REPLICAS=${minReplicas} -p MAX_REPLICAS=${maxReplicas} -p MIN_CPU=${minCPU} -p MAX_CPU=${maxCPU} -p MIN_MEM=${minMem} -p MAX_MEM=${maxMem} | oc apply -f -", returnStdout: true)
}

def deployUIStage(String hostRoute, String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURLFrontend, String rawApiDcURLBackend, String minReplicasFE, String maxReplicasFE, String minCPUFE, String maxCPUFE, String minMemFE, String maxMemFE, String minReplicasBE, String maxReplicasBE, String minCPUBE, String maxCPUBE, String minMemBE, String maxMemBE) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging Image ${repoName}-backend:${jobName} with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-backend:${tag}", "${repoName}-backend:${tag}")

     echo "Tagging Image ${repoName}-frontend-static:${jobName} with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-frontend-static:${tag}", "${repoName}-frontend-static:${tag}")

     echo "Processing DeploymentConfig ${appName}-backend..."
     def dcBackendTemplate = openshift.process('-f',
       "${rawApiDcURLBackend}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${hostRoute}",
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
       "HOST_ROUTE=${hostRoute}",
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

def deployUIStageWithCerts(String hostRoute, String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURLFrontend, String rawApiDcURLBackend, String minReplicasFE, String maxReplicasFE, String minCPUFE, String maxCPUFE, String minMemFE, String maxMemFE, String minReplicasBE, String maxReplicasBE, String minCPUBE, String maxCPUBE, String minMemBE, String maxMemBE, String caCert, String cert, String privateKey) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging Image ${repoName}-backend:${jobName} with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-backend:${tag}", "${repoName}-backend:${tag}")

     echo "Tagging Image ${repoName}-frontend-static:${jobName} with version ${tag}"
     openshift.tag("${sourceEnv}/${repoName}-frontend-static:${tag}", "${repoName}-frontend-static:${tag}")

     echo "Processing DeploymentConfig ${appName}-backend..."
     def dcBackendTemplate = openshift.process('-f',
       "${rawApiDcURLBackend}",
       "REPO_NAME=${repoName}",
       "JOB_NAME=${jobName}",
       "NAMESPACE=${projectEnv}",
       "APP_NAME=${appName}",
       "HOST_ROUTE=${hostRoute}",
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
       "HOST_ROUTE=${hostRoute}",
       "TAG=${tag}",
       "MIN_REPLICAS=${minReplicasFE}",
       "MAX_REPLICAS=${maxReplicasFE}",
       "MIN_CPU=${minCPUFE}",
       "MAX_CPU=${maxCPUFE}",
       "MIN_MEM=${minMemFE}",
       "MAX_MEM=${maxMemFE}",
       "CA_CERT=${caCert}",
       "CERTIFICATE=${cert}",
       "PRIVATE_KEY=${privateKey}"
     )

     echo "Applying Deployment ${appName}-frontend-static..."
     def dcFrontendStatic = openshift.apply(dcFrontendStaticTemplate).narrow('dc')
   }
  }
}

def deployPatroniSecrets(String stageEnv, String projectEnv, String appName) {
 def patroni = openshift.selector('statefulset', "${appName}-pgsql-${stageEnv}")
 if(!patroni.exists()){
   def dcTemplate = openshift.process('-f',
     'https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/patroni/patroni-postgresql-secrets.yaml',
     "NAME=${appName}-pgsql",
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

def deployPatroni(String stageEnv, String projectEnv, String appName, String sourceEnv) {
 def patroni = openshift.selector('statefulset', "${appName}-pgsql-${stageEnv}")
 if(!patroni.exists()){
   def dcTemplate = openshift.process('-f',
     'https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/patroni/patroni-postgresql.yaml',
     "NAME=${appName}-pgsql",
     "SUFFIX=-${stageEnv}",
     "IMAGE_STREAM_NAMESPACE=${sourceEnv}",
     "IMAGE_STREAM_TAG=patroni:v11-stable",
     "IMAGE_REGISTRY=image-registry.openshift-image-registry.svc:5000",
     "INSTANCE=${appName}-pgsql-${stageEnv}"
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

def triggerWorkflow(String token, String eventType = 'smoke-test-test-admin') {
  def dispatchRequest = """
    {
      "event_type": "${eventType}"
    }
  """
  def response = httpRequest customHeaders: [[name: 'Authorization', value: "token ${token}"], [name: 'Accept', value: "application/vnd.github.ant-man-preview+json"]], contentType: 'APPLICATION_JSON', httpMode: 'POST', requestBody: dispatchRequest, url: "https://api.github.com/repos/${OWNER}/${TESTS_REPO_NAME}/dispatches"
  echo "triggerWorkflow Status: ${response.status}"
  echo "triggered test workflow in Github Actions!"
}

def getLatestWorkflowRun(String token) {
  def response = httpRequest customHeaders: [[name: 'Authorization', value: "token ${token}"], [name: 'Accept', value: "application/vnd.github.ant-man-preview+json"]], url: "https://api.github.com/repos/${OWNER}/${TESTS_REPO_NAME}/actions/runs?branch=main&event=repository_dispatch"
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
  sleep(15)
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
def performPenRegApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String commonNamespace){
    configMapSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    performStandardUpdateConfigMapStep("${repoName}", "${tag}", "${targetEnv}", "${appName}", "${NAMESPACE}", "${commonNamespace}");
    performStandardRollout(appName, projectEnv, jobName)
    script{
        deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
    }
}

 def performPenServicesApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String commonNamespace){
    configMapSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    performStandardUpdateConfigMapStep("${repoName}", "${tag}", "${targetEnv}", "${appName}", "${NAMESPACE}", "${commonNamespace}");
    script{
        deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
    }
    performStandardRollout(appName, projectEnv, jobName)
 }

 def performReportGenerationApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String commonNamespace){
    configMapCDOGSSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
    performStandardUpdateConfigMapStep("${repoName}", "${tag}", "${targetEnv}", "${appName}", "${NAMESPACE}", "${commonNamespace}");
    script{
        deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
    }
    performStandardRollout(appName, projectEnv, jobName)
 }

 def performStandardUpdateConfigMapStep(String repoName,String tag, String targetEnv, String appName, String NAMESPACE, String commonNamespace){
     script{
         dir('tools/jenkins'){
             if(tag == "latest") {
                 sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/master/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\" \"${commonNamespace}\""
             } else {
                 sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/${tag}/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\" \"${commonNamespace}\""
             }
         }
     }
 }

 def configMapCDOGSSetup(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
   script {
     try{
       sh( script: "oc -n ${namespace}-${targetEnv} describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
       echo 'Config map already exists. Moving to next stage...'
     } catch(e){
       configProperties = input(
         id: 'configProperties', message: "Please enter the required CDOGS credentials to allow ${appName} to run. Credentials will be required from both CDOGS & ${appName}:",
         parameters: [
         string(defaultValue: "",
         description: 'Client ID to obtain token for calling CDOGS API',
         name: 'CDOGS_CLIENT_ID'),
       string(defaultValue: "",
         description: "Client secret to obtain token for calling CDOGS API",
         name: 'CDOGS_CLIENT_SECRET'),
       string(defaultValue: "",
         description: "URL from where token will be obtained",
         name: 'CDOGS_TOKEN_ENDPOINT'),
       string(defaultValue: "",
         description: "base url to call cdogs api",
         name: 'CDOGS_BASE_URL'),
       string(defaultValue: "",
         description: "Token for ${appName} FluentBit sidecar to connect to the Splunk",
         name: 'SPLUNK_TOKEN'),
     ])
       sh """
       set +x
       echo Creating ${appName}-${targetEnv}-setup-config configmap...
       oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties.SPLUNK_TOKEN} --from-literal=CDOGS_CLIENT_ID=${configProperties.CDOGS_CLIENT_ID} --from-literal=CDOGS_CLIENT_SECRET=${configProperties.CDOGS_CLIENT_SECRET} --from-literal=CDOGS_TOKEN_ENDPOINT=${configProperties.CDOGS_TOKEN_ENDPOINT} --from-literal=CDOGS_BASE_URL=${configProperties.CDOGS_BASE_URL} --dry-run -o yaml | oc apply -f -
       """
     }
   }
 }
 def performTraxNotificationApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE){
   script {
     deployStageNoEnv(sourceEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
   }
   configMapChesSetup("${appName}","${appName}".toUpperCase(), "${NAMESPACE}", "${targetEnv}", "${sourceEnv}");
   script{
     dir('tools/jenkins'){
         if(tag == "latest") {
             sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/main/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\""
         } else {
             sh "curl -s https://raw.githubusercontent.com/bcgov/${repoName}/${tag}/tools/jenkins/update-configmap.sh | bash /dev/stdin \"${targetEnv}\" \"${appName}\" \"${NAMESPACE}\""
         }
     }
   }
   performStandardRollout(appName, projectEnv, jobName)
 }

 def performPenMyEdApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String sourceEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String commonNamespace){
   script{
     deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, sourceEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem)
   }
   configMapMyEdSetup("${appName}","${appName}".toUpperCase(), NAMESPACE, "${targetEnv}", "${sourceEnv}");
   performStandardUpdateConfigMapStep("${repoName}", "${tag}", "${targetEnv}", "${appName}", "${NAMESPACE}", "${commonNamespace}");
   performStandardRollout(appName, projectEnv, jobName)
 }

 def configMapMyEdSetup(String appName,String appNameUpper, String namespace, String targetEnv, String sourceEnv){
   script {
     try{
       sh( script: "oc -n ${namespace}-${targetEnv} describe configmaps ${appName}-${targetEnv}-setup-config", returnStdout: true)
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
       echo Creating ${appName}-${targetEnv}-setup-config configmap...
       oc create -n ${namespace}-${targetEnv} configmap ${appName}-${targetEnv}-setup-config --from-literal=SPLUNK_TOKEN_${appNameUpper}=${configProperties} --dry-run -o yaml | oc apply -f -
       """
     }
   }
 }
return this;
