package servlet;

import dao.UsuarioDAO;
import model.Usuario;
import model.Cliente;
import dao.ClienteDAO;
import utils.DBConnection;

import javax.servlet.annotation.WebServlet;
import org.mindrot.jbcrypt.BCrypt;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
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

    // Mostrar el formulario de login
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
    }

    // Procesar el login
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            Usuario user = usuarioDAO.getByUsername(username);

            if (user != null && BCrypt.checkpw(password, user.getPasswordHash())) {
                HttpSession session = req.getSession();
                if ("cliente".equals(user.getRol())) {
                    ClienteDAO clienteDAO = new ClienteDAO(DBConnection.getConnection());
                    Cliente existente = clienteDAO.getClienteByEmail(user.getEmail());

                    if (existente == null) {
                        Cliente nuevo = new Cliente();
                        nuevo.setNombre(user.getUsername());
                        nuevo.setCorreo(user.getEmail());
                        nuevo.setDireccion("No especificada");
                        nuevo.setTelefono("N/A");

                        clienteDAO.insertCliente(nuevo);
                        int clienteId = clienteDAO.getLastInsertId();
                        user.setClienteId(clienteId);
                    } else {
                        user.setClienteId(existente.getId());
                    }
                }
                session.setAttribute("usuarioLogueado", user);
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            } else {
                req.setAttribute("error", "Credenciales incorrectas");
                req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException("Error al intentar iniciar sesión", e);
        }
    }
}
