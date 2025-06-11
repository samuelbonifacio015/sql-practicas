# Resumen de Ejercicios SQL

Este `README.md` resume los ejercicios SQL desarrollados en esta carpeta, clasificados por las funciones y conceptos esenciales de SQL utilizados.

## Funciones y Conceptos Esenciales de SQL

### Creación y Manipulación de Objetos (DDL - Data Definition Language)

*   **`CREATE FUNCTION`**: Utilizado para crear funciones escalares y funciones de tabla en línea (`inline table-valued functions`). Ejemplos incluyen: 
    *   `dbo.fn_PaisMenorPedidos`: Retorna el país del cliente con menor cantidad de pedidos en un año.
    *   `dbo.fn_CategoriaMasVendida`: Retorna la categoría con mayor cantidad de ítems vendidos en un año.
    *   `dbo.fn_OrdenesPorAnio`: Retorna la cantidad de órdenes atendidas en un año.
    *   `dbo.fn_ClienteMasOrdenes`: Retorna el nombre del cliente con más órdenes en un año.
    *   `dbo.fn_ShipperMasPedidos`: Retorna el nombre del `shipper` con más pedidos en un año.
    *   `dbo.fn_ProveedorMasPedidos`: Retorna el proveedor con más productos pedidos en un año.
    *   `dbo.fn_ClienteTopPaisAnio`: Retorna el cliente con más pedidos desde un país específico en un año.
    *   `dbo.fn_ProveedorTopPorPais`: Retorna el proveedor con más productos vendidos en un país de destino.
    *   `dbo.fn_CategoriaTopPorPais`: Retorna la categoría con más órdenes según el país de destino.
    *   `dbo.fn_ProveedorMenorVentas`: Retorna el proveedor con menos productos vendidos en un año.
    *   `FN_CANT_UBI`: Devuelve la cantidad total de ubigeos.
    *   `FN_CANT_UBI_DPTO`: Devuelve la cantidad de ubigeos de un departamento específico.
    *   `FN_LIS_UBI`: Lista todos los departamentos con sus provincias.
    *   `FN_LIS_UBI_DPTO`: Devuelve las provincias de un departamento determinado.

*   **`CREATE PROCEDURE`**: Utilizado para crear procedimientos almacenados. Ejemplos incluyen:
    *   `dbo.sp_ProductosPorCategoria`: Lista los productos de una categoría determinada.
    *   `dbo.sp_ProductosPorProveedor`: Lista los productos que comercializa un proveedor determinado.
    *   `dbo.sp_CategoriaMayorVenta`: Retorna la categoría con mayor monto de ventas acumulado.
    *   `dbo.sp_PaisMasVentasPorAnio`: Retorna el país con más órdenes vendidas en un año.
    *   `SP_LIST_MED_DIST`: Lista los médicos de un determinado distrito.

*   **`CREATE VIEW`**: Utilizado para crear vistas. Ejemplos incluyen:
    *   `CAT_PROD_PED`: Vista para encontrar la categoría a la que pertenece la mayor cantidad de productos.
    *   `Customer_Total`: Vista que muestra el total de ítems adquiridos por cada cliente.
    *   `cantidad_productosXcategory`: Vista que muestra la cantidad de productos por categoría.

### Consultas y Filtrado (DML - Data Manipulation Language)

*   **`SELECT`**: Fundamental para la recuperación de datos.
*   **`FROM`**: Especifica las tablas de donde se obtienen los datos.
*   **`WHERE`**: Filtra registros basándose en una condición específica. Ejemplos de uso con operadores:
    *   `UnitPrice > 18 AND UnitPrice < 100`
    *   `Country = 'Mexico'`
    *   `Country NOT IN ('FRANCE', 'BRAZIL', 'MEXICO')`
    *   `Country <> 'Mexico'`
    *   `YEAR(ORDERDATE) = '2016'`
    *   `ShippedDate BETWEEN '1997-10-1' AND '1997-11-1'`
    *   `YEAR(ShippedDate) IN (2016, 2018)`
    *   `CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)`
    *   `o.CustomerID IS NULL`
*   **`ORDER BY`**: Ordena el conjunto de resultados de una consulta. Ejemplos:
    *   `UnitPrice DESC` (descendente)
    *   `COUNT(O.OrderID) ASC` (ascendente)
    *   `ContactName asc, ProductName asc`
*   **`DISTINCT`**: Elimina filas duplicadas del conjunto de resultados.
*   **`TOP`**: Limita el número de filas devueltas por una consulta.
*   **`LIKE`**: Para búsqueda de patrones (`%Pavarotti%`, `'Mexico'`).

### Uniones (Joins)

*   **`JOIN`** (o `INNER JOIN`): Combina filas de dos o más tablas basándose en una columna relacionada entre ellas. Ampliamente utilizado en todos los ejercicios para relacionar `Customers`, `Orders`, `Order Details`, `Products`, `Categories`, `Suppliers`, `Shippers`, `Employees`, `Territories`, `Region`, `EmployeeTerritories`, `medico`, `direccion`, `ubigeo`.
*   **`LEFT JOIN`**: Retorna todas las filas de la tabla izquierda, y las filas coincidentes de la tabla derecha. Si no hay coincidencia, el resultado es `NULL` en el lado derecho.
*   **`RIGHT JOIN`**: Retorna todas las filas de la tabla derecha, y las filas coincidentes de la tabla izquierda. Si no hay coincidencia, el resultado es `NULL` en el lado izquierdo.

### Funciones Agregadas y Agrupación

*   **`COUNT()`**: Cuenta el número de filas.
*   **`SUM()`**: Calcula la suma de un conjunto de valores.
*   **`MIN()`**: Devuelve el valor mínimo en un conjunto de valores.
*   **`MAX()`**: Devuelve el valor máximo en un conjunto de valores.
*   **`AVG()`**: Calcula el promedio de un conjunto de valores.
*   **`GROUP BY`**: Agrupa filas que tienen los mismos valores en columnas especificadas en grupos de resumen. Utilizado con funciones agregadas para realizar cálculos por grupo (e.g., `COUNT(ORDERID) POR SHIPCOUNTRY`).
*   **`HAVING`**: Filtra los grupos resultantes de una cláusula `GROUP BY`. Ejemplos:
    *   `HAVING COUNT(OrderID) > 20`
    *   `HAVING COUNT(OrderID) > 100`

### Funciones de Cadena y Fecha/Hora

*   **`CONCAT()`**: Concatena dos o más cadenas de texto.
*   **`YEAR()`**: Extrae el año de una fecha.
*   **`MONTH()`**: Extrae el mes de una fecha.

### Operaciones de Conjuntos

*   **`UNION`**: Combina los conjuntos de resultados de dos o más sentencias `SELECT` en un único conjunto de resultados. Utilizado para combinar información de `Suppliers`, `Customers`, y `Employees` bajo un tipo de persona.

### Conversión de Tipos

*   **`CAST()`**: Convierte una expresión de un tipo de datos a otro (e.g., `CAST(DEPARTAMENTO AS NVARCHAR(50))`).

---

Este resumen proporciona una visión general de las capacidades de SQL exploradas en los archivos de práctica, desde la definición de funciones y procedimientos hasta la manipulación avanzada de datos y consultas.