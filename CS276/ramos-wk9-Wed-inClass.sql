set serveroutput on;
set feedback on;

create or replace trigger database_has_changed
  after create on schema
  begin
    dbms_output.put_line('You are trying to modify the database.');
    if ora_dict_obj_type = 'TABLE' then
      dbms_output.put_line('A table was created. Create '|| ora_dict_obj_type 
      ||' '|| ora_dict_obj_name ||' was created by '|| ora_dict_obj_owner 
      ||'.');
    end if;
  end;
  
create table superhero (
  superhero_id number primary key,
  superhero_name varchar2(100),
  superhero_alias varchar2(200)
);

drop table superhero;

alter trigger database_has_changed disable;