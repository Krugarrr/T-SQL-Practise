SELECT
    CustomerID, SalesOrderID, (ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS Number
FROM
    Sales.SalesOrderHeader