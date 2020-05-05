set serveroutput on;

drop table person cascade constraints;
create table person (
  person_id number primary key,
  f_name varchar2(20) not null,
  l_name varchar2(20) not null,
  m_i_name varchar2(1) not null
);

declare
  type person_rec is record
  (
    person_id number, --could also use %type
    f_name varchar2(20), --%type
    l_name varchar2(20), --%type
    m_i_name varchar2(1) --%type
  );
  -- implicit record
  a_person person%rowtype; --person_rec
begin
  -- initalize field values
  a_person.person_id := 100;
  a_person.f_name := 'Teddy';
  a_person.l_name := 'Bear';
  a_person.m_i_name := 'M';
  -- insert record into table
  insert into person
    values a_person;
end;


select * from person where l_name = 'Bear';
commit;