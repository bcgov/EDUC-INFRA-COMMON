FROM openshift/jenkins
COPY plugins.txt /plugins.txt

USER 0
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER 1001
