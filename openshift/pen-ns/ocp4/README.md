# Network Security Policies 

## NSP Deployment
Network Security Policies can be deployed for the PEN namespace by performing the following
* Switch to the correct project/namespace you're targetting
* Navigate to the `./openshift/pen-ns/ocp4` folder
* Run the following command:

```
 oc process -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/pen-ns/ocp4/pen-ocp-policies.yaml -p ENVIRONMENT=<env e.g. dev> -p COMMON_NAMESPACE=<common NS e.g.74a62a> NAMESPACE=<common NS e.g.85b41d> | oc create -f -
```
