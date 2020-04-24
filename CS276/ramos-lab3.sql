set serveroutput on;
set feedback on;

declare
  cursor charges_cur is
    select charge_id, customer_id, order_id, last_payment_date, current_balance
    from charges;
    
begin
  for charges_rec in charges_cur
  loop
    case
      when (trunc(sysdate) - last_payment_date) < 30 then
        dbmc_output.put_line('something less than 30 days.');
    end case;
  end loop;
end;


