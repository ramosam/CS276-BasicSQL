set serveroutput on;

-- Simple version first
create or replace procedure calc_commission
  (sales_amount_in IN number, commission OUT number)
IS
  v_commission number(10,2) := 0;
begin
  v_commission := sales_amount_in * 0.1;
  commission := v_commission;
end calc_commission;
-- Simple anonymous test
declare
  l_commission_earned number(10,2);
begin
  calc_commission(100, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
end;

-- Complex version
create or replace procedure calc_commission
  (sales_amount_in IN number, commission OUT number)
IS
  v_commission number(10,2) := 0;
  negative_balance EXCEPTION;
  no_sales_exception EXCEPTION;
begin
  if sales_amount_in = 0 OR sales_amount_in IS NULL then
    v_commission := 0;
    commission := v_commission;
    RAISE no_sales_exception;
  elsif sales_amount_in < 0 then
    v_commission := 0;
    commission := v_commission;
    RAISE negative_balance;
  else
    v_commission := sales_amount_in * 0.1;
    commission := v_commission;
  end if;
EXCEPTION
  when negative_balance then
    dbms_output.put_line('The balance is negative.');
  when no_sales_exception then
    dbms_output.put_line('There were no sales found.');
    
end calc_commission;

-- Complex test cases
declare
  l_commission_earned number(10,2);
begin
  dbms_output.put_line('Test expected good value.');
  calc_commission(100, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  
  dbms_output.put_line('Test null value.');
  calc_commission(null, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  
  dbms_output.put_line('Test negative value.');
  calc_commission(-100, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  
  dbms_output.put_line('Test zero value.');
  calc_commission(0, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  
end;
