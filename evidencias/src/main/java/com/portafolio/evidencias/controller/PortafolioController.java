package com.portafolio.evidencias.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PortafolioController {

    @GetMapping("/")
    public String index() {
        // Retorna el nombre del archivo JSP sin la extensión
        return "index"; 
    }
}