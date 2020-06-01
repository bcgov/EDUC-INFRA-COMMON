FROM openshift/jenkins:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root
RUN wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo 
RUN yum install -y apache-maven
RUN yum-config-manager --enable rhel-7-server-optional-rpms
RUN yum install java-11-openjdk-devel
# drop back to the regular jenkins user - good practice
USER 1001
