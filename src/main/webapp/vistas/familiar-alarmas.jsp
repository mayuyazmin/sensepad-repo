<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SensePad · Alarmas</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.19.0/dist/tabler-icons.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/styles.css" />
  <style>
    .alarm-row {
      display: flex; align-items: center; gap: 16px;
      padding: 18px 20px; border-bottom: 1px solid var(--border-soft);
    }
    .alarm-row:last-child { border-bottom: none; }
    .alarm-icon { font-size: 26px; flex-shrink: 0; }
    .alarm-name { font-size: 1.08rem; font-weight: 700; color: var(--navy); }
    .alarm-time { font-size: .92rem; color: var(--navy-soft); margin-top: 3px; }
  </style>
</head>
<body>

  <div class="shell">

    <jsp:include page="_sidebar-familiar.jsp">
      <jsp:param name="active" value="alarmas" />
    </jsp:include>

    <header class="shell-header">
      <div class="shell-context">Panel de <strong>familiar</strong></div>
    </header>

    <main class="shell-main">

      <div class="page-head">
        <div>
          <span class="eyebrow coral"><span class="dot"></span> 2 sin leer</span>
          <h1 class="page-title">Últimas <em>alarmas.</em></h1>
          <p class="page-sub">Historial de eventos y emergencias.</p>
        </div>
      </div>

      <article class="card" style="padding: 0;">
        <div class="alarm-row">
          <i class="ti ti-alert-triangle alarm-icon" style="color: var(--coral-deep);"></i>
          <div>
            <div class="alarm-name">SOS activado</div>
            <div class="alarm-time">Hoy, 14:35</div>
          </div>
        </div>
        <div class="alarm-row">
          <i class="ti ti-battery-1 alarm-icon" style="color: var(--coral-deep);"></i>
          <div>
            <div class="alarm-name">Batería baja</div>
            <div class="alarm-time">Hoy, 12:10</div>
          </div>
        </div>
        <div class="alarm-row">
          <i class="ti ti-plug-connected alarm-icon" style="color: var(--ok);"></i>
          <div>
            <div class="alarm-name">Dispositivo conectado</div>
            <div class="alarm-time">Hoy, 09:02</div>
          </div>
        </div>
        <div class="alarm-row">
          <i class="ti ti-shield-off alarm-icon" style="color: var(--coral);"></i>
          <div>
            <div class="alarm-name">Fuera de zona segura</div>
            <div class="alarm-time">Ayer, 18:47</div>
          </div>
        </div>
      </article>

    </main>

  </div>

</body>
</html>