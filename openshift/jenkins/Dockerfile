FROM bcgov/jenkins-basic:v2-stable
COPY plugins.txt /plugins.txt

USER 0
RUN /usr/local/bin/install-plugins.sh /plugins.txt
RUN set -x && \
    chgrp -R 0 $JENKINS_REF_HOME && \
    chmod -R 644 $JENKINS_REF_HOME && \
    chmod -R g+rwX $JENKINS_REF_HOME
USER 1001
