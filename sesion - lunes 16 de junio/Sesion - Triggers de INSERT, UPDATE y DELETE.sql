/* Sesión Lunes - Semana 12 */
/* 16/06 */

USE NORTHWND1
GO

-- Ejercicio 1:
-- Validar unidades en stock con 
-- las cantidades ingresadas en los pedidos

SELECT * FROM Products
SELECT * FROM [Order Details]

INSERT INTO [Order Details]
VALUES ('10248', '1', '18', '40', '0')

DELETE FROM [Order Details]

CREATE TRIGGER TR_VAL_STOCK ON [Order Details]
FOR INSERT
AS
BEGIN
     IF EXISTS (
         SELECT I.ProductID 
         FROM INSERTED I
         INNER JOIN PRODUCTS P ON I.ProductID = P.ProductID
         WHERE I.Quantity > P.UnitsInStock
     )
     BEGIN
         ROLLBACK 
         PRINT 'LA CANTIDAD QUE DESEA INGRESAR ES MAYOR AL STOCK'
     END
END


-- Del caso anterior descontar el stock de las
-- cantidades ingresadas, cree un nuevo trigger

CREATE TRIGGER TR_DESC_STOCK ON [Order Details]
AFTER INSERT
AS
BEGIN
    UPDATE P
    SET P.UnitsInStock = P.UnitsInStock - I.Quantity         -- Formula para el descuento de unidades, en base a la cantidad ingresada
    FROM PRODUCTS P                    
    INNER JOIN INSERTED I ON I.ProductID = P.ProductID       -- Unimos lo ya insertado en product y ahora lo actualizamos
     BEGIN
          ROLLBACK
          PRINT 'SE HA DESCONTADO LA CANTIDAD INGRESADA AL STOCK'
     END
END

------
CREATE TRIGGER TR_VAL_STOCK_UPDATE ON [Order Details]
FOR INSERT
AS
    BEGIN                                                     -- Se declaran variables con su tipo de entrada (INT)
         DECLARE @PROD_ID INT
         DECLARE @CANT_ING INT
         DECLARE @STOCK INT

         SET @PROD_ID = (SELECT PRODUCTID FROM INSERTED)      -- SET y SELECT para ubicar donde se encuentran
         SET @CANT_ING = (SELECT QUANTITY FROM INSERTED)
         SET @STOCK = (SELECT UNITSINSTOCK FROM PRODUCTS WHERE PRODUCTID = @PROD_ID)

    IF (@STOCK > @CANT_ING)                                   -- Si la cantidad ingresada es mayor al stock
    BEGIN                                                     -- Se muestra un mensaje indicando que no se puede ingresar
         UPDATE Products
         SET UnitsInStock = @STOCK - @CANT_ING
         WHERE ProductID = @PROD_ID
    END
END

-- Crear una tabla auditoria de productos, que almacene
-- el codigo de producto, su nombre, el precio, el usuario
-- y la fecha que lo realizó
-- cuando alguien quiera actualizar (cambiar) el precio de un producto

CREATE TABLE AuditoriaProductos (
    IdAuditoria INT IDENTITY PRIMARY KEY,
    ProductID INT,
    NombreProducto NVARCHAR(100),
    PrecioA FLOAT,
    PrecioN FLOAT,
    Usuario NVARCHAR(100),
    FechaCambio DATE
);

CREATE TRIGGER TR_AUDIT_PRECIO 
ON Products
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaProductos (
        ProductID, NombreProducto, PrecioA, PrecioN, Usuario, FechaCambio
    )
    SELECT
        I.ProductID,
        I.ProductName,
        D.UnitPrice AS PrecioA,
        I.UnitPrice AS PrecioN,
        'Usuario' AS Usuario, 
        GETDATE() 
    FROM INSERTED I
    INNER JOIN DELETED D ON I.ProductID = D.ProductID
    WHERE I.UnitPrice <> D.UnitPrice;
END;


-- Cambiar el precio de un producto
UPDATE Products
SET UnitPrice = UnitPrice + 1
WHERE ProductID = 1;

-- Ver auditoría
SELECT * FROM AuditoriaProductos;
