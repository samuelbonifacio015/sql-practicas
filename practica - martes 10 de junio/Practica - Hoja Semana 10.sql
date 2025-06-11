use NORTHWND1
GO

-- Ejercicio 1
-- Retorna el país del cliente con menor cantidad de pedidos en un año
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
-- Retorna el nombre de la categoría con mayor cantidad de ítems vendidos en un año
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
    ORDER BY SUM(OD.Quantity) DESC  --> Mayor cantidad de ítems vendidos

    RETURN @categoria
END
GO

-- Ejercicio 3
-- Retorna la cantidad de órdenes atendidas en un año
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
-- Retorna el nombre del cliente con más órdenes en un año
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
-- Retorna el nombre del shipper con más pedidos en un año
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
-- Retorna el proveedor con más productos pedidos en un año
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
-- Retorna el cliente con más pedidos desde un país específico en un año
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
-- Lista los productos de una categoría determinada
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
-- Retorna el proveedor con más productos vendidos en un país de destino
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
-- Retorna la categoría con más órdenes según el país de destino
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
-- Retorna la categoría con mayor monto de ventas acumulado
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
-- Retorna el país con más órdenes vendidas en un año
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
-- Retorna el proveedor con menos productos vendidos en un año
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
-- Retorna la cantidad de órdenes para un año dado
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
-- Retorna la categoría con menos órdenes realizadas en un año
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
-- Retorna la cantidad de órdenes atendidas por shipper en un año
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
-- Retorna el cliente con más órdenes en un país destino y año
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
-- Retorna la cantidad de empleados según país (parámetro)
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
-- Retorna la cantidad de órdenes realizadas por país de destino en un año
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
-- Retorna el cliente con más órdenes según país de destino
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
-- Retorna el shipper con más pedidos atendidos para un país de destino
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
