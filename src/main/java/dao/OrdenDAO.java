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
        String sql = "SELECT * FROM ordenes";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Orden orden = new Orden(
                        rs.getInt("id"),
                        rs.getInt("cliente_id"),
                        rs.getInt("bicicleta_id"),
                        rs.getTimestamp("fecha"),
                        rs.getInt("cantidad"),
                        rs.getDouble("total")
                );
                ordenes.add(orden);
            }
        }
        return ordenes;
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
                    return new Orden(
                            rs.getInt("id"),
                            rs.getInt("cliente_id"),
                            rs.getInt("bicicleta_id"),
                            rs.getTimestamp("fecha"),
                            rs.getInt("cantidad"),
                            rs.getDouble("total")
                    );
                }
            }
        }
        return null;
    }

}
