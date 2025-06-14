use NORTHWND1
GO

/* Hoja de Ejercicios - Semana 11 */

-- Ejercicio 1
-- Muestre el nombre del producto y el nombre su categor�a para cada producto

SELECT * FROM Products

SELECT * FROM Categories

SELECT ProductName
From Products

SELECT Products.ProductName, Categories.CategoryName
FROM PRODUCTS
JOIN CATEGORIES ON Products.CategoryID = Categories.CategoryID

-- JOIN: Combina ambas filas siempre va junto a un ON
-- Se realiza una uni�n entre 'Products' y 'Categories' usando el campo 'CategoryID' presente en ambas tablas

-- Ejercicio 2
-- Indicar el nombre del producto con la mayor cantidad de �rdenes

SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT TOP 1                                     -- SELECT TOP 1: Devuelve el producto con mayor cantidad de ordenes
    P.ProductName, 
    COUNT(DISTINCT OD.OrderID) AS OrderCount     -- Cuenta cu�ntas �rdenes distintas incluyeron ese producto
FROM 
    [Order Details] OD                           -- Usa la tabla 'Order Details'  que contiene el detalle de cada pedido
JOIN 
    Products P ON OD.ProductID = P.ProductID     -- Uni�n con la tabla 'Products' para acceder a ProductID
GROUP BY 
    P.ProductName                                -- Agrupa los resultados por nombre de producto
ORDER BY 
    OrderCount DESC;                             -- Ordena de mayor a menor (Output)

-- Ejercicio 3
-- Indicar la cantidad de �rdenes atendidas por cada empleado
-- (mostrar el nombre y apellido de cada empleado)

SELECT * FROM Employees
SELECT * FROM [Order Details]

SELECT
     E.FirstName + ' ' + E.LastName AS FullName,   -- Nombres completos de empleados
     COUNT (O.OrderID) AS Quantity                 -- Se cuenta por c�antas ordenes atendi� cada empleado
FROM
    Employees E                                    -- Tabla de empleados
JOIN
    Orders O ON E.EmployeeID = O.EmployeeID        -- Relaci�n entre empleados y �rdenes atendidas
GROUP BY
    E.FirstName, E.LastName                        -- Agrupar por nombre y apellido de empleado
ORDER BY
    Quantity DESC;                                 -- Ordenar por cantidad (mayor a menor)

-- Ejercicio 4
-- Indicar la cantidad de �rdenes realizadas por cada cliente
-- (mostrar el nombre de la compa�ia de cada cliente)

SELECT * FROM Customers
SELECT * FROM [Order Details]

SELECT 
      C.CompanyName,
      COUNT(O.OrderID) AS Quantity              -- Cuenta cantidad de ordenes que hizo un cliente
FROM 
    Customers C
JOIN
    Orders O ON C.CustomerID = O.CustomerID     -- Relacion entre clientes y ordenes
GROUP BY
    C.CompanyName                               -- Agrupa toda la info en 'CompanyName'
ORDER BY
    Quantity DESC;

-- Ejercicio 5
-- Identificar la relaci�n de clientes (nombre de compa��a)
-- que no han realizado pedidos.

SELECT * FROM Customers
SELECT * FROM Orders

SELECT
      C.CompanyName                            -- Muestra el nombre de la compa�ia del cliente
FROM Customers C                               -- Tabla de clientes
LEFT JOIN 
    Orders O ON C.CustomerID = O.CustomerID    -- Relacion de Orders con Customers usando LEFT JOIN
WHERE
    O.OrderID IS NULL                          -- Filtra los clientes que no tienen ordenes

-- Ejercicio 6
-- Muestre el c�digo y nombre de todos los clientes (nombre de compa��a)
-- que tienen �rdenes pendientes de despachar.

SELECT * FROM Customers
SELECT * FROM Orders

SELECT
      C.CompanyName, C.CustomerID
FROM Customers C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID    -- Se une con la tabla de orders (relaci�n)
WHERE
    O.ShippedDate IS NULL                      -- La condicion es que las Ordenes Pendientes sean NULL
GROUP BY
    C.CustomerID, C.CompanyName                -- Agrupamos por CustomerID y CompanyName
ORDER BY
    C.CompanyName                              -- Orden Alfabetico por CompanyName
