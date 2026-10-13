<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SensePad · Mapa</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.19.0/dist/tabler-icons.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/styles.css" />
</head>
<body>

  <div class="shell">

    <jsp:include page="_sidebar-familiar.jsp">
      <jsp:param name="active" value="mapa" />
    </jsp:include>

    <header class="shell-header">
      <div class="shell-context">Panel de <strong>familiar</strong></div>
    </header>

    <main class="shell-main">

      <div class="page-head">
        <div>
          <span class="eyebrow coral"><span class="dot"></span> En vivo</span>
          <h1 class="page-title">Mapa <em>completo.</em></h1>
          <p class="page-sub">Ubicación y recorrido del dispositivo.</p>
        </div>
      </div>

      <article class="card" style="padding: 0; overflow: hidden;">
        <iframe
          src="https://maps.google.com/maps?q=caballito+buenos+aires&z=15&output=embed"
          style="width: 100%; height: 520px; border: 0; display: block;"
          loading="lazy"
          title="Mapa">
        </iframe>
      </article>

    </main>

  </div>

</body>
</html>