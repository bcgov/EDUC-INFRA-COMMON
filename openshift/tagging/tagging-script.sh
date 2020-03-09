#!/bin/bash
oc project c2mvws-tools
oc apply -f tagging-pipeline.yaml
echo "Version: $1"
echo "App: $2"

oc start-build tagging-pipeline -w --env=VERSION=$1 --env=APP_NAME=$2