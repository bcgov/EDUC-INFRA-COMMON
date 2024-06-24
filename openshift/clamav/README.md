# ClamAV

ClamAV® is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.

This is a repo setup for utilization in Red Hat Openshift. This solution allows you to create a pod in your openshift environment to scan any file for known virus signatures, quickly and effectively.

The builds package the barebones service, and the deployment config will download latest signatures on first run.

Freshclam can be run within the container at any time to update the existing signatures. Alternatively, you can re-deploy which will fetch the latest into the running container.

This clamav setup is cloned from the repo: https://github.com/bcgov/clamav

## Building & Deploying On OpenShift

### Import base image for `ubi8/ubi` used by `clamav-bc.yaml`

Change to your build namespace (e.g. tools)

```
oc project <namespace>
```

Import latest version

```
oc import-image ubi8/ubi:latest --from=registry.access.redhat.com/ubi8/ubi:latest --confirm
```

## Image pull setup

Run the following command to allow your upper namespaces (DEV/TEST/PROD) to reach into tools to get the built ClamAV image:

```
oc policy add-role-to-user system:image-puller system:serviceaccount:<namespace-prefix>-dev:default --namespace=<namespace-prefix>-tools
oc policy add-role-to-user system:image-puller system:serviceaccount:<namespace-prefix>-test:default --namespace=<namespace-prefix>-tools
oc policy add-role-to-user system:image-puller system:serviceaccount:<namespace-prefix>-prod:default --namespace=<namespace-prefix>-tools
```

## Build

Add the Build Configuration to the namespace

```
oc -n <namspace> process -f "clamav-bc.yaml" | oc -n <namspace> create -f -
```

Start the build

```
oc -n <namespace> start-build bc/clamav-build
```

## Deployment

Navigate to clamav-dc.yaml in your local machine and run the following command to deploy the pod to your namespace <<TAG>> is for the image ex. latest, 1.0.1
<<namespace>> could be 75e61b-dev

```
oc process -f clamav-dc.yaml -p TAG=<<TAG>> | oc apply -n <<namespace>> -f -
```

## Versioning Deployments

Tag the latest image in the tools environment

```
oc tag -n <<namespace>> clamav:latest clamav:<<TAG>>
```

Method 1: apply a patch to the deployment config to point to the new image in DEV, TEST or PROD. Make sure to adjust the namespace appropriately. Ex.
<<namespace>> could be 75e61b-dev,
<<tools namespace>> could be 75e61b-tools.

```
oc patch dc clamav -n <<namespace>> --type=json -p '[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "image-registry.openshift-image-registry.svc:5000/<<tools namespace>>/clamav:<tag>" }]'
```

Method 2: process a new deployment config with the newest image tag <<TAG>> ex. 1.0.1 etc.
<<namespace>> could be 75e61b-dev

```
oc process -f clamav-dc.yaml -p TAG=<<TAG>> | oc apply -n <<namespace>> -f -

```
