<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1" />
  <title>SensePad · Bienvenido</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.19.0/dist/tabler-icons.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/styles.css" />
</head>
<body>

  <main class="welcome">

    <div class="welcome-brand">
      <div class="brand-mark"></div>
      <span class="brand-name">Sense<b>Pad</b></span>
    </div>

    <div class="welcome-body">
      <span class="eyebrow"><span class="dot"></span> Aplicación SensePad</span>
      <h1 class="welcome-title">Bienvenido a <em>SensePad.</em></h1>
      <p class="welcome-sub">Elegí cómo querés ingresar.</p>

      <ul class="mode-list">
        <li>
          <a href="familiar-inicio.jsp" class="mode-card">
            <div class="mode-icon"><i class="ti ti-home"></i></div>
            <div class="mode-body">
              <h2 class="mode-title">Soy <em>familiar</em></h2>
              <p class="mode-desc">Ubicación, batería y alarmas del SensePad.</p>
              <span class="mode-cta">Entrar al panel →</span>
            </div>
          </a>
        </li>
        <li>
          <a href="usuario-menu.jsp" class="mode-card">
            <div class="mode-icon"><i class="ti ti-hand-finger"></i></div>
            <div class="mode-body">
              <h2 class="mode-title">Soy <em>usuario</em></h2>
              <p class="mode-desc">Configurar botones y extravío.</p>
              <span class="mode-cta">Configurar botones →</span>
            </div>
          </a>
        </li>
      </ul>
    </div>

    <p class="welcome-foot">© 2026 SensePad · Tecnología asistiva con propósito.</p>

  </main>

</body>
</html>