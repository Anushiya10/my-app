# Use a base image with Java and Maven
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the source code
COPY src /app/src
COPY pom.xml /app

# Build the application
RUN mvn clean package

# Use a lightweight base image for runtime
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar /app/my-app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "my-app.jar"]
