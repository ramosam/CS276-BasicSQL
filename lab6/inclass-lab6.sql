-- brand type does not = premium

/*
83630
*/


select emp_fname, emp_lname, min(LGS.sal_amount)
from lgemployee LGE,
(select min(sal_from), emp_num, sal_amount
  from lgsalary_history group by emp_num, sal_amount) LGS
where LGE.emp_num = LGS.emp_num
group by emp_fname, emp_lname;




/*
grab the firstname, lastname, and salary of every employee based on their hire date
-- where hire date = 




Write a query to display the brand name, brand type, product SKU, 
product description, and price of any products that are not a premium brand,
but that cost more than the most expensive premium brand products.  

	-BRAND_TYPE != ‘PREMIUM’

*/

--
select brand_name, brand_type 
from lgbrand b;
select count(*)
from lgbrand;

--
select prod_sku, prod_descript, prod_price 
from lgproduct p;
select count(*)
from lgproduct;

-- Everything, by brand_id
select brand_name, brand_type, prod_sku, prod_descript, prod_price
from lgbrand b
join lgproduct p on p.brand_id = b.brand_id;
select count(*)
from lgbrand b
join lgproduct p on p.brand_id = b.brand_id;

-- Everything, by brand_id where type != premium
select brand_name, brand_type, prod_sku, prod_descript, prod_price
from lgbrand b
join lgproduct p on p.brand_id = b.brand_id
where brand_type != 'PREMIUM';

select count(*)
from lgbrand b
join lgproduct p on p.brand_id = b.brand_id
where brand_type != 'PREMIUM';

-- What is the most expensive premium product?

select prod_sku, brand_name, b.brand_type, prod_price, prod_descript
from lgbrand b
join lgproduct p on p.brand_id = b.brand_id
where prod_price > 
--find max prod_price that is a premium product
  (select max(prod_price) 
    from lgproduct lgp 
    join lgbrand lgb on lgb.brand_id = lgp.brand_id 
    where lgb.brand_type = 'PREMIUM'
    )
    AND
    (b.brand_type != 'PREMIUM')
    ;





























