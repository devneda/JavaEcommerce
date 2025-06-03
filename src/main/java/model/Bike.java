package model;

public class Bike {
    private int id;
    private String modelo;
    private String tipo;
    private double precio; // Cambiado a double
    private int stock;
    private String image;

    public Bike() {
    }

    public Bike(int id, String modelo, String tipo, double precio, int stock, String image) {
        this.id = id;
        this.modelo = modelo;
        this.tipo = tipo;
        this.precio = precio;
        this.stock = stock;
        this.image = image;
    }

    // Getters y setters (opcional, pero recomendados)

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Bike{" +
                "id=" + id +
                ", modelo='" + modelo + '\'' +
                ", tipo='" + tipo + '\'' +
                ", precio=" + precio +
                ", stock=" + stock +
                ",image='" + image + '\'' +
                '}';
    }
}
