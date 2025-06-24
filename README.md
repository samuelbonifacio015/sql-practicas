# Guía de comandos SQL - NORTHWIND

## FUNCIONES, PROCEDIMIENTOS ALMACENADOS Y TRIGGERS

### FUNCIONES

#### Sintaxis básica:

```sql
CREATE FUNCTION nombre_funcion(@parametro1 tipo, @parametro2 tipo)
RETURNS tipo_retorno
AS
BEGIN
    -- Lógica de la función
    RETURN valor;
END
```

#### Uso práctico:

Las funciones permiten encapsular lógica reutilizable que devuelve un valor. Son útiles para cálculos complejos, validaciones y transformaciones de datos.

#### Ejemplos:

**Función escalar - Calcular edad:**

```sql
CREATE FUNCTION CalcularEdad(@fechaNacimiento DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @fechaNacimiento, GETDATE());
END

-- Uso:
SELECT FirstName, LastName, dbo.CalcularEdad(BirthDate) AS Edad
FROM Employees;
```

**Función de tabla - Obtener pedidos por cliente:**

```sql
CREATE FUNCTION ObtenerPedidosCliente(@CustomerID NCHAR(5))
RETURNS TABLE
AS
RETURN (
    SELECT OrderID, OrderDate, RequiredDate, ShippedDate
    FROM Orders
    WHERE CustomerID = @CustomerID
);

-- Uso:
SELECT * FROM dbo.ObtenerPedidosCliente('ALFKI');
```

### PROCEDIMIENTOS ALMACENADOS

#### Sintaxis básica:

```sql
CREATE PROCEDURE nombre_procedimiento
    @parametro1 tipo,
    @parametro2 tipo OUTPUT  -- Parámetro de salida opcional
AS
BEGIN
    -- Lógica del procedimiento
    -- Puede incluir múltiples operaciones
END
```

#### Uso práctico:

Los procedimientos almacenados permiten ejecutar múltiples operaciones SQL como una unidad, mejorando el rendimiento y la seguridad. Son ideales para operaciones complejas que involucran múltiples tablas.

#### Ejemplos:

**Procedimiento simple - Insertar nuevo empleado:**

```sql
CREATE PROCEDURE InsertarEmpleado
    @FirstName NVARCHAR(10),
    @LastName NVARCHAR(20),
    @Title NVARCHAR(30),
    @City NVARCHAR(15),
    @Country NVARCHAR(15)
AS
BEGIN
    INSERT INTO Employees (FirstName, LastName, Title, City, Country)
    VALUES (@FirstName, @LastName, @Title, @City, @Country);

    SELECT 'Empleado insertado correctamente' AS Mensaje;
END

-- Uso:
EXEC InsertarEmpleado 'Juan', 'Pérez', 'Analista', 'Lima', 'Perú';
```

**Procedimiento con parámetro de salida - Obtener total de ventas:**

```sql
CREATE PROCEDURE ObtenerTotalVentas
    @CustomerID NCHAR(5),
    @TotalVentas MONEY OUTPUT
AS
BEGIN
    SELECT @TotalVentas = SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
    FROM Orders o
    INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    WHERE o.CustomerID = @CustomerID;

    IF @TotalVentas IS NULL
        SET @TotalVentas = 0;
END

-- Uso:
DECLARE @Total MONEY;
EXEC ObtenerTotalVentas 'ALFKI', @Total OUTPUT;
SELECT @Total AS TotalVentasCliente;
```

### TRIGGERS

#### Sintaxis básica:

```sql
CREATE TRIGGER nombre_trigger
ON nombre_tabla
AFTER/INSTEAD OF INSERT/UPDATE/DELETE
AS
BEGIN
    -- Lógica del trigger
    -- Puede acceder a las tablas INSERTED y DELETED
END
```

#### Uso práctico:

Los triggers se ejecutan automáticamente en respuesta a eventos específicos en las tablas. Son útiles para auditoría, validaciones complejas, mantenimiento de datos derivados y aplicación de reglas de negocio.

#### Ejemplos:

**Trigger de auditoría - Registrar cambios en empleados:**

```sql
-- Primero crear tabla de auditoría
CREATE TABLE AuditoriaEmpleados (
    AuditoriaID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Accion VARCHAR(10),
    FechaModificacion DATETIME,
    Usuario VARCHAR(50),
    ValorAnterior NVARCHAR(MAX),
    ValorNuevo NVARCHAR(MAX)
);

-- Crear trigger
CREATE TRIGGER TR_AuditoriaEmpleados
ON Employees
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Para INSERT
    IF EXISTS (SELECT * FROM INSERTED) AND NOT EXISTS (SELECT * FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEmpleados (EmployeeID, Accion, FechaModificacion, Usuario, ValorNuevo)
        SELECT EmployeeID, 'INSERT', GETDATE(), SYSTEM_USER,
               CONCAT('Nombre: ', FirstName, ' ', LastName, ', Ciudad: ', City)
        FROM INSERTED;
    END

    -- Para UPDATE
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEmpleados (EmployeeID, Accion, FechaModificacion, Usuario, ValorAnterior, ValorNuevo)
        SELECT i.EmployeeID, 'UPDATE', GETDATE(), SYSTEM_USER,
               CONCAT('Nombre: ', d.FirstName, ' ', d.LastName, ', Ciudad: ', d.City),
               CONCAT('Nombre: ', i.FirstName, ' ', i.LastName, ', Ciudad: ', i.City)
        FROM INSERTED i
        INNER JOIN DELETED d ON i.EmployeeID = d.EmployeeID;
    END

    -- Para DELETE
    IF EXISTS (SELECT * FROM DELETED) AND NOT EXISTS (SELECT * FROM INSERTED)
    BEGIN
        INSERT INTO AuditoriaEmpleados (EmployeeID, Accion, FechaModificacion, Usuario, ValorAnterior)
        SELECT EmployeeID, 'DELETE', GETDATE(), SYSTEM_USER,
               CONCAT('Nombre: ', FirstName, ' ', LastName, ', Ciudad: ', City)
        FROM DELETED;
    END
END
```

**Trigger de validación - Controlar stock de productos:**

```sql
CREATE TRIGGER TR_ValidarStock
ON [Order Details]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si hay suficiente stock
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        INNER JOIN Products p ON i.ProductID = p.ProductID
        WHERE i.Quantity > p.UnitsInStock
    )
    BEGIN
        RAISERROR('Error: No hay suficiente stock para el producto solicitado', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Actualizar stock disponible
    UPDATE Products
    SET UnitsInStock = UnitsInStock - i.Quantity
    FROM Products p
    INNER JOIN INSERTED i ON p.ProductID = i.ProductID;
END
```

**Trigger INSTEAD OF - Para vistas complejas:**

```sql
-- Crear vista
CREATE VIEW VistaEmpleadosCompleta AS
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Title, e.City, e.Country
FROM Employees e;

-- Crear trigger INSTEAD OF para permitir INSERT en la vista
CREATE TRIGGER TR_InsertVistaEmpleados
ON VistaEmpleadosCompleta
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Employees (FirstName, LastName, Title, City, Country)
    SELECT FirstName, LastName, Title, City, Country
    FROM INSERTED;
END

-- Uso:
INSERT INTO VistaEmpleadosCompleta (FirstName, LastName, Title, City, Country)
VALUES ('Ana', 'García', 'Desarrolladora', 'Madrid', 'España');
```

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

**Descripción**: Ordena las filas por la columna `City` en orden ascendente por defecto. Se puede agregar `DESC`
