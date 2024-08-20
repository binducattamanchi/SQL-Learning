/* Use simple equi-joins*/
SELECT *
FROM
table1 a
JOIN
table2 b
ON a.date = CONCAT(b.year, '-',
b.month, '-', b.day)

VS

SELECT *
FROM
table1 a
JOIN (
select
name, CONCAT(b.year, '-', b.month, '-', b.day) as date
from
table2 b
) new
ON a.date = new.date
