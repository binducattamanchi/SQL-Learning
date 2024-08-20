/* Avoid subqueries in WHERE clause */

select
sum(price)
from
table1
where
itemid in (
select itemid
from table2
)

VS

with t2 as (
select itemid
from table2
)
select
sum(price)
from
table1 as t1
join
t2
on t1.itemid = t2.itemid
