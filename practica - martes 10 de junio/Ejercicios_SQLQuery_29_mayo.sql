
/*Ejercicio 1
Por cada cliente, indicar el nombre del cliente y la cantidad de �tems
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
Listar los nombres de los clientes que son del pa�s de �Mexico�.*/
SELECT ContactName, Country
 from Customers
 WHERE Country='Mexico'

SELECT ContactName, Country
 from Customers
 WHERE Country  like 'Mexico'

/*Listar los nombres de los clientes que no son del pa�s de �Mexico�.*/

SELECT ContactName, Country
 from Customers
 WHERE Country not in ('Mexico')

 SELECT ContactName, Country
 from Customers
 WHERE Country <>'Mexico'
 order by Country asc


/*Ejercicio 15
Listar los nombres de los productos y el nombre de su categor�a. */
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

/*Indicar el nombre del producto con mayor precio*/select ProductNamefrom Productswhere UnitPrice = (select max(unitprice) from Products)/*Indicar el nombre del pa�s con la mayor cantidad de clientes*/select country, Cantidadfrom (select country, count(CustomerID) as Cantidad		from customers		group by country) QPwhere Cantidad = (select max(cantidad)                 from (select country, count(CustomerID) as Cantidad		              from customers		              group by country) QP)/* primero desarrollar una tablaque muestre la cantidad de clientes por pais*/select country, count(CustomerID) as Cantidadfrom customersgroup by country/*Ejercicio 2
Indicar el nombre del cliente que m�s �tems ha adquirido.*/
/*Primera Opci�n*/

SELECT ContactName, Total
from (SELECT C.ContactName, SUM(Quantity) Total
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	JOIN OrderDetails OD ON O.OrderID = OD.OrderID
	GROUP BY C.ContactName) R
where Total = (select Max(Total) 
			   from (SELECT C.ContactName, 
					SUM(Quantity) Total
					FROM Customers C
					JOIN Orders O ON C.CustomerID = O.CustomerID
					JOIN OrderDetails OD ON O.OrderID = OD.OrderID
					GROUP BY C.ContactName) R )/*Muestra clienntes con cantidad de items comprados*/SELECT C.ContactName, SUM(Quantity) Total
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	JOIN OrderDetails OD ON O.OrderID = OD.OrderID
	GROUP BY C.ContactName/* 2da opcion */Create view Customer_Total as
	SELECT C.ContactName, SUM(Quantity) Total
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	JOIN OrderDetails OD ON O.OrderID = OD.OrderID
	GROUP BY C.ContactNameSELECT ContactName, Total
from Customer_Total
where Total = (select Max(Total) 
			   from Customer_Total)


/*Ejercicio 3
Por cada cliente, indicar el nombre del cliente, 
los nombres de los productos adquiridos
y la cantidad de �tems por producto 
adquirido en total.*/

SELECT ContactName, ProductName, SUM(Quantity) as ItemsTotal
FROM Customers C
JOIN Orders O ON C.CustomerId = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY ContactName, ProductName/*Ejercicio 35
Lista el nombre del cliente Pavarotti, 
N�mero de orden de pedido y
fechas de transporte en la cual 
las fechas de transporte est� entre los
meses octubre y noviembre del a�o 2017*/
select C.ContactName, OD.OrderID, OD.ShippedDate
from Orders OD join Customers C
on OD.CustomerID = C.CustomerID
where ShippedDate between '2017-10-1' and '2017-11-30'
and C.ContactName like '%Pavarotti%'

/*2da forma*/
select C.ContactName, OD.OrderID, OD.ShippedDate
from Orders OD join Customers C
on OD.CustomerID = C.CustomerID
where year(ShippedDate) = 2017 and 
(MONTH(shippedDate) in (10,11))
and C.ContactName like '%Pavarotti%'

/*Mostrar los mismos datos pero de los a�os
2016 y 2018 */

select C.ContactName, OD.OrderID, OD.ShippedDate
from Orders OD join Customers C
on OD.CustomerID = C.CustomerID
where year(ShippedDate) in (2016,2018)
and C.ContactName like '%Pavarotti%'

