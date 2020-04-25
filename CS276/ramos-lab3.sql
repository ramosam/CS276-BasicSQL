set serveroutput on;
set feedback on;

-- 1 Payments
declare
  cursor charges_cur is
    select charge_id, customer_id, order_id, last_payment_date, current_balance
    from charges;
    
begin
  for charges_rec in charges_cur
  loop
    case
      when (trunc(sysdate) - charges_rec.last_payment_date) < 30 then
        dbms_output.put_line('Account within acceptable time frame. No fees applied.');
      when (trunc(sysdate) - charges_rec.last_payment_date) < 60 then
        dbms_output.put_line('Payment is late. A 10% fee will be applied. The new payment due is: $'|| charges_rec.current_balance * 1.1);
      when (trunc(sysdate) - charges_rec.last_payment_date) >= 60  then
        dbms_output.put_line('Account is overdue. CustomerID '|| charges_rec.customer_id ||' must go to collections.');
    end case;
  end loop;
end;

-----------------------------------------------------------------------------

-- 3
declare
  cursor student_table_cur is
    select fk_student_id, substr(grade, 1, 1) as grade
      from enrollment;      
  cursor student_count_cur is
    select fk_student_id, count(fk_student_id) as course_count, student_first_name, student_last_name 
      from enrollment
      join student on student.student_id = enrollment.fk_student_id
      group by fk_student_id, student_first_name, student_last_name;     
  v_s_course_count number(4,2); -- num of courses
  v_s_points number(4,2); -- accrue points
  v_s_gpa number(4,2); -- gpa
begin
  for student_count_rec in student_count_cur --  for each unique student_id
    loop
    v_s_course_count := student_count_rec.course_count;
    v_s_points := 0;
    v_s_gpa := 0;
    for student_table_rec in student_table_cur
      loop
        if student_count_rec.fk_student_id = student_table_rec.fk_student_id then
          case student_table_rec.grade
            when 'A' then
              v_s_points := v_s_points + 4;
            when 'B' then
              v_s_points := v_s_points + 3;
            when 'C' then
              v_s_points := v_s_points + 2;
            when 'D' then
              v_s_points := v_s_points + 1;
            else
              v_s_points := v_s_points + 0;
          
          end case;
        end if;
      end loop;
    v_s_gpa := v_s_points / v_s_course_count;
    dbms_output.put_line('Student '|| student_count_rec.fk_student_id ||', '|| 
    student_count_rec.student_first_name ||' '|| student_count_rec.student_last_name 
    || ' earned a GPA of: '|| v_s_gpa ||'.');
      
    end loop;
end;


