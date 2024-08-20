/*
Identify Products with Sales Increasing for Three Consecutive Months
 Schema :  Sales (ProductID, SaleDate, Quantity).
*/
WITH MonthlySales AS (
 SELECT ProductID, 
 DATE_TRUNC('month', SaleDate) AS Month, 
 SUM(Quantity) AS MonthlyQuantity
 FROM Sales
 GROUP BY ProductID, DATE_TRUNC('month', SaleDate)
),
SalesGrowth AS (
 SELECT ProductID, 
 Month, 
 MonthlyQuantity,
 LAG(MonthlyQuantity, 1) OVER (PARTITION BY ProductID ORDER BY Month) AS PrevMonth1,
 LAG(MonthlyQuantity, 2) OVER (PARTITION BY ProductID ORDER BY Month) AS PrevMonth2
 FROM MonthlySales
)
SELECT ProductID, Month, MonthlyQuantity
FROM SalesGrowth
WHERE MonthlyQuantity > PrevMonth1 AND PrevMonth1 > PrevMonth2;
