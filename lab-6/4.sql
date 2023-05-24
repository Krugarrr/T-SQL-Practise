-- thx to @pypkaed
FROM Production.Product AS p1
WHERE ListPrice > (
        SELECT AVG(ListPrice)
        FROM Production.Product AS p2
        WHERE p1.ProductSubcategoryID = p2.ProductSubcategoryID
        GROUP BY p2.ProductSubcategoryID
    )

-- second var

WITH tmp (SubcategoryID, AvgPrice)
AS (
SELECT DISTINCT ProductSubcategoryID,
       AVG(ListPrice) OVER(PARTITION BY ProductSubcategoryID)
  FROM Production.Product
  )

SELECT ProductID, ListPrice, tmp.AvgPrice
FROM Production.Product p
         JOIN
     tmp
     ON p.ProductSubcategoryID = tmp.SubcategoryID
WHERE ListPrice > AvgPrice

-- third var

WITH
ProductsAndAvg (ProductID, StandardCost, ProductSubcategoryID, AvgCostSubcategory) AS
(
	SELECT
		ProductID, StandardCost, ProductSubcategoryID, (AVG(StandardCost) OVER(PARTITION BY ProductSubcategoryID))
	FROM
		Production.Product
)
SELECT
    ProductID
FROM
    ProductsAndAvg
WHERE
        StandardCost > AvgCostSubcategory AND ProductSubcategoryID IS NOT NULL