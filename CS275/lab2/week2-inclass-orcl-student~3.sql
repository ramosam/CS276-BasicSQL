create table student_address 
(student_id varchar2(9),
address_id varchar2(2),
street_number varchar2(50)
);

alter table student_address
add constraint PK_STUDENT_ADDRESS PRIMARY KEY (student_id, address_id);

insert into student_address
values
('L11111111', '1', '123 Main Street');

select * from student_address;

describe student_address;

drop table enrollment;

create table enrollment
(student_id varchar2(9),
course_id varchar2(9),
enrollment_date date);

insert into enrollment
values
('L11111111', '31978', (to_date('011620', 'MMDDYY')));


select * from enrollment;


drop table student_address;

create table student_address
(student_id varchar2(9),
address_id number);

create table product
(product_id varchar2(3),
product_name varchar2(24),
cost decimal(8,3));

insert into product
values
('ABC', 'Cinnamon Candle', 4.95);





