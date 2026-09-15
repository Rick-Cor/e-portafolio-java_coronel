# Etapa de construcción
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
# Entramos a la carpeta donde realmente vive el proyecto y el pom.xml
WORKDIR /app/evidencias
RUN mvn clean package -DskipTests

# Etapa de ejecución
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Extraemos el archivo ya compilado desde la ruta correcta
COPY --from=build /app/evidencias/target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.war"]