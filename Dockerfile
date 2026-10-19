# syntax=docker/dockerfile:1
# =============================================================================
#  Dockerfile para Microsoft Azure y Despliegue en la Raíz del Repositorio
#  - Multi-stage build optimizado para Java 21 + Spring Boot (WAR ejecutable)
#  - Etapa 1: Caché de dependencias Maven con pom.xml y compilación
#  - Etapa 2: Imagen ligera Alpine JRE con usuario seguro no-root
#  - Puerto estándar: EXPOSE 8080 (compatible con PORT y WEBSITES_PORT de Azure)
# =============================================================================

# ---------- Etapa 1: Compilación ----------
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build

# 1) Descarga de dependencias (capa cacheable)
COPY evidencias/pom.xml .
RUN mvn -B -q dependency:go-offline

# 2) Código fuente y empaquetado del WAR
COPY evidencias/src ./src
RUN mvn -B -q package -DskipTests \
 && cp target/*.war /build/app.war

# ---------- Etapa 2: Imagen Ligera de Ejecución ----------
FROM eclipse-temurin:21-jre-alpine AS runtime

RUN addgroup -S spring && adduser -S spring -G spring
WORKDIR /app

RUN mkdir -p /app/src/main/resources/static/evidencias \
 && chown -R spring:spring /app

COPY --from=build --chown=spring:spring /build/app.war /app/app.war

USER spring

ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75.0 -XX:+UseSerialGC -XX:+ExitOnOutOfMemoryError -Djava.security.egd=file:/dev/./urandom -Duser.timezone=UTC" \
    SPRING_JPA_SHOW_SQL=false

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.war"]
