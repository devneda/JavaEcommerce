package dao;

import model.Usuario;
import java.sql.*;

public class UsuarioDAO {
    private final Connection conn;

    public UsuarioDAO(Connection conn) {
        this.conn = conn;
    }

    public Usuario getByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        }
        return null;
    }

    public void insertUsuario(Usuario user) throws SQLException {
        String sql = "INSERT INTO usuarios (username, email, password_hash, rol, cliente_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getRol());
            if (user.getClienteId() != null) {
                stmt.setInt(5, user.getClienteId());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }
            stmt.executeUpdate();
        }
    }

    public boolean validateLogin(String username, String passwordHash) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE username = ? AND password_hash = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, passwordHash); // Debes comparar hash, no texto plano
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    private Usuario mapResultSet(ResultSet rs) throws SQLException {
        return new Usuario(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("password_hash"),
                rs.getString("rol"),
                rs.getInt("cliente_id")
        );
    }
}
