# Redis 

## Redis Deployment
* Redis can be deployed by cloning this repository locally from Git
* Switch to the correct project/namespace you're targetting
* Navigate to the `./openshift/redis` folder
* Run the following command:

```
oc process -f redis.dc.yaml | oc create -f-
```

