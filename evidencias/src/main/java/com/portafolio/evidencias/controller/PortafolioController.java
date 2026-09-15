package com.portafolio.evidencias.controller;

import com.portafolio.evidencias.model.Evidencia;
import com.portafolio.evidencias.repository.EvidenciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;

@Controller
public class PortafolioController {

    @Autowired
    private EvidenciaRepository evidenciaRepository;

    @GetMapping("/")
    public String inicio(Model model) {
        // 1. Extraemos todas las evidencias de la base de datos
        List<Evidencia> listaEvidencias = evidenciaRepository.findAll();
        // 2. Las enviamos a la vista JSP bajo el nombre "evidencias"
        model.addAttribute("evidencias", listaEvidencias);
        return "index";
    }
}