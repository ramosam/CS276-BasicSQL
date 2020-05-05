set serveroutput on;

declare
  type person_rec is record
  (
    person_id pls_integer,
    f_name varchar2(20),
    l_name varchar2(20),
    m_i_name varchar2(1)
  );
  a_person person_rec;
begin
  a_person.person_id := 100;
  a_person.f_name := 'Pamela';
  a_person.l_name := 'Farr';
  a_person.m_i_name := 'M';

  insert into person
    values person_rec;
end;
