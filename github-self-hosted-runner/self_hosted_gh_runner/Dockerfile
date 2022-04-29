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

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]