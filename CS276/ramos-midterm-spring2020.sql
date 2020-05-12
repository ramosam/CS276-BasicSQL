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


