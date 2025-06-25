USE pc2practica
GO

-- CLIENTE
CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY IDENTITY,
    Documento VARCHAR(20) NOT NULL,
    Nombre VARCHAR(100),
    Direccion VARCHAR(150),
    Telefono VARCHAR(15)
);

-- VEHICULO
CREATE TABLE Vehiculo (
    Id_Vehiculo INT PRIMARY KEY IDENTITY,
    Placa VARCHAR(10) NOT NULL,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Color VARCHAR(30),
    Id_Cliente INT FOREIGN KEY REFERENCES Cliente(Id_Cliente)
);

-- SERVICIO
CREATE TABLE Servicio (
    Id_Servicio INT PRIMARY KEY IDENTITY,
    Nombre_Servicio VARCHAR(100),
    Categoria_Servicio VARCHAR(50),
    Precio_Lista DECIMAL(10, 2)
);

-- REPUESTO
CREATE TABLE Repuesto (
    Id_Repuesto INT PRIMARY KEY IDENTITY,
    Nombre_Repuesto VARCHAR(100),
    Categoria_Repuesto VARCHAR(50),
    Costo DECIMAL(10, 2)
);

-- TECNICO
CREATE TABLE Tecnico (
    Id_Tecnico INT PRIMARY KEY IDENTITY,
    Documento VARCHAR(20),
    Nombre VARCHAR(100),
    Direccion VARCHAR(150),
    Telefono VARCHAR(15),
    Especialidad VARCHAR(50),
    Costo_Hora DECIMAL(10, 2)
);

-- ORDEN DE SERVICIO
CREATE TABLE Orden_Servicio (
    Id_Orden INT PRIMARY KEY IDENTITY,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Estado VARCHAR(20),
    Id_Vehiculo INT FOREIGN KEY REFERENCES Vehiculo(Id_Vehiculo),
    Kilometraje INT
);

-- DETALLE DE SERVICIOS POR ORDEN
CREATE TABLE Orden_Servicio_Servicio (
    Id_Orden INT FOREIGN KEY REFERENCES Orden_Servicio(Id_Orden),
    Id_Servicio INT FOREIGN KEY REFERENCES Servicio(Id_Servicio),
    Cantidad INT,
    Precio DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    PRIMARY KEY (Id_Orden, Id_Servicio)
);

-- DETALLE DE REPUESTOS POR ORDEN
CREATE TABLE Orden_Servicio_Repuesto (
    Id_Orden INT FOREIGN KEY REFERENCES Orden_Servicio(Id_Orden),
    Id_Repuesto INT FOREIGN KEY REFERENCES Repuesto(Id_Repuesto),
    Cantidad INT,
    Costo DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    PRIMARY KEY (Id_Orden, Id_Repuesto)
);

-- DETALLE DE TECNICOS POR ORDEN
CREATE TABLE Orden_Tecnico (
    Id_Orden INT FOREIGN KEY REFERENCES Orden_Servicio(Id_Orden),
    Id_Tecnico INT FOREIGN KEY REFERENCES Tecnico(Id_Tecnico),
    Horas_Trabajadas DECIMAL(5, 2),
    Costo_Hora DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    PRIMARY KEY (Id_Orden, Id_Tecnico)
);

-- CATEGORÍA DE SERVICIO
CREATE TABLE Categoria_Servicio (
    Id_Categoria_Servicio INT PRIMARY KEY IDENTITY,
    Nombre_Categoria VARCHAR(50)
);

-- CATEGORÍA DE REPUESTO
CREATE TABLE Categoria_Repuesto (
    Id_Categoria_Repuesto INT PRIMARY KEY IDENTITY,
    Nombre_Categoria VARCHAR(50)
);

-- ESTADO DE ORDEN
CREATE TABLE Estado_Orden (
    Id_Estado INT PRIMARY KEY IDENTITY,
    Nombre_Estado VARCHAR(20)
);

-- ESPECIALIDAD DE TÉCNICO
CREATE TABLE Especialidad (
    Id_Especialidad INT PRIMARY KEY IDENTITY,
    Nombre_Especialidad VARCHAR(50)
);

-- TIPO DE DOCUMENTO (opcional, útil si validas RUC, DNI, CE, etc.)
CREATE TABLE Tipo_Documento (
    Id_Tipo_Documento INT PRIMARY KEY IDENTITY,
    Nombre_Tipo VARCHAR(30)
);


ALTER TABLE Tecnico
ADD Id_Especialidad INT FOREIGN KEY REFERENCES Especialidad(Id_Especialidad);

ALTER TABLE Servicio
ADD Id_Categoria_Servicio INT FOREIGN KEY REFERENCES Categoria_Servicio(Id_Categoria_Servicio);

ALTER TABLE Repuesto
ADD Id_Categoria_Repuesto INT FOREIGN KEY REFERENCES Categoria_Repuesto(Id_Categoria_Repuesto);

ALTER TABLE Orden_Servicio
ADD Id_Estado INT FOREIGN KEY REFERENCES Estado_Orden(Id_Estado);

ALTER TABLE Cliente
ADD Id_Tipo_Documento INT FOREIGN KEY REFERENCES Tipo_Documento(Id_Tipo_Documento);

ALTER TABLE Tecnico
ADD Id_Tipo_Documento INT FOREIGN KEY REFERENCES Tipo_Documento(Id_Tipo_Documento);
