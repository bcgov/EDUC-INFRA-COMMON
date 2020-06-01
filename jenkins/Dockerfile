FROM openshift/jenkins:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root
RUN wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo 
RUN yum install -y apache-maven
RUN yum-config-manager --enable rhel-7-server-optional-rpms
RUN yum install -y java-11-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-11.0.7.10-4.el7_8.x86_64
# drop back to the regular jenkins user - good practice
USER 1001
