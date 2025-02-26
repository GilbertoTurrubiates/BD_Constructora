SHOW DATABASES;
CREATE DATABASE constructora;
USE constructora;

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

DELIMITER $$

-- Procedimiento para agregar un usuario
CREATE PROCEDURE AgregarUsuario(
    IN p_nombre VARCHAR(50),
    IN p_apellidoP VARCHAR(50),
    IN p_apellidoM VARCHAR(50),
    IN p_correoPersonal VARCHAR(100),
    IN p_correoTrabajo VARCHAR(100),
    IN p_contraseña VARCHAR(255),
    IN p_telefono VARCHAR(10),
    IN p_rol ENUM('Supervisor', 'Proveedor')
)
BEGIN
    INSERT INTO usuarios (nombre, apellidoP, apellidoM, correoPersonal, correoTrabajo, contraseña, telefono, rol)
    VALUES (p_nombre, p_apellidoP, p_apellidoM, p_correoPersonal, p_correoTrabajo, p_contraseña, p_telefono, p_rol);
END$$

-- Procedimiento para modificar un usuario
CREATE PROCEDURE ModificarUsuario(
    IN p_id_usuario INT,
    IN p_nombre VARCHAR(50),
    IN p_apellidoP VARCHAR(50),
    IN p_apellidoM VARCHAR(50),
    IN p_correoPersonal VARCHAR(100),
    IN p_correoTrabajo VARCHAR(100),
    IN p_contraseña VARCHAR(255),
    IN p_telefono VARCHAR(10),
    IN p_rol ENUM('Supervisor', 'Proveedor')
)
BEGIN
    UPDATE usuarios 
    SET nombre = p_nombre,
        apellidoP = p_apellidoP,
        apellidoM = p_apellidoM,
        correoPersonal = p_correoPersonal,
        correoTrabajo = p_correoTrabajo,
        contraseña = p_contraseña,
        telefono = p_telefono,
        rol = p_rol
    WHERE id_usuario = p_id_usuario;
END$$

-- Procedimiento para eliminar un usuario (soft delete)
CREATE PROCEDURE EliminarUsuario(IN p_id_usuario INT)
BEGIN
    UPDATE usuarios SET activo = FALSE WHERE id_usuario = p_id_usuario;
END$$

DELIMITER ;


CREATE TABLE clientes (
	nombre VARCHAR(50) NOT NULL,
	apellidoP VARCHAR(50) NOT NULL,
	apellidoM VARCHAR(50) NOT NULL,
	rfcCliente VARCHAR(13) NOT NULL,
	telefonoCliente VARCHAR(10) NOT NULL,
	clientePotencial BOOLEAN DEFAULT TRUE,
	clienteContratado BOOLEAN DEFAULT TRUE
);

CREATE TABLE proyectos (
nombreProyecto VARCHAR(60) NOT NULL,
ubicacion VARCHAR(100) NOT NULL,
proveedorResponsable VARCHAR (50) NOT NULL
);