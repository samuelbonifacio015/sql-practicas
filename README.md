
# Guía de comandos SQL - NORTHWIND

## 1. LECTURA

### SELECT
```sql
SELECT FirstName, LastName FROM Employees;
```
**Descripción**: Selecciona las columnas `FirstName` y `LastName` de la tabla `Employees`. Este comando se usa para recuperar datos de las tablas de la base de datos.

### FROM
```sql
SELECT * FROM Orders;
```
**Descripción**: Especifica la tabla `Orders` de donde se van a obtener los datos. Se utiliza para indicar la fuente de los datos en la consulta SQL.

### WHERE
```sql
SELECT * FROM Employees WHERE City = 'Seattle';
```
**Descripción**: Filtra las filas de la tabla `Employees` para obtener solo aquellas en las que la columna `City` tiene el valor 'Seattle'.

### AND
```sql
SELECT * FROM Employees WHERE City = 'Seattle' AND Country = 'USA';
```
**Descripción**: Combina múltiples condiciones. En este caso, solo se recuperarán las filas donde ambas condiciones (`City = 'Seattle'` y `Country = 'USA'`) sean ciertas.

### OR
```sql
SELECT * FROM Employees WHERE City = 'Seattle' OR City = 'London';
```
**Descripción**: Permite combinar condiciones. Se seleccionarán las filas donde cualquiera de las condiciones sea verdadera.

### IN
```sql
SELECT * FROM Employees WHERE City IN ('Seattle', 'London', 'Paris');
```
**Descripción**: Filtra los resultados para aquellos registros en los que la columna `City` esté en la lista proporcionada (en este caso, 'Seattle', 'London', 'Paris').

### LIKE
```sql
SELECT * FROM Customers WHERE CompanyName LIKE 'A%';
```
**Descripción**: Utiliza un comodín (`%`) para buscar coincidencias. Aquí, devuelve todas las filas de la tabla `Customers` donde el nombre de la empresa comienza con la letra 'A'.

### IS NULL
```sql
SELECT * FROM Employees WHERE Extension IS NULL;
```
**Descripción**: Filtra filas en las que la columna `Extension` tenga un valor nulo. Se usa cuando queremos encontrar valores nulos en una columna.

### DISTINCT
```sql
SELECT DISTINCT City FROM Customers;
```
**Descripción**: Devuelve solo los valores únicos de la columna `City` en la tabla `Customers`. Elimina duplicados en los resultados.

### JOIN
```sql
SELECT Orders.OrderID, Customers.CustomerName 
FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
```
**Descripción**: Combina las filas de las tablas `Orders` y `Customers`, donde el `CustomerID` coincide en ambas tablas. El `JOIN` se usa para combinar datos de varias tablas relacionadas.

### AS
```sql
SELECT FirstName AS "First Name", LastName AS "Last Name" FROM Employees;
```
**Descripción**: Asigna un alias a las columnas seleccionadas. En este caso, las columnas `FirstName` y `LastName` se mostrarán como "First Name" y "Last Name", respectivamente.

### UNION
```sql
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers;
```
**Descripción**: Combina los resultados de dos consultas SELECT, eliminando duplicados. En este caso, une las ciudades de las tablas `Customers` y `Suppliers`.

### CASE
```sql
SELECT OrderID, 
       CASE 
          WHEN Freight < 50 THEN 'Low'
          WHEN Freight BETWEEN 50 AND 150 THEN 'Medium'
          ELSE 'High' 
       END AS FreightCategory
FROM Orders;
```
**Descripción**: Elige un valor según las condiciones proporcionadas, similar a un `IF-ELSE`. Aquí, clasifica los pedidos en categorías de 'Low', 'Medium' o 'High' según el valor de `Freight`.

### LIMIT
```sql
SELECT * FROM Employees LIMIT 5;
```
**Descripción**: Limita el número de filas devueltas por la consulta. En este caso, solo devuelve las primeras 5 filas de la tabla `Employees`.

### ORDER BY
```sql
SELECT * FROM Customers ORDER BY City;
```
**Descripción**: Ordena las filas por la columna `City` en orden ascendente por defecto. Se puede agregar `DESC` para ordenar de manera descendente.

