FILE=./properties/setup-sonarqube.properties

OPENSHIFT_NAMESPACE=$(grep -i 'OPENSHIFT_NAMESPACE' $FILE  | cut -f2 -d'=')
JP_LOCATION=$(grep -i 'JP_LOCATION' $FILE  | cut -f2 -d'=')
if [ -z "$JP_LOCATION" ]
then
      JQ=jq
else
      JQ=$JP_LOCATION/jq-win64.exe
fi


echo Properties Defined
echo -----------------------------------------------------------
echo OPENSHIFT_NAMESPACE: $OPENSHIFT_NAMESPACE
echo Other properties omitted. 
echo -----------------------------------------------------------



envValue=tools

oc project $OPENSHIFT_NAMESPACE-$envValue

echo "Deploying SonarQube app..."
oc new-app -f https://raw.githubusercontent.com/BCDevOps/sonarqube/master/sonarqube-postgresql-template.yaml --param=SONARQUBE_VERSION=8.2
oc rollout status dc/sonarqube --watch

#########################################################################################
# From https://github.com/BCDevOps/sonarqube/blob/master/provisioning/updatesqadminpw.sh
#generate new admin password to override silly default
admin_password=$(oc -o json get secret sonarqube-admin-password | sed -n 's/.*"password": "\(.*\)",/\1/p' | base64 --decode)

echo "Updating SonarQube with generated password"
sleep 30s
# figure out the sonarqube route so we know where to access the API
sonarqube_url=$(oc get routes | awk '/sonarqube/{print $2}')
curl -G -X POST -v -u admin:admin --data-urlencode "login=admin" --data-urlencode "password=$admin_password" --data-urlencode "previousPassword=admin" "https://$sonarqube_url/api/users/change_password"
#########################################################################################
SONARQUBE_PW=$admin_password
SONARQUBE_URL="https://$sonarqube_url"
SONARQUBE_USER="admin"

echo Creating SonarQube tokens
echo Creating Digital ID API token
SONAR_TOKEN_DIGITALID_API=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=Digital ID API" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')
echo Creating PEN Request token
SONAR_TOKEN_PEN_REQUEST=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=PEN Request" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')
echo Creating PEN Request API token
SONAR_TOKEN_PEN_REQUEST_API=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=PEN Request API" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')
echo Creating PEN Request Email API token
SONAR_TOKEN_PEN_REQUEST_EMAIL_API=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=PEN Request Email API" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')
echo Creating SOAM API token
SONAR_TOKEN_SOAM_API=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=SOAM API" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')
echo Creating Student API token
SONAR_TOKEN_STUDENT_API=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=Student API" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')
echo Creating Services Card API token
SONAR_TOKEN_SERVICES_CARD_API=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=Services Card API" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')
echo Creating PEN Demog API token
SONAR_TOKEN_PEN_DEMOG_API=$(curl --silent -u $SONARQUBE_USER:$SONARQUBE_PW -X POST --data "name=PEN Demog API" "$SONARQUBE_URL/api/user_tokens/generate" | $JQ '.token')


echo
echo Re-creating digitalid-api-secrets
oc delete secret digitalid-api-secrets
oc create secret generic digitalid-api-secrets --from-literal=sonarqube-token=${SONAR_TOKEN_DIGITALID_API//\"} --from-literal=sonarqube-host=$SONARQUBE_URL

echo Re-creating pen-request-secrets
oc delete secret pen-request-secrets 
oc create secret generic pen-request-secrets --from-literal=sonarqube-token=${SONAR_TOKEN_PEN_REQUEST//\"} --from-literal=sonarqube-host=$SONARQUBE_URL

echo Re-creating pen-request-api-secrets
oc delete secret pen-request-api-secrets
oc create secret generic pen-request-api-secrets --from-literal=sonarqube-token=${SONAR_TOKEN_PEN_REQUEST_API//\"} --from-literal=sonarqube-host=$SONARQUBE_URL

echo Re-creating pen-request-email-api-secrets
oc delete secret pen-request-email-api-secrets
oc create secret generic pen-request-email-api-secrets --from-literal=sonarqube-token=${SONAR_TOKEN_PEN_REQUEST_EMAIL_API//\"} --from-literal=sonarqube-host=$SONARQUBE_URL

echo Re-creating soam-api-secrets
oc delete secret soam-api-secrets
oc create secret generic soam-api-secrets --from-literal=sonarqube-token=${SONAR_TOKEN_SOAM_API//\"} --from-literal=sonarqube-host=$SONARQUBE_URL

echo Re-creating student-api-secrets
oc delete secret student-api-secrets
oc create secret generic student-api-secrets --from-literal=sonarqube-token=${SONAR_TOKEN_STUDENT_API//\"} --from-literal=sonarqube-host=$SONARQUBE_URL

echo Re-creating services-card-api-secrets
oc delete secret services-card-api-secrets
oc create secret generic services-card-api-secrets --from-literal=sonarqube-token=${SONAR_TOKEN_SERVICES_CARD_API//\"} --from-literal=sonarqube-host=$SONARQUBE_URL

echo Re-creating pen-demographics-api-secrets
oc delete secret pen-demographics-api-secrets
oc create secret generic pen-demographics-api-secrets --from-literal=sonarqube-token="${SONAR_TOKEN_PEN_DEMOG_API//\"}" --from-literal=sonarqube-host=$SONARQUBE_URL
echo Complete.
