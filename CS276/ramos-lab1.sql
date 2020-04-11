set serveroutput on;
-- 1
declare
  test_date date;
  test_number number(8,2);
  test_name varchar2(25);
begin
  test_date := to_date('11-APR-20', 'dd-mm-yy');
  test_number := 61;
  test_name := 'Super Secret';
  dbms_output.put_line('Test Date: '|| test_date);
  dbms_output.put_line('Test Number: '|| test_number);
  dbms_output.put_line('Test Name: '|| test_name);
end;
-- 2 in document
-- 3
select sysdate from dual;
-- 4
DECLARE
   	current_block	varchar2(10)  	:= 'OUTER';
	outer_block	varchar2(10)	:= 'OUTER';

BEGIN
	dbms_output.put_line ('[current_block]['||current_block||']');

	DECLARE
		current_block	varchar2(10)	:= 'INNER';
	BEGIN
		dbms_output.put_line('[current_block]['||current_block||']');
		dbms_output.put_line('[outer_block]['||outer_block||']');
	END;

	dbms_output.put_line ('[current_block]['||current_block||']');
END;

-- 5
declare
  v_length NUMBER(8,2);
  v_width NUMBER(8,2);
begin
  v_length := 7;
  v_width := 5;
  dbms_output.put_line('The length is: '|| v_length);
  dbms_output.put_line('The width is: '|| v_width);
  dbms_output.put_line('The area of the rectangle is: '|| v_length * v_width);
end;


-- 6
create table people (
  first_name varchar2(30),
  last_name varchar2(30),
  favorite_color varchar2(30)
);

insert into people values ('Jaina',	'Proudmoore', 'Sea Green');
insert into people values ('Taelia', 'Fordragon', 'Emerald');
insert into people values ('Carol', 'Danvers', 'Gunmetal Gray');

declare
  v_first_three_of_first_name varchar2(3);
  v_after_three_of_last_name varchar2(15);
  v_plain_color varchar2(15);
begin
  select substr(first_name, 1, 3) into v_first_three_of_first_name from people where FIRST_NAME = 'Jaina';
  select substr(last_name, 4) into v_after_three_of_last_name from people where last_name = 'Fordragon';
  select substr(favorite_color, (instr(favorite_color, ' ') + 1)) into v_plain_color from people where first_name = 'Carol';
  dbms_output.put_line('First three of Jaina are: '|| V_FIRST_THREE_OF_FIRST_NAME);
  dbms_output.put_line('After three characters of Fordragon are: '|| V_AFTER_THREE_OF_LAST_NAME);
  dbms_output.put_line('A plain color is: '|| V_PLAIN_COLOR);
end;
