#!/bin/bash
oc project c2mvws-tools
oc apply -f scan-pipeline.yaml

## 'digitalid-api' 'pen-demographics-api' 'pen-request' 'pen-request-api' 'services-card-api' 'soam-api' 'student-admin' 'student-api'}
url_array=( 'pen-request-email-api' 'pen-request-api' 'pen-demographics-api' 'services-card-api' 'pen-request' 'student-api' 'codetable-api' 'student-admin' 'soam-api' 'digitalid-api' )
key_array=( 'penrequest-email-api-zap' 'penrequest-api-zap' 'pen-demographics-api-zap' 'services-card-api-zap' 'pen-request-zap' 'student-api-zap' 'codetable-api-zap' 'student-admin-zap' 'soam-api-zap' 'digitalid-api-zap' )
for index in ${!url_array[*]}
do
    echo "Item: ${url_array[$item]}"
    oc start-build scan-pipeline -w --env=PROJECT_NAME=${url_array[$index]} --env=PROJECT_KEY=${key_array[$index]} --env=NAMESPACE='dev'
done