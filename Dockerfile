# Etapa de construcción
FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY . .
RUN mvn clean package -DskipTests

# Etapa de ejecución
FROM eclipse-temurin:21-jre-alpine
COPY --from=build target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.war"]