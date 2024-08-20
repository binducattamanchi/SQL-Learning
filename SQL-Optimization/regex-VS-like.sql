/* Regexp performs better than like */

############ 1

SELECT *
FROM
table1
WHERE
lower(item_name) LIKE '%samsung%' OR
lower(item_name) LIKE '%xiaomi%' OR
lower(item_name) LIKE '%iphone%' OR
lower(item_name) LIKE '%huawei%'
........
  .....

  VS

SELECT *
FROM
table1
WHERE
REGEXP_LIKE(lower(item_name),
'samsung|xiaomi|iphone|huawei')
......
  ....

#############  2

SELECT
CASE
WHEN concat(' ',item_name,' ') LIKE '%acer%' then 'Acer'
WHEN concat(' ',item_name,' ') LIKE '%advance%' then 'Advance'
WHEN concat(' ',item_name,' ') LIKE '%alfalink%' then 'Alfalink'
…
AS brand
FROM item_list

VS

SELECT
regexp_extract(item_name,'(asus|lenovo|hp|acer|dell|zyrex|...)')
AS brand
FROM item_list
