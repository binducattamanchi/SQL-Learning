/*
Write a query to get the earliest order_id for all customers for each date they placed their first order.
*/

select order_id from (
  select *,
  row_number() over (partition by customer_id,date(order_datetime) order by customer_id,order_datetime as Rn
  from orders) as o
  where o.rn=1;
