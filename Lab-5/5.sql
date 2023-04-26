WITH
  ProductInfo (Customer, SalesOrder, ProductCount)
AS
  (
    SELECT
      CustomerID AS Customer, SOD.SalesOrderID AS SalesOrder, COUNT(DISTINCT ProductID) AS ProductCount
    FROM
      Sales.SalesOrderDetail AS SOD
    JOIN
      Sales.SalesOrderHeader AS SOH
    ON
      SOD.SalesOrderID = SOH.SalesOrderID
    GROUP BY
        CustomerID, SOD.SalesOrderID
  ),
Counter (Customer, SalesOrder, ProductCount)
AS
    (
    SELECT
        PI1.Customer, PI1.SalesOrder, PI1.ProductCount
    FROM
        ProductInfo AS PI1
    JOIN
        ProductInfo AS PI2
    ON
        PI1.Customer = PI2.Customer AND PI1.SalesOrder != PI2.SalesOrder AND PI1.ProductCount = PI2.ProductCount
    GROUP BY
        PI1.Customer, PI1.SalesOrder, PI1.ProductCount
    )
SELECT
    DISTINCT Customer
FROM
    ProductInfo
WHERE
    Customer NOT IN (
                       SELECT
                           Counter.Customer
                       FROM
                           Counter)
ORDER BY
    Customer
