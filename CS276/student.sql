drop table student cascade constraints;

create table student
(student_id	varchar2(25)  primary key,
student_first	varchar2(25),
student_last	varchar2(25));

insert into student values
('L11111111','Pamela','Farr');
insert into student values
('L22222222','Ernest','Hemingway');
insert into student values
('L33333333','Ayn','Rand');
insert into student values
('L44444444','James','Joyce');

commit;