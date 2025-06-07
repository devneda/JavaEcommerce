package dao;

import model.Orden;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdenDAO {
    private final Connection conn;

    public OrdenDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Orden> getAllOrdenes() throws SQLException {
        List<Orden> ordenes = new ArrayList<>();
        String sql = "SELECT o.id, o.fecha, o.cantidad, o.total, " +
                "c.nombre AS cliente_nombre, b.tipo AS bici_tipo " +
                "FROM ordenes o " +
                "JOIN clientes c ON o.cliente_id = c.id " +
                "JOIN bicicletas b ON o.bicicleta_id = b.id " +
                "ORDER BY o.fecha DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Orden orden = new Orden();
                orden.setId(rs.getInt("id"));
                orden.setFecha(rs.getDate("fecha"));
                orden.setCantidad(rs.getInt("cantidad"));
                orden.setTotal(rs.getDouble("total"));
                orden.setClienteNombre(rs.getString("cliente_nombre"));
                orden.setBiciTipo(rs.getString("bici_tipo"));
                ordenes.add(orden);
            }
        }
        return ordenes;
    }

    public List<Orden> getOrdenesByClienteConJoin(int clienteId) throws SQLException {
        List<Orden> ordenes = new ArrayList<>();
        String sql = "SELECT o.id, o.fecha, o.cantidad, o.total, " +
                "c.nombre AS cliente_nombre, b.tipo AS bici_tipo " +
                "FROM ordenes o " +
                "JOIN clientes c ON o.cliente_id = c.id " +
                "JOIN bicicletas b ON o.bicicleta_id = b.id " +
                "WHERE o.cliente_id = ? ORDER BY o.fecha DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clienteId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Orden orden = new Orden();
                orden.setId(rs.getInt("id"));
                orden.setFecha(rs.getDate("fecha"));
                orden.setCantidad(rs.getInt("cantidad"));
                orden.setTotal(rs.getDouble("total"));
                orden.setClienteNombre(rs.getString("cliente_nombre"));
                orden.setBiciTipo(rs.getString("bici_tipo"));
                ordenes.add(orden);
            }
        }
        return ordenes;
    }

    public List<Orden> buscarPorClienteOTipo(String query) throws SQLException {
        List<Orden> lista = new ArrayList<>();
        String sql = "SELECT o.id, o.fecha, o.cantidad, o.total, " +
                "c.nombre AS cliente_nombre, b.tipo AS bici_tipo " +
                "FROM ordenes o " +
                "JOIN clientes c ON o.cliente_id = c.id " +
                "JOIN bicicletas b ON o.bicicleta_id = b.id " +
                "WHERE LOWER(c.nombre) LIKE ? OR LOWER(b.tipo) LIKE ? " +
                "ORDER BY o.fecha DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String wildcardQuery = "%" + query.toLowerCase() + "%";
            ps.setString(1, wildcardQuery);
            ps.setString(2, wildcardQuery);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orden orden = new Orden();
                orden.setId(rs.getInt("id"));
                orden.setFecha(rs.getDate("fecha"));
                orden.setCantidad(rs.getInt("cantidad"));
                orden.setTotal(rs.getDouble("total"));
                orden.setClienteNombre(rs.getString("cliente_nombre"));
                orden.setBiciTipo(rs.getString("bici_tipo"));
                lista.add(orden);
            }
        }
        return lista;
    }

    public void insertOrden(Orden orden) throws SQLException {
        String sql = "INSERT INTO ordenes (cliente_id, bicicleta_id, fecha, cantidad, total) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orden.getClienteId());
            stmt.setInt(2, orden.getBicicletaId());
            stmt.setTimestamp(3, new Timestamp(orden.getFecha().getTime()));
            stmt.setInt(4, orden.getCantidad());
            stmt.setDouble(5, orden.getTotal());
            stmt.executeUpdate();
        }
    }

    public void updateOrden(Orden orden) throws SQLException {
        String sql = "UPDATE ordenes SET cliente_id = ?, bicicleta_id = ?, fecha = ?, cantidad = ?, total = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orden.getClienteId());
            stmt.setInt(2, orden.getBicicletaId());
            stmt.setTimestamp(3, new Timestamp(orden.getFecha().getTime()));
            stmt.setInt(4, orden.getCantidad());
            stmt.setDouble(5, orden.getTotal());
            stmt.setInt(6, orden.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteOrden(int id) throws SQLException {
        String sql = "DELETE FROM ordenes WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public Orden getOrdenById(int id) throws SQLException {
        String sql = "SELECT * FROM ordenes WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Orden orden = new Orden();
                    orden.setId(rs.getInt("id"));
                    orden.setClienteId(rs.getInt("cliente_id"));
                    orden.setBicicletaId(rs.getInt("bicicleta_id"));
                    orden.setFecha(rs.getTimestamp("fecha"));
                    orden.setCantidad(rs.getInt("cantidad"));
                    orden.setTotal(rs.getDouble("total"));
                    return orden;
                }
            }
        }
        return null;
    }
}