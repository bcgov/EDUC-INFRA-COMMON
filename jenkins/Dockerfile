FROM openshift/jenkins:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root

RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
RUN sed -i s/\$releasever/7/g /etc/yum.repos.d/epel-apache-maven.repo
RUN yum install jpackage-utils
RUN yum install -y apache-maven
RUN wget https://chromedriver.storage.googleapis.com/2.40/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
RUN yum install google-chrome-stable_current_x86_64.rpm

# drop back to the regular jenkins user - good practice
USER 1001
