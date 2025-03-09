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
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidoP VARCHAR(50) NOT NULL,
    apellidoM VARCHAR(50) NOT NULL,
    rfcCliente VARCHAR(13) NOT NULL UNIQUE,
    telefonoCliente VARCHAR(10) NOT NULL,
    clientePotencial BOOLEAN DEFAULT TRUE,
    clienteContratado BOOLEAN DEFAULT TRUE
);

DELIMITER $$

-- Procedimiento para agregar un cliente
CREATE PROCEDURE AgregarCliente(
    IN p_nombre VARCHAR(50),
    IN p_apellidoP VARCHAR(50),
    IN p_apellidoM VARCHAR(50),
    IN p_rfcCliente VARCHAR(13),
    IN p_telefonoCliente VARCHAR(10),
    IN p_clientePotencial BOOLEAN,
    IN p_clienteContratado BOOLEAN
)
BEGIN
    INSERT INTO clientes (nombre, apellidoP, apellidoM, rfcCliente, telefonoCliente, clientePotencial, clienteContratado)
    VALUES (p_nombre, p_apellidoP, p_apellidoM, p_rfcCliente, p_telefonoCliente, p_clientePotencial, p_clienteContratado);
END$$

-- Procedimiento para modificar un cliente
CREATE PROCEDURE ModificarCliente(
    IN p_id_cliente INT,
    IN p_nombre VARCHAR(50),
    IN p_apellidoP VARCHAR(50),
    IN p_apellidoM VARCHAR(50),
    IN p_rfcCliente VARCHAR(13),
    IN p_telefonoCliente VARCHAR(10),
    IN p_clientePotencial BOOLEAN,
    IN p_clienteContratado BOOLEAN
)
BEGIN
    UPDATE clientes 
    SET nombre = p_nombre,
        apellidoP = p_apellidoP,
        apellidoM = p_apellidoM,
        rfcCliente = p_rfcCliente,
        telefonoCliente = p_telefonoCliente,
        clientePotencial = p_clientePotencial,
        clienteContratado = p_clienteContratado
    WHERE id_cliente = p_id_cliente;
END$$

-- Procedimiento para eliminar un cliente (soft delete)
CREATE PROCEDURE EliminarCliente(IN p_id_cliente INT)
BEGIN
    UPDATE clientes SET clientePotencial = FALSE, clienteContratado = FALSE WHERE id_cliente = p_id_cliente;
END$$

DELIMITER ;


CREATE TABLE proyectos (
nombreProyecto VARCHAR(60) NOT NULL,
ubicacion VARCHAR(100) NOT NULL,
proveedorResponsable VARCHAR (50) NOT NULL
);