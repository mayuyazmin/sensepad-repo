<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SensePad · Panel Familiar</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.19.0/dist/tabler-icons.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/styles.css" />
  <style>
    .dash-grid { display: grid; grid-template-columns: 1.5fr 1fr; gap: 24px; }
    @media (max-width: 1080px) { .dash-grid { grid-template-columns: 1fr; } }

    .loc-block { text-align: center; padding: 20px 0; }
    .loc-lbl { font-size: .78rem; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: var(--navy-soft); }
    .loc-val { font-family: var(--font-serif); font-size: 2rem; color: var(--navy); margin: 10px 0; }
    .loc-time { font-size: .95rem; color: var(--navy-soft); }

    .status-row {
      display: flex; align-items: center; gap: 14px;
      padding: 14px 0; border-bottom: 1px solid var(--border-soft);
    }
    .status-row:last-child { border-bottom: none; }
    .status-icon { font-size: 24px; }
    .status-info { flex: 1; }
    .status-label { font-size: .82rem; color: var(--navy-soft); font-weight: 700; text-transform: uppercase; letter-spacing: .04em; }
    .status-value { font-size: 1.05rem; font-weight: 700; color: var(--navy); margin-top: 2px; }

    .alarm-list { display: flex; flex-direction: column; gap: 10px; }
    .alarm-row {
      display: flex; align-items: center; gap: 14px;
      padding: 14px 16px; border-radius: 14px;
      background: var(--cream);
      border: 1px solid var(--border-soft);
    }
    .alarm-icon { font-size: 22px; color: var(--coral-deep); flex-shrink: 0; }
    .alarm-name { font-size: 1rem; font-weight: 700; color: var(--navy); }
    .alarm-time { font-size: .88rem; color: var(--navy-soft); margin-top: 2px; }
  </style>
</head>
<body>

  <div class="shell">

    <jsp:include page="_sidebar-familiar.jsp">
      <jsp:param name="active" value="inicio" />
    </jsp:include>

    <header class="shell-header">
      <div class="shell-context">Panel de <strong>familiar</strong></div>
    </header>

    <main class="shell-main">

      <div class="page-head">
        <div>
          <span class="eyebrow"><span class="dot"></span> Todo en orden</span>
          <h1 class="page-title">Bienvenido a <em>SensePad.</em></h1>
          <p class="page-sub">Visualización rápida del estado y ubicación del usuario.</p>
        </div>
      </div>

      <div class="dash-grid">

        <article class="card">
          <div class="card-head">
            <div class="card-title"><i class="ti ti-map-pin"></i> Ubicación aproximada</div>
            <a href="familiar-mapa.jsp" class="card-link">Ver mapa completo →</a>
          </div>
          <div class="loc-block">
            <div class="loc-lbl">Zona actual</div>
            <div class="loc-val">Caballito, CABA</div>
            <div class="loc-time">Actualizado hace 12 segundos</div>
          </div>
        </article>

        <article class="card">
          <div class="card-head">
            <div class="card-title"><i class="ti ti-device-mobile"></i> Estado del dispositivo</div>
          </div>

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
            <i class="ti ti-check status-icon" style="color: var(--ok);"></i>
            <div class="status-info">
              <div class="status-label">Estado general</div>
              <div class="status-value">Funcionando bien</div>
            </div>
          </div>
        </article>

      </div>

      <article class="card" style="margin-top: 24px;">
        <div class="card-head">
          <div class="card-title"><i class="ti ti-bell"></i> Últimas alarmas</div>
          <a href="familiar-alarmas.jsp" class="card-link">Ver todas →</a>
        </div>
        <div class="alarm-list">
          <div class="alarm-row">
            <i class="ti ti-alert-triangle alarm-icon"></i>
            <div>
              <div class="alarm-name">SOS activado</div>
              <div class="alarm-time">Hoy, 14:35</div>
            </div>
          </div>
          <div class="alarm-row">
            <i class="ti ti-battery-1 alarm-icon"></i>
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
        </div>
      </article>

    </main>

  </div>

</body>
</html>