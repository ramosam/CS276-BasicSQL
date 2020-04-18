set serveroutput on;
set feedback on;

declare
  v_sale_price number(8,2) := 0;
  v_commission_pct number(8,2) := 0;
  v_commission_amt number(8,2) := 0;
  v_bonus number(8,2) := 0;
  v_total number(8,2) := 0;
  v_agent_level varchar2(1);
begin
  select sale_price, agent_level 
  into v_sale_price, v_agent_level
  from house_sale
  join agent on agent.agent_id = HOUSE_SALE.FK_AGENT_ID
  where agent.agent_id = 201;
  
  if v_agent_level = 'H' then
    v_bonus := 25000;
    v_commission_pct := 0.15;
  elsif v_agent_level = 'M' then
    v_bonus := 10000;
    v_commission_pct := 0.10;
  elsif v_agent_level = 'L' then
    v_bonus := 5000;
    v_commission_pct := 0.05;
  else
    v_bonus := 0;
    v_commission_pct := 0;
  end if;
  
  v_commission_amt := V_COMMISSION_PCT * v_sale_price;
  v_total := v_commission_amt + v_bonus;
  
  dbms_output.put_line('The sale price of the house is '|| v_sale_price 
  || '. The agent''s level is '|| v_agent_level ||'. The bonus is '||v_bonus ||'. 
  The commission amount earned is '|| v_commission_amt ||'. The agent earned '|| 
  v_total ||' in total.');
end;


-------------------------------------------------------------------------------

declare
  v_sale_price number(8,2) := 0;
  v_commission_pct number(8,2) := 0;
  v_commission_amt number(8,2) := 0;
  v_bonus number(8,2) := 0;
  v_total number(8,2) := 0;
  v_agent_level varchar2(1);
begin
  select sale_price, agent_level 
  into v_sale_price, v_agent_level
  from house_sale
  join agent on agent.agent_id = HOUSE_SALE.FK_AGENT_ID
  where agent.agent_id = 201;
  
  case v_agent_level
    when 'H' then
      v_bonus := 25000;
      v_commission_pct := 0.15;
    when 'M' then
      v_bonus := 10000;
      v_commission_pct := 0.10;
    when 'L' then
      v_bonus := 5000;
      v_commission_pct := 0.05;
    else
      v_bonus := 0;
      v_commission_pct := 0;
  end case;
  v_commission_amt := V_COMMISSION_PCT * v_sale_price;
  v_total := v_commission_amt + v_bonus;
  dbms_output.put_line('The sale price of the house is '|| v_sale_price 
  || '. The agent''s level is '|| v_agent_level ||'. The bonus is '||v_bonus ||'. 
  The commission amount earned is '|| v_commission_amt ||'. The agent earned '|| 
  v_total ||' in total.');
end;


-------------------------------------------------------------------------------

declare
  v_num_f number(2) := 0;
  v_num_s number(2) := 0;
  v_num_j number(2) := 0;
  v_num_r number(2) := 0;
  v_seats number(2) := 20;
  v_seats_left number(2) := 0;
  
begin
  select count(fk_student_type_id) into v_num_f
  from student 
  where fk_student_type_id = 'F';
  
  select count(fk_student_type_id) into v_num_s
  from student 
  where fk_student_type_id = 'S';
  
  select count(fk_student_type_id) into v_num_j
  from student 
  where fk_student_type_id = 'J';
  
  select count(fk_student_type_id) into v_num_r
  from student 
  where fk_student_type_id = 'R';

  if v_num_r >= v_seats then -- if too many seniors
    dbms_output.put_line('There are only seniors in the class.');
    
  else
    v_seats_left := v_seats - v_num_r; -- space left for juniors
    if v_num_j >= v_seats_left then -- if too many juniors
      dbms_output.put_line('There are '|| v_num_r ||' seniors in the class. 
      There are '|| v_seats_left ||' juniors in the class. There are '
      || v_num_j - v_seats_left ||' juniors on the waitlist.');
    else 
      v_seats_left := v_seats_left - v_num_j; -- space left for sophomores
      if v_num_s >= v_seats_left then -- if too many sophomores
        dbms_output.put_line('There are '|| v_num_r ||' seniors in the class. 
        There are '|| v_num_j ||' juniors in the class. There are '
          || v_seats_left ||' sophomores in the class. There are '
          || v_num_s - v_seats_left ||' sophomores on the waitlist.');
      else
        v_seats_left := v_seats_left - v_num_s; -- space left for freshmen
        if v_num_f >= v_seats_left then -- if too many freshmen
          dbms_output.put_line('There are '|| v_num_r ||' seniors in the class.');
          dbms_output.put_line('There are '|| v_num_j ||' juniors in the class.');
          dbms_output.put_line('There are '|| v_num_s ||' sophomores in the class.');
          dbms_output.put_line('There are '|| v_seats_left ||' freshmen in the class.');
          dbms_output.put_line('There are '|| (v_num_f - v_seats_left) ||' freshmen on the waitlist.'); 
        end if;
      end if;
    end if;
  end if;
end;

