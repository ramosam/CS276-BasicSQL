set serveroutput on;

--Week 7: Working with collections
--Wed inClass assignment


declare
  cursor donor_cur is select iddonor, firstname, lastname
  from donor;
  
  -- associative array type
  type donor_t is table of donor_cur%rowtype
    index by pls_integer;
  -- creating variables to work with the array
  l_donors donor_t;
  l_index pls_integer := 0;
begin
  for donor_rec in donor_cur loop
    -- forcing the index to start at one and move off the initial value.
    l_index := l_index + 1;
    -- you can assign the record because the l_donors table 
    -- is the same row type as donor_cur
    l_donors (l_index) := donor_rec;
  end loop;
  for v_index in 1..l_index loop
    dbms_output.put_line(l_donors(v_index).iddonor ||' '||
    l_donors (v_index).firstname ||' '|| l_donors (v_index).lastname);
  end loop;
end;

