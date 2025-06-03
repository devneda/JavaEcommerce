package servlet;

import dao.ClienteDAO;
import model.Cliente;
import utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            clienteDAO = new ClienteDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Error al conectar con base de datos", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    req.setAttribute("cliente", null);
                    req.getRequestDispatcher("/jsp/cliente-form.jsp").forward(req, resp);
                    break;
                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    Cliente cliente = clienteDAO.getClienteById(id);
                    req.setAttribute("cliente", cliente);
                    req.getRequestDispatcher("/jsp/cliente-form.jsp").forward(req, resp);
                    break;
                case "delete":
                    clienteDAO.deleteCliente(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect("clientes");
                    break;
                default:
                    List<Cliente> clientes = clienteDAO.getAllClientes();
                    req.setAttribute("clientes", clientes);
                    req.getRequestDispatcher("/jsp/clientes-list.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = req.getParameter("id") != null && !req.getParameter("id").isEmpty()
                ? Integer.parseInt(req.getParameter("id")) : 0;

        Cliente cliente = new Cliente(
                id,
                req.getParameter("nombre"),
                req.getParameter("correo"),
                req.getParameter("direccion"),
                req.getParameter("telefono")
        );

        try {
            if (id == 0) {
                clienteDAO.insertCliente(cliente);
            } else {
                clienteDAO.updateCliente(cliente);
            }
        } catch (SQLException e) {
            throw new ServletException("Error al guardar cliente", e);
        }

        resp.sendRedirect("clientes");
    }
}
