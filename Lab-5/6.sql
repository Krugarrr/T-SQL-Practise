WITH
  ProductInfo (Customer, ProductID)
AS
  (
    SELECT
      SOH.CustomerID as Customer, SOD.ProductID
    FROM
      Sales.SalesOrderDetail AS SOD
    JOIN
      Sales.SalesOrderHeader AS SOH
    ON
      SOD.SalesOrderID = SOH.SalesOrderID
    GROUP BY
        SOH.CustomerID, SOD.ProductID
    HAVING COUNT(*) > 1
  ),
Counter (Customer)
AS
    (
    SELECT
        CustomerID AS Customer
    FROM
        Sales.SalesOrderHeader AS SOH
    JOIN
        Sales.SalesOrderDetail AS SOD
    ON SOH.SalesOrderID = SOD.SalesOrderID
    GROUP BY SOH.CustomerID, SOD.ProductID
    HAVING COUNT(*) = 1
    )


SELECT
     DISTINCT Customer
FROM
    ProductInfo
WHERE
    Customer NOT IN (SELECT * FROM Counter)
ORDER BY
    Customer