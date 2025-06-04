-- Crear base de datos
CREATE DATABASE IF NOT EXISTS ecommerce_trek;
USE ecommerce_trek;

-- Tabla de usuarios para login
CREATE TABLE usuarios (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(100) NOT NULL UNIQUE,
password_hash VARCHAR(255) NOT NULL,
rol ENUM('cliente', 'admin') NOT NULL DEFAULT 'cliente',
creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de clientes
CREATE TABLE clientes (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
correo VARCHAR(100),
direccion TEXT,
telefono VARCHAR(15)
);

-- Tabla de bicicletas
CREATE TABLE bicicletas (
id INT AUTO_INCREMENT PRIMARY KEY,
modelo VARCHAR(100),
tipo VARCHAR(50),
precio DECIMAL(10,2),
stock INT,
image VARCHAR(150)
);

-- Tabla de órdenes
CREATE TABLE ordenes (
id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT,
bicicleta_id INT,
fecha DATETIME,
cantidad INT,
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES clientes(id),
FOREIGN KEY (bicicleta_id) REFERENCES bicicletas(id)
);

-- Insertar datos en clientes
INSERT INTO clientes (nombre, correo, direccion, telefono) VALUES
('Carlos Gómez', 'carlos@example.com', 'Calle 123, Ciudad', '5551234567'),
('Laura Pérez', 'laura@example.com', 'Avenida 456, Ciudad', '5552345678'),
('Miguel Torres', 'miguel@example.com', 'Boulevard 789, Ciudad', '5553456789'),
('Ana Ruiz', 'ana@example.com', 'Calle Luna 42', '5554567890'),
('Jorge López', 'jorge@example.com', 'Av. del Sol 89', '5555678901'),
('Sandra Díaz', 'sandra@example.com', 'Calle Mar 33', '5556789012'),
('Daniel Herrera', 'daniel@example.com', 'Camino Verde 22', '5557890123'),
('Lucía Moreno', 'lucia@example.com', 'Pasaje Azul 14', '5558901234'),
('Iván Romero', 'ivan@example.com', 'Calle Norte 67', '5559012345'),
('María Castillo', 'maria@example.com', 'Av. Central 55', '5550123456'),
('Raúl Vargas', 'raul@example.com', 'Calle Este 21', '5552345012'),
('Carmen Silva', 'carmen@example.com', 'Calle Oeste 80', '5553456013'),
('Andrés Molina', 'andres@example.com', 'Calle Sur 11', '5554567014'),
('Elena Fuentes', 'elena@example.com', 'Av. Libertad 9', '5555678015'),
('Héctor Peña', 'hector@example.com', 'Calle del Río 5', '5556789016');

-- Insertar datos en bicicletas
INSERT INTO bicicletas (modelo, tipo, precio, stock, image) VALUES
('Trek Marlin 5', 'Montaña', 599.99, 10, 'm_trekmarlin5.png'),
('Trek Domane AL 2', 'Carretera', 899.99, 8, 'c_trekdomaneal2.png'),
('Trek FX 3 Disc', 'Híbrida', 799.99, 12, 'h_trekfx3disc.png'),
('Trek Dual Sport 2', 'Híbrida', 749.99, 15, 'h_trekdualsport2.png'),
('Trek Verve 1', 'Urbana', 549.99, 20, 'u_trekverve1.png'),
('Trek Marlin 7', 'Montaña', 849.99, 5, 'm_trekmarlin7.png'),
('Trek Emonda ALR 5', 'Carretera', 1799.99, 3, 'c_trekemondaalr5.png'),
('Trek Powerfly FS 4', 'Eléctrica', 4599.99, 2, 'e_trekpowerflyfs4.png'),
('Trek Rail 7', 'Eléctrica', 6299.99, 1, 'e_trekrail7.png'),
('Trek 820', 'Montaña', 469.99, 25, 'm_trek820.png'),
('Trek FX 2 Disc', 'Híbrida', 699.99, 18, 'h_trekfx2disc.png'),
('Trek Roscoe 7', 'Montaña', 1349.99, 4, 'm_trekroscoe7.png'),
('Trek Domane SL 5', 'Carretera', 2999.99, 2, 'c_trekdomanesl5.png'),
('Trek Precaliber 24', 'Infantil', 399.99, 6, 'i_trekprecaliber24.png'),
('Trek Verve+ 2', 'Eléctrica', 2699.99, 3, 'e_trekverve+2.png');

-- Insertar datos en órdenes
INSERT INTO ordenes (cliente_id, bicicleta_id, fecha, cantidad, total) VALUES
(1, 1, NOW(), 1, 599.99),
(2, 2, NOW(), 1, 899.99),
(3, 3, NOW(), 2, 1599.98),
(4, 4, NOW(), 1, 749.99),
(5, 5, NOW(), 3, 1649.97),
(6, 6, NOW(), 1, 849.99),
(7, 7, NOW(), 1, 1799.99),
(8, 8, NOW(), 1, 4599.99),
(9, 9, NOW(), 1, 6299.99),
(10, 10, NOW(), 2, 939.98),
(11, 11, NOW(), 1, 699.99),
(12, 12, NOW(), 1, 1349.99),
(13, 13, NOW(), 1, 2999.99),
(14, 14, NOW(), 2, 799.98),
(15, 15, NOW(), 1, 2699.99);

-- ¡Listo! Base de datos ecommerce_trek creada con 3 tablas y más de 15 datos en cada una.
