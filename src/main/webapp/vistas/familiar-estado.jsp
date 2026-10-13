<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SensePad · Estado</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.19.0/dist/tabler-icons.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/styles.css" />
  <style>
    .status-row { display: flex; align-items: center; gap: 16px; padding: 18px 0; border-bottom: 1px solid var(--border-soft); }
    .status-row:last-child { border-bottom: none; }
    .status-icon { font-size: 28px; flex-shrink: 0; }
    .status-info { flex: 1; }
    .status-label { font-size: .82rem; color: var(--navy-soft); font-weight: 700; text-transform: uppercase; letter-spacing: .04em; }
    .status-value { font-size: 1.15rem; font-weight: 700; color: var(--navy); margin-top: 3px; }
  </style>
</head>
<body>

  <div class="shell">

    <jsp:include page="_sidebar-familiar.jsp">
      <jsp:param name="active" value="estado" />
    </jsp:include>

    <header class="shell-header">
      <div class="shell-context">Panel de <strong>familiar</strong></div>
    </header>

    <main class="shell-main">

      <div class="page-head">
        <div>
          <span class="eyebrow"><span class="dot"></span> Actualizado</span>
          <h1 class="page-title">Estado del <em>dispositivo.</em></h1>
          <p class="page-sub">Detalle del hardware SensePad.</p>
        </div>
      </div>

      <article class="card">
        <div class="status-row">
          <i class="ti ti-battery-3 status-icon" style="color: var(--ok);"></i>
          <div class="status-info">
            <div class="status-label">Batería</div>
            <div class="status-value">87% · Cargando</div>
          </div>
        </div>
        <div class="status-row">
          <i class="ti ti-satellite status-icon" style="color: var(--ok);"></i>
          <div class="status-info">
            <div class="status-label">Señal GPS</div>
            <div class="status-value">Excelente · Activo</div>
          </div>
        </div>
        <div class="status-row">
          <i class="ti ti-wifi status-icon" style="color: var(--ok);"></i>
          <div class="status-info">
            <div class="status-label">Internet</div>
            <div class="status-value">Conectado · Estable</div>
          </div>
        </div>
        <div class="status-row">
          <i class="ti ti-bolt status-icon" style="color: var(--coral);"></i>
          <div class="status-info">
            <div class="status-label">Encendido</div>
            <div class="status-value">Sí</div>
          </div>
        </div>
        <div class="status-row">
          <i class="ti ti-id status-icon" style="color: var(--navy);"></i>
          <div class="status-info">
            <div class="status-label">Dispositivo</div>
            <div class="status-value">SP-001</div>
          </div>
        </div>
      </article>

    </main>

  </div>

</body>
</html>