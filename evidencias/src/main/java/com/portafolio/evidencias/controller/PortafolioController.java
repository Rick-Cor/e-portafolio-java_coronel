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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class PortafolioController {

    @Autowired
    private EvidenciaRepository evidenciaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Directorio donde se guardan físicamente los archivos subidos
    private static final String CARPETA_SUBIDAS = "src/main/resources/static/evidencias/";

    // --- Método auxiliar para ordenar las tarjetas de forma segura extrayendo el número de semana ---
    private List<Evidencia> ordenarEvidenciasSeguro(List<Evidencia> listaOriginal) {
        List<Evidencia> listaModificable = new ArrayList<>(listaOriginal);
        
        listaModificable.sort((a, b) -> {
            String numeroA = (a.getSemana() != null) ? a.getSemana().replaceAll("[^0-9]", "") : "0";
            String numeroB = (b.getSemana() != null) ? b.getSemana().replaceAll("[^0-9]", "") : "0";
            
            int numA = numeroA.isEmpty() ? 0 : Integer.parseInt(numeroA);
            int numB = numeroB.isEmpty() ? 0 : Integer.parseInt(numeroB);
            
            return Integer.compare(numA, numB);
        });
        
        return listaModificable;
    }

    // Página principal pública (disponible en /, /index y /inicio)
    @GetMapping({"/", "/index", "/inicio"})
    public String inicio(Model model) {
        List<Evidencia> listaOrdenada = ordenarEvidenciasSeguro(evidenciaRepository.findAll());
        model.addAttribute("evidencias", listaOrdenada);
        return "index";
    }

    // Mostrar vista de Login
    @GetMapping("/login")
    public String mostrarLogin(HttpSession session) {
        if (session.getAttribute("usuarioLogueado") != null) {
            return "redirect:/dashboard";
        }
        return "login";
    }

    // Procesar formulario de Login
    @PostMapping("/login")
    public String procesarLogin(@RequestParam String correo, 
                                @RequestParam String password, 
                                HttpSession session, 
                                Model model) {
        Usuario usuario = usuarioRepository.findByCorreoAndPassword(correo, password);
        if (usuario != null) {
            session.setAttribute("usuarioLogueado", usuario);
            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Correo o contraseña incorrectos.");
            model.addAttribute("correoIngresado", correo);
            return "login";
        }
    }

    // Mostrar Panel de Administración (Protegido por sesión)
    @GetMapping("/dashboard")
    public String mostrarDashboard(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            return "redirect:/login";
        }
        
        List<Evidencia> listaOrdenada = ordenarEvidenciasSeguro(evidenciaRepository.findAll());
        
        model.addAttribute("usuario", usuario);
        model.addAttribute("evidencias", listaOrdenada);
        return "dashboard";
    }

    // Procesar la subida y creación de una nueva evidencia
    @PostMapping("/dashboard/subir")
    public String guardarEvidencia(@ModelAttribute Evidencia evidencia, 
                                   @RequestParam("archivo") MultipartFile archivo, 
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            return "redirect:/login";
        }
        
        try {
            if (archivo != null && !archivo.isEmpty()) {
                String nombreLimpio = limpiarNombreArchivo(archivo.getOriginalFilename());
                Path rutaDestino = Paths.get(CARPETA_SUBIDAS).toAbsolutePath().normalize();
                Files.createDirectories(rutaDestino);
                
                Path archivoFinal = rutaDestino.resolve(nombreLimpio);
                Files.copy(archivo.getInputStream(), archivoFinal, StandardCopyOption.REPLACE_EXISTING);
                
                evidencia.setImagenUrl("/evidencias/" + nombreLimpio);
            } else if (evidencia.getImagenUrl() == null || evidencia.getImagenUrl().trim().isEmpty()) {
                evidencia.setImagenUrl("#");
            }
            
            evidenciaRepository.save(evidencia);
            redirectAttributes.addFlashAttribute("mensajeExito", "Evidencia registrada correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("mensajeError", "Error al guardar la evidencia: " + e.getMessage());
        }
        
        return "redirect:/dashboard";
    }

    // Procesar la edición de una evidencia existente (título, descripción, semana y archivo)
    @PostMapping("/dashboard/editar")
    public String editarEvidencia(@RequestParam("id") Long id,
                                  @RequestParam("semana") String semana,
                                  @RequestParam("titulo") String titulo,
                                  @RequestParam("descripcion") String descripcion,
                                  @RequestParam(value = "archivo", required = false) MultipartFile archivo,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            return "redirect:/login";
        }

        try {
            Optional<Evidencia> evidenciaOpt = evidenciaRepository.findById(id);
            if (evidenciaOpt.isPresent()) {
                Evidencia evidencia = evidenciaOpt.get();
                evidencia.setSemana(semana);
                evidencia.setTitulo(titulo);
                evidencia.setDescripcion(descripcion);

                // Si se adjuntó un nuevo archivo, se reemplaza la URL
                if (archivo != null && !archivo.isEmpty()) {
                    String nombreLimpio = limpiarNombreArchivo(archivo.getOriginalFilename());
                    Path rutaDestino = Paths.get(CARPETA_SUBIDAS).toAbsolutePath().normalize();
                    Files.createDirectories(rutaDestino);
                    
                    Path archivoFinal = rutaDestino.resolve(nombreLimpio);
                    Files.copy(archivo.getInputStream(), archivoFinal, StandardCopyOption.REPLACE_EXISTING);
                    
                    evidencia.setImagenUrl("/evidencias/" + nombreLimpio);
                }

                evidenciaRepository.save(evidencia);
                redirectAttributes.addFlashAttribute("mensajeExito", "Evidencia actualizada correctamente.");
            } else {
                redirectAttributes.addFlashAttribute("mensajeError", "La evidencia con ID " + id + " no existe.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("mensajeError", "Error al actualizar la evidencia: " + e.getMessage());
        }

        return "redirect:/dashboard";
    }

    // Procesar la eliminación de una evidencia
    @PostMapping("/dashboard/eliminar")
    public String eliminarEvidencia(@RequestParam("id") Long id,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            return "redirect:/login";
        }

        try {
            if (evidenciaRepository.existsById(id)) {
                evidenciaRepository.deleteById(id);
                redirectAttributes.addFlashAttribute("mensajeExito", "Evidencia eliminada correctamente.");
            } else {
                redirectAttributes.addFlashAttribute("mensajeError", "La evidencia a eliminar no existe.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("mensajeError", "Error al eliminar: " + e.getMessage());
        }

        return "redirect:/dashboard";
    }

    // Cerrar Sesión
    @GetMapping("/logout")
    public String cerrarSesion(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // Limpia el nombre del archivo para evitar caracteres problemáticos
    private String limpiarNombreArchivo(String original) {
        if (original == null || original.isEmpty()) {
            return "archivo_" + System.currentTimeMillis();
        }
        // Conservar nombre base y sanitizar caracteres inválidos en URLs/rutas
        return Paths.get(original).getFileName().toString().replaceAll("[\\\\/:*?\"<>|]", "_");
    }
}