--  LAB 5 --

-- Having is a sub clause of GROUP - this is NOT a where clause

/*
  If I have to compare the amounts of the group by, then you have to use having.
  
select vendor code, product name, and cost
aggregate the total cost of products by vendor
sleect only the rows of the result set cost(qoh * price) > 500
list results in descending order by total cost

from product

*/

Select student_name
from Student
Where student_name = 'Tyler Ritter' 
  OR student_name = 'Krista DeStasio' 
  OR student_name = 'Alicia Ramos';




select vendor.v_code, product.p_descript, sum(product.p_qoh * product.p_price) as Cost
from vendor
join product 
on product.v_code = vendor.v_code
group by vendor.v_code, product.p_descript
having sum(product.p_qoh * product.p_price) > 500
order by sum(product.p_qoh * product.p_price) desc;




