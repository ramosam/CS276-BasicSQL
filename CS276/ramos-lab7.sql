set serveroutput on;

-- Ramos Week 7 Lab

create or replace package donor_calc_pkg
  is

--  -- Declaration for package level access.
-- Define record
  type donor_rt is record (
    iddonor pledge.iddonor%type,
    firstname donor.firstname%type,
    lastname donor.lastname%type,
    payamt payment.payamt%type);
-- Define table collection    
  type donor_tt is table of donor_rt index by pls_integer;
-- List procedures
  procedure get_donor_collection(pledge_id_in IN number, donor_collection_out OUT donor_tt);
  procedure calc_total_pledge_avg_amt(pledge_id_in IN number, total_pledge_out OUT number, avg_pledge_out OUT number);
  
end donor_calc_pkg;



create or replace package body donor_calc_pkg
  is
    procedure get_donor_collection(pledge_id_in IN number, donor_collection_out OUT donor_tt)
    is   
    cursor donor_cur is 
      select pledge.iddonor, firstname, lastname, payamt
      from donor 
      join pledge on pledge.iddonor = donor.iddonor
      join payment on payment.idpledge = pledge.idpledge
      where pledge.idpledge = pledge_id_in;
      
    d_col donor_tt;
    d_rec donor_rt;
    v_index number := 1;
    
    begin
        for donor_rec in donor_cur loop
          d_rec.iddonor := donor_rec.iddonor;
          d_rec.firstname := donor_rec.firstname;
          d_rec.lastname := donor_rec.lastname;
          d_rec.payamt := donor_rec.payamt;
          d_col(v_index) := d_rec;
          v_index := v_index + 1;
        end loop;
        donor_collection_out := d_col;
    end get_donor_collection;  
    
      
  procedure calc_total_pledge_avg_amt(pledge_id_in IN number, total_pledge_out OUT number, avg_pledge_out OUT number)
    is
    v_num_pay number(4,0) := 0;
    v_total_pledge number(8,2) := 0; 
    d_col donor_tt;
    d_rec donor_rt;

    NO_DATA_FOUND exception;
    pragma exception_init (NO_DATA_FOUND, -20001);
    
    begin
      get_donor_collection(pledge_id_in, d_col);    
      v_num_pay := d_col.count;
      
      if v_num_pay > 0 then
        for v_index in 1 .. d_col.count loop
          v_total_pledge := v_total_pledge + d_col(v_index).payamt;
        end loop;
      else
        raise NO_DATA_FOUND;
      end if;
      
      total_pledge_out := v_total_pledge;
      avg_pledge_out := v_total_pledge / v_num_pay; 
       
    exception
      when no_data_found then
        dbms_output.put_line('There was no data found for this pledge id.');
      
    end calc_total_pledge_avg_amt;  
  
end donor_calc_pkg;
  
  
 
 declare
    donor_t donor_calc_pkg.donor_tt;    
    total_pledged number;
    avg_payment number;
    
 begin
    DONOR_CALC_PKG.CALC_TOTAL_PLEDGE_AVG_AMT(107, total_pledged, avg_payment);
    dbms_output.put_line('Total pledged: '|| total_pledged);
    dbms_output.put_line('Average amount: '|| avg_payment);
    dbms_output.put_line('Testing 0 ------------');
    DONOR_CALC_PKG.CALC_TOTAL_PLEDGE_AVG_AMT(0, total_pledged, avg_payment);
    dbms_output.put_line('Total pledged: '|| total_pledged);
    dbms_output.put_line('Average amount: '|| avg_payment);

 end;
 