/*Indicar la cantidad de �rdenes atendidas 
por cada empleado (mostrar el nombre y apellido de cada
empleado)
Mostrar solo los empledos que superen la cantidad de 100
ordenes atendidas
. */

select concat(e.FirstName,', ',e.LastName) fullname, count(o.OrderID)  as total
from Employees e
join Orders O
on o.EmployeeID=e.EmployeeID
group by e.LastName, e.FirstName
having count(o.OrderID) > 100

/*Ejercicio 6
Por cada cliente indicar el nombre del cliente 
y la relaci�n de los nombres
de las categor�as de los productos 
que ha adquirido.*/

SELECT DISTINCT ContactName, CategoryName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories CA ON CA.CategoryID = P.CategoryID
ORDER BY 1asc, 2 asc

--Ejercicio 33
--Indicar la categor�a con mayor 
--cantidad de productos vendidos.

create view cantida_productosXcategory as
	SELECT c.CategoryName, sum(od.Quantity) as cantidad
	FROM Products P
	JOIN OrderDetails OD
	ON P.ProductID = OD.ProductID
	JOIN Categories C
	ON C.CategoryID = P.CategoryID
	group by c.CategoryName

select CategoryName, cantidad
from cantida_productosXcategory
where cantidad = (select max(cantidad)
                  from cantida_productosXcategory)


--Listar los nombres de los clientes que no tienen �rdenes registradas.
SELECT ContactName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)

--2da opci�n
select c.ContactName
from customers c
left join orders o on  c.CustomerID = o.CustomerID
where o.CustomerID is null


--3era opci�n
select c.ContactName
from orders o
right join customers c on  c.CustomerID = o.CustomerID
where o.CustomerID is null


--Mostrar los nombres y apellidos de los empleados junto con los nombres y apellidos de sus respectivos
--jefes
select e.EmployeeID, e.LastName, e.FirstName, e.ReportsTo, j.EmployeeID, j.LastName, j.FirstName
from employees e
join Employees j on e.ReportsTo = j.EmployeeID


--Mostrar todos los empleados aquellos que tienen jefe o no
select e.EmployeeID, e.LastName, e.FirstName, e.ReportsTo, j.EmployeeID, j.LastName, j.FirstName
from employees e
left join Employees j on e.ReportsTo = j.EmployeeID

--Mostrar todos los empleados aquellos que no tienen jefe
select e.EmployeeID, e.LastName, e.FirstName, e.ReportsTo, j.EmployeeID, j.LastName, j.FirstName
from employees e
left join Employees j on e.ReportsTo = j.EmployeeID
where j.EmployeeID  is null


select j.EmployeeID, j.LastName, j.FirstName, j.ReportsTo, e.EmployeeID, e.LastName, e.FirstName
from employees e
right join Employees j on j.ReportsTo = e.EmployeeID
where e.EmployeeID  is null



--Mostrar el monto total por a�o, por pedido
select year(o.OrderDate) as anio, o.OrderID, sum(od.Quantity * od.UnitPrice) as subtotal
from orders o
join OrderDetails od on o.OrderID = od.OrderID
group by year(o.OrderDate), o.OrderID

--Mostrar el monto total de pedidos por a�o
select year(o.OrderDate) as anio, sum(od.Quantity * od.UnitPrice) as subtotal
from orders o
join OrderDetails od on o.OrderID = od.OrderID
group by year(o.OrderDate)


--Mostrar el monto total de pedidos por a�o, por mes
select year(o.OrderDate) as anio, month(o.OrderDate) as mes, sum(od.Quantity * od.UnitPrice) as subtotal
from orders o
join OrderDetails od on o.OrderID = od.OrderID
group by year(o.OrderDate), month(o.OrderDate)
order by 1 asc, 2 asc

