 echo "Loading deployment helpers"

def performApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String toolsEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE){
    script {
      openshift.withCluster() {
        openshift.withProject("${targetEnvironment}") {
          def dcApi = openshift.selector('dc', "${appName}-${jobName}")
          if (!dcApi.exists()) {
            deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, toolsEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem);
          } else {
            echo "Deployments already exists, skipping to config map update"
          }
        }
      }
    }

    script{
        dir('tools/jenkins'){
            sh "curl https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-deployment/download-kc.sh | bash /dev/stdin \"${NAMESPACE}\""
        }
    }
    configMapSetup("${APP_NAME}","${APP_NAME}".toUpperCase(), NAMESPACE);
    script{
      dir('tools/jenkins'){
        sh "bash ./update-configmap.sh ${TARGET_ENV} ${APP_NAME} ${NAMESPACE}"
      }
    }
    deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, toolsEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem);
}

def performSoamApiDeploy(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String toolsEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv, String NAMESPACE, String DEV_EXCHANGE_REALM){
    script {
      openshift.withCluster() {
        openshift.withProject("${targetEnvironment}") {
          def soamDC = openshift.selector('dc', "${appName}-${jobName}")
          if (!soamDC.exists()) {
            deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, toolsEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem);
          } else {
            echo "Deployments already exists, skipping to config map update"
          }
        }
      }
    }

    script{
        dir('tools/jenkins'){
            sh "curl https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-deployment/download-kc.sh | bash /dev/stdin \"${NAMESPACE}\""
        }
    }
    configMapSetup("${APP_NAME}","${APP_NAME}".toUpperCase(), NAMESPACE);
    script{
      dir('tools/jenkins'){
        sh "bash ./update-configmap.sh ${TARGET_ENV} ${APP_NAME} ${NAMESPACE} ${DEV_EXCHANGE_REALM}"
      }
    }
    deployStageNoEnv(stageEnv, projectEnv, repoName, appName, jobName,  tag, toolsEnv, targetEnvironment, appDomain, rawApiDcURL, minReplicas, maxReplicas, minCPU, maxCPU, minMem, maxMem);

    script {
      openshift.withCluster() {
        openshift.withProject("${targetEnv}") {
          openshift.selector('dc', "sso-${targetEnv}").rollout().latest()
        }
      }
    }
}

def configMapSetup(String appName,String appNameUpper, String namespace){
    script {
       try{
        sh( script: "oc project ${namespace}-dev", returnStdout: true)
        sh( script: "oc describe configmaps ${appName}-dev-setup-config", returnStdout: true)
        sh( script: "oc project ${namespace}-tools", returnStdout: true)
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
          ])
       sh """
         set +x
         echo Running curl command...
         oc create -n ${namespace}-dev configmap ${appName}-dev-setup-config --from-literal=DB_JDBC_CONNECT_STRING=${configProperties.DB_JDBC_CONNECT_STRING} --from-literal=DB_USER_${appNameUpper}=${configProperties.DB_USER} --from-literal=DB_PWD_${appNameUpper}=${configProperties.DB_PWD} --dry-run -o yaml | oc apply -f -
         oc project ${namespace}-tools
       """
      }
    }
}

def configMapChesSetup(String appName,String appNameUpper, String namespace){
    script {
       try{
        sh( script: "oc project ${namespace}-dev", returnStdout: true)
        sh( script: "oc describe configmaps ${appName}-dev-setup-config", returnStdout: true)
        sh( script: "oc project ${namespace}-tools", returnStdout: true)
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
          ])
       sh """
         set +x
         echo Running curl command...
         oc create -n ${namespace}-dev configmap ${appName}-dev-setup-config --from-literal=CHES_CLIENT_ID=${configProperties.CHES_CLIENT_ID} --from-literal=CHES_TOKEN_URL=${configProperties.CHES_TOKEN_URL} --from-literal=CHES_ENDPOINT_URL=${configProperties.CHES_ENDPOINT_URL} --from-literal=CHES_CLIENT_SECRET=${configProperties.CHES_CLIENT_SECRET} --dry-run -o yaml | oc apply -f -
         oc project ${namespace}-tools
       """
      }
    }
}

def deployStage(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String toolsEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging ${appName} image with version ${tag}"
     openshift.tag("${toolsEnv}/${repoName}-${jobName}:latest", "${repoName}-${jobName}:${tag}")
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

def deployStageNoTag(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String toolsEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem, String targetEnv) {
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

def deployStageNoEnv(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String toolsEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging ${appName} image with version ${tag}"
     openshift.tag("${toolsEnv}/${repoName}-${jobName}:latest", "${repoName}-${jobName}:${tag}")
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

def deployStageNoTagNoEnv(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String toolsEnv, String targetEnvironment, String appDomain, String rawApiDcURL, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem) {
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

def deployUIStage(String stageEnv, String projectEnv, String repoName, String appName, String jobName, String tag, String toolsEnv, String targetEnvironment, String appDomain, String rawApiDcURLFrontend, String rawApiDcURLBackend, String minReplicas, String maxReplicas, String minCPU, String maxCPU, String minMem, String maxMem) {
  openshift.withCluster() {
   openshift.withProject(projectEnv) {
     echo "Tagging Image ${repoName}-backend:${jobName} with version ${tag}"
     openshift.tag("${toolsEnv}/${repoName}-backend:latest", "${repoName}-backend:${tag}")

     echo "Tagging Image ${repoName}-frontend-static:${jobName} with version ${tag}"
     openshift.tag("${toolsEnv}/${repoName}-frontend-static:latest", "${repoName}-frontend-static:${tag}")

     echo "Processing DeploymentConfig ${appName}-backend..."
     def dcBackendTemplate = openshift.process('-f',
       "${rawApiDcURLBackend}",
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
       "MIN_REPLICAS=${minReplicas}",
       "MAX_REPLICAS=${maxReplicas}",
       "MIN_CPU=${minCPU}",
       "MAX_CPU=${maxCPU}",
       "MIN_MEM=${minMem}",
       "MAX_MEM=${maxMem}"
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

return this;