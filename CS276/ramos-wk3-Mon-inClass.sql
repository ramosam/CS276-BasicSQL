set serveroutput on;
set feedback on;

create or replace procedure student_in_class_pt_1 as
  cursor student_cur is
    select student_id, student_first_name, student_last_name, fk_student_type_id
    from student;
    
begin
  for student_rec in student_cur
  loop
    case student_rec.fk_student_type_id
      when 'F' then
        insert into Freshman (student_id, student_first_name, student_last_name)
        values (student_rec.student_id, student_rec.student_first_name, student_rec.student_last_name);
      when 'S' then
        insert into Sophomore (student_id, student_first_name, student_last_name)
        values (student_rec.student_id, student_rec.student_first_name, student_rec.student_last_name);
      when 'J' then
        insert into Junior (student_id, student_first_name, student_last_name)
        values (student_rec.student_id, student_rec.student_first_name, student_rec.student_last_name);
      when 'R' then
        insert into Senior (student_id, student_first_name, student_last_name)
        values (student_rec.student_id, student_rec.student_first_name, student_rec.student_last_name);
      else
        insert into other_level (student_id, student_first_name, student_last_name)
        values (student_rec.student_id, student_rec.student_first_name, student_rec.student_last_name);
    end case;

  end loop;
end student_in_class_pt_1;

exec student_in_class_pt_1;
