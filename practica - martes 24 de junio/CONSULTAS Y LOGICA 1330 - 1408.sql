--  Practica 17:00PM - 18:34PM --

/* Primeros Pasos */

-- 1. Mostrar especialidad y costo total generado por técnicos de esa especialidad

SELECT t.Especialidad, SUM(ot.Subtotal) AS Costo_total
FROM Tecnico t
JOIN Orden_Tecnico ot ON T.Id_Tecnico = ot.Id_Tecnico
GROUP BY t.Especialidad

SELECT * FROM Orden_Tecnico
SELECT * FROM Tecnico

-- 2.Mostrar los repuestos más utilizados

SELECT * FROM Repuesto
SELECT * FROM Orden_Servicio_Repuesto

SELECT r.Nombre_Repuesto, SUM(osr.Cantidad) AS Total_Usado
FROM Repuesto r
JOIN Orden_Servicio_Repuesto osr ON r.Id_Repuesto = osr.Id_Repuesto
GROUP BY r.Nombre_Repuesto
ORDER BY Total_Usado DESC;

-- 3.Mostrar el técnico y sus horas totales trabajadas

SELECT * FROM Tecnico
SELECT * FROM Orden_Tecnico

SELECT t.Nombre, SUM(ot.Horas_Trabajadas) AS Total_Horas
FROM Tecnico T
JOIN Orden_Tecnico ot ON t.Id_Tecnico = ot.Id_Tecnico
GROUP BY t.Nombre;

-- 4.¿Qué cliente no ha realizado pedidos?

SELECT * FROM Cliente
SELECT * FROM Vehiculo
SELECT * FROM Orden_Servicio

SELECT c.Nombre
FROM Cliente c
LEFT JOIN Vehiculo v ON C.Id_Cliente = v.Id_Cliente
LEFT JOIN Orden_Servicio os ON v.Id_Vehiculo = os.Id_Vehiculo
WHERE os.Id_Orden IS NULL;

-- 5. Mostrar el modelo de vehículo con más órdenes de servicio

SELECT * FROM Vehiculo
SELECT * FROM Orden_Servicio

SELECT TOP 1 v.Modelo, COUNT(os.Id_Orden) AS Total_Ordenes
FROM Vehiculo v
JOIN Orden_Servicio os ON V.Id_Vehiculo = os.Id_Vehiculo
GROUP BY v.Modelo
ORDER BY Total_Ordenes DESC;