<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String active = request.getParameter("active");
  if (active == null) active = "";
%>

<div class="shell-brand">
  <div class="brand-mark"></div>
  <span class="brand-name">Sense<b>Pad</b></span>
</div>

<nav class="shell-nav" aria-label="Navegación panel familiar">
  <div class="nav-section">
    <a href="familiar-inicio.jsp" class="nav-link <%= "inicio".equals(active) ? "active" : "" %>">
      <i class="ti ti-home"></i> Inicio
    </a>
    <a href="familiar-mapa.jsp" class="nav-link <%= "mapa".equals(active) ? "active" : "" %>">
      <i class="ti ti-map-pin"></i> Mapa
    </a>
    <a href="familiar-estado.jsp" class="nav-link <%= "estado".equals(active) ? "active" : "" %>">
      <i class="ti ti-device-mobile"></i> Estado
    </a>
    <a href="familiar-alarmas.jsp" class="nav-link <%= "alarmas".equals(active) ? "active" : "" %>">
      <i class="ti ti-bell"></i> Alarmas
    </a>
  </div>

  <div class="nav-section">
    <a href="bienvenida.jsp" class="nav-link">
      <i class="ti ti-logout"></i> Volver al inicio
    </a>
  </div>

  <div class="nav-device">
    <div class="nav-device-head">
      <div class="nav-device-icon"><i class="ti ti-device-mobile"></i></div>
      <div>
        <div class="nav-device-label">Dispositivo</div>
        <div class="nav-device-id">SP-001</div>
      </div>
    </div>
    <div class="nav-device-status">Conectado</div>
  </div>
</nav>