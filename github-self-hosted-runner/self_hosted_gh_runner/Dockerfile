########
# Creates a linux-based self-hosted gihub actions runner
# that can be run in a containerized environment.
# See the corresponding start.sh script for operational details
########

# base
FROM ghcr.io/bcgov/gh-runner-base:latest

# copy over the start.sh script
COPY start.sh start.sh

# make the script executable
RUN chmod +x start.sh

# since the config and run script for actions are not allowed to be run by root,
# set the user to "docker" so all subsequent commands are run as the docker user
# not working in OS: https://stackoverflow.com/questions/41415031/openshift-does-not-honor-the-user-directive-in-dockerfile
#USER 1001

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]