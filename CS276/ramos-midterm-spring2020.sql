/*
Ramos - Midterm Spring 2020
--------------------------------
1.	Take a look at the type of data in the Midterm Pledge Schema sql script file
in Moodle to become familiar with the data. You do not need to read any tables
from the database for this question. 

a.	 Create a stored procedure that determines and returns in an OUT parameter 
the monthly payment amount for a pledge based on a “Total Pledge Amount” passed
to the procedure as an IN parameter. See the table below. For example if the 
total pledge amount is $240, the procedure should return $80 as the monthly 
payment since 240/3 is 80. Test your code with a donor pledge of $480.00. You 
should output both the pledge amount and the monthly payment amount expected.

b.	Make sure your procedure uses a programmer-defined exception to handle the 
exception of a pledge amount less than $1.00. Just output an informative message
to handle the exception. 

c.	Remember all programming code should be placed in the script file that you 
upload to Moodle

Total Pledge Amount	Number of Months	Monthly Payment
From 1 to $250	3	The Program
Over $250 to $500	6	Must Calculate
Over $500 to $750	9	These
Over $750	12	Values


*/
set serveroutput on;
set feedback on;

create or replace procedure calc_pledge_payment(pledge_amount_in in number, payment_amount out number)
  is
  INVALID_PLEDGE_AMOUNT EXCEPTION;
  pragma exception_init (INVALID_PLEDGE_AMOUNT, -20001);
  v_payment_amount number(8,2) := 0;
  
  begin
    case 
      when pledge_amount_in > 750 then
        v_payment_amount := pledge_amount_in / 12;
      when pledge_amount_in > 500 then
        v_payment_amount := pledge_amount_in / 9;
      when pledge_amount_in > 250 then
        v_payment_amount := pledge_amount_in / 6;
      when pledge_amount_in >= 1 then
        v_payment_amount := pledge_amount_in / 3;
      else raise INVALID_PLEDGE_AMOUNT;
    end case;
    payment_amount := v_payment_amount;
  exception
    when INVALID_PLEDGE_AMOUNT then
      dbms_output.put_line('This is an invalid pledge amount.');
  end calc_pledge_payment;
  
-- Test procedure
declare
  my_payment number(8,2) := 0;
begin
  calc_pledge_payment(480.00, my_payment);
  dbms_output.put_line('My payment for $480.00 is: '|| my_payment);
  calc_pledge_payment(240.00, my_payment);
  dbms_output.put_line('My payment for $240.00 is: '|| my_payment);
  calc_pledge_payment(800.00, my_payment);
  dbms_output.put_line('My payment for $800.00 is: '|| my_payment);
  calc_pledge_payment(0.00, my_payment);
  dbms_output.put_line('My payment for $0.00 is: '|| my_payment);
end;


/*
2.	Examine the tables and their fields in the Midterm Pledge Schema sql script
file in Moodle. Take a good look at the PLEDGE table.

a.	Create a stored procedure with incoming parameters to double the pledge
amount stored for a donor on a given pledge date. Use IDDONOR = 309 and 
PLEDGEDATE of ’08-OCT-2012’. Pass in the donor ID and date as parameters to the
procedure. The procedure should execute an UPDATE to alter the appropriate pledge
amount. Remember all programming code should be placed in the script file that
you upload to Moodle.

b.	Now add an exception handler for a no data found error that outputs a message
that no data was found. Test the exception handler with iddonor = 400.

c.	Now write a SELECT statement to verify that your PL/SQL code changed the
pledge amount. This SELECT statement doesn’t need to be part of a PL/SQL block.

*/

create or replace procedure update_double_donor_pledge(donor_id_in in pledge.iddonor%type, pledge_date_in in pledge.pledgedate%type)
  is
  
  NO_DATA_FOUND EXCEPTION;
  pragma exception_init (NO_DATA_FOUND, -20001);
  v_count number := 0;
  begin
    select count(*) into v_count from pledge where iddonor = donor_id_in;
    if v_count = 0
      then raise NO_DATA_FOUND;
    end if;
    update pledge set pledgeamt = pledgeamt * 2
    where pledge.iddonor = donor_id_in and pledge.pledgedate = pledge_date_in;

  exception
    when NO_DATA_FOUND then
      dbms_output.put_line('There was no data found for this id and date.');
  end update_double_donor_pledge;
  
  
