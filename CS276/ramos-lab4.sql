/*
Part 1: Create a Procedure
1)	Start with your code from the first exercise in lab 2 where you’re checking 
for Low, Mid, and High using an if-elsif construct. Modify your code so that it
become a procedure. Name your procedure agent_bonus. It should have an IN 
parameter of p_agent_id and four OUT parameters of p_sales_price, p_bonus, 
p_commission and p_total. That is rather than print these four values out in
the procedure your procedure will return them to the calling block of code. 
(Note: the “p” in p_agent_id and other parameters stands for parameter.
2)	Use an anonymous block to call your procedure passing 201 for the agent it.
This means your WHERE clause in the SELECT INTO becomes WHERE agent_id = 
p_agent_id. Print out the four values being returned in the anonymous block. 
That is your output is done in the anonymous block as a test of your procedure,
rather than outputting the values in the procedure itself.
3)	Now change the agent id your passing to the procedure to 205 which is not a
valid agent id and notice your result when you run your anonymous block code to
call the procedure again. You should receive a no data found error.

Part 2: Adding Exception Handling
1)	Add an Exception section to the agent_bonus procedure that outputs separate
messages for the NO_DATA_FOUND system error and the TOO_MANY_ROWS system error.
See https://www.techonthenet.com/oracle/exceptions/named_system.php
2)	Add exception handling to the agent_bonus procedure that outputs a message 
in the Exception section when the agent level is something other than M, L or H.
That is declare an exception, add an ELSE clause where you RAISE the exception.
3)	Now test your procedure again by passing 205 for the agent id. Your code 
should have “handled” the NO_DATA_FOUND system error.
4)	Now change the AGENT_LEVEL in the AGENT table for agent 201 to a value
other than M, L, or H and run your anonymous block passing 201 for the agent. 
Your code should have “handled” your programmer-defined exception.




*/

set serveroutput on;
set feedback on;

create or replace procedure agent_bonus
  (p_agent_id IN number, p_sales_price OUT number, p_bonus OUT number, p_commission OUT number, p_total OUT number)
IS

-- Variables
  v_sale_price number(10,2) := 0;
  v_agent_level varchar2(1);
  v_commission_pct number(10,2) := 0;
  v_commission_amt number(10,2) := 0;
  v_bonus number(10,2) := 0;
  v_total number(10,2) := 0;
  
  INCORRECT_AGENT_LEVEL EXCEPTION;
  pragma exception_init (INCORRECT_AGENT_LEVEL, -20003);

-- Begin
BEGIN
  select sale_price, agent_level 
  into v_sale_price, v_agent_level
  from house_sale
  join agent on agent.agent_id = HOUSE_SALE.FK_AGENT_ID
  where agent.agent_id = p_agent_id;
  
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
      raise_application_error(-20003, 'The agent does not have a valid level assigned.');
  end case;
  -- Calculating
  v_commission_amt := V_COMMISSION_PCT * v_sale_price;
  v_total := v_commission_amt + v_bonus;
  -- Finalizing
  p_sales_price := v_sale_price;
  p_bonus := v_bonus;
  p_commission := v_commission_amt;
  p_total := v_total;
  
-- Exception
EXCEPTION
  when NO_DATA_FOUND then
    p_sales_price := 0;
    p_bonus := 0;
    p_commission := 0;
    p_total := 0;
    dbms_output.put_line('There was no data found~.');
  when TOO_MANY_ROWS then
    p_sales_price := 0;
    p_bonus := 0;
    p_commission := 0;
    p_total := 0;  
    dbms_output.put_line('Too many rows were returned~.');
  when INCORRECT_AGENT_LEVEL then
    p_sales_price := 0;
    p_bonus := 0;
    p_commission := 0;
    p_total := 0;  
    dbms_output.put_line('The agent does not have a valid level~.');
-- End
END agent_bonus;



declare
  f_sales_price number(10,2) := 0;
  f_bonus number(10,2) := 0;
  f_commission number(10,2) := 0;
  f_total number(10,2) := 0;
  
Begin
  dbms_output.put_line('Test  bad agent id value: 205.');
  agent_bonus(205, f_sales_price, f_bonus, f_commission, f_total);
  dbms_output.put_line('--------------------------');  
  dbms_output.put_line('The sale price of the house is '|| f_sales_price 
  || '. The bonus is ' ||f_bonus ||'. 
  The commission amount earned is '|| f_commission ||'. The agent earned '|| 
  f_total ||' in total.');
  dbms_output.put_line('--------------------------');
  dbms_output.put_line('');
  
end;

update agent set agent_level = 'M' where agent_id = 201;
