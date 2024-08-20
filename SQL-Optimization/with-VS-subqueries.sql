/* Use WITH statements vs. nested subqueries */

SELECT
itemid
FROM (
SELECT
order_id,item_id from orders
where order_id between(1,100)
)a
  

VS


with a as(
  order_id,item_id from orders
where order_id between(1,100)
)
select itemid from a;
