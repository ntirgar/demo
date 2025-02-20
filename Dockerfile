# Use a base image with Java 17
FROM gradle:jdk21 AS buildp
COPY . .
# Build the application
RUN gradle clean bootJar
# Create a separate stage for running the application
FROM openjdk:21-jdk
# Set the working directory WORKDIR /app
# Copy the JAR file from the build stage
COPY --from=buildp /home/gradle/build/libs/demo-0.0.1-SNAPSHOT.jar app.jar
# Expose the port the app runs on
EXPOSE 80
# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
