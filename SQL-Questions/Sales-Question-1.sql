/*
 Find the Top 3 Employees with the Highest Total Sales in Each Region
 Schema : Using Employees (EmployeeID, Name, RegionID)  
 Sales (SaleID, EmployeeID, Amount)
*/

WITH RankedSales AS (
 SELECT 
  e.EmployeeID, 
  e.Name, 
  e.RegionID, 
  SUM(s.Amount) AS TotalSales,
  RANK() OVER (PARTITION BY e.RegionID ORDER BY SUM(s.Amount) DESC) AS SalesRank
 FROM Employees e
 JOIN Sales s 
  ON e.EmployeeID = s.EmployeeID
 GROUP BY e.EmployeeID, e.Name, e.RegionID
)
SELECT EmployeeID, Name, RegionID, TotalSales
FROM RankedSales
WHERE SalesRank <= 3;
