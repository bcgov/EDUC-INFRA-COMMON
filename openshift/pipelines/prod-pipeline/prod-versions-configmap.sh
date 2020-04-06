echo
echo Creating config map prod-versions-config-map
oc create -n $1-$2 configmap prod-versions-config-map --from-literal=DIGITAL_ID_API_VERSION=0.8 --from-literal=PEN_DEMOG_API_VERSION=0.8 --from-literal=PEN_REQUEST_API_VERSION=0.8 --from-literal=PEN_REQUEST_EMAIL_API_VERSION=0.8 --from-literal=SERVICES_CARD_API_VERSION=0.8 --from-literal=SOAM_API_VERSION=0.8 --from-literal=STUDENT_API_VERSION=0.8 --from-literal=PEN_REQUEST_VERSION=0.8 --from-literal=STAFF_ADMIN_VERSION=0.8 --dry-run -o yaml | oc apply -f -
echo
echo Complete.
