# Redis 

## Redis Deployment
Redis can be deployed by cloning this repository locally from Git
* Switch to the correct project/namespace you're targetting
* Navigate to the `./openshift/redis` folder
* Run the following command:

```
oc process -f redis.dc.yaml | oc create -f-
```


```
oc process -f redis-exporter.dc.yaml | oc create -f-
```

## Redis HA Deployment
Redis HA can be deployed by cloning this repository locally from Git
* Switch to the correct project/namespace you're targetting
* Navigate to the `./openshift/redis` folder
* Run the following command:

```
oc apply -f redis-ha.dc.yaml
```
* Once the pods are running, run the following command to initialize the cluster:

```
oc exec -it redis-0 -- redis-cli --cluster create --cluster-replicas 1 $(oc get pods -l app=redis -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')
```
* Run the following command to initialize the exporter:

```
oc process -f redis-exporter.dc.yaml | oc create -f-
```
