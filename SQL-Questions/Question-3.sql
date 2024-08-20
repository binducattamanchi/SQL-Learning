/*
List Customers Who Placed Orders in Consecutive Months
Schema : Orders (OrderID, CustomerID, OrderDate)
*/
WITH MonthlyOrders AS (
 SELECT CustomerID, 
 DATE_TRUNC('month', OrderDate) AS OrderMonth
 FROM Orders
 GROUP BY CustomerID, DATE_TRUNC('month', OrderDate)
),
ConsecutiveMonths AS (
 SELECT CustomerID, 
 OrderMonth,
 LAG(OrderMonth, 1) OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS PrevMonth
 FROM MonthlyOrders
)
SELECT DISTINCT CustomerID
FROM ConsecutiveMonths
WHERE OrderMonth = PrevMonth + INTERVAL '1 month';
