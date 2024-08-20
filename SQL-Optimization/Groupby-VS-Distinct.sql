-- Using DISTINCT
SELECT DISTINCT Department
FROM LargeEmployeeTable;

-- Using GROUP BY
SELECT Department
FROM LargeEmployeeTable
GROUP BY Department;

/*
Simple Deduplication: Use DISTINCT for simple deduplication tasks. It’s designed specifically for this purpose and is often optimized for performance.
Aggregation and Grouping: Use GROUP BY when you need to perform aggregations or group data, as it provides flexibility for additional calculations.

Execution Plan:

Both DISTINCT and GROUP BY may generate similar execution plans for simple cases of deduplication. However, DISTINCT is usually optimized specifically for removing duplicates.
Efficiency:

For removing duplicates without aggregation, DISTINCT is typically more straightforward and can be slightly faster because it is optimized for this specific purpose.
Index Usage:

Both DISTINCT and GROUP BY may benefit from indexes on the columns being deduplicated or grouped, but GROUP BY can sometimes involve more complex sorting and grouping operations.
*/
