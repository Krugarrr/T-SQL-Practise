/*1 var*/
WITH
	OrderCount (CustomerID, SalesOrderID, ProductCount) AS
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
	CustomerID, AVG(ProductCount)
FROM
	OrderCount
GROUP BY
	CustomerID
ORDER BY
	CustomerID

/* 2 var*/