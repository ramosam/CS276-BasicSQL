set serveroutput on;
set feedback on;

-- row level trigger that will put out a warning message
create or replace trigger update_employee_salary
-- any time there is an update on the employee_salary column in the employee table
before update of employee_salary on employee
for each row
begin
  dbms_output.put_line('WARNING: There was a change to an employee''s salary.');
  dbms_output.put_line('EmployeeID: '|| :old.employee_id);
  dbms_output.put_line('Employee name: '|| :old.employee_first ||' '|| :old.employee_last);
  dbms_output.put_line('Old salary: '|| :old.employee_salary);
  dbms_output.put_line('NEW salary: '|| :new.employee_salary);
end;

-- Make an update statement to test on employee id 3.
update employee
  set employee_salary = employee_salary + 1000000
  where employee_id = 3;
  
  
  
-- row level trigger to raise application error to prevent 
-- insertion of a row if the customer credit rating is below 5.
create or replace trigger no_credit_for_bad_customer_rating
before insert on customer
for each row
begin
  if :new.customer_credit_rating < 5 then
    RAISE_APPLICATION_ERROR(-20000, 'Customer ' || :new.customer_first || 
    ' '|| :new.customer_last ||' with credit rating of '|| :new.customer_credit_rating
    ||' could not be added. Customer credit rating should be above a 5.');
  end if; 
end;

insert into customer (customer_id, CUSTOMER_FIRST, CUSTOMER_LAST, customer_credit_rating) 
  values (7, 'Tom', 'Jerry', 1);
  

--create a row level trigger that will insert a row into the purchase_audit table
-- any time a record is updated or inserted into the purchase table. Needs username
-- of who performed the task. Test twice, once with insert and once with update.
create or replace trigger record_purchase_audit_log
after insert or update on purchase
for each row
begin
  if inserting then
    dbms_output.put_line('An insert was performed.');
    insert into purchase_audit (purchase_id, customer_id, purchase_date, 
      total_purchase_price, who_did_this) values (:new.purchase_id, :new.customer_id,
      :new.purchase_date, :new.total_purchase_price, ora_login_user);
  elsif updating then
    dbms_output.put_line('An update was performed.');
    update purchase_audit set purchase_date = :new.purchase_date, 
      total_purchase_price = :new.total_purchase_price, who_did_this = ora_login_user
      where purchase_id = :old.purchase_id and customer_id = :old.customer_id;
  end if;
end;

delete from purchase where purchase_id = 1;
delete from purchase_audit where purchase_id = 1;

insert into purchase (purchase_id, customer_id, purchase_date, 
    total_purchase_price) values (1, 1, systimestamp, 10);

update purchase set total_purchase_price = 9 where purchase_id = 1 and customer_id = 1;