--3. La empresa tiene como pol�tica otorgar a los jefes una comisi�n del 0.5% sobre la venta de sus
--subordinados. Calcule la comisi�n mensual que le ha correspondido a cada jefe por cada a�o
--(bas�ndose en la fecha de la orden) seg�n las ventas que figuran en la base de datos. Muestre el
--c�digo del jefe, su apellido, el a�o y mes de c�lculo, el monto acumulado de venta de sus
--subordinados, y la comisi�n obtenida.

select j.EmployeeID, j.LastName, j.FirstName, year(o.OrderDate) as anio, 
month(o.OrderDate) as mes, sum(od.Quantity * od.UnitPrice) as subtotal,
(sum(od.Quantity * od.UnitPrice))*0.05 as comision
from orders o
join OrderDetails od on o.OrderID = od.OrderID
join Employees e
on e.EmployeeID =o.EmployeeID
join Employees j
on e.ReportsTo = j.EmployeeID
group by  j.EmployeeID, j.LastName, j.FirstName, year(o.OrderDate), month(o.OrderDate)
order by 1 asc, 2 asc, 3 asc, 4 asc


--Obtener los pa�ses donde el importe total anual de las �rdenes enviadas supera los $4,500. Para
--determinar el a�o, tome como base la fecha de la orden (orderdate). Ordene el resultado monto total
--de venta.
--Muestre el pa�s, el a�o, y el importe anual de venta

select o.ShipCountry, year(o.OrderDate) as anio, sum(od.Quantity * od.UnitPrice) as subtotal
from orders o
join OrderDetails od on o.OrderID = od.OrderID
group by  o.ShipCountry, year(o.OrderDate), o.OrderID
having sum(od.Quantity * od.UnitPrice) > 4500


--Ejercicio 28
--Indicar el nombre del cliente con m�s pedidos.
SELECT Contactname, Quantity
from (SELECT ContactName, COUNT(OrderID) Quantity
		FROM Orders O, Customers C
		WHERE O.CustomerID = C.CustomerID
		GROUP BY ContactName) R
where Quantity = (Select max(Quantity)
					from (SELECT ContactName, COUNT(OrderID) Quantity
							FROM Orders O, Customers C
							WHERE O.CustomerID = C.CustomerID
							GROUP BY ContactName) R )

/* 2da opci�n*/
create view CantidadPedidosXCliente as
SELECT ContactName, COUNT(OrderID) Quantity
		FROM Orders O, Customers C
		WHERE O.CustomerID = C.CustomerID
		GROUP BY ContactName

select ContactName, Quantity
from CantidadPedidosXCliente
where  Quantity = ( select max(quantity) from CantidadPedidosXCliente)


--Ejercicio 22
--Lista los nombres de las categor�as y el precio promedio de sus
--productos.
SELECT CategoryName, AVG(UnitPrice)
FROM Products P, Categories C
WHERE P.CategoryID = C.CategoryID
GROUP BY CategoryNameSELECT CategoryName, AVG(UnitPrice)
FROM Products P
join Categories C on P.CategoryID = C.CategoryID
GROUP BY CategoryName----15) De cada producto que haya tenido venta en por lo menos 20 transacciones (ordenes) del a�o 2017
----mostrar el c�digo, nombre y cantidad de unidades vendidas y cantidad de ordenes en las que se
----vendi�.select year(o.OrderDate) ,p.ProductID,p.ProductName ,sum(od.Quantity) as CanntidadVendida,count(o.orderid) as total_ordenesfrom Products Pjoin OrderDetails od on od.ProductID = p.ProductIDjoin Orders o on o.OrderID = od.OrderIDgroup by year(o.OrderDate) ,p.ProductID,p.ProductNamehaving count(o.orderid) > 20  and year(o.OrderDate) = 1997select p.ProductID,p.ProductName ,sum(od.Quantity) as CanntidadVendida,count(o.orderid) as total_ordenesfrom Products Pjoin OrderDetails od on od.ProductID = p.ProductIDjoin Orders o on o.OrderID = od.OrderIDwhere year(o.OrderDate) = 1997group by p.ProductID,p.ProductNamehaving count(o.orderid) > 20  