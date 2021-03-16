### TO UN-Deploy Nats from an Environment
 switch to the project using oc cli and run this command. `oc delete all,pvc,configmap,statefulset -l app=nats`

### TO UN-Deploy Nats streaming from an Environment
switch to the project using oc cli and run this command. `oc delete all,pvc,configmap,statefulset -l app=stan`

### TO Deploy Nats To an Environment
`Step 1.`  Login to OC through command line. switch to the namespace you want to deploy nats.

`Step 2.`  run the command, replacing the question mark with proper namespace.
 
 `oc new-app -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/nats/nats.yml -p POD_NAMESPACE=?`
 
### TO Deploy Nats Streaming To an Environment
`Step 1.`  NATS should be up and running for NATS Streaming(STAN) to work.

`Step 2.`  Login to OC through command line. switch to the namespace you want to deploy nats streaming. run the command, replacing the question mark with proper namespace.

`Step 3.`  `oc new-app -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/nats/stan.yml -p POD_NAMESPACE=? `
