drop table myTable cascade constraints;

create table myTable
(
myID number(5) primary key not null, 
myBirthdate date not null,
myNotBirthdate date not null
);


insert into myTable (myID, myBirthdate, myNotBirthdate) Values (1, to_date('10/09/1981 04:23', 'mm/dd/yyyy hh24:mi'), to_date('01/01/1991 01:01','mm/dd/yyyy hh24:mi'));

insert into myTable (myID, myBirthdate, myNotBirthdate) Values (2, to_date('09/09/1981 04:23', 'mm/dd/yyyy hh24:mi'), to_date('02/01/1991 01:01','mm/dd/yyyy hh24:mi'));

insert into myTable (myID, myBirthdate, myNotBirthdate) Values (3, to_date('08/09/1981 04:23', 'mm/dd/yyyy hh24:mi'), to_date('03/01/1991 01:01','mm/dd/yyyy hh24:mi'));


select * from mytable;

-- number of days actual
select sum( mynotbirthdate -  mybirthdate)
from mytable
where myid = 1;

--number of days rounded
select round(sum( mynotbirthdate -  mybirthdate))
from mytable
where myid = 1;



select mybirthdate, last_day(mybirthdate) from mytable;


select to_char(mybirthdate, 'Day') from mytable;





select (
(
 mytable.mynotbirthdate - 
 mytable.mybirthdate)
 * 24) as hours_between
from mytable;




insert into myTable (myID, myBirthdate, myNotBirthdate) Values (4, to_date('07/09/1981 04:23', 'mm/dd/yyyy hh24:mi'), to_date('04/01/1991 01:01','mm/dd/yyyy hh24:mi'));

insert into myTable (myID, myBirthdate, myNotBirthdate) Values (5, to_date('06/09/1981 04:23', 'mm/dd/yyyy hh24:mi'), to_date('05/01/1991 01:01','mm/dd/yyyy hh24:mi'));


select * from mytable;


select mybirthdate, sum( mynotbirthdate -  mybirthdate)
from mytable
group by mybirthdate;



select mybirthdate, round(sum( mynotbirthdate -  mybirthdate))
from mytable
group by mybirthdate;


select sum( mynotbirthdate -  mybirthdate) as lots_of_days
from mytable;