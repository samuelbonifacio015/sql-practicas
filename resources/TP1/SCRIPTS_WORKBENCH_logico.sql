-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS RurInnovaDB;
USE RurInnovaDB;

-- Tabla: App
CREATE TABLE App (
    Id_App INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_App VARCHAR(100) NOT NULL,
    Version VARCHAR(20)
);

-- Tabla: Usuario
CREATE TABLE Usuario (
    Id_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Correo_Electronico VARCHAR(255) NOT NULL UNIQUE,
    Password_Hash VARCHAR(255) NOT NULL,
    Nombre_Completo_Usuario VARCHAR(255),
    Tipo_Usuario ENUM('Emprendedor', 'Mentor', 'Administrador') NOT NULL,
    Fecha_Creacion_Cuenta DATE DEFAULT (CURRENT_DATE),
    Estado_Cuenta ENUM('Activo', 'Inactivo', 'Suspendido', 'Pendiente_Verificacion') DEFAULT 'Activo',
    Telefono_Usuario VARCHAR(50),
    Ultimo_Acceso DATE,
    Id_App INT,
    FOREIGN KEY (Id_App) REFERENCES App(Id_App)
);

-- Tabla: Direccion
CREATE TABLE Direccion (
    Id_Direccion INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT NOT NULL,
    Distrito VARCHAR(100) NOT NULL,
    Direccion_Completa VARCHAR(255),
    Referencia VARCHAR(255),
    Latitud DECIMAL(10, 8),
    Longitud DECIMAL(11, 8),
    Tipo_Direccion VARCHAR(50),
    Fecha_Registro DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

-- Tabla: Emprendedor
CREATE TABLE Emprendedor (
    Id_Emprendedor INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT NOT NULL,
    Nombre_Completo VARCHAR(255),
    Fecha_Nacimiento DATE,
    DNI VARCHAR(20),
    Telefono VARCHAR(50),
    Correo_Electronico VARCHAR(255),
    Tipo_Emprendimiento VARCHAR(100),
    Estado_Emprendimiento VARCHAR(100),
    Fecha_Registro DATE DEFAULT (CURRENT_DATE),
    Distrito_Residencia VARCHAR(100),
    Descripcion_Negocio TEXT,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

-- Tabla: Mentor
CREATE TABLE Mentor (
    Id_Mentor INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT NOT NULL,
    Nombre_Completo VARCHAR(255),
    Correo_Electronico VARCHAR(255),
    Telefono VARCHAR(50),
    Area_Especializacion VARCHAR(100),
    Años_Experiencia INT,
    Tipo_Mentoria VARCHAR(100),
    Fecha_Registro DATE DEFAULT (CURRENT_DATE),
    Numero_Sesiones_Mentoria INT DEFAULT 0,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

-- Tabla: Negocio
CREATE TABLE Negocio (
    Id_Negocio INT AUTO_INCREMENT PRIMARY KEY,
    Id_Emprendedor INT NOT NULL,
    Nombre_Negocio VARCHAR(255),
    Descripcion_Negocio TEXT,
    Tipo_Negocio VARCHAR(100),
    Estado_Negocio VARCHAR(100),
    Capital_Recibido DECIMAL(10, 2),
    Fecha_Registro DATE DEFAULT (CURRENT_DATE),
    Monto_Objetivo DECIMAL(10, 2),
    Fecha_Ultima_Actualizacion DATE,
    FOREIGN KEY (Id_Emprendedor) REFERENCES Emprendedor(Id_Emprendedor)
);

-- Tabla: Organizacion Patrocinadora
CREATE TABLE Organizacion_Patrocinadora (
    Id_Organizacion INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Organizacion VARCHAR(255),
    Tipo_Organizacion VARCHAR(100),
    Responsable VARCHAR(255),
    Correo_Electronico VARCHAR(255),
    Telefono VARCHAR(50),
    Direccion VARCHAR(255),
    Fecha_Ingreso DATE,
    Descripcion TEXT
);

-- Tabla: Concurso
CREATE TABLE Concurso (
    Id_Concurso INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Concurso VARCHAR(255),
    Descripcion_Concurso TEXT,
    Fecha_Lanzamiento DATE,
    Fecha_Cierre DATE,
    Premios_Ofrecidos TEXT,
    Tema_Concurso VARCHAR(100),
    Numero_Participantes INT,
    Evaluador_Responsable INT,
    Id_Organizacion INT,
    Estado_Concurso VARCHAR(50),
    FOREIGN KEY (Evaluador_Responsable) REFERENCES Usuario(Id_Usuario),
    FOREIGN KEY (Id_Organizacion) REFERENCES Organizacion_Patrocinadora(Id_Organizacion)
);

-- Tabla: Recursos
CREATE TABLE Recursos (
    Id_Recurso INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Recurso VARCHAR(50),
    Titulo VARCHAR(255),
    Descripcion TEXT,
    Formato VARCHAR(50),
    Tamaño VARCHAR(50),
    Fecha_Publicacion DATE,
    Tamaño_Descarga VARCHAR(50),
    Id_Usuario INT,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

-- Tabla: Capacitacion
CREATE TABLE Capacitacion (
    Id_Capacitacion INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Programa VARCHAR(255),
    Descripcion_Programa TEXT,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Institucion VARCHAR(255),
    Duracion VARCHAR(50),
    Modalidad VARCHAR(50),
    Costo DECIMAL(10,2),
    Id_Usuario INT,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

-- Tabla: Curso
CREATE TABLE Curso (
    Id_Curso INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Curso VARCHAR(255),
    Descripcion_Curso TEXT,
    Area_Especializacion VARCHAR(100),
    Duracion VARCHAR(50),
    Nivel VARCHAR(50),
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Instructor INT,
    Id_Capacitacion INT,
    FOREIGN KEY (Instructor) REFERENCES Mentor(Id_Mentor),
    FOREIGN KEY (Id_Capacitacion) REFERENCES Capacitacion(Id_Capacitacion)
);

-- Tabla: Sesion de Mentoria
CREATE TABLE Sesion_Mentoria (
    Id_Sesion INT AUTO_INCREMENT PRIMARY KEY,
    Id_Mentor INT NOT NULL,
    Id_Emprendedor INT NOT NULL,
    Fecha_Sesion DATE,
    Duracion VARCHAR(50),
    Tipo_Sesion VARCHAR(50),
    Objetivo TEXT,
    Tema_Trata VARCHAR(255),
    Comentarios_FinSesion TEXT,
    FOREIGN KEY (Id_Mentor) REFERENCES Mentor(Id_Mentor),
    FOREIGN KEY (Id_Emprendedor) REFERENCES Emprendedor(Id_Emprendedor)
);
