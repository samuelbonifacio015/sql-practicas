/* PRACTICA 19:14PM - 21:28PM */
USE pc2practica
GO
-- FUNCIONES

/* Primeros Pasos*/

SELECT * FROM Orden_Servicio


/* 1. Estamos creando una funcion para listar vehiculos sin ordenes en un año*/
/* Esta funcion retorna una tabla */
CREATE FUNCTION FN_VehiculosSinOrden (@ANIO INT)
RETURNS TABLE
AS
RETURN
   SELECT v.* FROM Vehiculo v
   LEFT JOIN Orden_Servicio os ON v.Id_Vehiculo = os.Id_Vehiculo
       AND YEAR(os.Fecha_inicio) = @ANIO
   WHERE os.Id_Orden IS NULL;

/*Seleccionamos toda la columnas de la tabla Vehiculo usando el alias v */
/* Lo unimos usando todos los datos con Orden_Servicio en un nuevo alias os.Id_Vehiculo*/
/* Ya que nos pide listar en un año, utilizamos year y una fecha de inicio para identificar el "Año"*/
/* Por ultimo, nos aseguramos que los vehiculos no tengan ordenes */

-- uso
SELECT * FROM FN_VehiculosSinOrden(2024);

/* 2.Función que calcula total de órdenes de un cliente */

SELECT * FROM Cliente
SELECT * FROM Orden_Servicio
SELECT * FROM Vehiculo

CREATE FUNCTION FN_TotalOrdenesCliente (@IdCliente INT)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;

    SELECT @Total = COUNT(*)
    FROM Cliente c
    JOIN Vehiculo v ON c.Id_Cliente = v.Id_Cliente
    JOIN Orden_Servicio o ON v.Id_Vehiculo = o.Id_Vehiculo
    WHERE c.Id_Cliente = @IdCliente;

    RETURN @Total;
END;


-- uso
SELECT dbo.FN_TotalOrdenesCliente(1) AS TotalOrdenes;

-- PROCEDURES

/* Hoja de Ejercicios - PC2 MODELO */

-- 1. Diseñar la función o procedimiento almacenado que permita determinar 
-- la cantidad órdenes de trabajo por mes en un determinado año.

SELECT * FROM Orden_Servicio

CREATE PROCEDURE SP_ORDEN_MES 
    @Anio INT
AS
BEGIN 
    SELECT
         MONTH(Fecha_Inicio) AS MES,
         COUNT(*) AS Total_Ordenes
    FROM Orden_Servicio
    WHERE YEAR(Fecha_Inicio) = @Anio
    GROUP BY MONTH(Fecha_Inicio)
    ORDER BY MES;
END;

/* Creamos el procedimiento e ingresamos el tipo de dato del output (año) 
Iniciamos con la sintaxis y seleccionamos primero la fecha de inicio como un mes
Contamos el total de ordenes de Orden_Servicio donde la fecha de inicio es un año
Agrupamos esta información por mes, así determina la cantidad de órdenes
de trabajo por mes en un determinado año (ejemplo: 2024) */

-- uso
EXEC SP_ORDEN_MES 2024;

