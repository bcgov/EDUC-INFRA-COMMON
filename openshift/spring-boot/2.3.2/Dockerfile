FROM maven:3-jdk-11
WORKDIR /workspace/app
COPY pom.xml .
RUN mvn -B dependency:go-offline
