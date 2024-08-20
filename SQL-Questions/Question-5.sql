/*
 Calculate the Moving Average of Sales for Each Product Over the Last 3 Months
 Schema : Given Sales (SaleID, ProductID, SaleDate, Amount)
*/
SELECT ProductID, 
 SaleDate, 
 Amount, 
 AVG(Amount) OVER (PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Sales;
