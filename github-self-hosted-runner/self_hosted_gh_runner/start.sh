#!/bin/bash

# the repository, example: EDUC-EDX-AUTOMATION
REPO=$REPO
# the organization, example: bcgov
ORGANIZATION=$ORGANIZATION
# a personal access token with repo admin rights
# see: https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
ACCESS_TOKEN=$ACCESS_TOKEN
# any labels for the runner
# You can use comma separation to assign multiple labels. For example: gpu,x64,linux
LABELS=$LABELS

# retrieve a registration token for this runner
echo "Obtaining access token..."
REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/repos/${ORGANIZATION}/${REPO}/actions/runners/registration-token | jq .token --raw-output)

cd /usr/local/bin/actions-runner

echo "Now configuring runner"
# register the runner with github
export RUNNER_ALLOW_RUNASROOT="1"
./config.sh --url https://github.com/${ORGANIZATION}/${REPO} --token ${REG_TOKEN} --disableupdate --labels ${LABELS}

# cleanup method is called when the container shuts down (i.e. docker [containerid] stop)
# this de-registers the runner with github before exiting
cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!