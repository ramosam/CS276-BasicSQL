drop table teacher cascade constraints;
drop table student cascade constraints;
drop table student_type cascade constraints;
drop table class cascade constraints;
drop table subject cascade constraints;
drop table term cascade constraints;
drop table section cascade constraints;
drop table enrollment cascade constraints;
drop table department cascade constraints;
drop table trainroute cascade constraints;
drop table trainstop cascade constraints;
drop table trainstation cascade constraints;
drop table freshman cascade constraints;
drop table sophomore cascade constraints;
drop table junior cascade constraints;
drop table senior cascade constraints;
drop table other_level cascade constraints;
drop table house_sale cascade constraints;
drop table agent cascade constraints;

create table charges
(charge_id    varchar(10)  PRIMARY KEY,
customer_id   varchar(10), 
order_id      varchar(10),
last_payment_date   date, 
current_balance   decimal(10,2));

insert into charges values ('1','1','1',(SELECT SYSDATE-30 FROM DUAL),
50.00 );
insert into charges values ('2','2','2',(SELECT SYSDATE-40 FROM DUAL),
60.00 );insert into charges values ('3','3','3',(SELECT SYSDATE-50 FROM 
DUAL),
70.00 );
insert into charges values ('4','4','4',(SELECT SYSDATE-60 FROM DUAL),
80.00 );
insert into charges values ('5','5','5',(SELECT SYSDATE-70 FROM DUAL),
90.00 );
insert into charges values ('6','6','6',(SELECT SYSDATE-80 FROM DUAL),
100.00 );
insert into charges values ('7','7','7',(SELECT SYSDATE-90 FROM DUAL),
120.00 );
insert into charges values ('8','8','8',(SELECT SYSDATE-100 FROM DUAL),
130.00 );
insert into charges values ('9','9','9',(SELECT SYSDATE-120 FROM DUAL),
140.00 );
insert into charges values ('10','10','10',(SELECT SYSDATE-130 FROM
DUAL), 150.00 );


create table house_sale
(sale_id        number  PRIMARY KEY,
fk_house_id        number  NOT NULL,
fk_owner_id        number  NOT NULL,
fk_agent_id     number  NOT NULL,
sale_price      number(15,5));

create table agent
(agent_id       number  PRIMARY KEY,
agent_first_name    varchar2(25)    NOT NULL,
agent_last_name     varchar2(25)    NOT NULL,
agent_level         varchar2(1));

alter table house_sale 
add constraint fk_agent_id
foreign key (fk_agent_id)
references agent(agent_id);

create table trainroute
(routenumber_id   number,
route_name  varchar2(50),
route_cost  decimal(8,2));

create table trainstop
(stopnumber_id  number,
routenumber_id  number,
stationnumber_id number,
arrive_time date,
depart_time date);

create table trainstation
(stationnumber_id number,
station_name  varchar2(50),
station_city  varchar2(50));

CREATE TABLE TEACHER
(TEACHER_ID   VARCHAR2(10) PRIMARY KEY,
TEACHER_FIRST_NAME   VARCHAR2(20)  NOT NULL,
TEACHER_LAST_NAME	VARCHAR2(30) NOT NULL,
SALARY			DECIMAL(8,2) NOT NULL,
FK_DEPARTMENT_ID		VARCHAR2(4));

CREATE TABLE DEPARTMENT
(DEPARTMENT_ID		VARCHAR2(4) PRIMARY KEY,
DEPARTMENT_NAME		VARCHAR2(30) NOT NULL);

CREATE TABLE STUDENT
(STUDENT_ID    varchar2(10) PRIMARY KEY,
STUDENT_FIRST_NAME   VARCHAR2(20)   NOT NULL,
STUDENT_LAST_NAME	VARCHAR2(20)	NOT NULL,
FK_STUDENT_TYPE_ID	VARCHAR2(1)	NOT NULL);

