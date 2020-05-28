--Set up a table of SHOPPER, one column of which is a nested
--table of products (via product code) that have been placed
--in their grocery cart. You’ll want to create a TYPE for the
--collection first.
--? Write a Function that will take in a product code and return
--a Boolean value of true if that product code is in that nested
--table column. Otherwise it returns false.
--? Upload screen shot of all your code and the results of two
--tests of the function. One should test the true case and one
--should test the false case.

set serveroutput on;

drop table shoppers cascade constraints;
drop table shoppers_product_t cascade constraints;
-- Creating a type for the collection
create or replace type product_nest_t is table of varchar2(50);

-- Create table with nested table value
create table shoppers
(
  shopper_id number(10) primary key,
  prod_table product_nest_t
)
nested table prod_table store as shopper_product_t;

insert into shoppers (shopper_id, prod_table) 
  values (100, product_nest_t('T-shirt', 'Yo-yo', 'Slinky', 'Sunglasses'));
insert into shoppers (shopper_id, prod_table) 
  values (101, product_nest_t('Hatchet', 'Yo-yo', 'Backpack', 'Snacks'));


create or replace function count_specific_product(product_code_in in varchar2, shopper_id_in in number) 
  return boolean
  is 
    -- declare variables to work with set base values
    v_bought_prod boolean := false;
    v_count_bought number(4) := 0;
  begin
    -- get count of specific product_id by shopper_id
    --save count of product in shopper's table
    select count(product_code_in) into v_count_bought
    --select everything from shoppers and their tables
    from shoppers s, table(s.prod_table)
    -- filter on product and shopper
    where column_value = product_code_in 
      AND s.shopper_id = shopper_id_in;
      
    --Check if the count is above 0.
    if v_count_bought > 0 then
      v_bought_prod := true;
    end if;
    return v_bought_prod;
  end;
  
  
begin
  if count_specific_product('Yo-yo', 100) then
    dbms_output.put_line('This shopper bought a yo-yo.');
  else
    dbms_output.put_line('This shopper did not buy a yo-yo.');
  end if;
    if count_specific_product('Snacks', 100) then
    dbms_output.put_line('This shopper bought snacks.');
  else
    dbms_output.put_line('This shopper did not buy snacks.');
  end if;
  
end;
    