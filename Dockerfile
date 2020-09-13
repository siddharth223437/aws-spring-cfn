#
# Build stage
# .  -f /home/app/pom.xml
FROM maven:3.6.0-jdk-11-slim AS build
COPY src spring-aws/src/
COPY pom.xml spring-aws/
WORKDIR /spring-aws

RUN mvn clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build spring-aws/target/spring-aws.jar spring-aws.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","spring-aws.jar"]