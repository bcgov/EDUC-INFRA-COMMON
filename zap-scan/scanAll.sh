#!/bin/bash
oc project c2mvws-tools
oc apply -f scan-pipeline.yaml

## 'digitalid-api' 'pen-demographics-api' 'pen-request' 'pen-request-api' 'services-card-api' 'soam-api' 'student-admin' 'student-api'}
url_array=( 'pen-request-email-api' 'pen-request-api' )
key_array=( 'penrequest-email-api' 'penrequest-api' )
for index in ${!url_array[*]}
do
    echo "Item: ${url_array[$item]}"
    oc start-build scan-pipeline -w --env=PROJECT_NAME=${url_array[$index]} --env=PROJEC_KEY${key_array[$index]}= --env=NAMESPACE='dev'
done