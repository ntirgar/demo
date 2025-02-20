# Use a base image with Java 17
FROM gradle:jdk21 AS buildp
COPY . .
# Build the application
RUN echo ${PWD} && ls -lR
RUN gradle clean bootJar
RUN echo ${PWD} && ls -lR

# Create a separate stage for running the application
FROM openjdk:21-jdk

# Set the working directory WORKDIR /app
RUN echo ${PWD} && ls -lR
# Copy the JAR file from the build stage
COPY --from=buildp /home/gradle/build/libs/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the port the app runs on
EXPOSE 80

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
