FROM openshift/jenkins
USER 0
#COPY ./contrib/jenkins/configuration $JENKINS_REF_HOME
COPY plugins.txt /plugins.txt
#RUN /usr/local/bin/jenkins-install-plugins /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
#RUN set -x && \
#    chgrp -R 0 $JENKINS_REF_HOME && \
#    chmod -R 644 $JENKINS_REF_HOME && \
#    chmod -R g+rwX $JENKINS_REF_HOME
#USER 1001
