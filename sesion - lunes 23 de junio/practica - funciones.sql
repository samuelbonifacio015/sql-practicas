use NORTHWND1
GO

SELECT * FROM ORDERS
SELECT * FROM [Order Details]

-- Crea una función escalar fn_TotalVentaPorPedido(@OrderID INT) que devuelva 
-- el importe total (Sum(Quantity × UnitPrice × (1–Discount))) de un pedido dado.
CREATE FUNCTION ufn_TotalVentaPorPedido (@OrderID INT)
RETURNS MONEY
AS
BEGIN
  DECLARE @Total MONEY

  SELECT @Total = SUM(UnitPrice * Quantity * (1 - Discount))
  FROM [Order Details]
  WHERE OrderID = @OrderID

  RETURN @Total
END

SELECT dbo.ufn_TotalVentaPorPedido(10248) AS TotalPedido
