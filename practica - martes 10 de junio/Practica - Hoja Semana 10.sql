use NORTHWND1
GO

-- Ejercicio 1
-- Retorna el pa�s del cliente con menor cantidad de pedidos en un a�o
CREATE FUNCTION dbo.fn_PaisMenorPedidos (@anio INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @pais VARCHAR(50)

    SELECT TOP 1 @pais = C.Country
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY C.CustomerID, C.Country
    ORDER BY COUNT(O.OrderID) ASC  --> ASC: menor a mayor (menos pedidos)

    RETURN @pais
END
GO

-- Ejercicio 2
-- Retorna el nombre de la categor�a con mayor cantidad de �tems vendidos en un a�o
CREATE FUNCTION dbo.fn_CategoriaMasVendida (@anio INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @categoria VARCHAR(50)

    SELECT TOP 1 @categoria = C.CategoryName
    FROM [Order Details] OD
    JOIN Orders O ON OD.OrderID = O.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Categories C ON P.CategoryID = C.CategoryID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY C.CategoryName
    ORDER BY SUM(OD.Quantity) DESC  --> Mayor cantidad de �tems vendidos

    RETURN @categoria
END
GO

-- Ejercicio 3
-- Retorna la cantidad de �rdenes atendidas en un a�o
CREATE FUNCTION dbo.fn_OrdenesPorAnio (@anio INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT

    SELECT @total = COUNT(*)
    FROM Orders
    WHERE YEAR(OrderDate) = @anio

    RETURN @total
END
GO

-- Ejercicio 4
-- Retorna el nombre del cliente con m�s �rdenes en un a�o
CREATE FUNCTION dbo.fn_ClienteMasOrdenes (@anio INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @nombre VARCHAR(100)

    SELECT TOP 1 @nombre = C.CompanyName
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY C.CompanyName
    ORDER BY COUNT(O.OrderID) DESC

    RETURN @nombre
END
GO

-- Ejercicio 5
-- Retorna el nombre del shipper con m�s pedidos en un a�o
CREATE FUNCTION dbo.fn_ShipperMasPedidos (@anio INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @shipper VARCHAR(100)

    SELECT TOP 1 @shipper = S.CompanyName
    FROM Orders O
    JOIN Shippers S ON O.ShipVia = S.ShipperID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY S.CompanyName
    ORDER BY COUNT(O.OrderID) DESC

    RETURN @shipper
END
GO

-- Ejercicio 6
-- Retorna el proveedor con m�s productos pedidos en un a�o
CREATE FUNCTION dbo.fn_ProveedorMasPedidos (@anio INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @proveedor VARCHAR(100)

    SELECT TOP 1 @proveedor = S.CompanyName
    FROM [Order Details] OD
    JOIN Orders O ON OD.OrderID = O.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Suppliers S ON P.SupplierID = S.SupplierID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY S.CompanyName
    ORDER BY SUM(OD.Quantity) DESC

    RETURN @proveedor
END
GO

-- Ejercicio 7
-- Retorna el cliente con m�s pedidos desde un pa�s espec�fico en un a�o
CREATE FUNCTION dbo.fn_ClienteTopPaisAnio (@pais VARCHAR(50), @anio INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @cliente VARCHAR(100)

    SELECT TOP 1 @cliente = C.CompanyName
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE C.Country = @pais AND YEAR(O.OrderDate) = @anio
    GROUP BY C.CompanyName
    ORDER BY COUNT(O.OrderID) DESC

    RETURN @cliente
END
GO

-- Ejercicio 8
-- Lista los productos de una categor�a determinada
CREATE PROCEDURE dbo.sp_ProductosPorCategoria @categoriaID INT
AS
BEGIN
    SELECT P.ProductName
    FROM Products P
    WHERE P.CategoryID = @categoriaID
END
GO

-- Ejercicio 9
-- Lista los productos que comercializa un proveedor determinado
CREATE PROCEDURE dbo.sp_ProductosPorProveedor @proveedorID INT
AS
BEGIN
    SELECT ProductName
    FROM Products
    WHERE SupplierID = @proveedorID
END
GO

-- Ejercicio 10
-- Retorna el proveedor con m�s productos vendidos en un pa�s de destino
CREATE FUNCTION dbo.fn_ProveedorTopPorPais (@paisDestino VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @proveedor VARCHAR(100)

    SELECT TOP 1 @proveedor = S.CompanyName
    FROM Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Suppliers S ON P.SupplierID = S.SupplierID
    WHERE O.ShipCountry = @paisDestino
    GROUP BY S.CompanyName
    ORDER BY SUM(OD.Quantity) DESC

    RETURN @proveedor
END
GO

-- Ejercicio 11
-- Retorna la categor�a con m�s �rdenes seg�n el pa�s de destino
CREATE FUNCTION dbo.fn_CategoriaTopPorPais (@paisDestino VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @categoria VARCHAR(100)

    SELECT TOP 1 @categoria = C.CategoryName
    FROM Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Categories C ON P.CategoryID = C.CategoryID
    WHERE O.ShipCountry = @paisDestino
    GROUP BY C.CategoryName
    ORDER BY COUNT(DISTINCT O.OrderID) DESC

    RETURN @categoria
END
GO

-- Ejercicio 12
-- Retorna la categor�a con mayor monto de ventas acumulado
CREATE PROCEDURE dbo.sp_CategoriaMayorVenta
AS
BEGIN
    SELECT TOP 1 C.CategoryName, SUM(OD.Quantity * OD.UnitPrice) AS TotalVenta
    FROM [Order Details] OD
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Categories C ON P.CategoryID = C.CategoryID
    GROUP BY C.CategoryName
    ORDER BY TotalVenta DESC
END
GO

-- Ejercicio 13
-- Retorna el pa�s con m�s �rdenes vendidas en un a�o
CREATE PROCEDURE dbo.sp_PaisMasVentasPorAnio @anio INT
AS
BEGIN
    SELECT TOP 1 ShipCountry, COUNT(*) AS TotalOrdenes
    FROM Orders
    WHERE YEAR(OrderDate) = @anio
    GROUP BY ShipCountry
    ORDER BY TotalOrdenes DESC
END
GO

-- Ejercicio 14
-- Retorna el proveedor con menos productos vendidos en un a�o
CREATE FUNCTION dbo.fn_ProveedorMenorVentas (@anio INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @proveedor VARCHAR(100)

    SELECT TOP 1 @proveedor = S.CompanyName
    FROM Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Suppliers S ON P.SupplierID = S.SupplierID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY S.CompanyName
    ORDER BY SUM(OD.Quantity) ASC  --> ASC: menor cantidad

    RETURN @proveedor
END
GO

-- Ejercicio 15
-- Retorna la cantidad de �rdenes para un a�o dado
CREATE FUNCTION dbo.fn_TotalOrdenesPorAnio (@anio INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT

    SELECT @total = COUNT(*)
    FROM Orders
    WHERE YEAR(OrderDate) = @anio

    RETURN @total
END
GO

-- Ejercicio 16
-- Retorna la categor�a con menos �rdenes realizadas en un a�o
CREATE FUNCTION dbo.fn_CategoriaMenorOrdenes (@anio INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @categoria VARCHAR(100)

    SELECT TOP 1 @categoria = C.CategoryName
    FROM Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Categories C ON P.CategoryID = C.CategoryID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY C.CategoryName
    ORDER BY COUNT(DISTINCT O.OrderID) ASC

    RETURN @categoria
END
GO

-- Ejercicio 17
-- Retorna la cantidad de �rdenes atendidas por shipper en un a�o
CREATE PROCEDURE dbo.sp_OrdenesPorShipperAnio @anio INT
AS
BEGIN
    SELECT S.CompanyName, COUNT(*) AS TotalOrdenes
    FROM Orders O
    JOIN Shippers S ON O.ShipVia = S.ShipperID
    WHERE YEAR(O.OrderDate) = @anio
    GROUP BY S.CompanyName
    ORDER BY TotalOrdenes DESC
END
GO

-- Ejercicio 18
-- Retorna el cliente con m�s �rdenes en un pa�s destino y a�o
CREATE FUNCTION dbo.fn_ClienteTopPorPaisAnio (@paisDestino VARCHAR(50), @anio INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @cliente VARCHAR(100)

    SELECT TOP 1 @cliente = C.CompanyName
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE O.ShipCountry = @paisDestino AND YEAR(O.OrderDate) = @anio
    GROUP BY C.CompanyName
    ORDER BY COUNT(O.OrderID) DESC

    RETURN @cliente
END
GO

-- Ejercicio 19
-- Retorna la cantidad de empleados seg�n pa�s (par�metro)
CREATE FUNCTION dbo.fn_EmpleadosPorPais (@pais VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @cantidad INT

    SELECT @cantidad = COUNT(*)
    FROM Employees
    WHERE Country = @pais

    RETURN @cantidad
END
GO

-- Ejercicio 20
-- Retorna la cantidad de �rdenes realizadas por pa�s de destino en un a�o
CREATE PROCEDURE dbo.sp_OrdenesPorPaisDestinoAnio @anio INT
AS
BEGIN
    SELECT ShipCountry, COUNT(*) AS TotalOrdenes
    FROM Orders
    WHERE YEAR(OrderDate) = @anio
    GROUP BY ShipCountry
    ORDER BY TotalOrdenes DESC
END
GO

-- Ejercicio 21
-- Retorna el cliente con m�s �rdenes seg�n pa�s de destino
CREATE FUNCTION dbo.fn_ClienteTopPorPaisDestino (@paisDestino VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @cliente VARCHAR(100)

    SELECT TOP 1 @cliente = C.CompanyName
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE O.ShipCountry = @paisDestino
    GROUP BY C.CompanyName
    ORDER BY COUNT(O.OrderID) DESC

    RETURN @cliente
END
GO

-- Ejercicio 22
-- Retorna el shipper con m�s pedidos atendidos para un pa�s de destino
CREATE FUNCTION dbo.fn_ShipperTopPorPaisDestino (@paisDestino VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @shipper VARCHAR(100)

    SELECT TOP 1 @shipper = S.CompanyName
    FROM Orders O
    JOIN Shippers S ON O.ShipVia = S.ShipperID
    WHERE O.ShipCountry = @paisDestino
    GROUP BY S.CompanyName
    ORDER BY COUNT(O.OrderID) DESC

    RETURN @shipper
END
GO
