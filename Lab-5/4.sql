WITH
	ProductInfo(ProductName, MaxPrice, MinPrice) AS
	(
		SELECT
			P.Name AS ProductName, MAX(SOD.LineTotal) AS MaxPrice, MIN(DISTINCT SOD.LineTotal) AS MinPrice
		FROM
			Production.Product AS P
		JOIN
			Sales.SpecialOfferProduct AS SOP
		ON
			P.ProductID = SOP.ProductID
		JOIN
			Sales.SalesOrderDetail AS SOD
		ON
			SOP.ProductID = SOD.ProductID
		JOIN
			Sales.SalesOrderHeader AS SOH
		ON
			SOD.SalesOrderID = SOH.SalesOrderID
		GROUP BY
			P.Name
	)
SELECT
	ProductName, MaxPrice, MinPrice
FROM
	ProductInfo