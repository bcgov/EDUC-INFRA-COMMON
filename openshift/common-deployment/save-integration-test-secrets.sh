envValue=$1
OPENSHIFT_NAMESPACE=$2
TOKEN=$3
OWNER=$4
REPO_NAME=$5
TARGET_ENVIRONMENT=$6
APP_NAME=$7
CLIENT_ID=$8

SOAM_KC_REALM_ID="master"
KCADM_FILE_BIN_FOLDER="/tmp/keycloak-9.0.3/bin"

curl https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/openshift/common-deployment/download-kc.sh | bash /dev/stdin "${OPENSHIFT_NAMESPACE}"

oc project "$OPENSHIFT_NAMESPACE"-"$envValue"

SOAM_KC_LOAD_USER_ADMIN=$(oc -o json get secret sso-admin-"${envValue}" | sed -n 's/.*"username": "\(.*\)"/\1/p' | base64 --decode)
SOAM_KC_LOAD_USER_PASS=$(oc -o json get secret sso-admin-"${envValue}" | sed -n 's/.*"password": "\(.*\)",/\1/p' | base64 --decode)
SOAM_KC=$OPENSHIFT_NAMESPACE-$envValue.pathfinder.gov.bc.ca

$KCADM_FILE_BIN_FOLDER/kcadm.sh config credentials --server https://$SOAM_KC/auth --realm $SOAM_KC_REALM_ID --user "$SOAM_KC_LOAD_USER_ADMIN" --password "$SOAM_KC_LOAD_USER_PASS"

getItClientID(){
    executorID= $KCADM_FILE_BIN_FOLDER/kcadm.sh get clients -r $SOAM_KC_REALM_ID --fields 'id,clientId' | grep -B2 "\"clientId\" : \"${CLIENT_ID}\"" | grep -Po "(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}"
}
itClientID=$(getItClientID)

getItClientSecret(){
    executorID= $KCADM_FILE_BIN_FOLDER/kcadm.sh get clients/$itClientID/client-secret -r $SOAM_KC_REALM_ID | grep -Po "(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}"
}
itClientSecret=$(getItClientSecret)


if [ ! -f /tmp/github-tools-v1.0.0-linux-x64.tar.gz ]
then
    echo 'Downloading and unzipping github-tools files...'
    wget -P /tmp -nc https://github.com/bcgov/EDUC-INFRA-COMMON/raw/master/github-tools/dist/github-tools-v1.0.0/github-tools-v1.0.0-linux-x64.tar.gz
    cd /tmp
    tar zxvf github-tools-v1.0.0-linux-x64.tar.gz
fi

/tmp/github-tools/bin/github-tools createSecret ${TOKEN} ${OWNER} ${REPO_NAME} SOAM_DISCOVERY_URL https://${TARGET_ENVIRONMENT}.pathfinder.gov.bc.ca/auth/realms/master/.well-known/openid-configuration
/tmp/github-tools/bin/github-tools createSecret ${TOKEN} ${OWNER} ${REPO_NAME} SOAM_CLIENT_ID ${APP_NAME}-it
/tmp/github-tools/bin/github-tools createSecret ${TOKEN} ${OWNER} ${REPO_NAME} SOAM_CLIENT_SECRET ${itClientSecret}
/tmp/github-tools/bin/github-tools createSecret ${TOKEN} ${OWNER} ${REPO_NAME} API_URL https://${APP_NAME}-${TARGET_ENVIRONMENT}.pathfinder.gov.bc.ca