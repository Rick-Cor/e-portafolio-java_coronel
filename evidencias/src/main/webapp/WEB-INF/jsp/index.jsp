<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>E-Portafolio | Ricardo Coronel</title>
    <style type="text/css">
        :root {
            --primary: #0099cc; 
            --primary-glow: rgba(0, 153, 204, 0.3);
            --bg-color: #0b192c; 
            --card-bg: rgba(28, 51, 89, 0.6); 
            --text-main: #f8f9fa;
            --text-muted: #b5c4d6;
        }
        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        .navbar {
            background: rgba(8, 20, 38, 0.9);
            backdrop-filter: blur(10px);
            padding: 1rem 5%;
            border-bottom: 1px solid rgba(0, 153, 204, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .navbar a { color: var(--text-main); text-decoration: none; font-weight: bold; letter-spacing: 0.5px; }
        .hero {
            padding: 4rem 5% 2rem;
            border-bottom: 1px solid rgba(255,255,255,0.05);
            background: radial-gradient(circle at top center, rgba(0, 153, 204, 0.1) 0%, transparent 70%);
        }
        .hero h1 { font-size: 2.8rem; margin: 0 0 0.5rem 0; color: #ffffff; }
        .hero p { color: var(--text-muted); max-width: 600px; font-size: 1.1rem; margin: 0; }
        
        /* Implementación de CSS Grid para un layout asimétrico moderno */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 5%;
            display: grid;
            grid-template-columns: 350px 1fr;
            gap: 2.5rem;
            align-items: start;
        }
        
        .card {
            background: var(--card-bg);
            border: 1px solid rgba(255,255,255,0.05);
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px var(--primary-glow);
            border-color: rgba(0, 153, 204, 0.4);
        }
        .card h2 { margin-top: 0; color: var(--primary); font-size: 1.4rem; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 0.8rem; margin-bottom: 1.5rem; }
        
        .profile-section p { font-size: 0.95rem; color: var(--text-muted); }
        .tag-container { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: 1.5rem; }
        .tag {
            background: rgba(0, 153, 204, 0.15);
            border: 1px solid rgba(0, 153, 204, 0.3);
            color: #66d9ff;
            padding: 0.4rem 1rem;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .evidence-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .evidence-item {
            background: rgba(11, 25, 44, 0.5);
            border-radius: 8px;
            padding: 1.5rem;
            border: 1px solid rgba(255,255,255,0.05);
        }
        .evidence-item h3 { margin: 0 0 1rem 0; font-size: 1.1rem; color: #ffffff; }
        .evidence-item p { font-size: 0.9rem; color: var(--text-muted); margin-bottom: 1.5rem; }
        
        .btn {
            display: inline-block;
            background-color: var(--primary);
            color: white;
            padding: 0.7rem 1.5rem;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            transition: all 0.3s;
            text-align: center;
        }
        .btn:hover { background-color: #007da6; box-shadow: 0 0 15px var(--primary-glow); }
        
        @media (max-width: 900px) {
            .container { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

    <div class="navbar">
        <a href="/">Ricardo Coronel</a>
        <a href="/login" style="color: var(--primary);">Panel Admin &rarr;</a>
    </div>

    <div class="hero">
        <h1>E-Portafolio Académico</h1>
        <p>Documentación y evidencias de aprendizaje estructuradas en Spring Boot.</p>
    </div>

    <div class="container">
        
        <!-- Columna Izquierda: Perfil -->
        <div class="card profile-section">
            <h2>Perfil Técnico</h2>
            <p>Apasionado por el desarrollo web y la creación de soluciones tecnológicas escalables. Actualmente expandiendo mis conocimientos en arquitecturas Java empresariales (Spring Boot) tras solidificar bases en desarrollo full-stack tradicional.</p>
            
            <div class="tag-container">
                <span class="tag">Java 21</span>
                <span class="tag">Spring Boot</span>
                <span class="tag">PHP</span>
                <span class="tag">MySQL</span>
                <span class="tag">Git / GitHub</span>
            </div>
        </div>

        <!-- Columna Derecha: Evidencias -->
        <div class="card">
            <h2>Repositorio de Evidencias</h2>
            
            <div class="evidence-grid">
                <div class="evidence-item">
                    <h3>Semana 1: Fundamentos Web</h3>
                    <p>Análisis y estructuración de los pilares principales para la planificación y despliegue de aplicaciones web modernas, abarcando desde la arquitectura cliente-servidor hasta el diseño de bases de datos.</p>
                    
                    <!-- Extensión corregida a .png -->
                    <a href="/evidencias/Infografia1(Fundamentos web).png" target="_blank" class="btn">Visualizar Infografía</a>
                </div>
                
                <!-- Espacio preparado para la Semana 2 -->
                <div class="evidence-item" style="opacity: 0.5; border-style: dashed;">
                    <h3>Semana 2: Próximamente</h3>
                    <p>Espacio reservado para la siguiente asignación académica.</p>
                </div>
            </div>
        </div>

    </div>

</body>
</html> 