### TO Deploy Nats To an Environment
`Step 1.`  Login to OC through command line. switch to the namespace you want to deploy nats.

`Step 2.`  run the command, replacing the question mark with proper namespace.
 
 `oc new-app -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/feature/nats/openshift/nats/nats.yml -p POD_NAMESPACE=?`
 
### TO Deploy Nats Streaming To an Environment
`Step 1.`  NATS should be up and running for NATS Streaming(STAN) to work.

`Step 2.`  Login to OC through command line. switch to the namespace you want to deploy nats streaming.

`Step 3.` run the command `oc apply -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/nats/stan.yml`