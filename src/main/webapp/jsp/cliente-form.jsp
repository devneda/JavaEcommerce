<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 03/06/2025
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/includes/header.jsp" %>

<%
  model.Cliente cliente = (model.Cliente) request.getAttribute("cliente");
  boolean editar = (cliente != null);
%>

<div class="container py-5">
  <h2 class="mb-4">
    ${editar ? "Editar Cliente" : "Nuevo Cliente"}
  </h2>

  <form action="${pageContext.request.contextPath}/clientes" method="post" class="row g-3">

    <input type="hidden" name="id" value="${editar ? cliente.id : ''}"/>

    <div class="col-md-6">
      <label for="nombre" class="form-label">Nombre</label>
      <input type="text" class="form-control" id="nombre" name="nombre"
             value="${editar ? cliente.nombre : ''}" required>
    </div>

    <div class="col-md-6">
      <label for="email" class="form-label">Correo Electrónico</label>
      <input type="email" class="form-control" id="email" name="email"
             value="${editar ? cliente.correo : ''}" required>
    </div>

    <div class="col-md-6">
      <label for="direccion" class="form-label">Dirección</label>
      <input type="text" class="form-control" id="direccion" name="direccion"
             value="${editar ? cliente.direccion : ''}">
    </div>

    <div class="col-md-6">
      <label for="telefono" class="form-label">Teléfono</label>
      <input type="text" class="form-control" id="telefono" name="telefono"
             value="${editar ? cliente.telefono : ''}">
    </div>

    <div class="col-12">
      <button type="submit" class="btn btn-primary">
        ${editar ? "Actualizar Cliente" : "Crear Cliente"}
      </button>
      <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
    </div>
  </form>
</div>

<%@ include file="/includes/footer.jsp" %>
