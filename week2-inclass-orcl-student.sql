create table course
(course_id varchar2(10) primary key);

insert into course
(course_id) values ('CS 275');

select * from course;

delete from course 
where course_id = 'CS 275';

-- gets rid of the table, the table cannot have any other relationships.
drop table course;

-- drops table and removes the relations to other tables. SLEDGEHAMMER
drop table course cascade constraints;

commit;