CREATE TABLE FRESHMAN
(STUDENT_ID    varchar2(10) PRIMARY KEY,
STUDENT_FIRST_NAME   VARCHAR2(20)   NOT NULL,
STUDENT_LAST_NAME	VARCHAR2(20)	NOT NULL);

CREATE TABLE SOPHOMORE
(STUDENT_ID    varchar2(10) PRIMARY KEY,
STUDENT_FIRST_NAME   VARCHAR2(20)   NOT NULL,
STUDENT_LAST_NAME	VARCHAR2(20)	NOT NULL);

CREATE TABLE JUNIOR
(STUDENT_ID    varchar2(10) PRIMARY KEY,
STUDENT_FIRST_NAME   VARCHAR2(20)   NOT NULL,
STUDENT_LAST_NAME	VARCHAR2(20)	NOT NULL);

CREATE TABLE SENIOR
(STUDENT_ID    varchar2(10) PRIMARY KEY,
STUDENT_FIRST_NAME   VARCHAR2(20)   NOT NULL,
STUDENT_LAST_NAME	VARCHAR2(20)	NOT NULL);

CREATE TABLE OTHER_LEVEL
(STUDENT_ID    varchar2(10) PRIMARY KEY,
STUDENT_FIRST_NAME   VARCHAR2(20)   NOT NULL,
STUDENT_LAST_NAME	VARCHAR2(20)	NOT NULL);

CREATE TABLE STUDENT_TYPE
(STUDENT_TYPE_ID	VARCHAR2(1)	PRIMARY KEY,
STUDENT_TYPE_DESC	VARCHAR2(20)	NOT NULL);

CREATE TABLE CLASS
(CLASS_NUMBER		VARCHAR2(8)	PRIMARY KEY,
CLASS_NAME		VARCHAR2(30)	NOT NULL,
FK_SUBJECT_ID		VARCHAR2(1)	NOT NULL);

CREATE TABLE SUBJECT
(SUBJECT_ID		VARCHAR2(10)	PRIMARY KEY,
SUBJECT_NAME		VARCHAR2(20)	NOT NULL);

CREATE TABLE TERM
(TERM_ID		VARCHAR2(8)	PRIMARY KEY,
TERM_DESC		VARCHAR2(30)	NOT NULL,
TERM_START_DATE		DATE		NOT NULL,
TERM_END_DATE		DATE		NOT NULL);

CREATE TABLE SECTION
(SECTION_ID		NUMBER		PRIMARY KEY,
AVAILABLE_ENROLLMENT	NUMBER,
LOCATION		VARCHAR2(8)	NOT NULL,
FK_TEACHER_ID		VARCHAR2(10),
FK_CLASS_NUMBER		VARCHAR2(8)	NOT NULL,
FK_TERM_ID		VARCHAR2(8)	NOT NULL);

CREATE TABLE ENROLLMENT
(ENROLLMENT_ID		VARCHAR2(6)	PRIMARY KEY,
FK_STUDENT_ID		VARCHAR2(10)	NOT NULL,
FK_SECTION_ID		NUMBER		NOT NULL,
GRADE			VARCHAR2(4));

alter table teacher
add constraint fk_department
foreign key (fk_department_id)
references department(department_id);

alter table student
add constraint fk_student_type
foreign key (fk_student_type_id)
references student_type(student_type_id);

alter table class
add constraint fk_subject
foreign key (fk_subject_id)
references subject(subject_id);

alter table section
add constraint fk_teacher
foreign key (fk_teacher_id)
references teacher (teacher_id);

alter table section
add constraint fk_class
foreign key (fk_class_number)
references class(class_number);

alter table enrollment
add constraint fk_student
foreign key (fk_student_id)
references student(student_id);

alter table enrollment
add constraint fk_section
foreign key (fk_section_id)
references section(section_id);

alter table section
add constraint fk_term
foreign key (fk_term_id)
references term(term_id);




