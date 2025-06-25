/* PC2 MODELO */
-- .Pregunta 1.
-- Diseñar la función o procedimiento almacenado que 
-- permita determinar la cantidad órdenes de trabajo
-- por mes en un determinado año.

CREATE PROCEDURE SP_OrdenesPorMes
    @anio INT
AS
BEGIN
    SELECT 
        MONTH(Fecha_Inicio) AS Mes,
        COUNT(*) AS Total_Ordenes
    FROM Orden_Servicio
    WHERE YEAR(Fecha_Inicio) = @anio
    GROUP BY MONTH(Fecha_Inicio)
    ORDER BY Mes;
END;


