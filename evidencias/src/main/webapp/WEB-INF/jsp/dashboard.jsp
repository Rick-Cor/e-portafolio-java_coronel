<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración | E-Portafolio</title>

    <style>
        :root {
            --bg-main: #f5f7ff;
            --bg-surface: #ffffff;
            --primary: #4f46e5;
            --primary-dark: #3730a3;
            --primary-light: #eef2ff;
            --secondary: #7c3aed;
            --cyan: #06b6d4;
            --green: #10b981;
            --green-light: #ecfdf5;
            --green-border: #a7f3d0;
            --danger: #ef4444;
            --danger-light: #fef2f2;
            --danger-border: #fecaca;
            --warning: #f59e0b;
            --text-main: #172033;
            --text-secondary: #475569;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --border-light: #f1f5f9;
            --shadow-sm: 0 2px 8px rgba(15, 23, 42, 0.05);
            --shadow-md: 0 10px 30px rgba(15, 23, 42, 0.08);
            --shadow-lg: 0 20px 45px rgba(15, 23, 42, 0.14);
            --radius-sm: 8px;
            --radius-md: 14px;
            --radius-lg: 20px;
            --font: "Segoe UI", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: var(--font);
            color: var(--text-main);
            background:
                radial-gradient(circle at 5% 0%, rgba(79, 70, 229, 0.08), transparent 30%),
                radial-gradient(circle at 95% 10%, rgba(6, 182, 212, 0.07), transparent 25%),
                var(--bg-main);
            min-height: 100vh;
            padding-bottom: 4rem;
        }

        /* ==================== TOPBAR ==================== */
        .topbar {
            position: sticky;
            top: 0;
            z-index: 100;
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            box-shadow: 0 2px 15px rgba(15, 23, 42, 0.04);
        }

        .topbar-inner {
            max-width: 1380px;
            margin: 0 auto;
            padding: 0.9rem 5%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--text-main);
            font-weight: 800;
            font-size: 1.1rem;
        }

        .brand-icon {
            width: 42px;
            height: 42px;
            display: grid;
            place-items: center;
            border-radius: 12px;
            color: white;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            box-shadow: 0 8px 18px rgba(79, 70, 229, 0.25);
        }

        .brand-text span {
            display: block;
            color: var(--primary);
            font-size: 0.76rem;
            font-weight: 700;
        }

        .topbar-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-pill {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0.45rem 0.9rem;
            background: var(--bg-main);
            border: 1px solid var(--border);
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .role-badge {
            background: var(--primary-light);
            color: var(--primary);
            padding: 0.2rem 0.55rem;
            border-radius: 12px;
            font-size: 0.72rem;
            font-weight: 800;
            letter-spacing: 0.4px;
        }

        .btn-link-public {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 0.6rem 1rem;
            border-radius: 10px;
            color: var(--text-secondary);
            background: white;
            border: 1px solid var(--border);
            text-decoration: none;
            font-size: 0.86rem;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .btn-link-public:hover {
            color: var(--primary);
            border-color: #c7d2fe;
            background: var(--primary-light);
        }

        .btn-logout {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 0.6rem 1rem;
            border-radius: 10px;
            color: var(--danger);
            background: var(--danger-light);
            border: 1px solid var(--danger-border);
            text-decoration: none;
            font-size: 0.86rem;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .btn-logout:hover {
            background: #fee2e2;
            transform: translateY(-1px);
        }

        /* ==================== CONTAINER ==================== */
        .container {
            max-width: 1380px;
            margin: 2rem auto 0;
            padding: 0 5%;
        }

        /* ==================== ALERTS ==================== */
        .alert {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 1.3rem;
            margin-bottom: 1.5rem;
            border-radius: var(--radius-md);
            font-size: 0.92rem;
            font-weight: 600;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: var(--green-light);
            border: 1px solid var(--green-border);
            color: #065f46;
        }

        .alert-error {
            background: var(--danger-light);
            border: 1px solid var(--danger-border);
            color: #991b1b;
        }

        .alert-close {
            background: none;
            border: none;
            font-size: 1.1rem;
            cursor: pointer;
            color: inherit;
            opacity: 0.7;
        }

        .alert-close:hover {
            opacity: 1;
        }

        /* ==================== METRICS ==================== */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 1.2rem;
            margin-bottom: 2rem;
        }

        .metric-card {
            background: var(--bg-surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.3rem 1.4rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            gap: 1.1rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .metric-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .metric-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: grid;
            place-items: center;
            font-size: 1.3rem;
            flex-shrink: 0;
        }

        .metric-icon.indigo {
            background: var(--primary-light);
            color: var(--primary);
        }

        .metric-icon.green {
            background: var(--green-light);
            color: var(--green);
        }

        .metric-icon.purple {
            background: #f3e8ff;
            color: var(--secondary);
        }

        .metric-icon.cyan {
            background: #ecfeff;
            color: var(--cyan);
        }

        .metric-info h4 {
            font-size: 0.78rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .metric-info .metric-value {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--text-main);
            line-height: 1;
        }

        /* ==================== ACTIONS BAR ==================== */
        .actions-bar {
            background: var(--bg-surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.2rem 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 260px;
        }

        .search-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .search-input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            font-size: 0.92rem;
            font-family: inherit;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            outline: none;
            transition: all 0.2s ease;
        }

        .search-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.12);
        }

        .btn-primary {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.78rem 1.4rem;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            font-size: 0.92rem;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            box-shadow: 0 6px 18px rgba(79, 70, 229, 0.22);
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 24px rgba(79, 70, 229, 0.32);
        }

        /* ==================== DATA TABLE ==================== */
        .table-card {
            background: var(--bg-surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.92rem;
        }

        thead {
            background: #fafbff;
            border-bottom: 2px solid var(--border);
        }

        th {
            padding: 1rem 1.3rem;
            font-size: 0.75rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: var(--text-muted);
            white-space: nowrap;
        }

        tbody tr {
            border-bottom: 1px solid var(--border-light);
            transition: background 0.15s ease;
        }

        tbody tr:hover {
            background: #f8faff;
        }

        td {
            padding: 1.1rem 1.3rem;
            vertical-align: middle;
        }

        .semana-badge {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            border-radius: 8px;
            background: var(--primary-light);
            color: var(--primary);
            font-size: 0.78rem;
            font-weight: 800;
            white-space: nowrap;
        }

        .evidencia-titulo {
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 0.25rem;
        }

        .evidencia-desc {
            color: var(--text-secondary);
            font-size: 0.85rem;
            line-height: 1.45;
            max-width: 460px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .file-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 0.4rem 0.75rem;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 700;
            text-decoration: none;
            background: #f1f5f9;
            color: var(--text-secondary);
            border: 1px solid var(--border);
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .file-link:hover {
            background: var(--primary-light);
            color: var(--primary);
            border-color: #c7d2fe;
        }

        .file-link.empty {
            color: var(--text-muted);
            background: #f8fafc;
            border-style: dashed;
            cursor: default;
        }

        .table-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
        }

        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.5rem 0.85rem;
            border-radius: 8px;
            font-size: 0.82rem;
            font-weight: 700;
            cursor: pointer;
            border: 1px solid transparent;
            font-family: inherit;
            transition: all 0.2s ease;
        }

        .btn-action.edit {
            background: #eff6ff;
            color: #2563eb;
            border-color: #bfdbfe;
        }

        .btn-action.edit:hover {
            background: #dbeafe;
            transform: translateY(-1px);
        }

        .btn-action.delete {
            background: var(--danger-light);
            color: var(--danger);
            border-color: var(--danger-border);
        }

        .btn-action.delete:hover {
            background: #fee2e2;
            transform: translateY(-1px);
        }

        /* ==================== MODALS ==================== */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(15, 23, 42, 0.55);
            backdrop-filter: blur(4px);
            z-index: 1000;
            display: none;
            place-items: center;
            padding: 1rem;
            animation: fadeIn 0.2s ease;
        }

        .modal-overlay.active {
            display: grid;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: white;
            border-radius: var(--radius-lg);
            width: 100%;
            max-width: 560px;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border);
            overflow: hidden;
            animation: modalScale 0.25s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes modalScale {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .modal-header {
            padding: 1.3rem 1.6rem;
            background: linear-gradient(135deg, #fbfbfe, #f4f6ff);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-header h3 {
            font-size: 1.18rem;
            font-weight: 800;
            color: var(--text-main);
        }

        .modal-close-btn {
            background: none;
            border: none;
            font-size: 1.4rem;
            color: var(--text-muted);
            cursor: pointer;
            line-height: 1;
            padding: 4px;
            border-radius: 6px;
        }

        .modal-close-btn:hover {
            color: var(--text-main);
            background: #e2e8f0;
        }

        .modal-body {
            padding: 1.6rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.45rem;
            font-size: 0.82rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            color: var(--text-main);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 0.95rem;
            font-size: 0.92rem;
            font-family: inherit;
            color: var(--text-main);
            background: #ffffff;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.12);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 90px;
        }

        .file-hint {
            display: block;
            margin-top: 0.4rem;
            font-size: 0.78rem;
            color: var(--text-muted);
        }

        .modal-footer {
            padding: 1.1rem 1.6rem;
            background: #fafbff;
            border-top: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn-secondary {
            padding: 0.75rem 1.2rem;
            border-radius: 10px;
            background: white;
            color: var(--text-secondary);
            border: 1.5px solid var(--border);
            font-size: 0.9rem;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-secondary:hover {
            background: #f1f5f9;
        }

        /* ==================== EMPTY STATE ==================== */
        .empty-row {
            text-align: center;
            padding: 4rem 1rem !important;
            color: var(--text-muted);
        }

        .empty-row span {
            display: block;
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
        }

        /* ==================== RESPONSIVE ==================== */
        @media (max-width: 800px) {
            .topbar-inner {
                flex-direction: column;
                align-items: flex-start;
            }
            .topbar-actions {
                width: 100%;
                justify-content: space-between;
                flex-wrap: wrap;
            }
            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }
            .btn-primary {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>

<body>

    <!-- ==================== TOPBAR ==================== -->
    <header class="topbar">
        <div class="topbar-inner">
            <a href="/" class="brand">
                <div class="brand-icon">RC</div>
                <div class="brand-text">
                    E-Portafolio
                    <span>Panel de Control</span>
                </div>
            </a>

            <div class="topbar-actions">
                <div class="user-pill">
                    <span>👤 <strong>${usuario != null ? usuario.nombre : 'Administrador'}</strong></span>
                    <span class="role-badge">${usuario != null ? usuario.rol : 'ADMIN'}</span>
                </div>

                <a href="/" class="btn-link-public" target="_blank">
                    🌐 Ver Sitio Público
                </a>

                <a href="/logout" class="btn-logout">
                    🚪 Cerrar Sesión
                </a>
            </div>
        </div>
    </header>

    <!-- ==================== MAIN CONTENT ==================== -->
    <main class="container">

        <!-- Flash messages -->
        <c:if test="${not empty mensajeExito}">
            <div class="alert alert-success">
                <span>✅ ${mensajeExito}</span>
                <button class="alert-close" onclick="this.parentElement.remove()">✕</button>
            </div>
        </c:if>

        <c:if test="${not empty mensajeError}">
            <div class="alert alert-error">
                <span>⚠️ ${mensajeError}</span>
                <button class="alert-close" onclick="this.parentElement.remove()">✕</button>
            </div>
        </c:if>

        <!-- KPI Metrics -->
        <section class="metrics-grid">
            <div class="metric-card">
                <div class="metric-icon indigo">📁</div>
                <div class="metric-info">
                    <h4>Total Evidencias</h4>
                    <div class="metric-value">${fn:length(evidencias)}</div>
                </div>
            </div>

            <div class="metric-card green">
                <div class="metric-icon green">⚡</div>
                <div class="metric-info">
                    <h4>Estado del Sistema</h4>
                    <div class="metric-value" style="font-size: 1.1rem; color: var(--green);">Conectado</div>
                </div>
            </div>

            <div class="metric-card purple">
                <div class="metric-icon purple">🎓</div>
                <div class="metric-info">
                    <h4>Rol Activo</h4>
                    <div class="metric-value" style="font-size: 1.1rem; color: var(--secondary);">${usuario != null ? usuario.rol : 'ADMIN'}</div>
                </div>
            </div>

            <div class="metric-card cyan">
                <div class="metric-icon cyan">📅</div>
                <div class="metric-info">
                    <h4>Ciclo Académico</h4>
                    <div class="metric-value" style="font-size: 1.1rem; color: var(--cyan);">Semana 1 - 16</div>
                </div>
            </div>
        </section>

        <!-- Search and Action Bar -->
        <section class="actions-bar">
            <div class="search-box">
                <span class="search-icon">🔍</span>
                <input type="text" 
                       id="searchInput" 
                       class="search-input" 
                       placeholder="Buscar por título, descripción o semana..." 
                       oninput="filtrarTabla()" />
            </div>

            <button type="button" class="btn-primary" onclick="abrirModalCrear()">
                ➕ Registrar Nueva Evidencia
            </button>
        </section>

        <!-- Evidence Table Card -->
        <section class="table-card">
            <div class="table-responsive">
                <table id="tablaEvidencias">
                    <thead>
                        <tr>
                            <th style="width: 110px;">Semana</th>
                            <th>Título y Descripción</th>
                            <th style="width: 170px;">Archivo Adjunto</th>
                            <th style="width: 170px; text-align: right;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty evidencias}">
                                <tr>
                                    <td colspan="4" class="empty-row">
                                        <span>📂</span>
                                        <strong>No hay evidencias registradas</strong>
                                        <p style="margin-top: 4px; font-size: 0.86rem;">Haz clic en "Registrar Nueva Evidencia" para comenzar.</p>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${evidencias}" var="e">
                                    <tr class="fila-evidencia" 
                                        data-semana="${fn:toLowerCase(e.semana)}"
                                        data-titulo="${fn:toLowerCase(e.titulo)}"
                                        data-desc="${fn:toLowerCase(e.descripcion)}">
                                        
                                        <td>
                                            <span class="semana-badge">${e.semana}</span>
                                        </td>

                                        <td>
                                            <div class="evidencia-titulo">${e.titulo}</div>
                                            <div class="evidencia-desc">${e.descripcion}</div>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty e.imagenUrl and e.imagenUrl ne '#'}">
                                                    <a href="${e.imagenUrl}" target="_blank" class="file-link" title="${e.imagenUrl}">
                                                        <c:choose>
                                                            <c:when test="${fn:endsWith(fn:toLowerCase(e.imagenUrl), '.pdf')}">
                                                                📄 Ver PDF
                                                            </c:when>
                                                            <c:otherwise>
                                                                🖼️ Ver Imagen
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="file-link empty">Sin archivo</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td style="text-align: right;">
                                            <div class="table-actions" style="justify-content: flex-end;">
                                                <button type="button" 
                                                        class="btn-action edit"
                                                        data-id="${e.id}"
                                                        data-semana="${e.semana}"
                                                        data-titulo="${e.titulo}"
                                                        data-descripcion="${e.descripcion}"
                                                        data-archivo="${e.imagenUrl}"
                                                        onclick="abrirModalEditar(this)">
                                                    ✏️ Editar
                                                </button>

                                                <button type="button" 
                                                        class="btn-action delete"
                                                        data-id="${e.id}"
                                                        data-titulo="${e.titulo}"
                                                        onclick="abrirModalEliminar(this)">
                                                    🗑️ Borrar
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </section>

    </main>

    <!-- ==================== MODAL: CREAR EVIDENCIA ==================== -->
    <div id="modalCrear" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3>➕ Nueva Evidencia de Aprendizaje</h3>
                <button type="button" class="modal-close-btn" onclick="cerrarModal('modalCrear')">✕</button>
            </div>

            <form action="/dashboard/subir" method="POST" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label" for="crear_semana">Semana Académica *</label>
                        <input type="text" 
                               id="crear_semana" 
                               name="semana" 
                               class="form-control" 
                               placeholder="Ej: Semana 8" 
                               list="listaSemanas"
                               required />
                        <datalist id="listaSemanas">
                            <option value="Semana 1"></option>
                            <option value="Semana 2"></option>
                            <option value="Semana 3"></option>
                            <option value="Semana 4"></option>
                            <option value="Semana 5"></option>
                            <option value="Semana 6"></option>
                            <option value="Semana 7"></option>
                            <option value="Semana 8"></option>
                            <option value="Semana 9"></option>
                            <option value="Semana 10"></option>
                            <option value="Semana 11"></option>
                            <option value="Semana 12"></option>
                            <option value="Semana 13"></option>
                            <option value="Semana 14"></option>
                            <option value="Semana 15"></option>
                            <option value="Semana 16"></option>
                        </datalist>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="crear_titulo">Título de la Evidencia *</label>
                        <input type="text" 
                               id="crear_titulo" 
                               name="titulo" 
                               class="form-control" 
                               placeholder="Ej: Infografía de Arquitectura de Software" 
                               required />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="crear_descripcion">Descripción Detallada *</label>
                        <textarea id="crear_descripcion" 
                                  name="descripcion" 
                                  class="form-control" 
                                  placeholder="Describe brevemente la actividad, competencias y resultados..." 
                                  required></textarea>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="crear_archivo">Archivo / Evidencia (PDF, Imagen)</label>
                        <input type="file" 
                               id="crear_archivo" 
                               name="archivo" 
                               class="form-control" 
                               accept=".pdf,image/png,image/jpeg,image/jpg" />
                        <span class="file-hint">Formatos soportados: PDF, PNG, JPG. Opcional (puedes subirlo luego).</span>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="cerrarModal('modalCrear')">Cancelar</button>
                    <button type="submit" class="btn-primary">💾 Guardar Evidencia</button>
                </div>
            </form>
        </div>
    </div>

    <!-- ==================== MODAL: EDITAR EVIDENCIA ==================== -->
    <div id="modalEditar" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3>✏️ Editar Evidencia</h3>
                <button type="button" class="modal-close-btn" onclick="cerrarModal('modalEditar')">✕</button>
            </div>

            <form action="/dashboard/editar" method="POST" enctype="multipart/form-data">
                <input type="hidden" id="edit_id" name="id" />

                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label" for="edit_semana">Semana Académica *</label>
                        <input type="text" 
                               id="edit_semana" 
                               name="semana" 
                               class="form-control" 
                               list="listaSemanas"
                               required />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="edit_titulo">Título de la Evidencia *</label>
                        <input type="text" 
                               id="edit_titulo" 
                               name="titulo" 
                               class="form-control" 
                               required />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="edit_descripcion">Descripción *</label>
                        <textarea id="edit_descripcion" 
                                  name="descripcion" 
                                  class="form-control" 
                                  required></textarea>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="edit_archivo">Reemplazar Archivo (Opcional)</label>
                        <input type="file" 
                               id="edit_archivo" 
                               name="archivo" 
                               class="form-control" 
                               accept=".pdf,image/png,image/jpeg,image/jpg" />
                        <span id="edit_archivo_actual" class="file-hint" style="color: var(--primary);"></span>
                        <span class="file-hint">Deja este campo vacío si deseas mantener el archivo actual.</span>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="cerrarModal('modalEditar')">Cancelar</button>
                    <button type="submit" class="btn-primary">💾 Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>

    <!-- ==================== MODAL: CONFIRMAR ELIMINACIÓN ==================== -->
    <div id="modalEliminar" class="modal-overlay">
        <div class="modal-content" style="max-width: 440px;">
            <div class="modal-header" style="background: var(--danger-light); border-bottom-color: var(--danger-border);">
                <h3 style="color: var(--danger);">🗑️ Confirmar Eliminación</h3>
                <button type="button" class="modal-close-btn" onclick="cerrarModal('modalEliminar')">✕</button>
            </div>

            <form action="/dashboard/eliminar" method="POST">
                <input type="hidden" id="delete_id" name="id" />

                <div class="modal-body">
                    <p style="font-size: 0.95rem; line-height: 1.5; color: var(--text-main);">
                        ¿Estás seguro de que deseas eliminar permanentemente esta evidencia?
                    </p>
                    <p id="delete_titulo_preview" style="margin-top: 0.6rem; font-weight: 700; color: var(--danger); font-size: 0.95rem;">
                    </p>
                    <p style="margin-top: 0.6rem; font-size: 0.8rem; color: var(--text-muted);">
                        Esta acción no se puede deshacer.
                    </p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="cerrarModal('modalEliminar')">Cancelar</button>
                    <button type="submit" class="btn-primary" style="background: var(--danger); box-shadow: 0 6px 18px rgba(239,68,68,0.25);">
                        Sí, Eliminar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- ==================== SCRIPTS ==================== -->
    <script>
        function abrirModalCrear() {
            document.getElementById('modalCrear').classList.add('active');
            document.getElementById('crear_semana').focus();
        }

        function abrirModalEditar(btn) {
            const id = btn.getAttribute('data-id');
            const semana = btn.getAttribute('data-semana') || '';
            const titulo = btn.getAttribute('data-titulo') || '';
            const desc = btn.getAttribute('data-descripcion') || '';
            const archivo = btn.getAttribute('data-archivo') || '';

            document.getElementById('edit_id').value = id;
            document.getElementById('edit_semana').value = semana;
            document.getElementById('edit_titulo').value = titulo;
            document.getElementById('edit_descripcion').value = desc;

            const archivoHint = document.getElementById('edit_archivo_actual');
            if (archivo && archivo !== '#') {
                archivoHint.textContent = '📎 Archivo actual: ' + archivo;
            } else {
                archivoHint.textContent = 'ℹ️ Sin archivo adjunto actualmente.';
            }

            document.getElementById('modalEditar').classList.add('active');
            document.getElementById('edit_titulo').focus();
        }

        function abrirModalEliminar(btn) {
            const id = btn.getAttribute('data-id');
            const titulo = btn.getAttribute('data-titulo') || '';

            document.getElementById('delete_id').value = id;
            document.getElementById('delete_titulo_preview').textContent = '«' + titulo + '»';
            document.getElementById('modalEliminar').classList.add('active');
        }

        function cerrarModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.remove('active');
            }
        }

        // Cerrar modal al hacer click en el backdrop
        document.querySelectorAll('.modal-overlay').forEach(overlay => {
            overlay.addEventListener('click', function(e) {
                if (e.target === this) {
                    this.classList.remove('active');
                }
            });
        });

        // Cerrar modal con tecla Escape
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                document.querySelectorAll('.modal-overlay.active').forEach(modal => {
                    modal.classList.remove('active');
                });
            }
        });

        // Filtrado en vivo de la tabla de evidencias
        function filtrarTabla() {
            const query = (document.getElementById('searchInput').value || '').toLowerCase().trim();
            const filas = document.querySelectorAll('.fila-evidencia');

            filas.forEach(fila => {
                const semana = fila.getAttribute('data-semana') || '';
                const titulo = fila.getAttribute('data-titulo') || '';
                const desc = fila.getAttribute('data-desc') || '';

                if (semana.includes(query) || titulo.includes(query) || desc.includes(query)) {
                    fila.style.display = '';
                } else {
                    fila.style.display = 'none';
                }
            });
        }
    </script>

</body>

</html>
