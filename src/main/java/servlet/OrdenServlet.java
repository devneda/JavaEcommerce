package servlet;

import dao.BikeDAO;
import dao.ClienteDAO;
import dao.OrdenDAO;
import model.Bike;
import model.Cliente;
import model.Orden;
import model.Usuario;
import utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet("/ordenes")
public class OrdenServlet extends HttpServlet {
    private OrdenDAO ordenDAO;
    private ClienteDAO clienteDAO;
    private BikeDAO bikeDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            ordenDAO = new OrdenDAO(conn);
            clienteDAO = new ClienteDAO(conn);
            bikeDAO = new BikeDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Error al inicializar DAOs", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Usuario user = (Usuario) req.getSession().getAttribute("usuarioLogueado");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    if (!"admin".equals(user.getRol())) {
                        resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    req.setAttribute("clientes", clienteDAO.getAllClientes());
                    req.setAttribute("bicicletas", bikeDAO.getAllBikes());
                    req.getRequestDispatcher("/jsp/orden-form.jsp").forward(req, resp);
                    break;

                case "delete":
                    if (!"admin".equals(user.getRol())) {
                        resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    ordenDAO.deleteOrden(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect("ordenes");
                    break;

                case "detail":
                    showDetail(req, resp, user);
                    break;

                default:
                    List<Orden> ordenes;
                    if ("admin".equals(user.getRol())) {
                        ordenes = ordenDAO.getAllOrdenes();
                    } else {
                        ordenes = ordenDAO.getOrdenesByCliente(user.getClienteId());
                    }
                    req.setAttribute("ordenes", ordenes);
                    req.getRequestDispatcher("/jsp/ordenes-list.jsp").forward(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en operaciones con órdenes", e);
        }
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp, Usuario user)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Orden orden = ordenDAO.getOrdenById(id);

        if (orden == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        if (!"admin".equals(user.getRol()) && orden.getClienteId() != user.getClienteId()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "No autorizado a ver esta orden.");
            return;
        }

        Cliente cliente = clienteDAO.getClienteById(orden.getClienteId());
        Bike bike = bikeDAO.getBikeById(orden.getBicicletaId());

        req.setAttribute("orden", orden);
        req.setAttribute("cliente", cliente);
        req.setAttribute("bike", bike);
        req.getRequestDispatcher("/jsp/ordenes-detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Usuario user = (Usuario) req.getSession().getAttribute("usuarioLogueado");
        if (user == null || !"admin".equals(user.getRol())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        int clienteId = Integer.parseInt(req.getParameter("clienteId"));
        int bicicletaId = Integer.parseInt(req.getParameter("bicicletaId"));
        int cantidad = Integer.parseInt(req.getParameter("cantidad"));
        double precioUnitario = Double.parseDouble(req.getParameter("precio"));
        double total = precioUnitario * cantidad;

        Orden orden = new Orden(0, clienteId, bicicletaId, new Date(), cantidad, total);
        orden.setUsuarioId(user.getId()); // Admin que registró la orden

        try {
            ordenDAO.insertOrden(orden);
        } catch (SQLException e) {
            throw new ServletException("Error al guardar la orden", e);
        }

        resp.sendRedirect("ordenes");
    }
}
