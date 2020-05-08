set serveroutput on;

create or replace package get_gpa
  is
  --procedure's declarations

  -- declares a package programmer defined record type
  type student_info_rt is record
    (student_id         student.student_id%type,
    student_first_name  student.student_first_name%type,
    student_last_name   student.student_last_name%type,
    student_type        student.fk_student_type_id%type);

  --procedure to retrieve student information based upon the
  --student's id.
  procedure get_student_info(student_id_in in varchar2, student_info_out  out student_info_rt);

  --procedure to calculate the gpa of a student based upon
  --a student record
  procedure calc_gpa(student_info_in in student_info_rt, gpa_out out number);

end get_gpa;
/ -- tells oracle this is the end point for this package.

create or replace package body get_gpa
  is
  --declaring the body of get_student_info.
  procedure get_student_info(student_id_in in varchar2, student_info_out  out student_info_rt)
    is
      invalid_student_type exception; -- declaring an exception to handle issues when a student cannot be found
      pragma exception_init(invalid_student_type, -20001); -- creates an exception with the assigned numeric code.
    begin
      -- select data for specific student id into student record type variable
      select student_id, student_first_name, student_last_name, fk_student_type_id
      into student_info_out
      from student
      where student.student_id = student_id_in;

      if student_info_out.student_type not in ('F', 'S', 'J', 'R') then
        --if the student is not of a known type, raise exception
        raise invalid_student_type;
      end if;
    exception
      when invalid_student_type then
      dbms_output.put_line('Student type is invalid.');
    end get_student_info;

  --declaring the body of calc_gpa.
  procedure calc_gpa(student_info_in in student_info_rt, gpa_out out number)
    is
    cursor gpa_cur is
      select grade
      from enrollment
      join section on enrollment.fk_section_id = section.section_id
      where enrollment.fk_student_id = student_info_in.student_id;

    v_grade_points decimal(6,2);

    begin
      v_grade_points := 0;
      for gpa_rec in gpa_cur loop --implicitly makes it the right type
        case gpa_rec.grade
          when 'A+' then v_grade_points := v_grade_points + 4.33;
          when 'A' then v_grade_points := v_grade_points + 4.0;
          when 'A-' then v_grade_points := v_grade_points + 3.67;
          when 'B+' then v_grade_points := v_grade_points + 3.33;
          when 'B+' then v_grade_points := v_grade_points + 3.33;
          when 'B' then v_grade_points := v_grade_points + 3.0;
          when 'B-' then v_grade_points := v_grade_points + 2.67;
          when 'C+' then v_grade_points := v_grade_points + 2.33;
          when 'C' then v_grade_points := v_grade_points + 2.0;
          when 'C-' then v_grade_points := v_grade_points + 1.67;
          when 'D' then v_grade_points := v_grade_points + 1.0;
          else v_grade_points := v_grade_points;
        end case;
      end loop;
      gpa_out := v_grade_points / 4;
    
    end calc_gpa;
end get_gpa;
/


--anonymous block to test the package
declare
  v_student_record    get_gpa.student_info_rt;
  v_gpa               number(6,2);
begin
  --get the student's information
  get_gpa.get_student_info('L1164156', v_student_record);
  --calculate the gpa for the student
  get_gpa.calc_gpa(v_student_record, v_gpa);
  --display output
  dbms_output.put_line(v_student_record.student_id ||' '|| v_student_record.student_first_name ||' '|| v_student_record.student_last_name);
  dbms_output.put_line('Student GPA: '|| v_gpa);
end;
