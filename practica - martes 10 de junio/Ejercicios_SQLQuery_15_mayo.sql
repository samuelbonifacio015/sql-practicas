
/*Ejercicio 1
Por cada cliente, indicar el nombre del cliente y la cantidad de ítems
que ha adquirido en total. */

Use Northwind
SELECT C.ContactName, sum(od.quantity) as total
FROM Customers  C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY ContactName order by total desc;


/* cantidad de clientes que existen*/
select COUNT(*) from Customers

/*Mostrar el precio mayor de la tabla productos*/
select max(unitprice) from Products


/*Ejercicio 13
Listar los nombres de los productos cuyo precio unitario sea mayor a 18. */
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 18

/*Ejercicio 14
Listar los nombres de los clientes que son del país de ‘Mexico’.*/
SELECT ContactName, Country
 from Customers
 WHERE Country='Mexico'

SELECT ContactName, Country
 from Customers
 WHERE Country  like 'Mexico'

/*Listar los nombres de los clientes que no son del país de ‘Mexico’.*/

SELECT ContactName, Country
 from Customers
 WHERE Country not in ('Mexico')

 SELECT ContactName, Country
 from Customers
 WHERE Country <>'Mexico'
 order by Country asc


/*Ejercicio 15
Listar los nombres de los productos y el nombre de su categoría. */
SELECT ProductName, CategoryName
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID

SELECT ProductName, CategoryName
FROM Products P, categories C
where P.CategoryID = C.CategoryID


/*Ejercicio 18
Indicar la cantidad de clientes que han realizado pedidos.*/

select count(DISTINCT  CustomerID) from orders



/* Mostrar por cliente la cantidad de pedidos */
select c.CustomerID, count(o.orderid)
from customers C
join Orders o on o.CustomerID = c.CustomerID
group by c.CustomerID

/*Indicar el nombre del producto con mayor precio*/

select ProductName
from Products
where UnitPrice = (select max(unitprice) from Products)

/*Indicar el nombre del país con la mayor cantidad de clientes*/

select country
from (select country, count(CustomerID) as Cantidad
		from customers
		group by country) QP
where Cantidad = (select max(cantidad) 
                from (select country, count(CustomerID) as Cantidad
		              from customers
		              group by country) QP)

/* primero desarollar una tabla que muestre 
la cantidad de clientes por país */

select country, count (CustomerID) as Cantidad
from customers
group by country

select country, CustomerID from customers

SELECT ContactName, Total
from (SELECT C.ContactName, SUM(Quantity) Total
				FROM Customers C
				JOIN Orders O ON C.CustomerID = O.CustomerID
				JOIN "Order Details" OD ON O.OrderID = OD.OrderID
				GROUP BY C.ContactName) R
where Total = (select Max(Total) from (SELECT C.ContactName,
			SUM(Quantity) Total
				FROM Customers C
				JOIN Orders O ON C.CustomerID = O.CustomerID
				JOIN "Order Details" OD ON O.OrderID = OD.OrderID
				GROUP BY C.ContactName) R )
--Segunda opción - creando una vista virtual
Create view Customer_Total as
SELECT C.ContactName, SUM(Quantity) Total
				FROM Customers C
				JOIN Orders O ON C.CustomerID = O.CustomerID
				JOIN "Order Details" OD ON O.OrderID = OD.OrderID
				GROUP BY C.ContactName
SELECT ContactName, Total
from Customer_Total
where Total = (select Max(Total) FROM Customer_total)

/*Por cada cliente, indicar el nombre del cliente, los nombres de los
productos adquiridos
y la cantidad de ítems por producto adquirido en total.*/

SELECT ContactName, ProductName, SUM(Quantity) as ItemsTotal
FROM Customers C
				JOIN Orders O ON C.CustomerId = O.CustomerID
				JOIN OrderDetails OD ON O.OrderID = OD.OrderID
				JOIN Products P ON OD.ProductID = P.ProductID
				GROUP BY ContactName, ProductName

/* Lista el nombre del cliente Pavarotti, Número de orden de pedido y
fechas de transporte en la cual la fechas de transporte está entre los
meses octubre y noviembre del año 1997 */

select C.ContactName, OD.OrderID, OD.ShippedDate
from Orders OD join Customers C
on OD.CustomerID = C.CustomerID
where ShippedDate between '1997-10-1' and '1997-11-1'
and C.ContactName like '%Pavarotti%'

select * from Orders

/* Mostrar los mismos datos pero del año 1996 */

select * from orders
select C.ContactName, OD.OrderID, OD.ShippedDate
from Orders OD join Customers C
on OD.CustomerID = C.CustomerID
where year (ShippedDate) = 1996

--2da forma
select C.ContactName, OD.OrderID, OD.ShippedDate
from Orders OD join Customers C
on OD.CustomerID = C.CustomerID
where year (ShippedDate) = 1996 and (MONTH(shippedDate) in (10,11))
and C.ContactName like '%Pavarotti%'

/* Indicar la cantidad de ordenes atendidas por cada empleado */
SELECT  concat (FirstName,',', LastName) fullname, Count(OrderID) as Quantity
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY FirstName,LastName HAVING count(OrderID) > 100
order by LastName, FirstName

/* Por cada cliente indicar el nombre del cliente y la relación de
los nombres
de las categorías de los productos que ha adquirido.*/

SELECT DISTINCT ContactName, CategoryName
		FROM Customers C
		JOIN Orders O ON C.CustomerID = O.CustomerID
		JOIN "Order Details" OD ON O.OrderID = OD.OrderID
		JOIN Products P ON P.ProductID = OD.ProductID
		JOIN Categories CA ON CA.CategoryID = P.CategoryID
		ORDER BY 1asc, 2 asc

/*Indicar la categoría con mayor cantidad de productos vendidos.*/

SELECT c.CategoryName, od.Quantity
FROM Products P
JOIN "Order Details" OD
	ON P.ProductID = OD.ProductID
JOIN Categories C
	ON C.CategoryID = P.CategoryID
where Quantity = (select max(Quantity) from Products P
	JOIN "Order Details" OD
		ON P.ProductID = OD.ProductID
	JOIN Categories C
		ON C.CategoryID = P.CategoryID)
SELECT MAX(od.Quantity)
FROM Products P
JOIN "Order Details" OD
	ON P.ProductID = OD.ProductID
JOIN Categories C
	ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID

create view cantidad_productosXcategory as
SELECT c.CategoryName, sum(od.Quantity) as cantidad
FROM Products P
JOIN "Order Details" OD
	ON P.ProductID = OD.ProductID
JOIN Categories C
	ON C.CategoryID = P.CategoryID
	group by c.CategoryName

select CategoryName, cantidad
from cantidad_productosXcategory
where cantidad = (select max(cantidad)
					from cantidad_productosXcategory)

