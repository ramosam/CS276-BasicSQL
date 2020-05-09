set serveroutput on;
set feedback on;

declare 
  type invoice_rec is record (
    shipping_id number(12) not null := 99,
    price number(8,2),
    product_ordered varchar2(30),
    amount_ordered number(12),
    fk_shops_id number(12)
  );
begin
  null;
end;

-- Part 1, question 2
--declare
--  type dept_rec1 is record (dept_num number(2), dept_name varchar2(14));
--  type dept_rec2 is record (dept_num number(2), dept_name varchar2(14));
--  
--  dept1_info dept_rec1;
--  dept2_info dept_rec1;
--  dept3_info dept_rec2;
--
--begin
--  dept1_info := dept2_info;
--  dept2_info := dept3_info;
--end;  --It's supposed to not work due to mismatched types.
--

-- Part 2
create or replace package GET_SECTIONS_TAUGHT
  is
  -- Declaration for package level access.
  type teacher_info_rt is record
    (teacher_id         teacher.teacher_id%type,
    teacher_first_name  teacher.teacher_first_name%type,
    teacher_last_name   teacher.teacher_last_name%type,
    teacher_dept        teacher.fk_department_id%type,
    teacher_salary      teacher.salary%type,
    section_count       number);
    
  type teacher_stats is record
    (t_dept_name        department.department_name%type,
    t_section_count     number);
  
  procedure get_teacher_info(teacher_id_in IN varchar2, teacher_info_out OUT teacher_info_rt);
  procedure calc_sections_taught(teacher_info_in IN teacher_info_rt, num_sections_out OUT teacher_stats);
  
end GET_SECTIONS_TAUGHT;


create or replace package body GET_SECTIONS_TAUGHT
  is
  /*
  First procedure: Given the teacher the procedure should return a record that includes all five fields that are
  in the TEACHER table. The procedure should handle an exception for an invalid department id. Assume that the only
  valid department ids are BUS, CSI, ENG and MTH. Just print a message to handle the exception.
  */
  procedure get_teacher_info(teacher_id_in IN varchar2, teacher_info_out OUT teacher_info_rt)
    is
      invalid_department_type exception; -- declaring an exception to handle issues when a department cannot be found
      pragma exception_init(invalid_department_type, -20001); -- creates an exception with the assigned numeric code.
    begin
      -- select data for specific teacher id into teacher record type variable
      select teacher_id, teacher_first_name, teacher_last_name, fk_department_id, salary, count(*) as count
      into teacher_info_out
      from teacher
      join section on teacher.teacher_id = section.fk_teacher_id
      join department on teacher.fk_department_id = department.department_id
      where teacher.teacher_id = teacher_id_in
      group by teacher_id, teacher_first_name, teacher_last_name, fk_department_id, salary;

      if teacher_info_out.teacher_dept not in ('BUS', 'CSI', 'ENG', 'MTH') then
        --if the teacher_dept is not of a known type, raise exception
        raise invalid_department_type;
      end if;
    exception
      when invalid_department_type then
      dbms_output.put_line('Department type is invalid.');    
  end get_teacher_info;
  
  /*
  Second procedure: Given the teacher record the procedure should return a count of the number of sections that 
  teacher has taught and return the full department name the teacher works under. Use the DEPARTMENT table to get
  the department name (example: Computer Science for department id CSI).
  */
  procedure calc_sections_taught(teacher_info_in IN teacher_info_rt, num_sections_out OUT teacher_stats)
    is  
    begin    
      num_sections_out.t_dept_name := teacher_info_in.teacher_dept;
      num_sections_out.t_section_count := teacher_info_in.section_count;

    end calc_sections_taught;
end GET_SECTIONS_TAUGHT;

/*
Write an anonymous block that is not part of the package that tests your package by 
1.	Calling the first procedure to get the teacher record using the teacher_id of ‘L0234567’
2.	Calling the second procedure and passing the teacher record just obtained
3.	Prints the teacher information, including the full department name and the count of the sections taught.
*/

declare
  v_teacher_record    get_sections_taught.teacher_info_rt;
  v_teacher_count     get_sections_taught.teacher_stats;

begin
  --get the teacher's information
  get_sections_taught.get_teacher_info('L0234567', v_teacher_record);
  --calculate the gpa for the student
  get_sections_taught.calc_sections_taught(v_teacher_record, v_teacher_count);
  --display output
  dbms_output.put_line('Teacher: '|| v_teacher_record.teacher_first_name ||' '|| 
  v_teacher_record.teacher_last_name ||' Department: '|| v_teacher_count.t_dept_name 
  ||', taught '|| v_teacher_count.t_section_count ||' classes.');

end;