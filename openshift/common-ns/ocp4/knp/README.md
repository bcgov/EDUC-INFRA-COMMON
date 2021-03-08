# Kubernetes Network Policies 

## KNP Deployment
Kubernetes Network Policies can be deployed for the common namespace by performing the following
* Run the following commands:
1. Delete the existing policies with this command.
   
    ```oc delete nsp,en --all```
2. Add the new policies by running this command after replacing variables.
```
 oc process -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-ns/ocp4/knp/ocp4-common-ns-policies.yaml -p ENVIRONMENT={ENV} -p NAMESPACE_PREFIX={COMMON_NS_PREFIX} PEN_NAMESPACE_PREFIX={PEN_NS_PREFIX} | oc create -f -
```

## KNP Deployment
Kubernetes Network Policies can be deployed for the pen namespace by performing the following
* Run the following commands:
1. Delete the existing policies with this command.

   ```oc delete nsp,en --all```
2. Add the new policies by running this command after replacing variables.
```
 oc process -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-ns/ocp4/knp/ocp4-pen-ns-policies.yaml -p ENVIRONMENT={ENV} -p COMMON_NAMESPACE_PREFIX={COMMON_NS_PREFIX} NAMESPACE_PREFIX={PEN_NS_PREFIX} | oc create -f -
```
