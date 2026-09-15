package com.portafolio.evidencias.repository;

import com.portafolio.evidencias.model.Evidencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EvidenciaRepository extends JpaRepository<Evidencia, Long> {
    // Con solo extender JpaRepository, ya tenemos acceso a métodos como save(), findAll(), deleteById(), etc.
}