SELECT
    Name, SalesOrderID, (SUM(OrderQty) OVER(PARTITION BY SalesOrderID)) * UnitPrice
FROM
    Sales.SalesOrderDetail AS SOD
JOIN
    Production.Product AS P
ON
    P.ProductID=SOD.ProductID