
/* Use UNION ALL Instead of UNION
UNION ALL is faster because it doesn't require sorting and deduplication
*/
-- Instead of this:
SELECT Name FROM Employees
UNION
SELECT Name FROM Contractors;

-- Use this:
SELECT Name FROM Employees
UNION ALL
SELECT Name FROM Contractors;
