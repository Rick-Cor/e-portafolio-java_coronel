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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
public class PortafolioController {

    @Autowired
    private EvidenciaRepository evidenciaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    // --- Método auxiliar para ordenar las tarjetas de forma segura extrayendo el número de semana ---
    private List<Evidencia> ordenarEvidenciasSeguro(List<Evidencia> listaOriginal) {
        // Creamos una nueva lista modificable para evitar errores de inmutabilidad desde TiDB
        List<Evidencia> listaModificable = new ArrayList<>(listaOriginal);
        
        listaModificable.sort((a, b) -> {
            // Extraemos solo los números. Si el campo es nulo, lo manejamos como un string "0".
            String numeroA = (a.getSemana() != null) ? a.getSemana().replaceAll("[^0-9]", "") : "0";
            String numeroB = (b.getSemana() != null) ? b.getSemana().replaceAll("[^0-9]", "") : "0";
            
            int numA = numeroA.isEmpty() ? 0 : Integer.parseInt(numeroA);
            int numB = numeroB.isEmpty() ? 0 : Integer.parseInt(numeroB);
            
            return Integer.compare(numA, numB);
        });
        
        return listaModificable;
    }

    // Página principal pública
    @GetMapping("/")
    public String inicio(Model model) {
        List<Evidencia> listaOrdenada = ordenarEvidenciasSeguro(evidenciaRepository.findAll());
        model.addAttribute("evidencias", listaOrdenada);
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
        
        // Aplicamos el mismo ordenamiento a la vista del panel
        List<Evidencia> listaOrdenada = ordenarEvidenciasSeguro(evidenciaRepository.findAll());
        
        model.addAttribute("usuario", usuario);
        model.addAttribute("evidencias", listaOrdenada);
        return "dashboard";
    }

    // Procesar la subida de archivos y nuevos registros (Protegido por sesión)
    @PostMapping("/dashboard/subir")
    public String guardarEvidencia(@ModelAttribute Evidencia evidencia, @RequestParam("archivo") MultipartFile archivo, HttpSession session) {
        // Verificar que el usuario tenga sesión iniciada por seguridad
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            return "redirect:/login";
        }
        
        if (!archivo.isEmpty()) {
            try {
                // 1. Definir la ruta física de destino en tu proyecto local
                String carpetaDestino = "src/main/resources/static/evidencias/";
                byte[] bytes = archivo.getBytes();
                Path rutaCompleta = Paths.get(carpetaDestino + archivo.getOriginalFilename());
                
                // 2. Asegurar que la carpeta exista y guardar el archivo físicamente
                Files.createDirectories(Paths.get(carpetaDestino));
                Files.write(rutaCompleta, bytes);
                
                // 3. Asignar la ruta relativa web al objeto antes de guardar en TiDB
                evidencia.setImagenUrl("/evidencias/" + archivo.getOriginalFilename());
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // 4. Guardar los datos de texto (incluyendo la nueva URL) en la base de datos
        evidenciaRepository.save(evidencia);
        
        // 5. Recargar el panel administrativo
        return "redirect:/dashboard";
    }

    // Cerrar Sesión
    @GetMapping("/logout")
    public String cerrarSesion(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}