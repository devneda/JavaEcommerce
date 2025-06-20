<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 03/06/2025
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/includes/header.jsp" %>

<div class="container py-5">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0">Listado de Clientes</h2>
    <form class="d-flex" method="get">
      <input type="text" class="form-control me-2" name="query" placeholder="Buscar" value="${param.query}">
      <button type="submit" class="btn btn-dark">
        <i class="bi bi-search"></i>
      </button>
    </form>
    <a href="${pageContext.request.contextPath}/clientes?action=new" class="btn btn-success">
      <i class="fa-solid fa-plus"></i> Añadir Cliente
    </a>
  </div>

  <div class="table-responsive">
    <table class="table table-bordered table-striped align-middle text-center">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Correo</th>
        <th>Dirección</th>
        <th>Teléfono</th>
        <th>Acciones</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="cliente" items="${clientes}">
        <tr>
          <td>${cliente.id}</td>
          <td>
            <a href="${pageContext.request.contextPath}/clientes?action=detail&id=${cliente.id}">
                ${cliente.nombre}
            </a>
          </td>
          <td>${cliente.correo}</td>
          <td>${cliente.direccion}</td>
          <td>${cliente.telefono}</td>
          <td>
            <a href="${pageContext.request.contextPath}/clientes?action=edit&id=${cliente.id}" class="btn btn-sm btn-warning">
              <i class="fa-solid fa-pen"></i> Editar
            </a>
            <a href="${pageContext.request.contextPath}/clientes?action=delete&id=${cliente.id}" class="btn btn-sm btn-danger"
               onclick="return confirm('¿Estás seguro de eliminar este cliente?');">
              <i class="fa-solid fa-trash"></i> Eliminar
            </a>
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
          <a class="page-link" href="clientes?page=${i}&query=${query}">${i}</a>
        </li>
      </c:forEach>
    </ul>
  </nav>
</div>


<%@ include file="/includes/footer.jsp" %>
