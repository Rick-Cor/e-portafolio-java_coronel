<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Portafolio | Ricardo Coronel</title>
    <style>
        :root {
            --bg-main: #0b0f19;
            --bg-surface: #151b2b;
            --bg-card: rgba(21, 27, 43, 0.7);
            --border-color: rgba(255, 255, 255, 0.08);
            --accent: #3b82f6;
            --accent-glow: rgba(59, 130, 246, 0.4);
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
            --font-sans: 'Segoe UI', system-ui, sans-serif;
            --font-mono: 'JetBrains Mono', Consolas, monospace;
        }

        body {
            font-family: var(--font-sans);
            background-color: var(--bg-main);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            /* Luces radiales sutiles para darle vida al fondo */
            background-image: 
                radial-gradient(circle at 15% 50%, rgba(59, 130, 246, 0.08), transparent 25%),
                radial-gradient(circle at 85% 30%, rgba(59, 130, 246, 0.08), transparent 25%);
            min-height: 100vh;
        }

        * { box-sizing: border-box; }

        /* ---------- Barra Superior ---------- */
        .topbar {
            background: rgba(11, 15, 25, 0.85);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .topbar-inner {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1.2rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .brand {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--text-main);
            text-decoration: none;
            letter-spacing: 0.5px;
        }
        .brand span { 
            color: var(--accent); 
            font-family: var(--font-mono); 
            font-weight: normal; 
            font-size: 0.95rem; 
        }
        .admin-btn {
            background: rgba(255, 255, 255, 0.03);
            color: var(--text-main);
            border: 1px solid var(--border-color);
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .admin-btn:hover {
            background: var(--accent);
            border-color: var(--accent);
            box-shadow: 0 0 15px var(--accent-glow);
            color: #fff;
        }

        /* ---------- Cabecera ---------- */
        .hero { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 4rem 5% 3.5rem; 
        }
        .hero-tag { 
            font-family: var(--font-mono); 
            color: var(--accent); 
            font-size: 0.9rem; 
            margin-bottom: 1rem; 
            display: inline-block;
            background: rgba(59, 130, 246, 0.1);
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
        }
        .hero h1 { 
            font-size: 2.8rem; 
            margin: 0 0 1rem 0; 
            font-weight: 800; 
            letter-spacing: -0.5px; 
            line-height: 1.2;
        }
        .hero p { 
            color: var(--text-muted); 
            font-size: 1.1rem; 
            max-width: 650px; 
            line-height: 1.6; 
            margin: 0; 
        }

        /* ---------- Layout Principal ---------- */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 5% 5rem;
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 3rem;
            align-items: start;
        }

        /* ---------- Ficha de Perfil ---------- */
        .profile-card {
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 2rem;
            position: sticky;
            top: 100px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .profile-card h3 { 
            font-family: var(--font-mono); 
            color: var(--accent); 
            font-size: 0.85rem; 
            margin: 0 0 1.5rem 0; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
        }
        .profile-card p { 
            color: var(--text-muted); 
            font-size: 0.95rem; 
            margin-bottom: 2rem; 
            line-height: 1.6;
        }
        .skill-group { margin-bottom: 1.5rem; }
        .skill-group:last-child { margin-bottom: 0; }
        .skill-group dt { 
            font-size: 0.8rem; 
            color: var(--text-muted); 
            margin-bottom: 0.4rem; 
        }
        .skill-group dd { 
            margin: 0; 
            font-family: var(--font-mono); 
            font-size: 0.95rem; 
            color: var(--text-main); 
        }

        /* ---------- Evidencias (Tarjetas Dinámicas) ---------- */
        .evidence-header { margin-bottom: 2rem; }
        .evidence-header h2 { font-size: 1.8rem; margin: 0 0 0.5rem 0; }
        .evidence-header p { color: var(--text-muted); margin: 0; font-size: 1rem; }

        .evidence-list { 
            display: flex; 
            flex-direction: column; 
            gap: 1.2rem; 
        }
        
        .evidence-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-left: 4px solid transparent;
            border-radius: 10px;
            padding: 1.8rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s ease;
            backdrop-filter: blur(8px);
        }
        
        .evidence-card:hover {
            border-left-color: var(--accent);
            border-top-color: rgba(255,255,255,0.15);
            border-right-color: rgba(255,255,255,0.15);
            border-bottom-color: rgba(255,255,255,0.15);
            background: rgba(255, 255, 255, 0.02);
            transform: translateX(6px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.4);
        }

        .evidence-info { flex: 1; padding-right: 2rem; }
        .evidence-meta { 
            font-family: var(--font-mono); 
            font-size: 0.85rem; 
            color: var(--accent); 
            margin-bottom: 0.5rem; 
            display: block; 
        }
        .evidence-info h4 { 
            margin: 0 0 0.5rem 0; 
            font-size: 1.2rem; 
            color: var(--text-main); 
        }
        .evidence-info p { 
            margin: 0; 
            color: var(--text-muted); 
            font-size: 0.95rem; 
            line-height: 1.5;
        }
        
        .btn-view {
            background: transparent;
            color: var(--text-main);
            border: 1px solid var(--border-color);
            padding: 0.7rem 1.2rem;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            transition: all 0.3s;
            white-space: nowrap;
        }
        .btn-view:hover {
            background: var(--text-main);
            color: var(--bg-main);
            border-color: var(--text-main);
        }

        .empty-state { 
            text-align: center; 
            padding: 4rem 2rem; 
            color: var(--text-muted); 
            border: 1px dashed var(--border-color); 
            border-radius: 12px; 
            background: rgba(255,255,255,0.01);
        }

        /* ---------- Responsivo ---------- */
        @media (max-width: 900px) {
            .container { grid-template-columns: 1fr; gap: 2rem; }
            .profile-card { position: relative; top: 0; }
            .evidence-card { flex-direction: column; align-items: flex-start; gap: 1.5rem; }
            .evidence-info { padding-right: 0; }
            .btn-view { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>

    <nav class="topbar">
        <div class="topbar-inner">
            <a href="/" class="brand">Ricardo Coronel <span>/portafolio</span></a>
            <a href="/login" class="admin-btn">Acceder al panel</a>
        </div>
    </nav>

    <header class="hero">
        <span class="hero-tag">-- Registro de evidencias</span>
        <h1>E-Portafolio académico</h1>
        <p>Documentación técnica de proyectos y evidencias de aprendizaje, estructurada con Spring Boot y servida dinámicamente desde una base de datos relacional.</p>
    </header>

    <main class="container">
        
        <!-- Ficha Lateral de Perfil -->
        <aside class="profile-card">
            <h3>Perfil . Técnico</h3>
            <p>Desarrollador enfocado en soluciones web escalables sobre bases de datos relacionales, con base sólida en desarrollo backend y frontend.</p>

            <dl class="skill-group">
                <dt>Lenguajes</dt>
                <dd>Java 21 &bull; PHP</dd>
            </dl>
            <dl class="skill-group">
                <dt>Frameworks & Patrones</dt>
                <dd>Spring Boot &bull; MVC</dd>
            </dl>
            <dl class="skill-group">
                <dt>Bases de Datos</dt>
                <dd>MySQL</dd>
            </dl>
            <dl class="skill-group">
                <dt>Herramientas</dt>
                <dd>Git / GitHub</dd>
            </dl>
        </aside>

        <!-- Lista Principal de Evidencias -->
        <section class="evidence-section">
            <div class="evidence-header">
                <h2>Evidencias Registradas</h2>
                <p>Explora el registro de actividades almacenadas en la base de datos.</p>
            </div>

            <div class="evidence-list">
                <c:if test="${empty evidencias}">
                    <div class="empty-state">
                        Aún no hay evidencias registradas en el sistema.
                    </div>
                </c:if>

                <!-- BUCLE DINÁMICO JSTL -->
                <c:forEach items="${evidencias}" var="item">
                    <article class="evidence-card">
                        <div class="evidence-info">
                            <span class="evidence-meta">${item.semana}</span>
                            <h4>${item.titulo}</h4>
                            <p>${item.descripcion}</p>
                        </div>
                        <a href="${item.imagenUrl}" target="_blank" rel="noopener noreferrer" class="btn-view">Ver evidencia</a>
                    </article>
                </c:forEach>
            </div>
        </section>

    </main>

</body>
</html>