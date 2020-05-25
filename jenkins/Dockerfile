FROM openshift/jenkins:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root
RUN yum install -y yum-utils \
    yum-config-manager --add-repo http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo \
    yum-config-manager --enable epel-apache-maven \
    yum install -y apache-maven
# drop back to the regular jenkins user - good practice
USER 1001
