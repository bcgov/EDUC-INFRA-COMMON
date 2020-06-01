FROM openshift/jenkins2:latest
USER 0
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh /plugins.txt
USER root
RUN wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo 
RUN yum install -y apache-maven
RUN yum-config-manager --enable rhel-7-server-optional-rpms
RUN yum install -y java-11-openjdk-devel
RUN alternatives --set java $(alternatives --display java | grep java-11 | awk '/family.*x86_64/ { print $1; }')
RUN alternatives --set javac $(alternatives --display javac | grep java-11 | awk '/family.*x86_64/ { print $1; }')
ENV JAVA_TOOL_OPTIONS -XX:+UnlockExperimentalVMOptions -Dsun.zip.disableMemoryMapping=true
ENV JENKINS_OPTS --enable-future-java

CMD ["groovysh"]

ENV GROOVY_HOME /opt/groovy

RUN set -o errexit -o nounset \
    && echo "Adding groovy user and group" \
    && groupadd --system --gid 1000 groovy \
    && useradd --system --gid groovy --uid 1000 --shell /bin/bash --create-home groovy \
    && mkdir --parents /home/groovy/.groovy/grapes \
    && chown --recursive groovy:groovy /home/groovy \
    \
    && echo "Symlinking root .groovy to groovy .groovy" \
    && ln --symbolic /home/groovy/.groovy /root/.groovy

VOLUME /home/groovy/.groovy/grapes

WORKDIR /home/groovy
RUN chmod 777 /home/groovy
ENV GROOVY_VERSION 2.5.9
RUN set -o errexit -o nounset \
    && echo "Downloading Groovy" \
    && wget --no-verbose --output-document=groovy.zip "https://archive.apache.org/dist/groovy/${GROOVY_VERSION}/distribution/apache-groovy-binary-${GROOVY_VERSION}.zip" \
    \
    && echo "Installing Groovy" \
    && unzip groovy.zip \
    && rm groovy.zip \
    && mv "groovy-${GROOVY_VERSION}" "${GROOVY_HOME}/" \
    && ln --symbolic "${GROOVY_HOME}/bin/grape" /usr/bin/grape \
    && ln --symbolic "${GROOVY_HOME}/bin/groovy" /usr/bin/groovy \
    && ln --symbolic "${GROOVY_HOME}/bin/groovyc" /usr/bin/groovyc \
    && ln --symbolic "${GROOVY_HOME}/bin/groovyConsole" /usr/bin/groovyConsole \
    && ln --symbolic "${GROOVY_HOME}/bin/groovydoc" /usr/bin/groovydoc \
    && ln --symbolic "${GROOVY_HOME}/bin/groovysh" /usr/bin/groovysh \
    && ln --symbolic "${GROOVY_HOME}/bin/java2groovy" /usr/bin/java2groovy \
    \
    && echo "Editing startGroovy to include java.xml.bind module" \
    && sed --in-place 's|startGroovy ( ) {|startGroovy ( ) {\n    JAVA_OPTS="$JAVA_OPTS --add-modules=ALL-SYSTEM"|' "${GROOVY_HOME}/bin/startGroovy"

# drop back to the regular jenkins user - good practice
USER 1001
