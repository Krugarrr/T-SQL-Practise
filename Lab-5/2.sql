WITH
	CIPIPC (CustomerID, ProductID, ProductCount)
AS
	(
		SELECT
			CustomerID, ProductID, COUNT(*) AS ProductCount
		FROM
			Sales.SalesOrderDetail AS SOD
		JOIN
			Sales.SalesOrderHeader AS SOH
		ON
			SOD.SalesOrderID = SOH.SalesOrderID
		GROUP BY
			CustomerID, ProductID
	),

OrderCount (CustomerID, SalesOrderID, ProductCount)
AS
	(
		SELECT
			CustomerID, SOD.SalesOrderID, COUNT(ProductID) AS ProductCount
		FROM
			Sales.SalesOrderDetail AS SOD
		JOIN
			Sales.SalesOrderHeader AS SOH
		ON
			SOD.SalesOrderID = SOH.SalesOrderID
		GROUP BY
			CustomerID, SOD.SalesOrderID
	)

SELECT
	OrderCount.CustomerID, (OrderCount.ProductCount / CIPIPC.ProductCount)
FROM
	OrderCount
JOIN
    CIPIPC
ON
    CIPIPC.CustomerID = OrderCount.CustomerID
WHERE OrderCount.ProductCount != 0
