<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 03/06/2025
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/includes/header.jsp" %>

<%
  model.Cliente cliente = (model.Cliente) request.getAttribute("cliente");
%>

<div class="container py-5">
  <h2 class="mb-4">${cliente != null ? "Editar Cliente" : "Nuevo Cliente"}</h2>

  <form action="${pageContext.request.contextPath}/clientes" method="post" class="row g-3">

    <input type="hidden" name="id" value="${cliente != null ? cliente.id : ''}"/>

    <div class="col-md-6">
      <label for="nombre" class="form-label">Nombre</label>
      <input type="text" class="form-control" id="nombre" name="nombre" required
             value="${cliente != null ? cliente.nombre : ''}">
    </div>

    <div class="col-md-6">
      <label for="correo" class="form-label">Correo electrónico</label>
      <input type="email" class="form-control" id="correo" name="correo" required
             value="${cliente != null ? cliente.correo : ''}">
    </div>

    <div class="col-md-6">
      <label for="direccion" class="form-label">Dirección</label>
      <input type="text" class="form-control" id="direccion" name="direccion" required
             value="${cliente != null ? cliente.direccion : ''}">
    </div>

    <div class="col-md-6">
      <label for="telefono" class="form-label">Teléfono</label>
      <input type="text" class="form-control" id="telefono" name="telefono" required
             value="${cliente != null ? cliente.telefono : ''}">
    </div>

    <div class="col-12">
      <button type="submit" class="btn btn-primary">
        <i class="fa-solid fa-floppy-disk"></i> Guardar
      </button>
      <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
    </div>
  </form>
</div>

<%@ include file="/includes/footer.jsp" %>
