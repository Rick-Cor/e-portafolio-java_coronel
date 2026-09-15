<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>E-Portafolio | Ricardo Coronel</title>
    <style type="text/css">
        :root {
            /* Paleta: azul tinta técnico + acento ámbar, pensada para un
               portafolio de desarrollo backend / bases de datos */
            --bg-main: #0e1116;
            --bg-surface: #151a21;
            --bg-raised: #1b212a;
            --border: #262e38;
            --border-strong: #38424f;
            --ink: #e9edf2;
            --ink-dim: #8a96a3;
            --accent: #f2a65a;
            --accent-strong: #f7b877;
            --accent-cool: #6bc2cf;
            --font-sans: 'Segoe UI', system-ui, -apple-system, Roboto, sans-serif;
            --font-mono: 'JetBrains Mono', 'SFMono-Regular', Consolas, 'Liberation Mono', monospace;
        }

        * { box-sizing: border-box; }

        body {
            font-family: var(--font-sans);
            background-color: var(--bg-main);
            background-image:
                linear-gradient(rgba(255,255,255,0.025) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.025) 1px, transparent 1px);
            background-size: 48px 48px;
            color: var(--ink);
            margin: 0;
            padding: 0;
            line-height: 1.6;
            min-height: 100vh;
        }

        a { color: inherit; }

        :focus-visible {
            outline: 2px solid var(--accent);
            outline-offset: 2px;
        }

        /* ---------- Barra superior ---------- */
        .topbar {
            background: rgba(14, 17, 22, 0.85);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .topbar-inner {
            max-width: 1280px;
            margin: 0 auto;
            padding: 1.1rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .brand {
            text-decoration: none;
            font-weight: 700;
            font-size: 1.02rem;
            letter-spacing: 0.2px;
            color: var(--ink);
        }
        .brand span {
            color: var(--accent);
            font-family: var(--font-mono);
            font-weight: 500;
        }
        .admin-link {
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--ink-dim);
            border: 1px solid var(--border-strong);
            padding: 0.5rem 1.1rem;
            border-radius: 6px;
            transition: border-color 0.2s ease, color 0.2s ease;
        }
        .admin-link:hover {
            color: var(--ink);
            border-color: var(--accent-cool);
        }

        /* ---------- Cabecera ---------- */
        .hero {
            padding: 4rem 5% 2.5rem;
            max-width: 1280px;
            margin: 0 auto;
        }
        .hero-tag {
            font-family: var(--font-mono);
            font-size: 0.9rem;
            color: var(--accent-cool);
            margin: 0 0 0.9rem 0;
        }
        .hero h1 {
            font-size: 2.6rem;
            line-height: 1.2;
            margin: 0 0 1rem 0;
            font-weight: 700;
            letter-spacing: -0.5px;
            max-width: 20ch;
        }
        .hero p {
            color: var(--ink-dim);
            max-width: 62ch;
            font-size: 1.08rem;
            margin: 0;
        }

        /* ---------- Layout principal ---------- */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 5% 5rem;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
            align-items: start;
        }

        /* ---------- Ficha de perfil ---------- */
        .profile-card {
            position: sticky;
            top: 88px;
            background: var(--bg-surface);
            border: 1px solid var(--border);
            border-radius: 10px;
            overflow: hidden;
        }
        .profile-card-tab {
            font-family: var(--font-mono);
            font-size: 0.78rem;
            color: var(--accent);
            background: var(--bg-raised);
            border-bottom: 1px solid var(--border);
            padding: 0.6rem 1.4rem;
            letter-spacing: 0.3px;
        }
        .profile-card-body {
            padding: 1.6rem 1.4rem 1.8rem;
        }
        .profile-card-body p {
            color: var(--ink-dim);
            font-size: 0.94rem;
            margin: 0 0 1.5rem 0;
        }
        .stack-group {
            margin-bottom: 1.1rem;
        }
        .stack-group:last-child { margin-bottom: 0; }
        .stack-group dt {
            font-size: 0.72rem;
            color: var(--ink-dim);
            margin-bottom: 0.4rem;
        }
        .stack-group dd {
            margin: 0;
            font-family: var(--font-mono);
            font-size: 0.86rem;
            color: var(--ink);
            padding-left: 0.85rem;
            border-left: 2px solid var(--border-strong);
        }

        /* ---------- Sección de evidencias ---------- */
        .evidence-section h2 {
            font-size: 1.3rem;
            font-weight: 700;
            margin: 0 0 0.3rem 0;
        }
        .evidence-section > p {
            color: var(--ink-dim);
            font-size: 0.94rem;
            margin: 0 0 1.5rem 0;
        }

        .evidence-table {
            border: 1px solid var(--border);
            border-radius: 10px;
            overflow: hidden;
            background: var(--bg-surface);
        }
        .evidence-row {
            display: grid;
            grid-template-columns: 48px 1fr auto;
            gap: 1.5rem;
            align-items: center;
            padding: 1.15rem 1.4rem;
            border-bottom: 1px solid var(--border);
        }
        .evidence-row:last-child { border-bottom: none; }

        .evidence-row.head {
            background: var(--bg-raised);
            padding: 0.75rem 1.4rem;
            font-size: 0.74rem;
            color: var(--ink-dim);
        }

        .evidence-row.data:hover {
            background: rgba(242, 166, 90, 0.04);
        }
        .evidence-row.data:nth-child(even) {
            background: rgba(255, 255, 255, 0.012);
        }
        .evidence-row.data:nth-child(even):hover {
            background: rgba(242, 166, 90, 0.045);
        }

        .row-index {
            font-family: var(--font-mono);
            font-size: 0.85rem;
            color: var(--ink-dim);
            text-align: right;
        }

        .row-content h3 {
            margin: 0 0 0.35rem 0;
            font-size: 1.02rem;
            font-weight: 600;
            color: var(--ink);
        }
        .row-content p {
            margin: 0;
            font-size: 0.9rem;
            color: var(--ink-dim);
            max-width: 60ch;
        }

        .row-action {
            white-space: nowrap;
        }
        .btn {
            display: inline-block;
            background: transparent;
            color: var(--accent-strong);
            border: 1px solid var(--accent);
            padding: 0.55rem 1.1rem;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.86rem;
            font-weight: 600;
            transition: background 0.2s ease, color 0.2s ease;
        }
        .btn:hover {
            background: var(--accent);
            color: #16130d;
        }

        .empty-state {
            padding: 3rem 1.4rem;
            text-align: center;
            color: var(--ink-dim);
            font-size: 0.95rem;
        }

        @media (max-width: 900px) {
            .container { grid-template-columns: 1fr; }
            .profile-card { position: relative; top: 0; }
            .hero h1 { font-size: 2.1rem; }

            .evidence-row.head { display: none; }
            .evidence-row.data {
                grid-template-columns: 1fr;
                gap: 0.6rem;
                padding: 1.2rem 1.3rem;
            }
            .row-index { text-align: left; }
            .row-action .btn { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>

    <div class="topbar">
        <div class="topbar-inner">
            <a class="brand" href="/">Ricardo Coronel <span>/portafolio</span></a>
            <a href="/login" class="admin-link">Acceder al panel</a>
        </div>
    </div>

    <header class="hero">
        <p class="hero-tag">-- registro de evidencias de aprendizaje</p>
        <h1>E-Portafolio académico</h1>
        <p>Documentación técnica de proyectos y evidencias, servida dinámicamente desde una base de datos relacional.</p>
    </header>

    <div class="container">

        <!-- Columna izquierda: perfil -->
        <aside class="profile-card">
            <div class="profile-card-tab">perfil.técnico</div>
            <div class="profile-card-body">
                <p>Desarrollador enfocado en soluciones web escalables sobre bases de datos relacionales, con base sólida en desarrollo backend y frontend.</p>

                <dl class="stack-group">
                    <dt>Lenguajes</dt>
                    <dd>Java 21 &middot; PHP</dd>
                </dl>
                <dl class="stack-group">
                    <dt>Frameworks &amp; patrones</dt>
                    <dd>Spring Boot &middot; MVC</dd>
                </dl>
                <dl class="stack-group">
                    <dt>Base de datos</dt>
                    <dd>MySQL</dd>
                </dl>
                <dl class="stack-group">
                    <dt>Herramientas</dt>
                    <dd>Git / GitHub</dd>
                </dl>
            </div>
        </aside>

        <!-- Columna derecha: evidencias -->
        <section class="evidence-section">
            <h2>Evidencias registradas</h2>
            <p>Cada fila corresponde a un registro almacenado en la base de datos.</p>

            <div class="evidence-table" role="table">

                <c:if test="${not empty evidencias}">
                    <div class="evidence-row head" role="row">
                        <span role="columnheader">#</span>
                        <span role="columnheader">Evidencia</span>
                        <span role="columnheader">Acción</span>
                    </div>
                </c:if>

                <!-- BUCLE DINÁMICO JSTL -->
                <c:forEach items="${evidencias}" var="item" varStatus="loop">
                    <div class="evidence-row data" role="row">
                        <span class="row-index" role="cell">${loop.index + 1}</span>
                        <div class="row-content" role="cell">
                            <h3>${item.titulo}</h3>
                            <p>${item.descripcion}</p>
                        </div>
                        <div class="row-action" role="cell">
                            <a href="${item.imagenUrl}" target="_blank" rel="noopener noreferrer" class="btn">Ver evidencia</a>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty evidencias}">
                    <div class="empty-state">
                        Aún no hay evidencias registradas. Cuando agregues registros desde el panel, aparecerán aquí.
                    </div>
                </c:if>

            </div>
        </section>

    </div>

</body>
</html>
