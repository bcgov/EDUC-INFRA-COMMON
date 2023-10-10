# Redis

## Redis HA Deployment

Redis HA can be deployed by cloning this repository locally from Git

- Switch to the correct project/namespace you're targetting
- Navigate to the `./openshift/redis` folder
- Run the following command:

```
oc apply -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/redis/redis-ha.dc.yaml
```

- Once the pods are running, run the following command to initialize the cluster:

```
oc exec -it redis-0 -- redis-cli --cluster create --cluster-replicas 1 $(oc get pods -l app=redis -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}')
```

#Delete Scripts
##Redis
`oc -n <namespace-env> delete secret,service,dc redis`
##Redis HA
`oc delete -n <namespace-env> all,rc,svc,dc,route,pvc,secret,configmap,sa,RoleBinding -l app=redis`
