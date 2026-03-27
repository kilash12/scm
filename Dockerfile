
# Stage 1: Build the JAR with Maven
FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY --from=builder /build/target/0-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
# FROM eclipse-temurin:21-jdk-jammy

# WORKDIR /app

# #COPY dist/scm2.0-0.0.1-SNAPSHOT.jar /app/scm2.0-0.0.1-SNAPSHOT.jar
# # COPY target/0-0.0.1-SNAPSHOT.jar /app/app.jar
# COPY target/0-0.0.1-SNAPSHOT.jar app.jar

# EXPOSE 8081
# ENTRYPOINT ["java","-jar","app.jar"]

# # ENTRYPOINT ["java", "-jar", "scm2.0-0.0.1-SNAPSHOT.jar"]
