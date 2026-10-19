# syntax=docker/dockerfile:1
# =============================================================================
#  Dockerfile de producción - e-Portafolio (Spring Boot 3.2 + JSP, Java 21)
#  - Multi-stage: compila con Maven y ejecuta solo con un JRE ligero (Alpine)
#  - Caché de dependencias: pom.xml se copia antes que el código fuente
#  - Seguridad: se ejecuta con un usuario sin privilegios (no root)
#  - La conexión a la BD (TiDB en Render / MySQL en local) se inyecta por
#    variables de entorno: SPRING_DATASOURCE_URL, _USERNAME, _PASSWORD
# =============================================================================

# ---------- Etapa 1: Construcción ----------
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build

# 1) Solo el pom.xml: esta capa (dependencias) se reutiliza mientras el pom no cambie
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

# 2) Código fuente y empaquetado del WAR ejecutable
COPY src ./src
RUN mvn -B -q package -DskipTests \
 && cp target/*.war /build/app.war

# ---------- Etapa 2: Ejecución ----------
FROM eclipse-temurin:21-jre-alpine AS runtime

# Usuario sin privilegios
RUN addgroup -S spring && adduser -S spring -G spring

WORKDIR /app

# El controlador guarda las subidas en una ruta relativa al directorio de trabajo
# (src/main/resources/static/evidencias/). Se crea con permisos para el usuario.
RUN mkdir -p /app/src/main/resources/static/evidencias \
 && chown -R spring:spring /app

COPY --from=build --chown=spring:spring /build/app.war /app/app.war

USER spring

# Opciones de la JVM pensadas para contenedores con poca memoria (p. ej. Render 512 MB).
# JAVA_TOOL_OPTIONS es leída automáticamente por la JVM.
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75.0 -XX:+UseSerialGC -XX:+ExitOnOutOfMemoryError -Djava.security.egd=file:/dev/./urandom -Duser.timezone=UTC" \
    SPRING_JPA_SHOW_SQL=false

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.war"]