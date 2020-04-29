set serveroutput on;
set feedback on;


create or replace procedure calc_commission
  (sales_amount_in IN number, commission_rate IN number, commission OUT number)
IS
  v_commission number(10,2) := 0;
  v_commission_rate number(10,2) := 0;
  
  negative_balance_exception EXCEPTION;
  pragma exception_init (negative_balance_exception, -20003);
  no_sales_exception EXCEPTION;
  pragma exception_init (no_sales_exception, -20002);
  commission_rate_exception EXCEPTION;
  pragma exception_init (commission_rate_exception, -20001);
  
begin
  if sales_amount_in = 0 OR sales_amount_in IS NULL then
    v_commission := 0;
    v_commission_rate := 0;
    commission := v_commission;
    RAISE_APPLICATION_ERROR(-20003, 'There were no sales found. Please check for errors.');
  elsif sales_amount_in < 0 then
    v_commission := 0;
    v_commission_rate := 0;
    commission := v_commission;
    RAISE_Application_Error(-20002, 'The balance is negative. Please check for errors.');
  elsif commission_rate < 0 then
    v_commission := 0;
    v_commission_rate := 0;
    commission := v_commission;
    RAISE_APPLICATION_ERROR(-20001, 'The commission rate was negative. Please check for errors.');
  else
    v_commission_rate := commission_rate / 100;
    v_commission := sales_amount_in * v_commission_rate;
    commission := v_commission;
  end if;
EXCEPTION
  when negative_balance_exception then
    dbms_output.put_line('The balance is negative.');
    dbms_output.put_line(sqlcode || ' ' || sqlerrm);
  when no_sales_exception then
    dbms_output.put_line('There were no sales found.');
    dbms_output.put_line(sqlcode || ' ' || sqlerrm);
  when commission_rate_exception then
    dbms_output.put_line('The commission rate was negative!');
    dbms_output.put_line(sqlcode || ' ' || sqlerrm);
    
end calc_commission;

-- Complex test cases
declare
  l_commission_earned number(10,2);
begin
  dbms_output.put_line('Test expected good values: 100, 10.');
  calc_commission(100, 10, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  dbms_output.put_line('--------------------------');
  dbms_output.put_line('');
  
  dbms_output.put_line('Test null sale value, 10 commision value.');
  calc_commission(null, 10, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  dbms_output.put_line('--------------------------');
  dbms_output.put_line('');
  
  dbms_output.put_line('Test negative sale value, 10 commission value');
  calc_commission(-100, 10, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  dbms_output.put_line('--------------------------');
  dbms_output.put_line('');
  
  dbms_output.put_line('Test zero sale value, 10 commission value.');
  calc_commission(0, 10, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  dbms_output.put_line('--------------------------');
  dbms_output.put_line('');
  
  dbms_output.put_line('Test 100 sale value, 0 commission value.');
  calc_commission(100, 0, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  dbms_output.put_line('--------------------------');
  dbms_output.put_line('');
  
  dbms_output.put_line('Test 100 sale value, -10 commission value.');
  calc_commission(100, -10, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
  dbms_output.put_line('--------------------------');
  dbms_output.put_line('');
  
end;
