SELECT * FROM PET;

SELECT * FROM OWNER;
SELECT * FROM PET WHERE PET_AGE >= 7;

DELETE FROM PET WHERE PET_AGE >= 7;
SELECT * FROM PET;

select * 
from OWNER join PET on OWNER.OWNER_ID = PET.FK_OWNER_ID
where pet.pet_color = 'White';

select * from pet;

----------------------------------------------------------------------------
drop table owner cascade constraints;
drop table pet cascade constraints;

create table PET
(PET_ID		NUMBER	PRIMARY KEY,
FK_OWNER_ID	NUMBER	not null,
PET_TYPE	varchar2(4)  not null,
PET_NAME	varchar2(25)  not null,
PET_COLOR	varchar2(10)  not null,
PET_AGE		number		not null);


create table OWNER
(OWNER_ID	number  PRIMARY KEY,
owner_first_name	varchar2(25)	not null,
owner_last_name		varchar2(25)	not null);


insert into pet values
(1234,3456,'Dog','Ruggles','Brown',8);
insert into pet values
(2345,5678,'Cat','Wayne','Black',5);
insert into pet values
(7890,3456,'Dog','Addie','Black',4);
insert into pet values
(6789,5678,'Cat','Rosie','White',7);
insert into owner values
(3456,'Pamela','Farr');
insert into owner values
(5678,'James','Joyce');

alter table PET
add constraint fk_owner_id
foreign key (fk_owner_id)
references owner (owner_id);
----------------------------------------------------------------------
COMMIT;

select * from pet;
select * from owner;

SELECT * FROM PET WHERE PET_AGE = 7 OR PET_COLOR = 'Black';

delete FROM PET WHERE PET_AGE = 7 OR PET_COLOR = 'Black';

Delete from PET where PET_NAME = 'RUGGLES';


update PET SET PET_NAME = 'George' WHERE PET_NAME = 'Ruggles';

select * 
from OWNER join PET on OWNER.OWNER_ID = PET.FK_OWNER_ID
where pet.pet_color = 'White';

--
UPDATE customers
SET state = 'California',
    customer_rep = 32
WHERE customer_id > 100;

UPDATE customers
SET c_details = (SELECT contract_date
                 FROM suppliers
                 WHERE suppliers.supplier_name = customers.customer_name)
WHERE customer_id < 1000;
--

UPDATE PET 
SET PET_NAME = 'Rudolph', PET_AGE = '2'
WHERE FK_OWNER_ID = (SELECT OWNER.OWNER_ID 
FROM OWNER 
WHERE OWNER.OWNER_FIRST_NAME = 'Pamela' AND OWNER.OWNER_LAST_NAME = 'Farr');


Update PET set PET_NAME = 'RUGGLES';

commit;