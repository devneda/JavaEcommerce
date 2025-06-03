<%--
  Created by IntelliJ IDEA.
  User: kenny
  Date: 03/06/2025
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/includes/header.jsp" %>

<%
  model.Bike bike = (model.Bike) request.getAttribute("bike");
%>

<div class="container py-5">
  <div class="row">
    <div class="col-md-6 text-center">
      <img src="${pageContext.request.contextPath}/images/${bike.image}" class="img-fluid mb-3"
           alt="${bike.modelo}" style="max-height: 400px; object-fit: contain;">
    </div>
    <div class="col-md-6">
      <h1 class="mb-3">${bike.modelo}</h1>
      <span class="badge bg-secondary mb-2">${bike.tipo}</span>
      <h3 class="text-success fw-bold mb-4">€${bike.precio}</h3>

      <p class="text-muted">
        Bicicleta premium de la colección Trek. Ideal para ciclistas que buscan rendimiento, estilo y tecnología.
        Este modelo incluye componentes de alta gama, diseño aerodinámico y una experiencia de conducción única.
      </p>

      <ul class="list-group list-group-flush mb-3">
        <li class="list-group-item"><strong>Tipo:</strong> ${bike.tipo}</li>
        <li class="list-group-item"><strong>Precio:</strong> €${bike.precio}</li>
