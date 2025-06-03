package servlet;

import dao.BikeDAO;
import model.Bike;
import utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/bikes")
public class BikeServlet extends HttpServlet {
    private BikeDAO bikeDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            bikeDAO = new BikeDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Error al inicializar BikeDAO", e);
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
                    req.setAttribute("bike", null);
                    req.getRequestDispatcher("/jsp/bike-form.jsp").forward(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteBike(req, resp);
                    break;
                case "detail":
                    showDetail(req, resp);
                    break;
                default:
                    listBikes(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en operación con bicicletas", e);
        }
    }

    private void listBikes(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        List<Bike> bikes = bikeDAO.getAllBikes();
        req.setAttribute("bikes", bikes);
        req.getRequestDispatcher("/jsp/bikes-list.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Bike bike = bikeDAO.getBikeById(id);
        req.setAttribute("bike", bike);
        req.getRequestDispatcher("/jsp/bike-form.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Bike bike = bikeDAO.getBikeById(id);
        req.setAttribute("bike", bike);
        req.getRequestDispatcher("/jsp/bike-detail.jsp").forward(req, resp);
    }

    private void deleteBike(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        bikeDAO.deleteBike(id);
        resp.sendRedirect("bikes");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int id = req.getParameter("id") != null && !req.getParameter("id").isEmpty()
                ? Integer.parseInt(req.getParameter("id")) : 0;

        String modelo = req.getParameter("modelo");
        String tipo = req.getParameter("tipo");
        double precio = Double.parseDouble(req.getParameter("precio"));
        int stock = Integer.parseInt(req.getParameter("stock"));
        String image = req.getParameter("image");

        Bike bike = new Bike(id, modelo, tipo, precio, stock, image);

        try {
            if (id == 0) {
                bikeDAO.insertBike(bike);
            } else {
                bikeDAO.updateBike(bike);
            }
        } catch (SQLException e) {
            throw new ServletException("Error al guardar la bicicleta", e);
        }

        resp.sendRedirect("bikes");
    }
}
