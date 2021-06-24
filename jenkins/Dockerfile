FROM openshift/jenkins:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root

RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
RUN sed -i s/\$releasever/7/g /etc/yum.repos.d/epel-apache-maven.repo
RUN yum install -y apache-maven --skip-broken
#RUN wget https://chromedriver.storage.googleapis.com/2.40/chromedriver_linux64.zip
#RUN unzip chromedriver_linux64.zip

#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
#RUN yum install -y google-chrome-stable_current_x86_64.rpm --skip-broken

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN echo "[google-chrome]\n" \
         "name=google-chrome\n" \
         "baseurl=https://dl.google.com/linux/chrome/rpm/stable/$basearch\n" \
         "enabled=1\n" \
         "gpgcheck=1\n" \
         "gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub\n" > /etc/yum.repos.d/google-chrome.repo

RUN echo $(cat /etc/yum.repos.d/google-chrome.repo)

RUN yum -y update --nobest
RUN yum install google-chrome-stable
# drop back to the regular jenkins user - good practice
USER 1001
