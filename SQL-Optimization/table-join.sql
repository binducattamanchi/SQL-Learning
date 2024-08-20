/* Always order your JOINs from largest tables to smallest tables */

SELECT
*
FROM
small_table
JOIN
large_table
ON small_table.id = large_table.id;

VS

SELECT
*
FROM
large_table
JOIN
small_table
ON small_table.id = large_table.id;
