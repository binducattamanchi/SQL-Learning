/* Use JOIN Instead of UNION
Sometimes, a UNION can be replaced with a JOIN, which might be more efficient depending on the use case.*/

-- Instead of using UNION:
SELECT e.Name, e.Role FROM Employees e
UNION
SELECT c.Name, c.Role FROM Contractors c;

-- Use a FULL OUTER JOIN:
SELECT COALESCE(e.Name, c.Name) AS Name, 
       COALESCE(e.Role, c.Role) AS Role
FROM Employees e
FULL OUTER JOIN Contractors c ON e.Name = c.Name;
