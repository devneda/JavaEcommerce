<%--
  Created by IntelliJ IDEA.
  User: kpineda
  Date: 04/06/2025
  Time: 12:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Registro - Trek Bikes</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f5f5;
    }
    .register-card {
      max-width: 450px;
      margin: 100px auto;
      padding: 30px;
      background-color: #fff;
      border-radius: 16px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }
    .form-title {
      font-weight: 600;
      text-align: center;
    }
  </style>
</head>
<body>

<div class="register-card">
  <h2 class="form-title mb-4">Crear Cuenta</h2>

  <form action="${pageContext.request.contextPath}/register" method="post">
    <div class="mb-3">
      <label for="username" class="form-label">Usuario</label>
      <input type="text" class="form-control" name="username" required>
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">Correo electrónico</label>
      <input type="email" class="form-control" name="email" required>
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">Contraseña</label>
      <input type="password" class="form-control" name="password" required>
    </div>

    <div class="mb-3">
      <label for="rol" class="form-label">Tipo de usuario</label>
      <select name="rol" class="form-select" required>
        <option value="cliente">Cliente</option>
        <option value="admin">Administrador</option>
      </select>
    </div>

    <div class="d-grid gap-2">
      <button type="submit" class="btn btn-success">Registrarse</button>
      <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary">Volver al login</a>
    </div>
  </form>
</div>

</body>
</html>
