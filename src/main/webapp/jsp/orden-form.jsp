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
  <h2 class="mb-4">${orden != null ? "Editar Orden" : "Registrar Nueva Orden"}</h2>

  <form action="${pageContext.request.contextPath}/ordenes" method="post" class="row g-3">
    <c:if test="${not empty orden}">
      <input type="hidden" name="id" value="${orden.id}" />
    </c:if>

    <!-- Cliente -->
    <c:choose>
      <c:when test="${sessionScope.usuarioLogueado.rol == 'admin'}">
        <div class="col-md-6">
          <label for="clienteId" class="form-label">Cliente</label>
          <select name="clienteId" id="clienteId" class="form-select" required>
            <option value="">Selecciona un cliente</option>
            <c:forEach var="c" items="${clientes}">
              <option value="${c.id}" ${orden != null && orden.clienteId == c.id ? "selected" : ""}>
                  ${c.nombre}
              </option>
            </c:forEach>
          </select>
        </div>
      </c:when>
      <c:otherwise>
        <input type="hidden" name="clienteId" value="${cliente.id}" />
        <div class="col-md-6">
          <label class="form-label">Cliente</label>
          <input type="text" class="form-control" value="${cliente.nombre}" disabled>
        </div>
      </c:otherwise>
    </c:choose>

    <!-- Bicicleta -->
    <c:choose>
      <c:when test="${sessionScope.usuarioLogueado.rol == 'admin'}">
        <div class="col-md-6">
          <label for="bicicletaId" class="form-label">Bicicleta</label>
          <select name="bicicletaId" id="bicicletaId" class="form-select" required onchange="updatePrecio()">
            <option value="">Selecciona una bicicleta</option>
            <c:forEach var="b" items="${bicicletas}">
              <option value="${b.id}" data-precio="${b.precio}" ${orden != null && orden.bicicletaId == b.id ? "selected" : ""}>
                  ${b.modelo} - €${b.precio}
              </option>
            </c:forEach>
          </select>
        </div>
      </c:when>
      <c:otherwise>
        <input type="hidden" name="bicicletaId" value="${bicicleta.id}" />
        <div class="col-md-6">
          <label class="form-label">Bicicleta</label>
          <input type="text" class="form-control" value="${bicicleta.modelo} - €${bicicleta.precio}" disabled>
          <input type="hidden" id="precio" name="precio" value="${bicicleta.precio}" />
        </div>
      </c:otherwise>
    </c:choose>

    <!-- Cantidad -->
    <div class="col-md-4">
      <label for="cantidad" class="form-label">Cantidad</label>
      <input type="number" class="form-control" id="cantidad" name="cantidad"
             value="${orden != null ? orden.cantidad : 1}" min="1" required onchange="updateTotal()">
    </div>

    <!-- Precio unitario (solo admin) -->
    <c:if test="${sessionScope.usuarioLogueado.rol == 'admin'}">
      <div class="col-md-4">
        <label for="precio" class="form-label">Precio unitario (€)</label>
        <input type="number" class="form-control" id="precio" name="precio" step="0.01"
               value="${orden != null ? orden.total / orden.cantidad : ''}" readonly required>
      </div>
    </c:if>

    <!-- Total -->
    <div class="col-md-4">
      <label for="total" class="form-label">Total (€)</label>
      <input type="text" class="form-control" id="total" value="0.00" readonly>
    </div>

    <!-- Botón enviar -->
    <div class="col-md-12 d-flex justify-content-end">
      <button type="submit" class="btn btn-primary">
        <i class="fa-solid fa-cart-plus"></i> ${orden != null ? "Actualizar" : "Guardar"} Orden
      </button>
    </div>
  </form>
</div>

<script>
  function updatePrecio() {
    const select = document.getElementById('bicicletaId');
    const selected = select.options[select.selectedIndex];
    const precio = selected.getAttribute('data-precio');
    if (precio) {
      document.getElementById('precio').value = precio;
      updateTotal();
    }
  }

  function updateTotal() {
    const precio = parseFloat(document.getElementById('precio').value || 0);
    const cantidad = parseInt(document.getElementById('cantidad').value || 1);
    const total = precio * cantidad;
    document.getElementById('total').value = total.toFixed(2);
  }

  window.onload = function () {
    if (document.getElementById('precio')) updateTotal();
  };
</script>

<%@ include file="/includes/footer.jsp" %>
