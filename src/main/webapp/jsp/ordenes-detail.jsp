<%--
  Created by IntelliJ IDEA.
  User: kenny
  Date: 03/06/2025
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/includes/header.jsp" %>

<%
  model.Orden orden = (model.Orden) request.getAttribute("orden");
  model.Cliente cliente = (model.Cliente) request.getAttribute("cliente");
  model.Bike bike = (model.Bike) request.getAttribute("bike");
%>

<div class="container py-5">
  <h2 class="mb-4">Detalle de Pedido #${orden.id}</h2>

  <div class="card mb-4">
    <div class="card-header fw-bold">Datos del Cliente</div>
    <div class="card-body">
      <p><strong>Nombre:</strong> ${cliente.nombre}</p>
      <p><strong>Correo:</strong> ${cliente.correo}</p>
      <p><strong>Dirección:</strong> ${cliente.direccion}</p>
    </div>
  </div>

  <div class="card mb-4">
    <div class="card-header fw-bold">Bicicleta Comprada</div>
    <div class="card-body">
      <p><strong>Modelo:</strong> ${bike.modelo}</p>
      <p><strong>Tipo:</strong> ${bike.tipo}</p>
      <p><strong>Precio unitario:</strong> €${bike.precio}</p>
      <p><strong>Cantidad:</strong> ${orden.cantidad}</p>
      <p class="fw-bold fs-5">Total: €${orden.total}</p>
    </div>
  </div>

  <a href="${pageContext.request.contextPath}/ordenes" class="btn btn-secondary">Volver a Órdenes</a>
</div>

<%@ include file="/includes/footer.jsp" %>
