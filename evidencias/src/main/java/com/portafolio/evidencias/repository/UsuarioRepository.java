package com.portafolio.evidencias.repository;

import com.portafolio.evidencias.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    // Método para buscar al usuario por correo y contraseña en la base de datos
    Usuario findByCorreoAndPassword(String correo, String password);
}