## 2. AGREGACIÓN

### GROUP BY
```sql
SELECT City, COUNT(*) AS NumberOfCustomers FROM Customers GROUP BY City;
```
**Descripción**: Agrupa las filas por la columna `City` y calcula el número de clientes por cada ciudad.

### HAVING
```sql
SELECT City, COUNT(*) AS NumberOfCustomers 
FROM Customers 
GROUP BY City 
HAVING COUNT(*) > 5;
```
**Descripción**: Filtra los resultados de un `GROUP BY`. Solo devuelve las ciudades con más de 5 clientes.

### COUNT
```sql
SELECT COUNT(*) FROM Employees;
```
**Descripción**: Devuelve el número total de filas en la tabla `Employees`. Es útil para contar registros.

### SUM
```sql
SELECT SUM(Freight) FROM Orders;
```
**Descripción**: Calcula la suma de los valores de la columna `Freight` en la tabla `Orders`.

### AVG
```sql
SELECT AVG(UnitPrice) FROM OrderDetails;
```
**Descripción**: Calcula el valor promedio de la columna `UnitPrice` en la tabla `OrderDetails`.

### MIN
```sql
SELECT MIN(OrderDate) FROM Orders;
```
**Descripción**: Devuelve la fecha más temprana (`MIN`) en la columna `OrderDate` de la tabla `Orders`.

### MAX
```sql
SELECT MAX(UnitPrice) FROM Products;
```
**Descripción**: Devuelve el valor máximo (`MAX`) de la columna `UnitPrice` en la tabla `Products`.

## 3. ESCRITURA

### INSERT
```sql
INSERT INTO Employees (FirstName, LastName, City, Country) 
VALUES ('John', 'Doe', 'New York', 'USA');
```
**Descripción**: Inserta una nueva fila en la tabla `Employees` con los valores especificados para `FirstName`, `LastName`, `City` y `Country`.

### UPDATE
```sql
UPDATE Employees 
SET City = 'Los Angeles' 
WHERE EmployeeID = 1;
```
**Descripción**: Actualiza el valor de la columna `City` a 'Los Angeles' para el empleado con `EmployeeID = 1`.

### DELETE
```sql
DELETE FROM Employees WHERE EmployeeID = 1;
```
**Descripción**: Elimina las filas de la tabla `Employees` donde el `EmployeeID` es igual a 1.

### TRUNCATE
```sql
TRUNCATE TABLE Employees;
```
**Descripción**: Elimina todas las filas de la tabla `Employees` de manera rápida, sin generar registros de transacciones.

### CREATE
```sql
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);
```
**Descripción**: Crea una nueva tabla llamada `Departments` con dos columnas: `DepartmentID` y `DepartmentName`.

### ALTER TABLE
```sql
ALTER TABLE Employees ADD COLUMN BirthDate DATE;
```
**Descripción**: Modifica la estructura de la tabla `Employees` añadiendo una nueva columna llamada `BirthDate` de tipo `DATE`.

### DROP TABLE
```sql
DROP TABLE Departments;
```
**Descripción**: Elimina la tabla `Departments` de la base de datos.

## 4. TRANSACCIÓN

### COMMIT
```sql
COMMIT;
```
**Descripción**: Confirma la transacción actual, aplicando de manera permanente los cambios realizados en la base de datos.

### ROLLBACK
```sql
ROLLBACK;
```
**Descripción**: Revierte cualquier cambio realizado durante la transacción actual, deshaciendo los cambios hechos hasta ese punto.

## 5. DIAGNÓSTICO

### EXPLAIN
```sql
EXPLAIN SELECT * FROM Orders WHERE CustomerID = 'ALFKI';
```
**Descripción**: Muestra el plan de ejecución de la consulta SQL. Proporciona información sobre cómo se ejecutará la consulta y los índices utilizados.

### DESCRIBE
```sql
DESCRIBE Employees;
```
**Descripción**: Muestra la estructura de la tabla `Employees`, incluyendo el nombre de las columnas, el tipo de datos y otras características.
