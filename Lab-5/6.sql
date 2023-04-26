WITH
  ProductInfo (Customer, SalesOrder, ProductCount, ProductID)
AS
  (
    SELECT
      CustomerID AS Customer, SOD.SalesOrderID AS SalesOrder, CHECKSUM_AGG(ProductID), ProductID
    FROM
      Sales.SalesOrderDetail AS SOD
    JOIN
      Sales.SalesOrderHeader AS SOH
    ON
      SOD.SalesOrderID = SOH.SalesOrderID
    GROUP BY
        CustomerID, SOD.SalesOrderID, ProductID
  ),
Counter (Customer, SalesOrder, ProductCount, ProductID)
AS
    (
    SELECT
        PI1.Customer, PI1.SalesOrder, PI1.ProductCount, PI1.ProductID
    FROM
        ProductInfo AS PI1
    WHERE PI1.ProductID IN
         (
                              SELECT
                                ProductID
                              FROM
                                  ProductInfo AS PI2
                              WHERE
                                  PI1.Customer = PI2.Customer
                                AND
                                  PI1.SalesOrder != PI2.SalesOrder
                            )
    )

SELECT
    DISTINCT Customer
FROM
    Counter
ORDER BY
    Customer
