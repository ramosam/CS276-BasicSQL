
-- Week 8 Functions

-- 2
set serveroutput on;

create or replace function purchaser_state(purchaser_id_in in number) return varchar2
  is
  v_state varchar2(2);
  begin
    select state_code into v_state
      from purchaser
      where purchaser_id = purchaser_id_in;
      
    return v_state;
  end;
  
declare
  c_state varchar2(2);
begin
  c_state := purchaser_state(30);
  dbms_output.put_line('Customer state is: '|| c_state);
end;


-- 3
create or replace function state_tax_code(state_code_in varchar2) 
  return tax_codes.tax_rate%type
  is
  v_tax_code tax_codes.tax_rate%type;
  begin
    select tax_codes.tax_rate into v_tax_code
      from tax_codes
      where tax_codes.state_code = state_code_in;
    return v_tax_code;
  end;
  
declare
  c_tax_code tax_codes.tax_rate%type;
begin
  c_tax_code := state_tax_code('AZ');
  dbms_output.put_line('Customer tax is: '|| c_tax_code);
end;  


-- 4
create or replace function total_cust_cost(purchaser_id_in in number, 
                                            product_id_in in number, 
                                            quantity_in in number)
  return number
  is
    v_total_cost number := 0;
    c_tax_rate tax_codes.tax_rate%type;
    c_state varchar2(2);
    v_prod_price number := 0;
    v_prod_cost number := 0;
  begin
    c_state := purchaser_state(purchaser_id_in);
    c_tax_rate := state_tax_code(c_state);
    select product_price into v_prod_price
      from product
      where product_id = product_id_in; 
    v_prod_cost := v_prod_price * quantity_in * (1 + c_tax_rate);
    return v_prod_cost;
  end;
  
declare 
  c_cost number;
begin
  c_cost := total_cust_cost(30, 400, 4);
  dbms_output.put_line('Customer total is: '|| TO_CHAR(c_cost,'$99,999.99'));
end;
  
  
  
create or replace procedure update_purchaser_purchased(purchaser_id_in in number, 
                                            product_id_in in number, 
                                            quantity_in in number)
  is
    v_first_name purchaser.purchaser_first_name%type;
    v_last_name purchaser.purchaser_last_name%type;
    v_prod_name product.product_name%type;
    c_cost number := 0;
  begin
  -- update quantity
    update product set product_amount = product_amount - quantity_in
      where product_id = product_id_in;
  -- get purchaser name
    select purchaser_first_name, purchaser.purchaser_last_name into 
      v_first_name, v_last_name
      from purchaser where
      purchaser_id = purchaser_id_in;
  -- get product name
    select product_name into v_prod_name
      from product
      where product_id = product_id_in;
  -- get purchaser cost
    c_cost := total_cust_cost(purchaser_id_in, product_id_in, quantity_in);
  -- display results
    dbms_output.put_line('Customer: '||v_first_name ||' '|| v_last_name
      ||' purchased '|| quantity_in ||' of '|| v_prod_name ||' for '||
      TO_CHAR(c_cost,'$99,999.99'));
  null;
  end;

  -- before
 select * from product where product_id = 400;

exec  update_purchaser_purchased(30, 400, 4);
  -- after
 select * from product where product_id = 400; 
 
 