# Redis 

## Redis Deployment
Redis can be deployed by cloning this repository locally from Git
* Switch to the correct project/namespace you're targetting
* Navigate to the `./openshift/redis` folder
* Run the following command:

```
oc process -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/redis/redis.dc.yaml | oc create -f-
```


```
oc new-app -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/redis/redis-exporter.yaml -p NAMESPACE=<provide the namespace> -p ENVIRONMENT=<provide your environment here>
```

## Redis HA Deployment
Redis HA can be deployed by cloning this repository locally from Git
* Switch to the correct project/namespace you're targetting
* Navigate to the `./openshift/redis` folder
* Run the following command:

```
oc apply -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/redis/redis-ha.dc.yaml
```
* Once the pods are running, run the following command to initialize the cluster:

```
oc exec -it redis-0 -- redis-cli --cluster create --cluster-replicas 1 $(oc get pods -l app=redis -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')
```

#Delete Scripts
##Redis
`oc -n <namespace-env> delete secret,service,dc redis`
##Redis HA
`oc delete -n <namespace-env> all,rc,svc,dc,route,pvc,secret,configmap,sa,RoleBinding -l app=redis`

