# Stage 1: Build the application
FROM gradle:7.5.1-jdk11 AS build
WORKDIR /home/gradle/src
COPY --chown=gradle:gradle . /home/gradle/src
RUN gradle build --no-daemon

# Stage 2: Run the application
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY --from=build /home/gradle/src/build/libs/notebook_backend-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]