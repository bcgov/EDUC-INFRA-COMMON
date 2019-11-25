## Master pipeline

This folder contains all the files required to run the master pipeline for the PEN project.

### Importing master pipeline

The template for the [master pipeline](https://github.com/bcgov/EDUC-INFRA-COMMON/blob/master/openshift/pipelines/master-pipeline/master-pipeline.template.yaml) can be imported into Openshift via command line or web console. To import the master pipeline to you environment via the oc command line, run this command: 
``` sh
oc process -f master-pipeline.template.yaml
```

To import the pipeline via web console, click the "Add to project" button in the top right corner of the web console, select "Import yaml/json" and paste the contents of master-pipeline.template.yaml into the text box.

### Adding to master pipeline

To add steps, such as spawning off children pipelines or setting up Jenkins slaves, you must add the following code to the Jenkinsfile-master file:
``` sh
stage ('STEP NAME') {
  steps {
      echo 'Starting pipeline...'
      script{
          openshift.withCluster(){
              openshift.withProject(){
                  try{
                      def bcApi = openshift.process('-f', 'openshift/pipelines/master-pipeline/children-pipelines/BUILD CONFIG TO BE PROCESSED')
                      openshift.apply(bcApi).narrow('bc').startBuild()
                  } catch(e) {
                      echo "STEP NAME failed to start"
                      throw e
                  }
              }
          }
      }
  }
}
```
Be sure to replace the STEP NAME and NAME OF BUILD CONFIG TO BE PROCESSED with appropriate variables.

You must also create a build config (in the children-pipelines folder) for the build you are referencing in the code above (BUILD CONFIG TO BE PROCESSED). If you are spawning off a child pipeline, you can create a file called PIPELINE_NAME.bc.yaml (replacing PIPELINE_NAME with desired pipeline name) that contains the following code:
``` sh
---
apiVersion: v1
kind: Template
labels: 
  template: PIPELINE_NAME
metadata: 
  name: PIPELINE_NAME
objects:
- apiVersion: v1
  kind: BuildConfig
  metadata: 
    name: "PIPELINE_NAME"
  spec:
    source:
      git:
        ref: master
        uri: "https://github.com/bcgov/YOUR REPO"
    strategy:
      jenkinsPipelineStrategy:
        jenkinsfilePath: PATH TO YOU JENKINSFILE
```

Be sure to replace PIPELINE_NAME, YOUR REPO, and PATH TO YOUR JENKINSFILE with actual values.

This file references an existing Jenkinsfile in a different repo, and will build and execute that Jenkinsfile as a part of the master-pipeline build.
