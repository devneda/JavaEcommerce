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
            throw new ServletException("Error al inicializar ClienteDAO", e);
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
                    showForm(req, resp, null);
                    break;
                case "edit":
                    int idToEdit = Integer.parseInt(req.getParameter("id"));
                    Cliente clienteToEdit = clienteDAO.getClienteById(idToEdit);
                    showForm(req, resp, clienteToEdit);
                    break;
                case "delete":
                    int idToDelete = Integer.parseInt(req.getParameter("id"));
                    clienteDAO.deleteCliente(idToDelete);
                    resp.sendRedirect("clientes");
                    break;
                case "detail":
                    showDetail(req, resp);
                    break;
                default:
                    listClientes(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException("Error en ClienteServlet", e);
        }
    }

    private void listClientes(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        String query = req.getParameter("query");
        List<Cliente> clientes;

        if (query != null && !query.trim().isEmpty()) {
            clientes = clienteDAO.buscarPorNombreOCorreo(query);
        } else {
            clientes = clienteDAO.getAllClientes();
        }

        req.setAttribute("clientes", clientes);
        req.getRequestDispatcher("/jsp/clientes-list.jsp").forward(req, resp);
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp, Cliente cliente)
            throws ServletException, IOException {
        req.setAttribute("cliente", cliente);
        req.getRequestDispatcher("/jsp/cliente-form.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Cliente cliente = clienteDAO.getClienteById(id);
        req.setAttribute("cliente", cliente);
        req.getRequestDispatcher("/jsp/cliente-detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        int id = req.getParameter("id") != null && !req.getParameter("id").isEmpty()
                ? Integer.parseInt(req.getParameter("id")) : 0;

        String nombre = req.getParameter("nombre");
        String correo = req.getParameter("correo");
        String direccion = req.getParameter("direccion");
        String telefono = req.getParameter("telefono");

        Cliente cliente = new Cliente(id, nombre, correo, direccion, telefono);

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
