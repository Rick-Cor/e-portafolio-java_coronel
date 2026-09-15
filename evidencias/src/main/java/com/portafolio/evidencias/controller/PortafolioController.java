package com.portafolio.evidencias.controller;

import com.portafolio.evidencias.model.Evidencia;
import com.portafolio.evidencias.model.Usuario;
import com.portafolio.evidencias.repository.EvidenciaRepository;
import com.portafolio.evidencias.repository.UsuarioRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

@Controller
public class PortafolioController {

    @Autowired
    private EvidenciaRepository evidenciaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Página principal pública
    @GetMapping("/")
    public String inicio(Model model) {
        List<Evidencia> listaEvidencias = evidenciaRepository.findAll();
        model.addAttribute("evidencias", listaEvidencias);
        return "index";
    }

    // Mostrar vista de Login
    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    // Procesar formulario de Login
    @PostMapping("/login")
    public String procesarLogin(@RequestParam String correo, @RequestParam String password, HttpSession session, Model model) {
        Usuario usuario = usuarioRepository.findByCorreoAndPassword(correo, password);
        if (usuario != null) {
            // Guardamos la sesión del administrador
            session.setAttribute("usuarioLogueado", usuario);
            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Correo o contraseña incorrectos.");
            return "login";
        }
    }

    // Mostrar Panel de Administración (Protegido por sesión)
    @GetMapping("/dashboard")
    public String mostrarDashboard(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            return "redirect:/login"; // Si no ha iniciado sesión, lo devuelve al login
        }
        List<Evidencia> listaEvidencias = evidenciaRepository.findAll();
        model.addAttribute("usuario", usuario);
        model.addAttribute("evidencias", listaEvidencias);
        return "dashboard";
    }

    // Cerrar Sesión
    @GetMapping("/logout")
    public String cerrarSesion(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}