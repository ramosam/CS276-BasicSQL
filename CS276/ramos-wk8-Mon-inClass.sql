set feedback on;
set serveroutput on;

-- using the product table from earlier assignment
create or replace function get_price(p_product_id varchar2) return number
  is
    -- local variable to manipulate
    v_prod_price number(8,2);
  begin
    -- selecting value into variable
    select product_price into v_prod_price
    from product
    where product_id = p_product_id;
    -- return the value to use
    return v_prod_price;
  end;
  
create or replace procedure calc_discount_pct (p_product_id_in IN varchar2, discount_pct_in IN number)
  is
  -- declare variables for use in procedure
  v_discount_price number(8,2);
  v_prod_name product.product_name%type;
  v_prod_id product.product_id%type;
  v_prod_old_price product.product_price%type;
  begin
    -- get original price
    v_prod_old_price := get_price(p_product_id_in);
    -- select into our variables for use
    select product_id, product_name into v_prod_id, v_prod_name
    from product
    where product_id = p_product_id_in;
    -- calculate the discount
    -- the price should be the original price minus the discounted amount to get the new price
    v_discount_price := v_prod_old_price - (discount_pct_in * v_prod_old_price);
    -- output the calculated data
    dbms_output.put_line('Product: '|| v_prod_id ||', '|| v_prod_name ||': Original price: '|| v_prod_old_price
    ||', Discounted price: '|| v_discount_price ||'.');
  end;
  
-- Execute the procedure
exec calc_discount_pct('3', 0.1);