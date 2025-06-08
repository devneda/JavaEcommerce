package dao;

import model.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {
    private final Connection conn;

    public ClienteDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Cliente> getAllClientes() throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT * FROM clientes";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Cliente c = new Cliente(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("correo"),
                        rs.getString("direccion"),
                        rs.getString("telefono")
                );
                clientes.add(c);
            }
        }
        return clientes;
    }

    public Cliente getClienteById(int id) throws SQLException {
        String sql = "SELECT * FROM clientes WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Cliente(
                            rs.getInt("id"),
                            rs.getString("nombre"),
                            rs.getString("correo"),
                            rs.getString("direccion"),
                            rs.getString("telefono")
                    );
                }
            }
        }
        return null;
    }

    public void insertCliente(Cliente c) throws SQLException {
        String sql = "INSERT INTO clientes (nombre, correo, direccion, telefono) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getNombre());
            stmt.setString(2, c.getCorreo());
            stmt.setString(3, c.getDireccion());
            stmt.setString(4, c.getTelefono());
            stmt.executeUpdate();
        }
    }

    public void updateCliente(Cliente c) throws SQLException {
        String sql = "UPDATE clientes SET nombre = ?, correo = ?, direccion = ?, telefono = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getNombre());
            stmt.setString(2, c.getCorreo());
            stmt.setString(3, c.getDireccion());
            stmt.setString(4, c.getTelefono());
            stmt.setInt(5, c.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteCliente(int id) throws SQLException {
        String sql = "DELETE FROM clientes WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public int getLastInsertId() throws SQLException {
        String sql = "SELECT LAST_INSERT_ID()";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    private Cliente mapRowToCliente(ResultSet rs) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setId(rs.getInt("id"));
        cliente.setNombre(rs.getString("nombre"));
        cliente.setCorreo(rs.getString("correo"));
        cliente.setDireccion(rs.getString("direccion"));
        cliente.setTelefono(rs.getString("telefono"));
        return cliente;
    }

    public Cliente getClienteByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM clientes WHERE correo = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToCliente(rs);
                }
            }
        }
        return null;
    }

    public List<Cliente> buscarPorNombreOCorreo(String query) throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT * FROM clientes WHERE LOWER(nombre) LIKE ? OR LOWER(correo) LIKE ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String wildcard = "%" + query.toLowerCase() + "%";
            ps.setString(1, wildcard);
            ps.setString(2, wildcard);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId(rs.getInt("id"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setCorreo(rs.getString("correo"));
                    cliente.setDireccion(rs.getString("direccion"));
                    cliente.setTelefono(rs.getString("telefono"));
                    clientes.add(cliente);
                }
            }
        }

        return clientes;
        }

    public List<Cliente> buscarPorNombreOCorreoPaginado(String query, int offset, int limit) throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT * FROM clientes WHERE LOWER(nombre) LIKE ? OR LOWER(correo) LIKE ? LIMIT ? OFFSET ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String wildcard = "%" + query.toLowerCase() + "%";
            ps.setString(1, wildcard);
            ps.setString(2, wildcard);
            ps.setInt(3, limit);
            ps.setInt(4, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    clientes.add(mapRowToCliente(rs));
                }
            }
        }
        return clientes;
    }

    public int countBuscarPorNombreOCorreo(String query) throws SQLException {
        String sql = "SELECT COUNT(*) FROM clientes WHERE LOWER(nombre) LIKE ? OR LOWER(correo) LIKE ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String wildcard = "%" + query.toLowerCase() + "%";
            stmt.setString(1, wildcard);
            stmt.setString(2, wildcard);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
