set serveroutput on;


create table person (
  person_id pls_integer primary_key,
  f_name varchar2(20) not null,
  l_name varchar2(20) not null,
  m_i_name varchr2(1) not null
);

declare
  type person_rec is record
  (
    person_id pls_integer, --could also use %type
    f_name varchar2(20), --%type
    l_name varchar2(20), --%type
    m_i_name varchar2(1) --%type
  );
  -- implicit record
  a_person person_rec;
begin
  -- initalize field values
  a_person.person_id := 100;
  a_person.f_name := 'Pamela';
  a_person.l_name := 'Farr';
  a_person.m_i_name := 'M';
  -- insert record into table
  insert into person
    values person_rec;
end;
