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

<div class="container py-5">
  <h2 class="mb-4">Detalle de Orden #${orden.id}</h2>

  <div class="card shadow-sm">
    <div class="card-body">
      <div class="row mb-3">
        <div class="col-md-6">
          <h5 class="card-title">Cliente</h5>
          <p class="card-text">
            <strong>Nombre:</strong> ${cliente.nombre} <br>
            <strong>Email:</strong> ${cliente.correo} <br>
            <strong>Teléfono:</strong> ${cliente.telefono}
          </p>
        </div>
        <div class="col-md-6">
          <h5 class="card-title">Bicicleta</h5>
          <p class="card-text">
            <strong>Modelo:</strong> ${bike.modelo} <br>
            <strong>Tipo:</strong> ${bike.tipo} <br>
            <strong>Precio unitario:</strong> €${bike.precio}
          </p>
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-4">
          <strong>Fecha:</strong><br>
          ${orden.fecha}
        </div>
        <div class="col-md-4">
          <strong>Cantidad:</strong><br>
          ${orden.cantidad}
        </div>
        <div class="col-md-4">
          <strong>Total:</strong><br>
          <span class="fs-5 fw-bold text-success">€${orden.total}</span>
        </div>
      </div>

      <div class="d-flex justify-content-between mt-4">
        <a href="${pageContext.request.contextPath}/ordenes" class="btn btn-secondary">
          <i class="fa-solid fa-arrow-left"></i> Volver a listado
        </a>

        <c:if test="${sessionScope.usuarioLogueado.rol == 'admin'}">
          <a href="${pageContext.request.contextPath}/ordenes?action=edit&id=${orden.id}" class="btn btn-warning">
            <i class="fa-solid fa-pen"></i> Editar Orden
          </a>
        </c:if>
      </div>
    </div>
  </div>
</div>

<%@ include file="/includes/footer.jsp" %>
