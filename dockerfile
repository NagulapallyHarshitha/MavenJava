# Stage 1: Build the Maven Java project
FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the Java JAR file
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built JAR from the Maven build stage
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080

# Run the app
CMD ["java", "-jar", "/app/app.jar"]
