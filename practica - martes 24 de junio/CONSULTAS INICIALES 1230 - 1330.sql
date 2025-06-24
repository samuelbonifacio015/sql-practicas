-- 12:50PM - 13:30PM Practica --

/* Primeros Pasos */
CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY IDENTITY,
    Documento VARCHAR(20) NOT NULL,
    Nombre VARCHAR(100),
    Direccion VARCHAR(150),
    Telefono VARCHAR(15)
);

CREATE TABLE Vehiculo (
    Id_Vehiculo INT PRIMARY KEY IDENTITY,
    Placa VARCHAR(10) NOT NULL,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Color VARCHAR(30),
    Id_Cliente INT FOREIGN KEY REFERENCES Cliente(Id_Cliente)
);

INSERT INTO Cliente (Documento, Nombre, Direccion, Telefono)
VALUES ('DNI', 'Samuel', 'AVPERU', '913558362');

INSERT INTO Vehiculo (Placa, Marca, Modelo, Color, Id_Cliente)
VALUES ('ABCD123', 'Toyota', 'Corolla', 'Rojo', '1');

/* Por mi cuenta */

-- 1 --

CREATE TABLE Servicio (
    Id_Servicio INT PRIMARY KEY IDENTITY,
    Nombre_Servicio VARCHAR(100),
    Categoria_Servicio VARCHAR(50),
    Precio_Lista DECIMAL(10, 2)
);

INSERT INTO Servicio (Nombre_Servicio, Categoria_Servicio, Precio_Lista)
VALUES ('Servicio', 'Programacion', '25')

SELECT * FROM Servicio

-- 2 --

CREATE TABLE Repuesto (
    Id_Repuesto INT PRIMARY KEY IDENTITY,
    Nombre_Repuesto VARCHAR(100),
    Categoria_Repuesto VARCHAR(50),
    Costo DECIMAL(10, 2)
);

INSERT INTO Repuesto (Nombre_Repuesto, Categoria_Repuesto, Costo)
VALUES ('Repuesto', 'Llantas', '50');

SELECT * FROM Repuesto

-- UPDATES --

/* Primeros Pasos */

UPDATE Repuesto
SET Nombre_Repuesto = 'Llanta 15',
    Categoria_Repuesto = 'Sistema de Llantas',
    Costo = '60'
WHERE Id_Repuesto = 1;

SELECT * FROM Repuesto

/* Por mi cuenta */

CREATE TABLE Tecnico (
    Id_Tecnico INT PRIMARY KEY IDENTITY,
    Documento VARCHAR(20),
    Nombre VARCHAR(100),
    Direccion VARCHAR(150),
    Telefono VARCHAR(15),
    Especialidad VARCHAR(50),
    Costo_Hora DECIMAL(10, 2)
);


INSERT INTO Tecnico (Documento, Nombre, Direccion, Telefono, Especialidad, Costo_Hora)
VALUES ('DNI', 'Samuel', 'AVPERU', '913558362', 'Programador', '20');

SELECT * FROM Tecnico

UPDATE Tecnico
SET Documento = 'Pasaporte',
    Nombre = 'Isabeth',
    Direccion = 'AVBRASIL',
    Telefono = '956362789',
    Especialidad = 'Psicologa',
    Costo_Hora = '30'
WHERE Id_Tecnico = 1;

-- DELETES --

DELETE FROM Tecnico;


-- Consultas muy básicas --

-- 1.Mostrar todos los datos de la tabla Cliente

SELECT * FROM CLIENTE

-- 2.Mostrar solo los nombres y edades de los Clientes

CREATE TABLE CLIENTESPRUEBA (
EDAD INT PRIMARY KEY,
PEDIDOS VARCHAR(150),
NOMBRE VARCHAR(100),
);

INSERT INTO CLIENTESPRUEBA (EDAD, PEDIDOS, NOMBRE)
VALUES 
       ('80', '7', 'MATIAS'),
       ('30', '7', 'ALESSANDRO'),
       ('60', '7', 'JOSE'),
       ('90', '7', 'JULIO')

SELECT EDAD, NOMBRE
FROM CLIENTESPRUEBA

-- 3. ¿Que Clientes tienen más de 30 años?

SELECT * FROM CLIENTESPRUEBA
WHERE EDAD > 30

-- 4. ¿Cuáles son los pedidos mayores a 200?

SELECT * FROM CLIENTESPRUEBA
WHERE PEDIDOS > 200
