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
<%@ page import="java.util.List" %>
<%@ page import="model.Cliente, model.Bike" %>

<%
  List<model.Cliente> clientes = (List<model.Cliente>) request.getAttribute("clientes");
  List<model.Bike> bicicletas = (List<model.Bike>) request.getAttribute("bicicletas");
%>

<div class="container py-5">
  <h2 class="mb-4">Registrar Nueva Orden</h2>

  <form action="${pageContext.request.contextPath}/ordenes" method="post" class="row g-3">

    <div class="col-md-6">
      <label for="clienteId" class="form-label">Cliente</label>
      <select name="clienteId" id="clienteId" class="form-select" required>
        <option value="">Selecciona un cliente</option>
        <c:forEach var="c" items="${clientes}">
          <option value="${c.id}">${c.nombre}</option>
        </c:forEach>
      </select>
    </div>

    <div class="col-md-6">
      <label for="bicicletaId" class="form-label">Bicicleta</label>
      <select name="bicicletaId" id="bicicletaId" class="form-select" required onchange="updatePrecio()">
        <option value="">Selecciona una bicicleta</option>
        <c:forEach var="b" items="${bicicletas}">
          <option value="${b.id}" data-precio="${b.precio}">
              ${b.modelo} - €${b.precio}
          </option>
        </c:forEach>
      </select>
    </div>

    <div class="col-md-4">
      <label for="cantidad" class="form-label">Cantidad</label>
      <input type="number" class="form-control" id="cantidad" name="cantidad" value="1" min="1" required>
    </div>

    <div class="col-md-4">
      <label for="precio" class="form-label">Precio unitario (€)</label>
      <input type="number" class="form-control" id="precio" name="precio" step="0.01" readonly required>
    </div>

    <div class="col-md-4 d-flex align-items-end">
      <button type="submit" class="btn btn-primary w-100">
        <i class="fa-solid fa-cart-plus"></i> Guardar Orden
      </button>
    </div>
  </form>
</div>

<script>
  function updatePrecio() {
    const select = document.getElementById('bicicletaId');
    const selected = select.options[select.selectedIndex];
    const precio = selected.getAttribute('data-precio');
    document.getElementById('precio').value = precio || '';
  }
</script>

<%@ include file="/includes/footer.jsp" %>
