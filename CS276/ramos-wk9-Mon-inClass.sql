set serveroutput on;

-- Week 9 Triggers
create or replace trigger update_employee_salary
-- any time there is an update on the employee_salary column in the employee table
before update of employee_salary on employee
for each row
begin
  dbms_output.put_line('EmployeeID: '|| :old.employee_id);
  dbms_output.put_line('First name: '|| :old.employee_first);
  dbms_output.put_line('Last name: '|| :old.employee_last);
  dbms_output.put_line('Old salary: '|| :old.employee_salary);
  dbms_output.put_line('NEW salary: '|| :new.employee_salary);
end;

-- Make an updte statement to test on employee id 3.
update employee
  set employee_salary = employee_salary + 10000
  where employee_id = 3;
  
select * from employee;  
  
-- rolling back changes
rollback;

-- update all the employee salaries by 3% to test multiple row updates
update employee
  set employee_salary = employee_salary * 1.03; --103%, 3% increase
  

