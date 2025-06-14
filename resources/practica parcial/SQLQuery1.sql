use NORTHWND1

select*from Employees

select*from Products

--Listar los nombres de los productos cuyo precio unitario sea mayor a 18 pero menor a 100, mostrando primero los productos de mayor precio

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 18 AND UnitPrice < 100
ORDER BY UnitPrice DESC;

--Indicar los países de procedencia de los clientes


