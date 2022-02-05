# syntax=docker/dockerfile:1

FROM nexus-ci.corp.dev.vtb/maven-jdk11:latest AS MAVEN_TOOL_CHAIN
#maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY Dockerfile /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM nexus-ci.corp.dev.vtb/openjdk/openjdk-11-rhel7:latest
#adoptopenjdk/openjdk11:alpine-jre

WORKDIR /app/test
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/HelloWorldSpring-1.0-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java","-jar","app.jar"]