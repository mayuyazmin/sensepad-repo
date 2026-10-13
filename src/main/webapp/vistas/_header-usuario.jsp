<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String back = request.getParameter("back");
  String showRestart = request.getParameter("showRestart");
%>

<header class="wizard-header">
  <div class="brand">
    <div class="brand-mark"></div>
    <span class="brand-name">Sense<b>Pad</b></span>
  </div>

  <% if (back != null && !back.isEmpty()) { %>
    <a href="<%= back %>" class="back-btn">
      <i class="ti ti-arrow-left"></i> Volver
    </a>
  <% } %>

  <% if ("1".equals(showRestart)) { %>
    <a href="usuario-menu.jsp" class="back-btn">
      <i class="ti ti-refresh"></i> Empezar de nuevo
    </a>
  <% } %>

  <a href="bienvenida.jsp" class="back-btn">
    <i class="ti ti-x"></i> Elegir otro modo
  </a>
</header>