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
            /* Paleta de colores moderna y vibrante */
            --bg-main: #09090b;
            --bg-secondary: #18181b;
            --primary: #00f2fe;
            --secondary: #4facfe;
            --accent: #8b5cf6;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --card-bg: rgba(255, 255, 255, 0.03);
            --card-border: rgba(255, 255, 255, 0.08);
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-main);
            background-image: 
                radial-gradient(circle at 15% 50%, rgba(79, 172, 254, 0.08), transparent 25%),
                radial-gradient(circle at 85% 30%, rgba(139, 92, 246, 0.08), transparent 25%);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            line-height: 1.6;
            min-height: 100vh;
        }

        /* Navegación con efecto cristal */
        .navbar {
            background: rgba(9, 9, 11, 0.7);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding: 1.2rem 5%;
            border-bottom: 1px solid var(--card-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .navbar a { 
            color: var(--text-main); 
            text-decoration: none; 
            font-weight: 600; 
            letter-spacing: 0.5px; 
            transition: color 0.3s;
        }
        .navbar a:hover { color: var(--primary); }
        .navbar .admin-link {
            background: rgba(139, 92, 246, 0.15);
            color: #c4b5fd;
            padding: 0.5rem 1.2rem;
            border-radius: 20px;
            border: 1px solid rgba(139, 92, 246, 0.3);
        }

        /* Cabecera con texto en gradiente */
        .hero {
            padding: 5rem 5% 3rem;
            text-align: center;
        }
        .hero h1 { 
            font-size: 3.5rem; 
            margin: 0 0 1rem 0; 
            background: linear-gradient(to right, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
            letter-spacing: -1px;
        }
        .hero p { 
            color: var(--text-muted); 
            max-width: 600px; 
            font-size: 1.2rem; 
            margin: 0 auto; 
        }
        
        /* Layout principal */
        .container {
            max-width: 1300px;
            margin: 0 auto;
            padding: 2rem 5% 5rem;
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 3rem;
            align-items: start;
        }
        
        /* Tarjetas base Glassmorphism */
        .card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            padding: 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
        .card h2 { 
            margin-top: 0; 
            color: var(--text-main); 
            font-size: 1.5rem; 
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1.5rem; 
        }
        .card h2::after {
            content: "";
            flex: 1;
            height: 1px;
            background: linear-gradient(to right, var(--card-border), transparent);
        }
        
        /* Perfil flotante (Sticky) */
        .profile-section {
            position: sticky;
            top: 100px;
        }
        .profile-section p { font-size: 1rem; color: var(--text-muted); line-height: 1.7; }
        .tag-container { display: flex; flex-wrap: wrap; gap: 0.6rem; margin-top: 2rem; }
        .tag {
            background: rgba(0, 242, 254, 0.1);
            border: 1px solid rgba(0, 242, 254, 0.2);
            color: var(--primary);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        .tag:hover {
            background: rgba(0, 242, 254, 0.2);
            transform: translateY(-2px);
        }
        
        /* Cuadrícula de evidencias dinámica */
        .evidence-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }
        .evidence-item {
            background: var(--bg-secondary);
            border-radius: 12px;
            padding: 1.8rem;
            border: 1px solid var(--card-border);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex;
            flex-direction: column;
            height: 100%;
            box-sizing: border-box;
        }
        .evidence-item:hover {
            transform: translateY(-8px);
            border-color: rgba(79, 172, 254, 0.4);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4), 0 0 15px rgba(79, 172, 254, 0.15);
        }
        .evidence-item h3 { 
            margin: 0 0 1rem 0; 
            font-size: 1.2rem; 
            color: var(--text-main); 
        }
        .evidence-item p { 
            font-size: 0.95rem; 
            color: var(--text-muted); 
            margin-bottom: 2rem; 
            flex-grow: 1; /* Empuja el botón hacia abajo */
        }
        
        /* Botones con gradiente */
        .btn {
            display: inline-block;
            background: linear-gradient(135deg, var(--secondary), var(--primary));
            color: #000;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 700;
            text-align: center;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            width: 100%;
            box-sizing: border-box;
        }
        .btn:hover { 
            box-shadow: 0 0 20px rgba(0, 242, 254, 0.4); 
            transform: scale(1.02);
            color: #000;
        }
        
        @media (max-width: 960px) {
            .container { grid-template-columns: 1fr; }
            .profile-section { position: relative; top: 0; }
            .hero h1 { font-size: 2.5rem; }
        }
    </style>
</head>
<body>

    <div class="navbar">
        <a href="/">Ricardo Coronel</a>
        <a href="/login" class="admin-link">Panel Admin &rarr;</a>
    </div>

    <div class="hero">
        <h1>E-Portafolio Académico</h1>
        <p>Documentación y evidencias de aprendizaje desplegadas dinámicamente</p>
    </div>

    <div class="container">
        
        <!-- Columna Izquierda: Perfil (Ahora es sticky) -->
        <div class="card profile-section">
            <h2>Perfil Técnico</h2>
            <p>Apasionado por el desarrollo web y la creación de soluciones tecnológicas escalables con bases de datos relacionales, construyendo sobre sólidas bases de desarrollo web.</p>
            
            <div class="tag-container">
                <span class="tag">Java 21</span>
                <span class="tag">Spring Boot</span>
                <span class="tag">MVC</span>
                <span class="tag">PHP</span>
                <span class="tag">MySQL</span>
                <span class="tag">Git / GitHub</span>
            </div>
        </div>

        <!-- Columna Derecha: Evidencias -->
        <div class="card">
            <h2>Repositorio de Evidencias</h2>
            
            <div class="evidence-grid">
                <!-- BUCLE DINÁMICO JSTL -->
                <!-- Este bloque iterará sobre la lista "evidencias" enviada por tu Controlador -->
                <c:forEach items="${evidencias}" var="item">
                    <div class="evidence-item">
                        <h3>${item.titulo}</h3>
                        <p>${item.descripcion}</p>
                        <a href="${item.imagenUrl}" target="_blank" class="btn">Visualizar Detalle</a>
                    </div>
                </c:forEach>
                
                <!-- Mensaje por si la base de datos está vacía -->
                <c:if test="${empty evidencias}">
                    <div style="grid-column: 1 / -1; text-align: center; padding: 2rem; color: var(--text-muted);">
                        <p>No hay evidencias registradas en la base de datos en este momento.</p>
                    </div>
                </c:if>
            </div>
        </div>

    </div>

</body>
</html>