# Use Java 21 as the base image
FROM eclipse-temurin:21-jdk-alpine

# Set working directory
WORKDIR /app

# Install necessary packages
RUN apk add --no-cache curl

# Download Maven wrapper
RUN curl -o mvnw https://raw.githubusercontent.com/takari/maven-wrapper/master/mvnw && \
    chmod +x mvnw && \
    mkdir -p .mvn/wrapper && \
    curl -o .mvn/wrapper/maven-wrapper.jar https://repo.maven.apache.org/maven2/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar && \
    curl -o .mvn/wrapper/maven-wrapper.properties https://raw.githubusercontent.com/takari/maven-wrapper/master/.mvn/wrapper/maven-wrapper.properties

# Copy pom.xml
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "target/lms-backend-0.0.1-SNAPSHOT.jar"] 
