<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión | Panel Administrativo</title>

    <style>
        :root {
            --bg-main: #f5f7ff;
            --surface: #ffffff;
            --primary: #4f46e5;
            --primary-dark: #3730a3;
            --primary-light: #eef2ff;
            --secondary: #7c3aed;
            --text-main: #172033;
            --text-secondary: #475569;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --danger: #ef4444;
            --danger-bg: #fef2f2;
            --danger-border: #fecaca;
            --shadow-md: 0 10px 30px rgba(15, 23, 42, 0.08);
            --shadow-lg: 0 20px 45px rgba(15, 23, 42, 0.12);
            --radius-md: 16px;
            --radius-lg: 22px;
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
                radial-gradient(circle at 10% 10%, rgba(79, 70, 229, 0.12), transparent 35%),
                radial-gradient(circle at 90% 90%, rgba(124, 58, 237, 0.12), transparent 35%),
                var(--bg-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        .login-card {
            width: 100%;
            max-width: 440px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(16px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            padding: 2.2rem 2rem 1.6rem;
            text-align: center;
            background: linear-gradient(135deg, #fbfbfe 0%, #f4f6ff 100%);
            border-bottom: 1px solid var(--border);
        }

        .brand-icon {
            width: 54px;
            height: 54px;
            margin: 0 auto 1rem;
            display: grid;
            place-items: center;
            border-radius: 16px;
            color: white;
            font-weight: 900;
            font-size: 1.3rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            box-shadow: 0 10px 22px rgba(79, 70, 229, 0.28);
        }

        .login-header h1 {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 0.35rem;
            letter-spacing: -0.5px;
        }

        .login-header p {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .login-body {
            padding: 2rem;
        }

        .alert-error {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0.85rem 1rem;
            margin-bottom: 1.5rem;
            border-radius: 10px;
            background: var(--danger-bg);
            border: 1px solid var(--danger-border);
            color: var(--danger);
            font-size: 0.88rem;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 1.35rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.84rem;
            font-weight: 700;
            color: var(--text-main);
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1.05rem;
            pointer-events: none;
        }

        .form-control {
            width: 100%;
            padding: 0.85rem 1rem 0.85rem 2.75rem;
            font-size: 0.95rem;
            font-family: inherit;
            color: var(--text-main);
            background: #ffffff;
            border: 1.5px solid var(--border);
            border-radius: 12px;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.12);
        }

        .btn-submit {
            width: 100%;
            padding: 0.9rem;
            margin-top: 0.5rem;
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 0.98rem;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.28);
            transition: all 0.25s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(79, 70, 229, 0.35);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .login-footer {
            padding: 1.2rem 2rem 1.6rem;
            text-align: center;
            background: #fafbff;
            border-top: 1px solid var(--border);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: var(--text-secondary);
            font-size: 0.88rem;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: var(--primary);
        }
    </style>
</head>

<body>

    <div class="login-card">

        <div class="login-header">
            <div class="brand-icon">RC</div>
            <h1>Panel Administrativo</h1>
            <p>Ingresa tus credenciales para gestionar evidencias</p>
        </div>

        <div class="login-body">

            <c:if test="${not empty error}">
                <div class="alert-error">
                    <span>⚠️</span>
                    <span>${error}</span>
                </div>
            </c:if>

            <form action="/login" method="POST">
                <div class="form-group">
                    <label class="form-label" for="correo">Correo Electrónico</label>
                    <div class="input-wrapper">
                        <span class="input-icon">✉</span>
                        <input type="email" 
                               id="correo" 
                               name="correo" 
                               class="form-control" 
                               placeholder="tu_correo@portafolio.com" 
                               value="${correoIngresado != null ? correoIngresado : ''}"
                               required 
                               autofocus />
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Contraseña</label>
                    <div class="input-wrapper">
                        <span class="input-icon">🔒</span>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-control" 
                               placeholder="••••••••" 
                               required />
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    <span>Iniciar Sesión</span>
                    <span>→</span>
                </button>
            </form>

        </div>

        <div class="login-footer">
            <a href="/" class="back-link">
                ← Volver al portafolio público
            </a>
        </div>

    </div>

</body>

</html>
