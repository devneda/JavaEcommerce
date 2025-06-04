package servlet;

import dao.ClienteDAO;
import dao.UsuarioDAO;
import model.Cliente;
import model.Usuario;
import utils.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            usuarioDAO = new UsuarioDAO(conn);
            clienteDAO = new ClienteDAO(conn);
        } catch (Exception e) {
            throw new ServletException("Error al conectar con la base de datos", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String rol = req.getParameter("rol");

        // Hash de la contraseña
        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

        int clienteId = 0;

        if ("cliente".equals(rol)) {
            try {
                Cliente cliente = clienteDAO.getClienteByEmail(email);
                if (cliente == null) {
                    // Crear nuevo cliente automáticamente
                    cliente = new Cliente();
                    cliente.setNombre(username);
                    cliente.setCorreo(email);
                    cliente.setDireccion("");
                    cliente.setTelefono("");

                    clienteDAO.insertCliente(cliente);
                }
                clienteId = cliente.getId();
            } catch (SQLException e) {
                throw new ServletException("Error al verificar/crear cliente", e);
            }
        }

        Usuario nuevo = new Usuario(0, username, email, passwordHash, rol, clienteId);

        try {
            usuarioDAO.insertUsuario(nuevo);
            resp.sendRedirect(req.getContextPath() + "/login");
        } catch (Exception e) {
            throw new ServletException("Error al registrar usuario", e);
        }
    }
}
