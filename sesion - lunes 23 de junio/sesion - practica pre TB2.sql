USE NORTHWND1
GO

SELECT * FROM PRODUCTS

CREATE TRIGGER TR_VAL_PED_ACT_STOCK_ON
ON [Order Details]
FOR DELETE
AS
BEGIN
    IF EXISTS (
        SELECT D.ORDERID
        FROM DELETED D
        INNER JOIN ORDERS O ON O.ORDERID = D.ORDERID
        WHERE O.ShippedDate IS NULL
    )
    BEGIN
        UPDATE P
        SET P.UNITSINSTOCK = P.UNITSINSTOCK + R1.TOTALSUMA
        FROM PRODUCTS P
        JOIN (
            SELECT PRODUCTID, SUM(QUANTITY) AS TOTALSUMA
            FROM DELETED
            GROUP BY PRODUCTID
        ) R1 ON P.ProductID = R1.PRODUCTID
    END
END

/* Lista de Ejercicios - Semana 7 */

-- 11. Indicar la cantidad de productos de acuerdo a su discontinuidad

SELECT COUNT(PRODUCTID) AS 'CANT', DISCONTINUED FROM PRODUCTS
GROUP BY DISCONTINUED

-- 12. Indicar los paises de prcedencia que superen los cinco clientes

SELECT COUNTRY, COUNT(CUSTOMERID) AS 'CANT' FROM CUSTOMERS
GROUP BY COUNTRY
HAVING COUNT (CUSTOMERID) > 5

-- 13. Indicar el nombre del producto con mayor precio

SELECT ProductName
FROM Products
WHERE UnitPrice = (
    SELECT MAX(UnitPrice)
    FROM Products
);

-- 14. Indicar el nombre del país con la mayor cantidad de clientes

SELECT COUNTRY
FROM CUSTOMERS
WHERE ContactName = (
    SELECT MAX (ContactName)
    FROM Customers
);

SELECT * FROM CUSTOMERS

/* Lista de Ejercicios - Semana 10 */

-- 21. Crear un procedimiento almacenado o función que retorne el cliente con la mayor cantidad de órdenes
-- realizadas de acuerdo a un determiando país de destino, el cual es ingresado como parámetro.

CREATE PROCEDURE dbo.GetTopCustomerByCountry
    @ShipCountry NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        c.CustomerID,
        c.CompanyName,
        COUNT(*) AS OrderCount
    FROM Customers AS c
    JOIN Orders     AS o
      ON c.CustomerID = o.CustomerID
    WHERE o.ShipCountry = @ShipCountry
    GROUP BY
        c.CustomerID,
        c.CompanyName
    ORDER BY
        OrderCount DESC;
END;
GO
