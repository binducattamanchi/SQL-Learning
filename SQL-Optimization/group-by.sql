/* Always "GROUP BY" by the attribute/column with the
largest number of unique entities/values*/

select
main_category,
sub_category,
itemid,
sum(price)
from
table1
group by
main_category, sub_category, itemid

VS

select
main_category,
sub_category,
itemid,
sum(price)
from
table1
group by
itemid, sub_category, main_category
