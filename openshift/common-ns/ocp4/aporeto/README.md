# Network Security Policies 

## NSP Deployment
Network Security Policies can be deployed for the common namespace by performing the following
* Run the following command:

```
 oc process -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-ns/ocp4/common-ocp-policies.yaml -p ENVIRONMENT=<env e.g. dev> -p COMMON_NAMESPACE=<common NS e.g.74a62a> NAMESPACE=<common NS e.g.85b41d> | oc create -f -
```

