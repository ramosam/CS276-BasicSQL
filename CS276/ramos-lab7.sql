set serveroutput on;

-- Ramos Week 7 Lab

create or replace package donor_calc_pkg
  is

--  -- Declaration for package level access.
  cursor donor_cur is 
    select pledge.iddonor, firstname, lastname, payamt
    from donor 
    join pledge on pledge.iddonor = donor.iddonor
    join payment on payment.idpledge = pledge.idpledge;

-- associative array type
  type donor_t is table of donor_cur%rowtype
      index by pls_integer;

      l_donor donor_t;
  
  procedure get_donor_collection(donor_id_in IN number, donor_collection_out OUT donor_calc_pkg.donor_t);
-- procedure calc_total_pledge_avg_amt(donor_id_in IN number, total_pledge_out OUT number, avg_pledge_out OUT number);


end donor_calc_pkg;
/
create or replace package body donor_calc_pkg
  is
  procedure get_donor_collection(donor_id_in IN number, donor_collection_out OUT donor_calc_pkg.donor_t)
  is      
    l_index pls_integer := 0;
    l_donor donor_calc_pkg.donor_t;
    begin
    
      for donor_rec in donor_calc_pkg.donor_cur loop
        if donor_rec.iddonor = donor_id_in then
          l_index := l_index + 1;
          l_donor (l_index) := donor_rec;
        end if;
      end loop;

      donor_collection_out := l_donor;
    end get_donor_collection;  
  
--  procedure calc_total_pledge_avg_amt(donor_id_in IN number, total_pledge_out OUT number, avg_pledge_out OUT number)
--    is
--    v_num_pay number(4,0) := 0;
--    v_total_pledge number(8,2) := 0;
--    
--    donor_collection donor_t := donor_t();
--
--    NO_DATA_FOUND exception;
--    pragma exception_init (NO_DATA_FOUND, -20001);
--    
--    begin
--      get_donor_collection(donor_id_in, donor_collection);
--    
--      
--      for donor_rec in donor_collection loop
--        v_num_pay := v_num_pay + 1;
--      end loop;
--      
--      if v_num_pay > 0 then
--        for donor_rec in donor_collection loop
--          v_total_pledge := v_total_pledge + donor_rec.payamt;
--        end loop;
--      else
--        raise NO_DATA_FOUND;
--      end if;
--
--      total_pledge_out := v_total_pledge;
--      avg_pledge_out := v_total_pledge / v_num_pay; 
--  
--    exception
--      when no_data_found then
--        dbms_output.put_line('There was no data found for this donor id.');
--      
--    end calc_total_pledge_avg_amt;  
    
  end donor_calc_pkg;      
        

 
 
 declare
 
   cursor donor_cur is 
    select pledge.iddonor, firstname, lastname, payamt
    from donor 
    join pledge on pledge.iddonor = donor.iddonor
    join payment on payment.idpledge = pledge.idpledge;
    
      type donor_t is table of donor_cur%rowtype
      index by pls_integer;
      


 begin
    donor_calc_pkg.get_donor_collection(107, donor_calc_pkg.l_donor);
    for donor_rec in donor_calc_pkg.donor_cur loop
      dbms_output.put_line(donor_rec.payamt);
    end loop; 
 end;
 
 
 
 
 
 
