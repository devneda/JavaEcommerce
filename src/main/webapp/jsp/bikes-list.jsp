<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 03/06/2025
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Bike" %>
<%@ include file="/includes/header.jsp" %>

<%--<%--%>
<%--    List<Bike> bikes = (List<Bike>) request.getAttribute("bikes");--%>
<%--%>--%>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Listado de Bicicletas Trek</h2>
        <!-- TODO cuadro de búsqueda -->
        <form class="d-flex justify-content-end mb-3" method="GET">
            <div class="input-group" style="max-width: 300px;">
                <input type="text" class="form-control" name="query" placeholder="Buscar" value="${param.query}">
                <button type="submit" class="btn btn-dark">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </form>

        <c:if test="${sessionScope.usuarioLogueado.rol == 'admin'}">
            <a href="${pageContext.request.contextPath}/bikes?action=new" class="btn btn-success"><i class="fa-solid fa-plus"></i> Añadir Bicicleta
            </a>
        </c:if>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle text-center">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Imagen</th>
                <th>Modelo</th>
                <th>Tipo</th>
                <th>Precio (€)</th>
                <th>Stock</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="bike" items="${bikes}">
                <tr>
                    <td>
                        <a href="${pageContext.request.contextPath}/bikes?action=detail&id=${bike.id}">
                                ${bike.id}
                        </a>
                    </td>
                    <td>
                        <img src="${pageContext.request.contextPath}/images/${bike.image}"
                             alt="${bike.modelo}" width="80" height="50">
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/bikes?action=detail&id=${bike.id}">
                                ${bike.modelo}
                        </a>
                    </td>
                    <td>${bike.tipo}</td>
                    <td>${bike.precio}</td>
                    <td>${bike.stock}</td>
                    <td>
                        <!-- TODO diferenciar los botones para usuario admin y para usuario cliente -> el cliente no debe modificar ni eliminar bicis -->
                        <!-- Si el usuario es admin, le muestro sus botones para editar y eliminar bicis -->
                        <c:if test="${sessionScope.usuarioLogueado.rol == 'admin'}">
                            <a href="${pageContext.request.contextPath}/bikes?action=edit&id=${bike.id}" class="btn btn-sm btn-warning">
                                <i class="fa-solid fa-pen"></i> Editar
                            </a>
                            <a href="${pageContext.request.contextPath}/bikes?action=delete&id=${bike.id}" class="btn btn-sm btn-danger"
                               onclick="return confirm('¿Estás seguro de eliminar esta bicicleta?');">
                                <i class="fa-solid fa-trash"></i> Eliminar
                            </a>
                        </c:if>

                        <!-- Si es tipo cliente, solo le muestro nuevo boton 'Comprar' -->
                        <c:if test="${sessionScope.usuarioLogueado.rol == 'cliente'}">
                            <a href="${pageContext.request.contextPath}/ordenes?action=new&idBici=${bike.id}" class="btn btn-sm btn-success">
                                <i class="fa-solid fa-cart-plus"></i> Comprar
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
                    <a class="page-link" href="bikes?page=${i}&query=${query}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>


<%@ include file="/includes/footer.jsp" %>
