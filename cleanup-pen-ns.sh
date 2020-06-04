oc project <project>

#Remove Digital ID API
oc delete route digitalid-api-master
oc delete svc digitalid-api-master
oc delete configmap digitalid-api-config-map
oc delete configmap digitalid-api-dev-setup-config
oc delete dc digitalid-api-master

#Remove Student API
oc delete route student-api-master
oc delete svc student-api-master
oc delete configmap student-api-config-map
oc delete configmap student-api-dev-setup-config
oc delete dc student-api-master

#Remove PEN Request API
oc delete route pen-request-api-master
oc delete svc pen-request-api-master
oc delete configmap pen-request-api-config-map
oc delete configmap pen-request-api-dev-setup-config
oc delete dc pen-request-api-master

#Remove Services Card API
oc delete route services-card-api-master
oc delete svc services-card-api-master
oc delete configmap services-card-api-config-map
oc delete configmap services-card-api-dev-setup-config
oc delete dc services-card-api-master

#Remove PEN Demog API
oc delete route pen-demographics-api-master
oc delete svc pen-demographics-api-master
oc delete configmap pen-demog-api-config-map
oc delete configmap pen-demographics-api-dev-setup-config
oc delete dc pen-demographics-api-master

#Remove SOAM API
oc delete route soam-api-master
oc delete svc soam-api-master
oc delete configmap soam-api-config-map
oc delete dc soam-api-master

#Remove SOAM SSO
oc delete all,rc,svc,dc,route,pvc,secret,configmap,sa -l app-name=sso
oc delete pvc -l statefulset=sso-pgsql-dev
oc delete cm -l cluster-name=sso-pgsql-dev
oc delete configmap soam-sso-config-map

#Remove NATS
oc delete all,rc,svc,dc,route,pvc,secret -l app=nats
oc delete configmap nats-config

#Remove STAN
oc delete all,rc,svc,dc,route,pvc,secret -l app=stan
oc delete configmap stan-config