# Config Maps

## Creating Config Maps from the command line
To create a generic config-map to be used in your openshift project, you must run the following command:
``` sh
oc create -n {YOUR_OPENSHIFT_ENVIRONMENT} configmap {CONFIG MAP NAME} \
  --from-literal={KEY_PAIR_NAME}={KEY_PAIR_VALUE} \
  --from-literal={KEY_PAIR_NAME}={KEY_PAIR_VALUE} \
```
Be sure to replace all values in curly brackets, and add as many key pair mappings as you need.

## Adding config map values to deployment configs
To automatically attach config maps to deployments, you must add them as environment variables in the deployment config as such:
``` yaml
env:
- name: NAME OF ENVIRONMENT VARIABLE
  valueFrom:
    configMapKeyRef:
        key: CONFIG MAP KEY
        name: CONFIG MAP NAME
```
To see this in better context, check out this [deployment config](https://github.com/bcgov/EDUC-PEN-REQUEST/blob/master/tools/openshift/backend.dc.yaml)
