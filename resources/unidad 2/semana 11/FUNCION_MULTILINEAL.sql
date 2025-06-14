use NORTHWND1
select* from Customers
select* from Employees
select* from Suppliers


SELECT COUNT(*) AS total_alumnos
FROM (
  SELECT CustomerID FROM Customers
  UNION
  SELECT Employeeid FROM Employees
  union
  SELECT SupplierID FROM Suppliers

) AS todos;

SELECT COUNT(*) AS total_personas
FROM (
  SELECT CAST(CustomerID AS NVARCHAR) AS id FROM Customers
  UNION
  SELECT CAST(EmployeeID AS NVARCHAR) AS id FROM Employees
  UNION
  SELECT CAST(SupplierID AS NVARCHAR) AS id FROM Suppliers
) AS todos;



create function FN_LIS_PER() RETURNS @LIS_PER TABLE(
TIPO_PER CHAR(1),
NOMBRE NVARCHAR(50),
APELLIDO NVARCHAR(50)
)
AS
BEGIN
	INSERT INTO @LIS_PER
		select 'TIPO_PER' = 'C', 
		companyname as nombre
		FROM Customers
		UNION
		select 'TIPO_PER' = 'E', 
		firstname as nombre
		FROM employees
		union
		select 'TIPO_PER' = 'S', 
		CompanyName as nombre
		FROM Suppliers
	RETURN
END

SELECT COUNT(*) FROM FN_LIS_PER()

--FN MULTISENTENCIA

--CREAR UNA FUNCION QUE LISTE LA VENTA TOTAL(PRECIO POR CANTIDAD P*Q) POR PAIS VENDIDO 
--LA CANTIDAD DE PEDIDOS DE UN DETERMINADO AÑO (ORDERDATE)
select*from Orders
select*from Products
select*from [Order Details]

CREATE FUNCTION FN_VENTAS_POR_PAIS()
RETURNS @VENTAS TABLE (
	PAIS NVARCHAR(50),
	VENTA_TOTAL MONEY
)
AS
BEGIN
	INSERT INTO @VENTAS
	SELECT 
		O.ShipCountry AS PAIS,
		SUM(OD.UnitPrice * OD.Quantity) AS VENTA_TOTAL
	FROM Orders O
	INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
	GROUP BY O.ShipCountry

	RETURN
END

SELECT * FROM FN_VENTAS_POR_PAIS();

--li
