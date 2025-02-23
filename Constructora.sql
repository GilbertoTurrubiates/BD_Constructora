CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidoP VARCHAR(50) NOT NULL,
    apellidoM VARCHAR(50) NOT NULL,
    correoPersonal VARCHAR(100) NOT NULL,
    correoTrabajo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    telefono VARCHAR(10) NULL,
    rol ENUM('Supervisor', 'Proveedor') NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);
