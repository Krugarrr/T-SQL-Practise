SELECT
    P.Name, SOD.ProductID, AVG(OrderQty) OVER(
    PARTITION BY
        SOD.ProductID, SalesOrderID
    ORDER BY
        SOD.ModifiedDate
    DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS Qty
FROM
    Production.Product AS P
JOIN
    Sales.SalesOrderDetail AS SOD
ON
    P.ProductID=SOD.ProductID
