select * from vendor;


drop table max_vendor;

create table max_vendor
(
vendor_id number primary key,
max_amount decimal(10,2));



/*(
select the highest amount of products sold (sum(price) based on vendor);
)
*/


-- number of products sold
--highest product sold per vendor


insert into max_vendor (vendor_id, max_amount) 
select vendor.v_code, sum(p_price)
from product
join vendor
on product.v_code = vendor.v_code
group by vendor.v_code;


/*
update the product price of Latex, Exterior (MPI Gloss Level 2) to the maximum price of any product * 1.2

update agent
set commission = commission + 0.02
where 2>= (select count(cust_code) from  customer where
customer.agent_code = agent.agent_code

*/

select max(lgp.prod_price) * 1.2
from lgproduct lgp;

select prod_sku from lgproduct
where prod_descript = 'Latex, Exterior (MPI Gloss Level 2)';

update lgproduct
set prod_price = (select max(lgp.prod_price) * 1.2 from lgproduct lgp)
where prod_descript = 'Latex, Exterior (MPI Gloss Level 2)';





delete from lgproduct
where brand_id = (select brand_id from lgbrand where brand_name = 'BINDER PRIME');


create table empnametable as (select emp_fname, emp_lname, dept_name 
from lgemployee 
join lgdepartment 
on lgemployee.dept_num = lgdepartment.dept_num);


select count(*)
from lgemployee;









