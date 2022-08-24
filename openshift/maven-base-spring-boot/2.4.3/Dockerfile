FROM artifacts.developer.gov.bc.ca/docker-remote/maven:3-jdk-11
WORKDIR /workspace/app
COPY pom.xml .
RUN mvn clean compile validate test
