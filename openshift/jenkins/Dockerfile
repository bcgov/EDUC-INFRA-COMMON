FROM bcgov/jenkins-basic:v2-latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER 1001
