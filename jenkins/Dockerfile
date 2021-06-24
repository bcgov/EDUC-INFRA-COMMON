FROM openshift/jenkins:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root

RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
RUN sed -i s/\$releasever/7/g /etc/yum.repos.d/epel-apache-maven.repo
RUN yum install -y apache-maven --skip-broken
RUN wget https://chromedriver.storage.googleapis.com/2.40/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip

RUN yum install apt
#==============================
# Google Chrome Stable - Latest
#==============================
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
        | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google.list \
  && apt-get -qy update \
  && apt-get -qy install -y google-chrome-stable \
  && apt-get -qyy autoremove \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get -qyy clean \
  && echo google-chrome-stable --version

#==================
# Chrome webdriver
#==================
# Credits to https://github.com/elgalu/docker-selenium
ENV CHROME_DRIVER_VERSION="2.38" \
    CHROME_DRIVER_BASE="chromedriver.storage.googleapis.com" \
    CPU_ARCH="64"
ENV CHROME_DRIVER_FILE="chromedriver_linux${CPU_ARCH}.zip"
ENV CHROME_DRIVER_URL="https://${CHROME_DRIVER_BASE}/${CHROME_DRIVER_VERSION}/${CHROME_DRIVER_FILE}"
RUN  wget -nv -O chromedriver_linux${CPU_ARCH}.zip ${CHROME_DRIVER_URL} \
  && unzip chromedriver_linux${CPU_ARCH}.zip \
  && rm chromedriver_linux${CPU_ARCH}.zip \
  && chmod 755 chromedriver \
  && mv chromedriver /usr/local/bin/ \
  && chromedriver --version

#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
#RUN yum install google-chrome-stable_current_x86_64.rpm
# drop back to the regular jenkins user - good practice
USER 1001
