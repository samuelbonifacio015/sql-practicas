use NORTHWND1
GO

/* Hoja de Ejercicios - Practica de Semana 8 */

/* Ejercicio 1
Muestre el nombre del producto y el nombre su categoría para cada producto. */

SELECT * FROM Products

SELECT * FROM Categories

SELECT Products.ProductName, Categories.CategoryName
FROM PRODUCTS
JOIN CATEGORIES ON Products.CategoryID = Categories.CategoryID 

-- Une las tablas Products y Categories usando CategoryID, y muestra el nombre del producto junto a su categoría.

