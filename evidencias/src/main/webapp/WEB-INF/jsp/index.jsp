```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>E-Portafolio | Ricardo Coronel</title>

    <style>

        /* =========================================================
           VARIABLES
        ========================================================= */

        :root {
            --bg-main: #f5f7ff;
            --bg-secondary: #eef2ff;
            --surface: #ffffff;

            --primary: #4f46e5;
            --primary-dark: #3730a3;
            --primary-light: #eef2ff;

            --secondary: #7c3aed;
            --cyan: #06b6d4;
            --green: #10b981;
            --orange: #f59e0b;

            --text-main: #172033;
            --text-secondary: #475569;
            --text-muted: #64748b;

            --border: #e2e8f0;

            --shadow-sm:
                0 2px 8px rgba(15, 23, 42, 0.05);

            --shadow-md:
                0 10px 30px rgba(15, 23, 42, 0.08);

            --shadow-lg:
                0 20px 45px rgba(15, 23, 42, 0.12);

            --radius-sm: 10px;
            --radius-md: 16px;
            --radius-lg: 22px;

            --font:
                "Segoe UI",
                system-ui,
                -apple-system,
                BlinkMacSystemFont,
                sans-serif;
        }


        /* =========================================================
           RESET
        ========================================================= */

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            padding: 0;

            font-family: var(--font);

            color: var(--text-main);

            background:
                radial-gradient(
                    circle at 5% 0%,
                    rgba(79, 70, 229, 0.12),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 95% 10%,
                    rgba(6, 182, 212, 0.10),
                    transparent 25%
                ),
                var(--bg-main);

            min-height: 100vh;
        }

        a {
            text-decoration: none;
        }


        /* =========================================================
           TOPBAR
        ========================================================= */

        .topbar {
            position: sticky;
            top: 0;

            z-index: 100;

            background: rgba(255,255,255,0.88);

            backdrop-filter: blur(18px);

            border-bottom: 1px solid var(--border);

            box-shadow: 0 2px 15px rgba(15,23,42,0.04);
        }


        .topbar-inner {
            max-width: 1280px;

            margin: auto;

            padding:
                1rem 5%;

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;
        }


        /* =========================================================
           BRAND
        ========================================================= */

        .brand {
            display: flex;

            align-items: center;

            gap: 12px;

            color: var(--text-main);

            font-weight: 800;

            font-size: 1.05rem;
        }


        .brand-icon {
            width: 42px;
            height: 42px;

            display: grid;

            place-items: center;

            border-radius: 12px;

            color: white;

            font-weight: 900;

            background:
                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--secondary)
                );

            box-shadow:
                0 8px 18px
                rgba(79,70,229,0.25);
        }


        .brand-text span {
            display: block;

            color: var(--primary);

            font-size: 0.75rem;

            font-weight: 700;

            margin-top: 2px;
        }


        /* =========================================================
           ADMIN BUTTON
        ========================================================= */

        .admin-btn {
            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                0.7rem
                1.1rem;

            border-radius: 10px;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--secondary)
                );

            font-size: 0.9rem;

            font-weight: 700;

            box-shadow:
                0 7px 18px
                rgba(79,70,229,0.20);

            transition:
                transform .25s ease,
                box-shadow .25s ease;
        }


        .admin-btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px
                rgba(79,70,229,0.28);
        }


        /* =========================================================
           HERO
        ========================================================= */

        .hero {
            max-width: 1280px;

            margin: auto;

            padding:
                4.5rem 5%
                3rem;
        }


        .hero-content {
            max-width: 800px;
        }


        .hero-tag {
            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                0.45rem
                0.8rem;

            margin-bottom: 1.2rem;

            border-radius: 30px;

            color: var(--primary);

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #f5f3ff
                );

            border:
                1px solid #ddd6fe;

            font-size: 0.78rem;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .5px;
        }


        .hero-tag::before {
            content: "";

            width: 8px;
            height: 8px;

            border-radius: 50%;

            background: var(--green);

            box-shadow:
                0 0 0 4px
                rgba(16,185,129,.12);
        }


        .hero h1 {
            margin: 0 0 1rem;

            font-size:
                clamp(2.3rem, 5vw, 4rem);

            line-height: 1.05;

            letter-spacing: -1.8px;

            font-weight: 900;

            background:
                linear-gradient(
                    90deg,
                    #172033,
                    var(--primary),
                    var(--secondary)
                );

            -webkit-background-clip: text;

            -webkit-text-fill-color: transparent;
        }


        .hero p {
            max-width: 760px;

            margin: 0;

            color: var(--text-secondary);

            font-size: 1.05rem;

            line-height: 1.75;
        }


        /* =========================================================
           MAIN LAYOUT
        ========================================================= */

        .container {
            max-width: 1280px;

            margin: auto;

            padding:
                0 5%
                5rem;

            display: grid;

            grid-template-columns:
                300px
                minmax(0, 1fr);

            gap: 2.5rem;

            align-items: start;
        }


        /* =========================================================
           PROFILE
        ========================================================= */

        .profile-card {
            position: sticky;

            top: 90px;

            overflow: hidden;

            background: var(--surface);

            border:
                1px solid var(--border);

            border-radius: var(--radius-lg);

            box-shadow: var(--shadow-md);
        }


        .profile-top {
            padding: 1.8rem;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--secondary)
                );
        }


        .profile-avatar {
            width: 58px;
            height: 58px;

            display: grid;

            place-items: center;

            margin-bottom: 1rem;

            border-radius: 16px;

            background:
                rgba(255,255,255,.18);

            border:
                1px solid
                rgba(255,255,255,.25);

            font-size: 1.4rem;

            font-weight: 900;
        }


        .profile-top h3 {
            margin: 0;

            font-size: 1.15rem;
        }


        .profile-top span {
            display: block;

            margin-top: .35rem;

            opacity: .85;

            font-size: .8rem;
        }


        .profile-body {
            padding: 1.6rem;
        }


        .profile-description {
            margin: 0 0 1.6rem;

            color: var(--text-secondary);

            font-size: .9rem;

            line-height: 1.65;
        }


        /* =========================================================
           SKILLS
        ========================================================= */

        .skill-group {
            padding:
                .9rem
                0;

            margin: 0;

            border-bottom:
                1px solid var(--border);
        }


        .skill-group:last-child {
            border-bottom: none;
        }


        .skill-group dt {
            margin-bottom: .4rem;

            color: var(--text-muted);

            font-size: .72rem;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .6px;
        }


        .skill-group dd {
            margin: 0;

            color: var(--text-main);

            font-size: .9rem;

            font-weight: 700;
        }


        /* =========================================================
           EVIDENCES HEADER
        ========================================================= */

        .evidence-header {
            display: flex;

            justify-content: space-between;

            align-items: flex-end;

            gap: 20px;

            margin-bottom: 1.5rem;
        }


        .section-label {
            display: block;

            margin-bottom: .35rem;

            color: var(--primary);

            font-size: .75rem;

            font-weight: 900;

            text-transform: uppercase;

            letter-spacing: 1px;
        }


        .evidence-header h2 {
            margin: 0;

            font-size: 1.7rem;

            letter-spacing: -.5px;
        }


        .evidence-header p {
            margin: .45rem 0 0;

            color: var(--text-muted);

            font-size: .9rem;
        }


        .evidence-counter {
            flex-shrink: 0;

            padding:
                .6rem
                .9rem;

            border-radius: 12px;

            color: var(--primary);

            background: var(--primary-light);

            font-size: .78rem;

            font-weight: 800;

            border:
                1px solid #ddd6fe;
        }


        /* =========================================================
           EVIDENCE LIST
        ========================================================= */

        .evidence-list {
            display: flex;

            flex-direction: column;

            gap: 1rem;
        }


        /* =========================================================
           EVIDENCE CARD
        ========================================================= */

        .evidence-card {
            position: relative;

            display: flex;

            align-items: center;

            gap: 1.5rem;

            padding: 1.35rem;

            background: var(--surface);

            border:
                1px solid var(--border);

            border-radius: var(--radius-md);

            box-shadow: var(--shadow-sm);

            overflow: hidden;

            transition:
                transform .25s ease,
                box-shadow .25s ease,
                border-color .25s ease;
        }


        .evidence-card::before {
            content: "";

            position: absolute;

            left: 0;
            top: 0;
            bottom: 0;

            width: 4px;

            background:
                linear-gradient(
                    180deg,
                    var(--primary),
                    var(--cyan)
                );
        }


        .evidence-card:hover {
            transform: translateY(-4px);

            border-color:
                #c7d2fe;

            box-shadow: var(--shadow-lg);
        }


        /* =========================================================
           EVIDENCE ICON
        ========================================================= */

        .evidence-icon {
            flex-shrink: 0;

            width: 54px;
            height: 54px;

            display: grid;

            place-items: center;

            border-radius: 14px;

            color: var(--primary);

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #ecfeff
                );

            font-size: 1.25rem;

            font-weight: 900;
        }


        /* =========================================================
           EVIDENCE INFO
        ========================================================= */

        .evidence-info {
            flex: 1;

            min-width: 0;
        }


        .evidence-meta {
            display: inline-flex;

            padding:
                .3rem
                .6rem;

            margin-bottom: .45rem;

            border-radius: 6px;

            color: var(--primary);

            background: var(--primary-light);

            font-size: .7rem;

            font-weight: 900;

            text-transform: uppercase;

            letter-spacing: .4px;
        }


        .evidence-info h4 {
            margin: 0 0 .4rem;

            color: var(--text-main);

            font-size: 1.05rem;

            line-height: 1.35;
        }


        .evidence-info p {
            margin: 0;

            color: var(--text-muted);

            font-size: .88rem;

            line-height: 1.55;
        }


        /* =========================================================
           VIEW BUTTON
        ========================================================= */

        .btn-view {
            display: inline-flex;

            align-items: center;

            justify-content: center;

            gap: 7px;

            flex-shrink: 0;

            padding:
                .72rem
                1rem;

            border-radius: 10px;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--secondary)
                );

            font-size: .82rem;

            font-weight: 800;

            box-shadow:
                0 5px 15px
                rgba(79,70,229,.18);

            transition:
                transform .2s ease,
                box-shadow .2s ease;
        }


        .btn-view::after {
            content: "→";

            font-size: 1rem;
        }


        .btn-view:hover {
            transform: translateY(-2px);

            box-shadow:
                0 9px 20px
                rgba(79,70,229,.28);
        }


        /* =========================================================
           EMPTY STATE
        ========================================================= */

        .empty-state {
            padding: 4rem 2rem;

            text-align: center;

            background: var(--surface);

            border:
                1px dashed #cbd5e1;

            border-radius: var(--radius-md);

            color: var(--text-muted);
        }


        .empty-icon {
            font-size: 2rem;

            margin-bottom: .8rem;
        }


        .empty-state strong {
            display: block;

            color: var(--text-main);

            margin-bottom: .35rem;
        }


        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media (max-width: 900px) {

            .container {
                grid-template-columns: 1fr;

                gap: 1.5rem;
            }

            .profile-card {
                position: relative;

                top: 0;
            }

        }


        @media (max-width: 650px) {

            .topbar-inner {
                padding:
                    .8rem 5%;
            }


            .brand-text {
                display: none;
            }


            .hero {
                padding:
                    3rem 5%
                    2rem;
            }


            .hero h1 {
                font-size: 2.5rem;
            }


            .evidence-header {
                align-items: flex-start;

                flex-direction: column;
            }


            .evidence-card {
                flex-direction: column;

                align-items: flex-start;

                padding: 1.2rem;
            }


            .evidence-icon {
                width: 48px;
                height: 48px;
            }


            .btn-view {
                width: 100%;
            }

        }


        /* =========================================================
           ACCESSIBILITY
        ========================================================= */

        :focus-visible {
            outline:
                3px solid
                rgba(79,70,229,.35);

            outline-offset: 3px;
        }


        @media (prefers-reduced-motion: reduce) {

            *,
            *::before,
            *::after {
                scroll-behavior: auto !important;

                transition: none !important;
            }

        }

    </style>
</head>


<body>


<!-- =========================================================
     NAVBAR
========================================================= -->

<nav class="topbar">

    <div class="topbar-inner">

        <a href="/" class="brand">

            <div class="brand-icon">
                RC
            </div>

            <div class="brand-text">
                Ricardo Coronel
                <span>E-Portafolio Académico</span>
            </div>

        </a>


        <a href="/login" class="admin-btn">
            ⚙ Acceder al panel
        </a>

    </div>

</nav>



<!-- =========================================================
     HERO
========================================================= -->

<header class="hero">

    <div class="hero-content">

        <span class="hero-tag">
            Registro de evidencias
        </span>


        <h1>
            E-Portafolio académico
        </h1>


        <p>
            Espacio digital para organizar, consultar y presentar
            evidencias de aprendizaje, actividades académicas y
            proyectos desarrollados durante la formación profesional.
        </p>

    </div>

</header>



<!-- =========================================================
     MAIN
========================================================= -->

<main class="container">


    <!-- =====================================================
         PROFILE
    ====================================================== -->

    <aside class="profile-card">


        <div class="profile-top">

            <div class="profile-avatar">
                RC
            </div>

            <h3>
                Perfil técnico
            </h3>

            <span>
                Desarrollo Web & Backend
            </span>

        </div>


        <div class="profile-body">

            <p class="profile-description">

                Desarrollador enfocado en soluciones web escalables
                sobre bases de datos relacionales, con experiencia
                en desarrollo backend y frontend.

            </p>


            <dl class="skill-group">

                <dt>
                    Lenguajes
                </dt>

                <dd>
                    Java 21 · PHP
                </dd>

            </dl>


            <dl class="skill-group">

                <dt>
                    Frameworks & Patrones
                </dt>

                <dd>
                    Spring Boot · MVC
                </dd>

            </dl>


            <dl class="skill-group">

                <dt>
                    Bases de datos
                </dt>

                <dd>
                    MySQL
                </dd>

            </dl>


            <dl class="skill-group">

                <dt>
                    Herramientas
                </dt>

                <dd>
                    Git · GitHub
                </dd>

            </dl>

        </div>

    </aside>



    <!-- =====================================================
         EVIDENCES
    ====================================================== -->

    <section class="evidence-section">


        <div class="evidence-header">

            <div>

                <span class="section-label">
                    Portafolio
                </span>

                <h2>
                    Evidencias registradas
                </h2>

                <p>
                    Explora las actividades y trabajos académicos
                    almacenados en el sistema.
                </p>

            </div>


            <div class="evidence-counter">
                Evidencias académicas
            </div>

        </div>



        <div class="evidence-list">


            <!-- =================================================
                 EMPTY STATE
            ================================================== -->

            <c:if test="${empty evidencias}">

                <div class="empty-state">

                    <div class="empty-icon">
                        📂
                    </div>

                    <strong>
                        No hay evidencias registradas
                    </strong>

                    <span>
                        Las evidencias aparecerán aquí cuando
                        sean agregadas al sistema.
                    </span>

                </div>

            </c:if>



            <!-- =================================================
                 EVIDENCE LOOP
            ================================================== -->

            <c:forEach
                    items="${evidencias}"
                    var="item">

                <article class="evidence-card">


                    <div class="evidence-icon">
                        📄
                    </div>


                    <div class="evidence-info">

                        <span class="evidence-meta">
                            ${item.semana}
                        </span>


                        <h4>
                            ${item.titulo}
                        </h4>


                        <p>
                            ${item.descripcion}
                        </p>

                    </div>


                    <a
                        href="${item.imagenUrl}"
                        target="_blank"
                        rel="noopener noreferrer"
                        class="btn-view">

                        Ver evidencia

                    </a>

                </article>

            </c:forEach>


        </div>

    </section>


</main>


</body>

</html>
```
