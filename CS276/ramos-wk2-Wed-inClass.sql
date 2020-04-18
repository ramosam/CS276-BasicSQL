set serveroutput on;
set feedback on;

declare
  v_operator varchar2(1) := '?';
  v_num_1 number(8,2) := 23;
  v_num_2 number(8,2) := 7;
  v_answer number(8,2) := 0;
begin
  case v_operator
    when '+' then
      v_answer := v_num_1 + v_num_2;
    when '-' then
      v_answer := v_num_1 - v_num_2;
    when '*' then
      v_answer := v_num_1 * + v_num_2;
    when '/' then
      if v_num_2 = 0 then
        v_answer := 0;
      else
        v_answer := v_num_1 / v_num_2;
      end if;
    else
      v_answer := 0;
  end case;
  dbms_output.put_line('The answer to '|| v_num_1 || ' ' || v_operator || ' ' || 
    v_num_2 || ' is ' || v_answer || '.');
end;