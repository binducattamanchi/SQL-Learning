/*
Find the Second Highest Salary in Each Department
 Schema: Employees (EmployeeID, Name, DepartmentID, Salary)
Data: (121,Bindu Cattamanchi,DSE,100000)
*/

 WITH RankedSalaries AS (
 SELECT DepartmentID, 
 Salary, 
 DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS Rank
 FROM Employees
 )
 SELECT DepartmentID, Salary
 FROM RankedSalaries
 WHERE Rank = 2;
