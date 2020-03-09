#!/bin/bash
oc project c2mvws-tools
oc apply -f tagging-pipeline.yaml

array=('educ-codetable-api-master' 'educ-pen-request-email-api-master' 'sso' 'educ-digitalid-api-master' 'educ-pen-demog-api-master' 'educ-pen-request-backend' 'educ-pen-request' 'educ-pen-request-api-master' 'educ-pen-request-frontend-static' 'educ-services-card-api-master' 'educ-soam-api-master' 'educ-student-admin-backend' 'educ-student-admin-frontend-static' 'educ-student-api-master')
for item in ${array[*]}
do
    echo "Item: $item"
    sh ./tagging-script.sh $1 $item 
done

oc delete bc/tagging-pipeline