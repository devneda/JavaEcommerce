<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 03/06/2025
  Time: 9:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/includes/header.jsp" %>

<section class="hero text-center">
    <div class="container">
        <h1 class="display-4">Bienvenido a Trek Bikes Shop</h1>
        <p class="lead">Explora, pedalea, conquista.</p>
    </div>

    <div class="container py-3">
        <form action="${pageContext.request.contextPath}/search"
              method="get"
              class="row g-2 justify-content-center">
            <div class="col-auto">
                <select name="type" class="form-select">
                    <option value="bike">Bicicletas</option>
                    <option value="cliente">Clientes</option>
                    <option value="orden">Órdenes</option>
                </select>
            </div>

            <div class="col-auto">
                <input type="text"
                       name="keyword"
                       class="form-control"
                       placeholder="Buscar por nombre o modelo…"
                       required />
            </div>

            <div class="col-auto">
                <button type="submit" class="btn btn-dark">
                    Buscar
                </button>
            </div>
        </form>
    </div>

    <div class="container py-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 card-hover shadow-sm">
                    <img src="${pageContext.request.contextPath}/images/bike.png"
                         class="card-img-top" alt="Bicicletas">
                    <div class="card-body">
                        <h5 class="card-title">Bicicletas</h5>
                        <p class="card-text">Descubre nuestra gama Trek: montaña, híbridas, eléctricas y más.</p>
                    </div>
                    <div class="card-footer bg-transparent">
                        <a href="${pageContext.request.contextPath}/bikes"
                           class="btn btn-dark">
                            Ver bicicletas <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 card-hover shadow-sm">
                    <img src="${pageContext.request.contextPath}/images/cliente.png"
                         class="card-img-top" alt="Clientes">
                    <div class="card-body">
                        <h5 class="card-title">Clientes</h5>
                        <p class="card-text">Gestiona tu base de clientes fácilmente.</p>
                    </div>
                    <div class="card-footer bg-transparent">
                        <a href="${pageContext.request.contextPath}/clientes"
                           class="btn btn-dark">
                            Ver clientes <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 card-hover shadow-sm">
                    <img src="${pageContext.request.contextPath}/images/orden.png"
                         class="card-img-top" alt="Órdenes">
                    <div class="card-body">
                        <h5 class="card-title">Órdenes</h5>
                        <p class="card-text">Consulta el historial de compras y ventas realizadas.</p>
                    </div>
                    <div class="card-footer bg-transparent">
                        <a href="${pageContext.request.contextPath}/ordenes"
                           class="btn btn-dark">
                            Ver órdenes <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="/includes/footer.jsp" %>
