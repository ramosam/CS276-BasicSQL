select price_in_us_dollars
from product
where product_name = 'Cashmere Sweater';

--What is the price of the flowing skirt in Cancun?  
select p.price_in_us_dollars * c.us_dollars_to_currency_ratio as Cancun_converted_cost
from product p
join sells s on s.product_id = p.product_id
join store_location sl on sl.store_location_id = s.store_location_id
join currency c on c.currency_id = sl.currency_accepted_id
where p.product_name = 'Flowing Skirt' and sl.store_name = 'Cancun Extension';


select p.price_in_us_dollars
from product p
where p.product_name = 'Flowing Skirt';

(select c.us_dollars_to_currency_ratio 
from currency c 
join store_location sl on sl.currency_accepted_id = c.currency_id
where sl.store_name = 'Cancun Extension');

-- Alternate using subqueries
select p.price_in_us_dollars * 
  (select c.us_dollars_to_currency_ratio 
  from currency c 
  join store_location sl on sl.currency_accepted_id = c.currency_id
  where sl.store_name = 'Cancun Extension') as converted_cost
from product p
where p.product_name = 'Flowing Skirt';

--question 5 and proof of concept
drop table TestMyValueColumn;

create table TestMyValueColumn (
Tester Number(2,2) not null
);

insert into TestMyValueColumn values (14);
insert into TestMyValueColumn values (0.92);
insert into TestMyValueColumn values (14.92);


select to_char(10500.37, '$00,000.00')
from dual;


-- 16 
select to_char(p.price_in_us_dollars * 
  (select c.us_dollars_to_currency_ratio 
  from currency c 
  join store_location sl on sl.currency_accepted_id = c.currency_id
  where sl.store_name = 'Cancun Extension'), 'FML999,999.00', ' NLS_CURRENCY=Mex$') as peso_converted_cost
from product p
where p.product_name = 'Flowing Skirt';


select product_name, to_char(price_in_us_dollars * 
(select us_dollars_to_currency_ratio
from currency
where currency_name = 'Mexican Peso'),
'FML999,999.00', 'NLS_CURRENCY=Mex$') as price_in_pesos
FROM product
where price_in_us_dollars *
  (select us_dollars_to_currency_ratio
  from currency
  where currency_name = 'Mexican Peso') < 2750;
  
  
  
--18
select product_name, to_char(price_in_us_dollars * 
(select us_dollars_to_currency_ratio
from currency
where currency_name = 'Canadian Dollar'),
'FML999,999.00', 'NLS_CURRENCY=CAN$') as price_in_CanadaDollar
FROM product
where (price_in_us_dollars *
  (select us_dollars_to_currency_ratio
  from currency
  where currency_name = 'Canadian Dollar') < 150) 
  OR
  (price_in_us_dollars *
  (select us_dollars_to_currency_ratio
  from currency
  where currency_name = 'Canadian Dollar') > 300);


--stores with number of offerings > 1
select sl.store_location_id, sl.store_name
from store_location sl
join offers o
on o.STORE_LOCATION_ID = sl.STORE_LOCATION_ID
group by sl.STORE_LOCATION_ID, sl.STORE_NAME
having count(o.PURCHASE_DELIVERY_OFFERING_ID) > 1;

--products and prices by store
select sl.store_name, p.product_name, p.price_in_us_dollars
from store_location sl
join sells s  
  on s.STORE_LOCATION_ID = sl.store_location_id
join product p 
  on p.PRODUCT_ID = s.PRODUCT_ID;


-- put it all together
select sl.store_name, p.product_name, to_char(p.price_in_us_dollars, 'FM$999.00') as price
from store_location sl
join sells s  
  on s.STORE_LOCATION_ID = sl.store_location_id
join product p 
  on p.PRODUCT_ID = s.PRODUCT_ID
where sl.store_location_id in ( 

  select sl.store_location_id
  from store_location sl
  join offers o
    on o.STORE_LOCATION_ID = sl.STORE_LOCATION_ID
  group by sl.STORE_LOCATION_ID, sl.STORE_NAME
  having count(o.PURCHASE_DELIVERY_OFFERING_ID) > 1
);


--20
-- product to purchase
--product must be in all locations
--sizes available for found product

-- get all products in all locations
select p.product_id, p.product_name, sl.STORE_NAME 
from product p 
join sells s on p.PRODUCT_ID = s.PRODUCT_ID
join store_location sl on sl.STORE_LOCATION_ID = s.STORE_LOCATION_ID;

--get count of all stores
select count(*) from store_location;

-- get name of products that are sold in all the stores
select p.product_id, p.product_name, count(s.STORE_LOCATION_ID)
from product p 
join sells s on p.PRODUCT_ID = s.PRODUCT_ID
join store_location sl on sl.STORE_LOCATION_ID = s.STORE_LOCATION_ID
group by p.product_id, p.product_name
having count(s.STORE_LOCATION_ID) = (select count(*) from store_location);

