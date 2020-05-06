# Maintenance Page

This is a simple maintenance page for the GetMyPEN app.  It can be enabled and disabled via Jenkins pipeline.

## Running Pipelines
To add the pipelines to your openshift environment, run the following command in your tools environment

```
oc process -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/maintenance-page/openshift/pipeline.bc.yaml -o yaml | oc create -f -
```

Now you will have four pipelines. Two for TEST and two for PROD: `enable-maintenance-page-prod-pipeline`,  and `disable-maintenance-page-prod-pipeline`, `enable-maintenance-page-test-pipeline`, and `disable-maintenance-page-test-pipeline`.  These pipelines can be triggered from the tools environment.
