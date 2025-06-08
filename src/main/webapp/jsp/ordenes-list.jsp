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

    <!-- Buscador -->
    <form class="d-flex" method="GET">
      <input type="text" class="form-control me-2" name="query" placeholder="Buscar" value="${param.query}">
      <button type="submit" class="btn btn-dark">
        <i class="bi bi-search"></i>
      </button>
    </form>
    <c:if test="${sessionScope.usuarioLogueado.rol == 'admin'}">
      <a href="ordenes?action=new" class="btn btn-success"><i class="fa-solid fa-plus"></i> Nueva Orden</a>
    </c:if>
  </div>

  <div class="table-responsive">
    <table class="table table-bordered table-striped align-middle text-center">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Cliente</th>
        <th>Bici (Tipo)</th>
        <th>Cantidad</th>
        <th>Total (€)</th>
        <th>Fecha</th>
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
          <td>${orden.clienteNombre}</td>
          <td>${orden.biciTipo}</td>
          <td>${orden.cantidad}</td>
          <td>€${orden.total}</td>
          <td>${orden.fecha}</td>
          <td>
            <!-- Si necesitas condicionar por rol -->
            <c:if test="${sessionScope.usuarioLogueado.rol == 'admin'}">
              <a href="${pageContext.request.contextPath}/ordenes?action=edit&id=${orden.id}" class="btn btn-sm btn-warning">
                <i class="fa-solid fa-pen"></i> Editar
              </a>
              <a href="${pageContext.request.contextPath}/ordenes?action=delete&id=${orden.id}"
                 class="btn btn-sm btn-danger"
                 onclick="return confirm('¿Estás seguro de eliminar esta orden?');">
                <i class="fa-solid fa-trash"></i> Eliminar
              </a>
            </c:if>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>


<div class="d-flex justify-content-center mt-4">
  <nav>
    <ul class="pagination">
      <c:forEach begin="1" end="${totalPages}" var="i">
        <li class="page-item ${i == currentPage ? 'active' : ''}">
          <a class="page-link" href="ordenes?page=${i}&query=${query}">${i}</a>
        </li>
      </c:forEach>
    </ul>
  </nav>
</div>


<%@ include file="/includes/footer.jsp" %>
