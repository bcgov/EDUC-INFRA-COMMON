# Patroni 

## Patroni Deployment
* Patroni can be deployed by cloning this repository locally from Git
* Switch to the correct project/namespace you're targetting
* Navigate to the `./openshift/patroni` folder
* Edit the `saga.env` and `saga-secrets.env`
* Run the following command to deploy Patroni for Saga API:

```
oc process --param-file=saga-secrets.env -f patroni-postgresql-secrets.yaml | oc create -f -
```


```
oc process --param-file=saga.env -f patroni-postgresql.yaml | oc create -f - 
```