--get sizes of products
select p.product_id, a.sizes_id
from product p 
join available_in a on a.PRODUCT_ID = p.PRODUCT_ID; 


-- putting it all together
select p.product_id, p.product_name, a.sizes_id, sl.STORE_NAME 
from product p 
join sells s on p.PRODUCT_ID = s.PRODUCT_ID
join store_location sl on sl.STORE_LOCATION_ID = s.STORE_LOCATION_ID
join available_in a on a.PRODUCT_ID = p.PRODUCT_ID
where p.PRODUCT_ID in 
    (select p.product_id
    from product p 
    join sells s on p.PRODUCT_ID = s.PRODUCT_ID
    join store_location sl on sl.STORE_LOCATION_ID = s.STORE_LOCATION_ID
    group by p.product_id, p.product_name
    having count(s.STORE_LOCATION_ID) = (select count(*) from store_location))
order by p.PRODUCT_NAME, a.SIZES_ID, sl.STORE_NAME    
;


--22  Moving Where to From
select product.product_id, product.product_name, a.sizes_id, sl.STORE_NAME 
from (select p.product_id, p.product_name
    from product p 
    join sells s on p.PRODUCT_ID = s.PRODUCT_ID
    join store_location sl on sl.STORE_LOCATION_ID = s.STORE_LOCATION_ID
    group by p.product_id, p.product_name
    having count(s.STORE_LOCATION_ID) = (select count(*) from store_location)) product 
join sells s on s.PRODUCT_ID = product.product_id
join store_location sl on sl.STORE_LOCATION_ID = s.STORE_LOCATION_ID
join available_in a on a.PRODUCT_ID = product.PRODUCT_ID
order by product.PRODUCT_NAME, a.SIZES_ID, sl.STORE_NAME    
;

-- 23
-- All products and prices in US Dollars
select store_location.store_name, product.product_name, product.price_in_us_dollars
from store_location
join sells on sells.STORE_LOCATION_ID = store_location.STORE_LOCATION_ID
join product on product.PRODUCT_ID = sells.PRODUCT_ID;

-- requires a location to sell Cashmere sweaters in order to be considered
-- accepts only Cashmere sweater product and retrieving only columns related
-- to the store_location table
select store_location.store_location_id, store_location.store_name
from store_location 
join sells on sells.store_location_id = store_location.STORE_LOCATION_ID
join product on product.PRODUCT_ID = sells.PRODUCT_ID
  -- filters out all the products that are not of interest
  AND product.PRODUCT_NAME = 'Cashmere Sweater';

--** Exists only works in a subquery **--
-- but this query is not what we need
-- This query returns :   Return all products and their prices for all locations
-- if ANY location sells Cashmere Sweaters
select store_location.store_name, product.product_name, product.price_in_us_dollars
from store_location
join sells on sells.STORE_LOCATION_ID = store_location.STORE_LOCATION_ID
join product on product.PRODUCT_ID = sells.PRODUCT_ID
where exists (
  select store_location.store_location_id, store_location.store_name
  from store_location 
  join sells on sells.store_location_id = store_location.STORE_LOCATION_ID
  join product on product.PRODUCT_ID = sells.PRODUCT_ID
    -- filters out all the products that are not of interest
    AND product.PRODUCT_NAME = 'Cashmere Sweater'
);


-- Exists demands a more complex method of combining the queries.
-- The subquery usually must be correlated with the outer query.
-- Correlated subqueries are executed once for each row in the outer query

--Altering the subquery...
select store_location.store_name, product.product_name, product.price_in_us_dollars
from store_location
join sells on sells.STORE_LOCATION_ID = store_location.STORE_LOCATION_ID
join product on product.PRODUCT_ID = sells.PRODUCT_ID
where exists (
  select Cashmere_location.store_location_id, Cashmere_location.store_name
  from store_location Cashmere_location
  join sells on sells.store_location_id = Cashmere_location.STORE_LOCATION_ID
  join product on product.PRODUCT_ID = sells.PRODUCT_ID
    -- filters out all the products that are not of interest
    AND product.PRODUCT_NAME = 'Cashmere Sweater'
    -- Hooks up to the outer query -- forces correlation
    WHERE Cashmere_location.STORE_LOCATION_ID = store_location.STORE_LOCATION_ID
);  -- Now there's no Cancun


-- 25
select p.product_id, p.product_name, a.sizes_id, sl.STORE_NAME 
from product p 
join sells s on p.PRODUCT_ID = s.PRODUCT_ID
join store_location sl on sl.STORE_LOCATION_ID = s.STORE_LOCATION_ID
join available_in a on a.PRODUCT_ID = p.PRODUCT_ID
where exists 
    (select product.product_id
    from product  
    join sells on p.PRODUCT_ID = sells.PRODUCT_ID
    join store_location  on store_location.STORE_LOCATION_ID = sells.STORE_LOCATION_ID
    group by product.product_id, product.product_name
    having count(sells.STORE_LOCATION_ID) = (select count(*) from store_location)
    )
order by p.product_id, a.sizes_id;

    








commit;
