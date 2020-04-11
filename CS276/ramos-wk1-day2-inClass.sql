set serveroutput on;

declare
  v_first_name varchar2(12) := 'Loren';
  v_last_name varchar2(12) := 'Johnson';
begin
  DBMS_OUTPUT.PUT_LINE(substr(V_FIRST_NAME, 3, 3));
END;
  
-- get starting index (position) of a string
declare
  v_first_name varchar2(12) := 'Loren';
  v_last_name varchar2(12) := 'Johnson';
begin
  DBMS_OUTPUT.PUT_LINE(instr(V_FIRST_NAME, 'Lo'));
  DBMS_OUTPUT.PUT_LINE(instr(V_LAST_NAME, 'son'));
END;

create table pet
(
full_pet_name varchar2(25),
pet_owner_name varchar2(25)
);

declare
  v_full_pet_name varchar2(12); -- not the same as the column designation
  v_first_pet_name varchar(12);
  v_last_pet_name varchar2(12);
begin
  insert into pet values ('Dandelion Johnson', 'Petersen');
  select substr(full_pet_name, 1, 8) into v_full_pet_name from pet;
  
  DBMS_OUTPUT.PUT_LINE(v_full_pet_name);
end;

---------------------------------------------------------
create table people (
  full_name varchar2(50),
  birthdate date
);
insert into people values ('Alicia/Ramos', to_date('11-Apr-2020', 'dd-mm-yyyy'));
select * from people;


declare
  v_first_name varchar2(25);
  v_last_name varchar2(25);
  v_last_name_dup varchar2(25);  
  v_birth_day date;
begin
  select substr(full_name, 1, instr(full_name, '/') - 1) into v_first_name from people;
  select substr(full_name, instr(full_name, '/') + 1) into v_last_name from people;
  select substr(full_name, -(length(full_name) - instr(full_name, '/')), (length(full_name) - instr(full_name, '/'))) 
   into v_last_name_dup from people;
  select last_day(birthdate) into v_birth_day from people;
  dbms_output.put_line('My name is '|| v_first_name ||' '|| v_last_name ||'.');
  dbms_output.put_line('My duplicated name is '|| v_first_name ||' '|| v_last_name_dup ||'.');
  dbms_output.put_line('First name length: '|| length(V_FIRST_NAME) ||' Last name length: '|| length(V_LAST_NAME));
  dbms_output.put_line('Last day of the month of date: '|| last_day(v_birth_day));
end;