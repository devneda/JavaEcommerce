package servlet;

import dao.UsuarioDAO;
import model.Usuario;
import utils.DBConnection;

import javax.servlet.annotation.WebServlet;
import org.mindrot.jbcrypt.BCrypt;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            usuarioDAO = new UsuarioDAO(conn);
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

        // Hash de la contraseña con BCrypt
        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

        Usuario nuevo = new Usuario(0, username, email, passwordHash, "cliente");

        try {
            usuarioDAO.insertUsuario(nuevo);
            resp.sendRedirect(req.getContextPath() + "/login");
        } catch (Exception e) {
            throw new ServletException("Error al registrar usuario", e);
        }
    }
}
