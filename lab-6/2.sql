SELECT
    Name, StandardCost, (StandardCost - MIN(StandardCost) OVER(PARTITION BY ProductSubcategoryID)) AS Difference
FROM
    Production.Product
