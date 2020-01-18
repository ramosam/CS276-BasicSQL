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
(2345,5678,'Cat,'Wayne','Black',5);
insert into pet values
(7890,3456,'D','Addie','Black',4);
insert into pet values
(6789,5678,'Cat,'Rosie','White',7);
insert into owner values
(3456,'Pamela','Farr');
insert into owner values
(5678,'James','Joyce');

alter table PET
add constraint fk_owner_id
foreign key (fk_owner_id)
references owner (owner_id);