package dao;

import model.Bike;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BikeDAO {
    private final Connection conn;

    public BikeDAO(Connection conn) {
        this.conn = conn;
    }

    // Obtener todas las bicis
    public List<Bike> getAllBikes() throws SQLException {
        List<Bike> bikes = new ArrayList<>();
        String sql = "SELECT * FROM bicicletas";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bikes.add(mapRowToBike(rs));
            }
        }
        return bikes;
    }

    // Obtener bici por ID
    public Bike getBikeById(int id) throws SQLException {
        String sql = "SELECT * FROM bicicletas WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToBike(rs);
                }
            }
        }
        return null;
    }

    // Insertar nueva bici
    public void insertBike(Bike bike) throws SQLException {
        String sql = "INSERT INTO bicicletas (modelo, tipo, precio, stock, image) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bike.getModelo());
            stmt.setString(2, bike.getTipo());
            stmt.setDouble(3, bike.getPrecio());
            stmt.setInt(4, bike.getStock());
            stmt.setString(5, bike.getImage());
            stmt.executeUpdate();
        }
    }

    // Actualizar bici existente
    public void updateBike(Bike bike) throws SQLException {
        String sql = "UPDATE bicicletas SET modelo = ?, tipo = ?, precio = ?, stock = ?, image = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bike.getModelo());
            stmt.setString(2, bike.getTipo());
            stmt.setDouble(3, bike.getPrecio());
            stmt.setInt(4, bike.getStock());
            stmt.setString(5, bike.getImage());
            stmt.setInt(6, bike.getId());
            stmt.executeUpdate();
        }
    }

    // Eliminar bici por ID
    public void deleteBike(int id) throws SQLException {
        String sql = "DELETE FROM bicicletas WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // Buscador por modelo
    public List<Bike> searchByModelo(String keyword) throws SQLException {
        List<Bike> bikes = new ArrayList<>();
        String sql = "SELECT * FROM bicicletas WHERE modelo LIKE ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bikes.add(mapRowToBike(rs));
                }
            }
        }
        return bikes;
    }

    // Mapeo de ResultSet a objeto Bike
    private Bike mapRowToBike(ResultSet rs) throws SQLException {
        Bike bike = new Bike();
        bike.setId(rs.getInt("id"));
        bike.setModelo(rs.getString("modelo"));
        bike.setTipo(rs.getString("tipo"));
        bike.setPrecio(rs.getDouble("precio"));
        bike.setStock(rs.getInt("stock"));
        bike.setImage(rs.getString("image"));
        return bike;
    }

    //
    public List<Bike> buscarPorModeloOTipo(String query) {
        List<Bike> lista = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM bicicletas WHERE LOWER(modelo) LIKE ? OR LOWER(tipo) LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            String wildcardQuery = "%" + query.toLowerCase() + "%";
            ps.setString(1, wildcardQuery);
            ps.setString(2, wildcardQuery);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapRowToBike(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
