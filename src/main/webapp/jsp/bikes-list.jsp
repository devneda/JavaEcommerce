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
        <a href="${pageContext.request.contextPath}/bikes/new" class="btn btn-success">
            <i class="fa-solid fa-plus"></i> Añadir Bicicleta
        </a>
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
                    <td>${bike.id}</td>
                    <td>
                        <img src="${pageContext.request.contextPath}/images/${bike.image}"
                             alt="${bike.modelo}" width="80" height="50">
                    </td>
                    <td>${bike.modelo}</td>
                    <td>${bike.tipo}</td>
                    <td>${bike.precio}</td>
                    <td>${bike.stock}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/bikes/edit?id=${bike.id}" class="btn btn-sm btn-warning">
                            <i class="fa-solid fa-pen"></i> Editar
                        </a>
                        <a href="${pageContext.request.contextPath}/bikes/delete?id=${bike.id}" class="btn btn-sm btn-danger"
                           onclick="return confirm('¿Estás seguro de eliminar esta bicicleta?');">
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
