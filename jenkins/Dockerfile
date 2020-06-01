FROM openshift/jenkins2:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root
RUN wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo 
RUN yum install -y apache-maven
#RUN yum-config-manager --enable rhel-7-server-optional-rpms
#RUN yum install -y java-11-openjdk-devel
#RUN alternatives --set java $(alternatives --display java | grep java-11 | awk '/family.*x86_64/ { print $1; }')
#RUN alternatives --set javac $(alternatives --display javac | grep java-11 | awk '/family.*x86_64/ { print $1; }')

# drop back to the regular jenkins user - good practice
USER 1001
