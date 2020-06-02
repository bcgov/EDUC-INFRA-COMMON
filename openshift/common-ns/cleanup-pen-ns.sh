oc project <project>

#Remove Digital ID
oc delete route digitalid-api-master
oc delete svc digitalid-api-master
oc delete configmap digitalid-api-config-map
oc delete configmap digitalid-api-dev-setup-config
oc delete dc digitalid-api-master