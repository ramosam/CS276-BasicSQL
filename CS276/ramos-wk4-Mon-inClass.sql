set serveroutput on;

create or replace procedure calc_commission
  (sales_amount_in IN number, commission OUT number)
IS
  v_commission number(10,2) := 0;
  negative_balance EXCEPTION;
  no_sales_exception EXCEPTION;
begin
  v_commission := sales_amount_in * 0.1;
  commission := v_commission;
EXCEPTION
  when negative_balance then
    dbms_output.put_line('The balance is negative.');
  when no_sales_exception then
    dbms_output.put_line('There were no sales found.');
end calc_commission;


declare
  l_commission_earned number(10,2)
begin
  calc_commission(100, l_commission_earned); -- Calling the procedure
  dbms_output.put_line('Commission earned is: '|| l_commission_earned);
end;
