oc project <project>

#Remove Digital ID API
oc delete route digitalid-api-master
oc delete svc digitalid-api-master
oc delete configmap digitalid-api-config-map
oc delete dc digitalid-api-master

#Remove Student API
oc delete route student-api-master
oc delete svc student-api-master
oc delete configmap student-api-config-map
oc delete dc student-api-master

#Remove PEN Request API
oc delete route pen-request-api-master
oc delete svc pen-request-api-master
oc delete configmap pen-request-api-config-map
oc delete dc pen-request-api-master

#Remove Services Card API
oc delete route services-card-api-master
oc delete svc services-card-api-master
oc delete configmap services-card-api-config-map
oc delete dc services-card-api-master

#Remove PEN Demog API
oc delete route pen-demographics-api-master
oc delete svc pen-demographics-api-master
oc delete configmap pen-demog-api-config-map
oc delete dc pen-demographics-api-master

#Remove SOAM API
oc delete route soam-api-master
oc delete svc soam-api-master
oc delete configmap soam-api-config-map
oc delete dc soam-api-master

#Remove SOAM SSO
oc delete all,rc,svc,dc,route,pvc,secret,configmap,sa -l app-name=sso
oc delete pvc -l statefulset=sso-pgsql-prod
oc delete cm -l cluster-name=sso-pgsql-prod
oc delete configmap soam-sso-config-map