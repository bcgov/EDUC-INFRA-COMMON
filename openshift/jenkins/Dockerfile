FROM openshift/jenkins-2-centos7
COPY plugins.txt /plugins.txt

USER 0
RUN /usr/local/bin/install-plugins.sh /plugins.txt
