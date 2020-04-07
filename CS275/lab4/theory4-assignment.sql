-- WEEK 4 THEORY ASSIGNMENT

-- STARTING SCRIPT
Drop table student cascade constraints; 
Create table student
(student_id     number(8) PRIMARY KEY,
Student_first     varchar2(25)  not null,
Student_last      varchar2(25)  not null,
Dorm_room_id   number(8));

Create table dorm_room
(dorm_room_id   number(8)  primary key,
Dorm_room_bldg   varchar2(3)  not null,
No_beds      number(8) not null);

Alter table student 
Add foreign key (dorm_room_id)
References dorm_room(dorm_room_id);
--------------------------------------------
-- Adding course table
drop table course cascade constraints;
Create table course
(course_num   number (8) PRIMARY KEY,
Course_title     varchar2(50) not null,
No_seats          number(8)  not null);

