CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    correo_electronico VARCHAR(100) UNIQUE,
    direccion VARCHAR(255),
    puesto VARCHAR(100),
    tipo_usuario ENUM('Trabajador', 'Promotor') NOT NULL,
    contraseña VARCHAR(255) NOT NULL
);

CREATE TABLE promotores (
    id_promotor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,  -- Relacionamos con la tabla de usuarios
    fecha_inicio DATE,
    fecha_fin DATE,
    estado_promotor ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

