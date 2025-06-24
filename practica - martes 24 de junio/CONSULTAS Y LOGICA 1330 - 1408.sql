--  Practica --

/* Primeros Pasos */

-- 1. Mostrar especialidad y costo total generado por técnicos de esa especialidad

SELECT t.Especialidad, SUM(ot.Subtotal) AS Costo_total
FROM Tecnico t
JOIN Orden_Tecnico ot ON T.Id_Tecnico = ot.Id_Tecnico
GROUP BY t.Especialidad

SELECT * FROM Orden_Tecnico