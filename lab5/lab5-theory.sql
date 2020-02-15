--  LAB 5 --
-- Nulls are not included in aggregate counts

-- the only time you don't have to use group by is when you include other values
-- (just the aggregate)
-- select product.v_code, vendor.v_name, avg(p_price)
-- from product
-- join vendor on product.v_code = vendor.v_code
-- group by product.v_code, vendor.v_name
-- having avg(p_price) < 10;

-- The standard is to put the aggregates at the end of the list.
-- the group by is just a series of buckets to use in order to perform the calculation.
-- grouping by the categories that have been defined prior.

-- Having is a sub clause of GROUP - this is NOT a where clause

/*
  If I have to compare the amounts of the group by, then you have to use having.
  
select vendor code, product name, and cost
aggregate the total cost of products by vendor
sleect only the rows of the result set cost(qoh * price) > 500
list results in descending order by total cost

from product

*/




-- In Class exercise

select vendor.v_code, product.p_descript, sum(product.p_qoh * product.p_price) as Cost
from vendor
join product 
on product.v_code = vendor.v_code
group by vendor.v_code, product.p_descript
having sum(product.p_qoh * product.p_price) > 500
order by sum(product.p_qoh * product.p_price) desc;




















