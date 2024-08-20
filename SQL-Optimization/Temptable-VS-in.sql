### /* temp table performs better than In condition*/

SELECT *
FROM Table1 as t1
WHERE
itemid in (3363134,
5189076, …, 4062349);

VS

SELECT *
FROM Table1 as t1
JOIN (
SELECT
itemid
FROM (
SELECT
split('3363134, 5189076, …,', ', ')
as bar
)
CROSS JOIN
UNNEST(bar) AS t(itemid)
) AS Table2 as t2
ON
t1.itemid = t2.itemid;
