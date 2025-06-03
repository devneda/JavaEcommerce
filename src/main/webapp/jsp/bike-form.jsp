<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 03/06/2025
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/includes/header.jsp" %>

<%
  model.Bike bike = (model.Bike) request.getAttribute("bike");
%>

<div class="container py-5">
  <h2 class="mb-4">${bike != null ? "Editar Bicicleta" : "Nueva Bicicleta"}</h2>

  <form action="${pageContext.request.contextPath}/bikes" method="post" class="row g-3">

    <input type="hidden" name="id" value="${bike != null ? bike.id : ''}"/>

    <div class="col-md-6">
      <label for="modelo" class="form-label">Modelo</label>
      <input type="text" class="form-control" id="modelo" name="modelo" required
             value="${bike != null ? bike.modelo : ''}">
    </div>

    <div class="col-md-6">
      <label for="tipo" class="form-label">Tipo</label>
      <select class="form-select" id="tipo" name="tipo" required>
        <option value="">Seleccionar tipo</option>
        <option value="Montaña" ${bike != null && bike.tipo == 'Montaña' ? 'selected' : ''}>Montaña</option>
        <option value="Carretera" ${bike != null && bike.tipo == 'Carretera' ? 'selected' : ''}>Carretera</option>
        <option value="Híbrida" ${bike != null && bike.tipo == 'Híbrida' ? 'selected' : ''}>Híbrida</option>
        <option value="Urbana" ${bike != null && bike.tipo == 'Urbana' ? 'selected' : ''}>Urbana</option>
        <option value="Eléctrica" ${bike != null && bike.tipo == 'Eléctrica' ? 'selected' : ''}>Eléctrica</option>
        <option value="Infantil" ${bike != null && bike.tipo == 'Infantil' ? 'selected' : ''}>Infantil</option>
      </select>
    </div>

    <div class="col-md-4">
      <label for="precio" class="form-label">Precio (€)</label>
      <input type="number" step="0.01" class="form-control" id="precio" name="precio" required
             value="${bike != null ? bike.precio : ''}">
    </div>

    <div class="col-md-4">
      <label for="stock" class="form-label">Stock</label>
      <input type="number" class="form-control" id="stock" name="stock" required
             value="${bike != null ? bike.stock : ''}">
    </div>

    <div class="col-md-4">
      <label for="image" class="form-label">Nombre de imagen</label>
      <input type="text" class="form-control" id="image" name="image"
             placeholder="ej: m_trekmarlin5.png"
             value="${bike != null ? bike.image : ''}">
    </div>

    <div class="col-12">
      <button type="submit" class="btn btn-primary">
        <i class="fa-solid fa-floppy-disk"></i> Guardar
      </button>
      <a href="${pageContext.request.contextPath}/bikes" class="btn btn-secondary">Cancelar</a>
    </div>
  </form>
</div>

<%@ include file="/includes/footer.jsp" %>
