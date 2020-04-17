FROM bcgov/jenkins-basic:v2-stable
COPY plugins.txt /plugins.txt

USER 0
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER 1001
