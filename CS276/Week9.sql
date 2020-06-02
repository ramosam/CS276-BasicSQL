drop table employee cascade constraints;

create table employee
(employee_id	number primary key,
employee_first	varchar2(20) not null,
employee_last	varchar2(30) not null,
employee_salary	float not null);

insert into employee values
(1,'Pamela','Farr',34000);

insert into employee values
(2,'Ernest','Hemingway',39000);

insert into employee values
(3,'James','Joyce',55000);

insert into employee values
(4,'Ayn','Rand',30000);

insert into employee values
(5,'Ursula','Leguin',68000);

drop table customer cascade constraints;

create table customer
(customer_id	number primary key,
customer_first	varchar2(20) not null,
customer_last	varchar2(30) not null,
customer_credit_rating	number not null);


insert into customer values
(1,'Pamela','Farr',9);

insert into customer values
(2,'Ernest','Hemingway',3);

insert into customer values
(3,'James','Joyce',10);

insert into customer values
(4,'Ayn','Rand',4);

insert into customer values
(5,'Ursula','Leguin',5);

drop table purchase cascade constraints;

create table purchase
(purchase_id    number  primary key,
customer_id     number  not null,
purchase_date   date  not null,
total_purchase_price  float);

drop table purchase_audit cascade constraints;

create table purchase_audit
(purchase_id    number  primary key,
customer_id     number  not null,
purchase_date   date  not null,
total_purchase_price  float,
who_did_this    varchar2(30));

commit;