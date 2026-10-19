package com.portafolio.evidencias.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Permite servir dinámicamente los archivos subidos al disco sin reiniciar el servidor
        Path uploadDir = Paths.get("src/main/resources/static/evidencias").toAbsolutePath().normalize();
        
        registry.addResourceHandler("/evidencias/**")
                .addResourceLocations(
                        "classpath:/static/evidencias/",
                        uploadDir.toUri().toString()
                );
    }
}
