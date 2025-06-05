<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 03/06/2025
  Time: 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Trek Bikes Shop</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet" crossorigin="anonymous">

  <!-- Bootstrap Icons -->
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
        crossorigin="anonymous">

  <!-- FontAwesome -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
        crossorigin="anonymous">

  <!-- Estilos personalizados -->
  <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
      <i class="fa-solid fa-bicycle me-2"></i> Trek Bikes
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarMain" aria-controls="navbarMain"
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarMain">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/bikes">
            <i class="fa-solid fa-mountain"></i> Bicicletas
          </a>
        </li>
        <c:if test="${sessionScope.usuarioLogueado.rol == 'admin'}">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/clientes">
              <i class="fa-solid fa-user"></i> Clientes
            </a>
          </li>
        </c:if>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/ordenes">
            <i class="fa-solid fa-receipt"></i> Órdenes
          </a>
        </li>
      </ul>
      <div class="d-flex align-items-center ms-auto">
        <c:if test="${not empty sessionScope.usuarioLogueado}">
          <span class="me-2 text-white">Hola, ${sessionScope.usuarioLogueado.username}</span>
          <form action="${pageContext.request.contextPath}/logout" method="get" class="d-inline">
            <button type="submit" class="btn btn-outline-danger btn-sm">Cerrar sesión</button>
          </form>
        </c:if>
      </div>
    </div>
  </div>
</nav>
