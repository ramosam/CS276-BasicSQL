set serveroutput on;

create or replace procedure calc_commission
  (sales_amount_in IN number, commission OUT number)
  IS
    v_commission number(10,2) := 0;
    exception_name Exception;
  begin
    v_commission := sales_amount_in * 0.1;
    commission := v_commission;
  end;