-- Test the procedure


  exec update_double_donor_pledge(309, '08-OCT-12');
  select * from pledge where iddonor = 309 and pledgedate = '08-Oct-12';
  exec update_double_donor_pledge(400, '08-OCT-12');


/*
3.	Examine the tables and fields in the Pledge database. Take a good look at 
PLEDGE and PAYMENT tables.

a.	Write a stored procedure that returns, in an OUT parameter, the count of 
payments by a specific donor and the total of those payments. Test the procedure
using iddonor = 302 for this exercise.

b.	Now add an exception handler for a no data found error that outputs a message
that no data was found. Test the exception handler with iddonor = 400.

c.	Remember all programming code should be placed in the script file that you 
upload to Moodle.

*/

create or replace procedure calc_num_payments_total_pledge_amt(donor_id_in IN number, num_pay_out OUT number, total_pledge_out OUT number)
  is
  v_num_pay number(4,0) := 0;
  v_total_pledge number(8,2) := 0;
  
  NO_DATA_FOUND exception;
  pragma exception_init (NO_DATA_FOUND, -20001);
  
  begin
    select count(*) into v_num_pay
    from pledge 
    join payment on pledge.idpledge = payment.idpledge
    where pledge.iddonor = donor_id_in;   
    
    if v_num_pay > 0 then
      select sum(payment.payamt) into v_total_pledge from payment
      join pledge on pledge.idpledge = payment.idpledge
      where pledge.iddonor = donor_id_in;
    else
      raise NO_DATA_FOUND;
    end if;
    num_pay_out := v_num_pay;
    total_pledge_out := v_total_pledge;

  exception
    when no_data_found then
      dbms_output.put_line('There was no data found for this donor id.');
    
  end calc_num_payments_total_pledge_amt;
  
  
declare
  num_payments number := 0;
  total_pledge number(8,2) := 0;
begin
  calc_num_payments_total_pledge_amt(302, num_payments, total_pledge);
  dbms_output.put_line('Donor 302 has paid '|| num_payments ||' payments for a total of '|| total_pledge);
  calc_num_payments_total_pledge_amt(400, num_payments, total_pledge);
  dbms_output.put_line('Donor 400 has paid '|| num_payments ||' payments for a total of '|| total_pledge);
end;


/*
4.	Start by examining the PLEDGE and STATUS tables. Use an explicit cursor to
get the following information about all pledges, the ID of the pledge, its pledge
amount and the status description for that pledge. Use a loop to output this
information for all 13 pledges.  You can write an anonymous block or a stored 
procedure. You don’t need to add any exception handling in this exericise.
Remember all programming code should be placed in the script file that you upload
to Moodle.
*/

declare
  cursor pledge_info_cur 
    is
    select pledge.idpledge, pledge.pledgeamt, status.statusdesc 
    from pledge
    join status on status.idstatus = pledge.idstatus;
  pledge_info_rt pledge_info_cur%rowtype;
begin
  dbms_output.put_line(' Pledge ID '||chr(9)||chr(9)||chr(9)||' Pledge AMT '||
  chr(9)||chr(9)||' Description ');
  dbms_output.put_line('------------------------------------------------');
  open pledge_info_cur;
  loop
    fetch pledge_info_cur into pledge_info_rt;
      exit when pledge_info_cur%notfound;
      dbms_output.put_line(chr(9)||pledge_info_rt.idpledge||
      chr(9)||chr(9)||chr(9)||
      to_char(pledge_info_rt.pledgeamt, '$999G999G999D99')||
      chr(9)||chr(9)||chr(9)||chr(9)||
      pledge_info_rt.statusdesc);
  end loop;
  close pledge_info_cur;
end;
