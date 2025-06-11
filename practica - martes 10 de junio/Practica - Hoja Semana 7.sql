use NORTHWND1
GO

/* Hoja de Ejercicios - Practica de Semana 7 */

/* Ejercicio 1
Listar los nombres de los productos cuyo precio unitario sea mayor a 18 pero menor a 100,
mostrando primero los productos de mayor precio. */

SELECT * FROM Products

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 18 AND UnitPrice < 100
ORDER BY UnitPrice DESC  --> DESC: descendente (de mayor a menor)

/* Ejercicio 2
Indicar los países de procedencia de los clientes.*/

SELECT * FROM Customers

SELECT DISTINCT Country --> DISTINCT: Para eliminar items duplicados 
FROM Customers

/* Ejercicio 3
Indicar los nombres de los clientes que no sean de 
los siguientes países de Francia, Brasil y México */

SELECT * FROM Customers

SELECT Country
FROM Customers
WHERE Country NOT IN ('FRANCE', 'BRAZIL', 'MEXICO') --> NOT IN: Donde no está (<'item'>)

------- Fin Hoja -----------