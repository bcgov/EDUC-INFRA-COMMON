FROM maven:3-jdk-11 as build
WORKDIR /workspace/app
COPY pom.xml .
RUN mvn clean package -DskipTests
