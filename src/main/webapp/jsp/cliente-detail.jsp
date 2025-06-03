<%--
  Created by IntelliJ IDEA.
  User: kenny
  Date: 03/06/2025
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/includes/header.jsp" %>

<%
    model.Cliente cliente = (model.Cliente) request.getAttribute("cliente");
%>

<div class="container py-5">
    <h2 class="mb-4">Detalle del Cliente</h2>

    <div class="card shadow-sm">
        <div class="card-body">
            <h4 class="card-title mb-3">${cliente.nombre}</h4>

            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Correo:</strong> ${cliente.correo}</li>
                <li class="list-group-item"><strong>Dirección:</strong> ${cliente.direccion}</li>
                <li class="list-group-item"><strong>Teléfono:</strong> ${cliente.telefono}</li>
                <li class="list-group-item"><strong>ID:</strong> ${cliente.id}</li>
            </ul>
        </div>
        <div class="card-footer text-end">
            <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">
                Volver al listado
            </a>
            <a href="${pageContext.request.contextPath}/clientes?action=edit&id=${cliente.id}" class="btn btn-primary">
                Editar
            </a>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
