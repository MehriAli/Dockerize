FROM maven:4.0.0 AS maven

WORKDIR /src/app
COPY . /src/app
# Compile and package the application to an executable JAR
RUN mvn package 

# For Java 11, 
FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=demo.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","demo.jar"]
