FROM docker-remote.artifacts.developer.gov.bc.ca/maven:3-jdk-11
WORKDIR /workspace/app
COPY pom.xml .
RUN mvn validate
