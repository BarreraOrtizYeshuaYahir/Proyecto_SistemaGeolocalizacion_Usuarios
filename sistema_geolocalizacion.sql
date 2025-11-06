-- SISTEMA DE GEOLOCALIZACIÓN --
drop database sistema_geolocalizacion;
CREATE DATABASE sistema_geolocalizacion;
USE sistema_geolocalizacion;

-- Tabla de géneros
CREATE TABLE genero (
    genero_id INT AUTO_INCREMENT PRIMARY KEY,
    genero_descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla de estados civiles
CREATE TABLE estado_civil (
    estado_civil_id INT AUTO_INCREMENT PRIMARY KEY,
    estado_civil_descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- TABLA USUARIOS MODIFICADA

CREATE TABLE usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_nombre VARCHAR(50) UNIQUE NOT NULL,
    usuario_primer_nombre VARCHAR(50) NOT NULL,
    usuario_segundo_nombre VARCHAR(50),
    usuario_apellido_paterno VARCHAR(50) NOT NULL,
    usuario_apellido_materno VARCHAR(50),
    usuario_edad INT,
    usuario_genero_id INT,
    usuario_estado_civil_id INT,
    usuario_email VARCHAR(100) UNIQUE NOT NULL,
    usuario_telefono VARCHAR(15),
    usuario_direccion_completa TEXT, -- Combina nacionalidad hasta manzana
    usuario_contrasena_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (usuario_genero_id) REFERENCES genero(genero_id),
    FOREIGN KEY (usuario_estado_civil_id) REFERENCES estado_civil(estado_civil_id)
);

-- TABLAS DE ROLES Y PERMISOS (MEJORADAS)

CREATE TABLE rol (
    rol_id INT AUTO_INCREMENT PRIMARY KEY,
    rol_nombre VARCHAR(50) NOT NULL UNIQUE,
    rol_descripcion TEXT
);

CREATE TABLE permiso (
    permiso_id INT AUTO_INCREMENT PRIMARY KEY,
    permiso_nombre VARCHAR(50) NOT NULL UNIQUE,
    permiso_descripcion TEXT
);
-- drop table usuarios_rol_permiso;
CREATE TABLE usuarios_rol_permiso (
    usuario_rol_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    rol_permiso_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (rol_permiso_id) REFERENCES rol_permiso(rol_id) ON DELETE CASCADE
);

CREATE TABLE rol_permiso (
    rol_permiso_id INT AUTO_INCREMENT PRIMARY KEY,
    rol_id INT NOT NULL,
    permiso_id INT NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES rol(rol_id) ON DELETE CASCADE,
    FOREIGN KEY (permiso_id) REFERENCES permiso(permiso_id) ON DELETE CASCADE,
    UNIQUE KEY unique_rol_permiso (rol_id, permiso_id)
);

-- TABLA DE MONITOREO 

CREATE TABLE monitoreo (
    monitoreo_id INT AUTO_INCREMENT PRIMARY KEY,
    monitoreo_usuario_id INT NOT NULL, -- Usuario monitoreado
	monitoreo_administrador_id INT NOT NULL, -- Usuario administrador
    FOREIGN KEY (monitoreo_usuario_id) REFERENCES usuarios_rol_permiso(usuario_rol_id) ON DELETE CASCADE,
	FOREIGN KEY (monitoreo_administrador_id) REFERENCES usuarios_rol_permiso(usuario_rol_id) ON DELETE CASCADE
);
show tables
