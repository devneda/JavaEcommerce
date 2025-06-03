<%--
  Created by IntelliJ IDEA.
  User: kenny
  Date: 03/06/2025
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/includes/header.jsp" %>

<div class="container py-5">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0">Listado de Órdenes</h2>
    <a href="${pageContext.request.contextPath}/ordenes?action=new" class="btn btn-success">
      <i class="fa-solid fa-plus"></i> Nueva Orden
    </a>
  </div>

  <div class="table-responsive">
    <table class="table table-bordered table-striped align-middle text-center">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Cliente ID</th>
        <th>Bicicleta ID</th>
        <th>Fecha</th>
        <th>Cantidad</th>
        <th>Total (€)</th>
        <th>Acciones</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="orden" items="${ordenes}">
        <tr>
          <td>
              <a href="${pageContext.request.contextPath}/ordenes?action=detail&id=${orden.id}">
                  ${orden.id}
              </a>
          </td>
          <td>${orden.clienteId}</td>
          <td>${orden.bicicletaId}</td>
          <td>${orden.fecha}</td>
          <td>${orden.cantidad}</td>
          <td>${orden.total}</td>
          <td>
            <a href="${pageContext.request.contextPath}/ordenes?action=delete&id=${orden.id}"
               class="btn btn-sm btn-danger"
               onclick="return confirm('¿Eliminar esta orden?');">
              <i class="fa-solid fa-trash"></i> Eliminar
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<%@ include file="/includes/footer.jsp" %>
