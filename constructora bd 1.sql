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

DELIMITER $$

CREATE PROCEDURE BuscarUsuarios(IN filtro VARCHAR(100))
BEGIN
    SELECT id_usuario, nombre, apellidoP, apellidoM, correoPersonal, correoTrabajo, telefono, rol, activo
    FROM usuarios
    WHERE nombre LIKE CONCAT('%', filtro, '%')
       OR apellidoP LIKE CONCAT('%', filtro, '%')
       OR apellidoM LIKE CONCAT('%', filtro, '%')
       OR correoPersonal LIKE CONCAT('%', filtro, '%')
       OR correoTrabajo LIKE CONCAT('%', filtro, '%')
       OR telefono LIKE CONCAT('%', filtro, '%')
       OR rol LIKE CONCAT('%', filtro, '%');
END $$

DELIMITER $$

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
DELIMITER $$

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

DELIMITER $$

-- Tabla actualizada de proyectos
CREATE TABLE proyectos (
    nombreProyecto VARCHAR(60) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    proveedorResponsable VARCHAR(50) NOT NULL,
    dimensiones VARCHAR(50) NOT NULL
);

-- Procedimiento para agregar un proyecto
CREATE PROCEDURE agregar_proyecto(
    IN p_nombreProyecto VARCHAR(60),
    IN p_ubicacion VARCHAR(100),
    IN p_proveedorResponsable VARCHAR(50),
    IN p_dimensiones VARCHAR(50)
)
BEGIN
    INSERT INTO proyectos (nombreProyecto, ubicacion, proveedorResponsable, dimensiones)
    VALUES (p_nombreProyecto, p_ubicacion, p_proveedorResponsable, p_dimensiones);
END$$

-- Procedimiento para modificar un proyecto
CREATE PROCEDURE modificar_proyecto(
    IN p_nombreProyecto VARCHAR(60),
    IN p_nuevaUbicacion VARCHAR(100),
    IN p_nuevoProveedorResponsable VARCHAR(50),
    IN p_nuevasDimensiones VARCHAR(50)
)
BEGIN
    UPDATE proyectos
    SET ubicacion = p_nuevaUbicacion,
        proveedorResponsable = p_nuevoProveedorResponsable,
        dimensiones = p_nuevasDimensiones
    WHERE nombreProyecto = p_nombreProyecto;
END$$

-- Procedimiento para eliminar un proyecto
CREATE PROCEDURE eliminar_proyecto(
    IN p_nombreProyecto VARCHAR(60)
)
BEGIN
    DELETE FROM proyectos WHERE nombreProyecto = p_nombreProyecto;
END$$

DELIMITER ;
