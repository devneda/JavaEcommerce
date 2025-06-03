package model;

import java.util.Date;

public class Orden {
    private int id;
    private int clienteId;
    private int bicicletaId;
    private Date fecha;
    private int cantidad;
    private double total;

    public Orden() {
    }

    public Orden(int id, int clienteId, int bicicletaId, Date fecha, int cantidad, double total) {
        this.id = id;
        this.clienteId = clienteId;
        this.bicicletaId = bicicletaId;
        this.fecha = fecha;
        this.cantidad = cantidad;
        this.total = total;
    }

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getClienteId() { return clienteId; }
    public void setClienteId(int clienteId) { this.clienteId = clienteId; }

    public int getBicicletaId() { return bicicletaId; }
    public void setBicicletaId(int bicicletaId) { this.bicicletaId = bicicletaId; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
}
