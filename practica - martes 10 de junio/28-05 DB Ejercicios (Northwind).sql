USE Northwind
GO

SELECT * FROM CUSTOMERS
SELECT DISTINCT CUSTOMERID FROM ORDERS
SELECT * FROM TERRITORIES
SELECT * FROM REGION
SELECT * FROM EmployeeTerritories
SELECT DISTINCT EMPLOYEEID FROM EmployeeTerritories

SELECT * FROM Territories

SELECT DISTINCT TERRITORYID FROM EmployeeTerritories

-- Listar los codigos de territorio (territories)
-- que no hayan sido asignados a ningun empleado
-- (employeeterritories)

SELECT TERRITORYID FROM Territories
WHERE TerritoryID NOT IN (SELECT DISTINCT TerritoryID FROM EmployeeTerritories)

SELECT EMPLOYEEID, TERRITORYID
FROM EMPLOYEES E

SELECT * FROM PRODUCTS

SELECT PRODUCTNAME
FROM PRODUCTS P INNER JOIN CATEGORIES C ON
p.CategoryID =c.CategoryID

SELECT COMPANYNAME
FROM CUSTOMERS C
INNER JOIN ORDERS O ON C.CustomerID = o.CustomerID


-- Encontrar los pedidos que debieron despacharse a una ciudad o 
-- código postal diferente de la ciudad o código postal del cliente que los solicitó. 
-- Para estos pedidos, mostrar el país, ciudad y código postal
-- del destinatario, así como la cantidad total de pedidos por cada destino.
SELECT * FROM Orders

SELECT SHIPCOUNTRY, SHIPCITY, ShipPostalCode, 
'cant_ped' = count (orderid)
FROM ORDERS O
INNER JOIN CUSTOMERS C ON O.CustomerID = C.CustomerID
WHERE ShipPostalCode <> PostalCode
group by ShipCountry, ShipCity, ShipPostalCode

-- Obtener el precio promedio
-- de las tablas products
SELECT 'PRE_PROM' = avg(unitprice) from products

-- Mostrar los nombres y apellidos de los empleados junto con 
-- los nombres y apellidos de sus respectivos jefes 

SELECT * FROM Employees

SELECT e.EmployeeID AS EMPLEADOID, E.LASTNAME AS EMPLEADOLASTNAME, E.FIRSTNAME AS EMPLEADOFIRSTNAME, E.ReportsTo AS REPORTSTO,
       j.LASTNAME AS JEFELASTNAME, j.FIRSTNAME AS JEFELASTNAME
FROM EMPLOYEES E
LEFT JOIN Employees j ON E.ReportsTo = j.EmployeeID
ORDER BY E.EmployeeID;

-- Encontrar la categoría a la que pertenece la mayor cantidad de productos. 
-- Mostrar el nombre de la categoría y la cantidad de productos que comprende.

SELECT * FROM [Order Details]
ORDER BY Quantity DESC

SELECT c.categoryName, 'Cant_Prod' = MAX(QUANTITY) 
FROM [Order Details] D
INNER JOIN PRODUCTS P ON D.PRODUCTID = P.PRODUCTID
INNER JOIN CATEGORIES C ON P.CategoryID = C.CategoryID
GROUP BY CategoryName
------
--CREAR UNA VISTA
CREATE VIEW CAT_PROD_PED
AS
SELECT c.categoryName, 'Cant_Prod' = MAX(QUANTITY) 
FROM [Order Details] D
INNER JOIN PRODUCTS P ON D.PRODUCTID = P.PRODUCTID
INNER JOIN CATEGORIES C ON P.CategoryID = C.CategoryID
GROUP BY CategoryName

--
SELECT * FROM CAT_PROD_PED

--
SELECT * FROM CAT_PROD_PED
WHERE CANT_PROD = (SELECT MAX(CANT_PROD)
FROM CAT_PROD_PED)