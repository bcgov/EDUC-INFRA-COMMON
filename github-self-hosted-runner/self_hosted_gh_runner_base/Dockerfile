########
# Creates a linux-based self-hosted gihub actions runner base
# that can be run in a containerized environment.
########

# base
FROM ubuntu:18.04

# set the github runner version
ARG RUNNER_VERSION="2.298.2"

# update the base packages
RUN apt-get update -y && apt-get upgrade -y

# install the packages the your code depends on along with jq so we can parse JSON
# add additional packages as necessary
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget firefox curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# install node and npm
#RUN apt-get install -y nodejs npm
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

# maybe npm update latest?

# install chrome headless
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb

# cd into the user directory, download and unzip the github actions runner
RUN cd /usr/local/bin && mkdir actions-runner && cd actions-runner \
    && wget --no-check-certificate https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && bin/installdependencies.sh

# ensure any user can rwx on gh actions folder
RUN chmod -R a+rwx /usr/local/bin/actions-runner

# ensure any user can rwx on node and chrome
RUN mkdir /.npm \
    && chmod -R a+rwx /.npm \
    && mkdir /.local \
    && chmod -R a+rwx /.local

# cleanup
RUN apt autoremove -y \
    && rm /google-chrome-stable_current_amd64.deb