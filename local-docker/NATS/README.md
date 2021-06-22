For Ephermal(Stateless) Nats with Jetstream just run this docker command in your local.

```
docker run -d -p 4222:4222 nats -js
```
###
For Clustered and PVC setup use the docker-compose yaml.
please create 3 directories in the project
```
data-0, data-1, data-2
```

Run the below command after switching to the project directory.

```
docker-compose up -d
```
