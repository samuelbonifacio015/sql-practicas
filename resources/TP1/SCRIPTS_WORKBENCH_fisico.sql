USE RurInnovaDB;

-- Crear catálogos necesarios
CREATE TABLE Tipo_Usuario (
    Id_Tipo_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo VARCHAR(50) UNIQUE
);

INSERT INTO Tipo_Usuario (Nombre_Tipo) VALUES ('Emprendedor'), ('Mentor'), ('Administrador');

CREATE TABLE Estado_Cuenta (
    Id_Estado INT AUTO_INCREMENT PRIMARY KEY,
    Estado VARCHAR(50) UNIQUE
);

INSERT INTO Estado_Cuenta (Estado) VALUES ('Activo'), ('Inactivo'), ('Suspendido'), ('Pendiente_Verificacion');

CREATE TABLE Distrito (
    Id_Distrito INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Distrito VARCHAR(100) UNIQUE
);

-- Agregar campos y claves a Usuario
ALTER TABLE Usuario
    ADD COLUMN Id_Tipo_Usuario INT,
    ADD COLUMN Id_Estado INT DEFAULT 1,
    ADD CONSTRAINT fk_tipo_usuario FOREIGN KEY (Id_Tipo_Usuario) REFERENCES Tipo_Usuario(Id_Tipo_Usuario),
    ADD CONSTRAINT fk_estado_cuenta FOREIGN KEY (Id_Estado) REFERENCES Estado_Cuenta(Id_Estado),
    ADD CONSTRAINT fk_app FOREIGN KEY (Id_App) REFERENCES App(Id_App);

-- Crear tabla Usuario_Telefono
CREATE TABLE Usuario_Telefono (
    Id_Telefono INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT,
    Telefono VARCHAR(50),
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

-- Crear tabla Registro_Acceso
CREATE TABLE Registro_Acceso (
    Id_Acceso INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT,
    Fecha_Hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    IP_Acceso VARCHAR(50),
    Dispositivo VARCHAR(100),
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

-- Eliminar columnas redundantes de Emprendedor
ALTER TABLE Emprendedor
    DROP COLUMN Correo_Electronico;

-- Agregar clave foránea a Emprendedor por distrito
ALTER TABLE Emprendedor
    ADD COLUMN Id_Distrito_Residencia INT,
    ADD CONSTRAINT fk_distrito_emprendedor FOREIGN KEY (Id_Distrito_Residencia) REFERENCES Distrito(Id_Distrito);

-- Crear tabla Emprendedor_Correo
CREATE TABLE Emprendedor_Correo (
    Id_Correo INT AUTO_INCREMENT PRIMARY KEY,
    Id_Emprendedor INT,
    Correo_Electronico VARCHAR(255),
    FOREIGN KEY (Id_Emprendedor) REFERENCES Emprendedor(Id_Emprendedor)
);

-- Crear tabla Direccion
CREATE TABLE Direccion (
    Id_Direccion INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT NOT NULL,
    Id_Distrito INT NOT NULL,
    Calle VARCHAR(100),
    Numero VARCHAR(20),
    Zona VARCHAR(100),
    Referencia VARCHAR(255),
    Latitud DECIMAL(10, 8),
    Longitud DECIMAL(11, 8),
    Tipo_Direccion VARCHAR(50),
    Fecha_Registro DATE,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario),
    FOREIGN KEY (Id_Distrito) REFERENCES Distrito(Id_Distrito)
);

-- Relacionar Distrito con Direccion
ALTER TABLE Direccion 
    ADD COLUMN Id_Distrito INT,
    ADD CONSTRAINT fk_distrito FOREIGN KEY (Id_Distrito) REFERENCES Distrito(Id_Distrito);

-- Relacionar Distrito con Emprendedor
ALTER TABLE Emprendedor 
    ADD COLUMN Id_Distrito INT,
    ADD CONSTRAINT fk_distrito_emprendedor FOREIGN KEY (Id_Distrito) REFERENCES Distrito(Id_Distrito);
    
CREATE TABLE Premios_Concurso (
    Id_Premio INT AUTO_INCREMENT PRIMARY KEY,
    Id_Concurso INT NOT NULL,
    Premio VARCHAR(255),
    Descripcion TEXT,
    FOREIGN KEY (Id_Concurso) REFERENCES Concurso(Id_Concurso)
);

CREATE TABLE Premios_Concurso (
    Id_Premio INT AUTO_INCREMENT PRIMARY KEY,
    Id_Concurso INT NOT NULL,
    Premio VARCHAR(255),
    Descripcion TEXT,
    FOREIGN KEY (Id_Concurso) REFERENCES Concurso(Id_Concurso)
);

CREATE TABLE Categoria_Negocio (
    Id_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Categoria VARCHAR(100) NOT NULL
);

-- En la tabla Negocio se asigna el Id_Categoria
ALTER TABLE Negocio
    ADD COLUMN Id_Categoria INT,
    ADD CONSTRAINT fk_categoria_negocio FOREIGN KEY (Id_Categoria) REFERENCES Categoria_Negocio(Id_Categoria);

CREATE TABLE Eventos (
    Id_Evento INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Evento VARCHAR(255),
    Fecha_Evento DATE,
    Descripcion TEXT,
    Lugar VARCHAR(255)
);

-- Relacionar con la tabla Usuario si es necesario (por ejemplo, un evento con un mentor o emprendedor)
ALTER TABLE Usuario
    ADD COLUMN Id_Evento INT,
    ADD CONSTRAINT fk_evento_usuario FOREIGN KEY (Id_Evento) REFERENCES Eventos(Id_Evento);


CREATE TABLE Tipo_Concurso (
    Id_Tipo_Concurso INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo_Concurso VARCHAR(100)
);

-- Relacionar la tabla Concurso con Tipo_Concurso
ALTER TABLE Concurso
    ADD COLUMN Id_Tipo_Concurso INT,
    ADD CONSTRAINT fk_tipo_concurso FOREIGN KEY (Id_Tipo_Concurso) REFERENCES Tipo_Concurso(Id_Tipo_Concurso);

CREATE TABLE Feedback (
    Id_Feedback INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT,
    Id_Emprendedor INT,
    Comentario TEXT,
    Valoracion INT,  -- Puntuación de 1 a 5, por ejemplo
    Fecha_Feedback DATE,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario),
    FOREIGN KEY (Id_Emprendedor) REFERENCES Emprendedor(Id_Emprendedor)
);

CREATE TABLE Historico_Emprendimiento (
    Id_Historico INT AUTO_INCREMENT PRIMARY KEY,
    Id_Emprendedor INT,
    Nombre_Negocio VARCHAR(255),
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Estado VARCHAR(100),
    Descripcion TEXT,
    FOREIGN KEY (Id_Emprendedor) REFERENCES Emprendedor(Id_Emprendedor)
);

CREATE TABLE Redes_Sociales (
    Id_Redes INT AUTO_INCREMENT PRIMARY KEY,
    Id_Usuario INT,
    Red_Social VARCHAR(100),
    Link_Red_Social VARCHAR(255),
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

CREATE TABLE Facturacion (
    Id_Factura INT AUTO_INCREMENT PRIMARY KEY,
    Id_Emprendedor INT,
    Monto DECIMAL(10, 2),
    Fecha_Factura DATE,
    Metodo_Pago VARCHAR(100),
    Estado_Pago VARCHAR(50),
    FOREIGN KEY (Id_Emprendedor) REFERENCES Emprendedor(Id_Emprendedor)
);

