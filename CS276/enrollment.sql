drop table enrollment cascade constraints;

create table enrollment 
(student_id   varchar2(25) not null,
course_number varchar2(25) not null,
term_code     number  not null,
grade                   varchar2(1));


Insert into enrollment values ('L11111111','WR121',201910,'A');
Insert into enrollment values ('L11111111','CS120',201910,'B');
Insert into enrollment values ('L11111111','CS260',201910,'A');
Insert into enrollment values ('L11111111','BA101',201920,'C');
Insert into enrollment values ('L11111111','FA232',201920,'A');
Insert into enrollment values ('L11111111','HR234',201920,'B');
Insert into enrollment values ('L11111111','MT111',201930,'B');
Insert into enrollment values ('L11111111','CS161',201930,'C');
Insert into enrollment values ('L11111111','CS162',201930,'A');
Insert into enrollment values ('L11111111','MT080',201940,'C');
Insert into enrollment values ('L11111111','ANTH101',201940,'A');
Insert into enrollment values ('L11111111','ART115',201940,'C');
Insert into enrollment values ('L22222222','AM149',201910,'A');
Insert into enrollment values ('L22222222','BA250',201910,'D');
Insert into enrollment values ('L22222222','BI103',201910,'C');
Insert into enrollment values ('L22222222','CS120',201920,'B');
Insert into enrollment values ('L22222222','CA163',201920,'B');
Insert into enrollment values ('L22222222','CG203',201920,'F');
Insert into enrollment values ('L22222222','CS100',201930,'D');
Insert into enrollment values ('L22222222','CH104',201930,'C');
Insert into enrollment values ('L22222222','FT201',201930,'A');
Insert into enrollment values ('L22222222','HIM153',201940,'B');
Insert into enrollment values ('L22222222','PN103',201940,'C');
Insert into enrollment values ('L22222222','CS253',201940,'B');
Insert into enrollment values ('L33333333','WLD242',201910,'A');
Insert into enrollment values ('L33333333','CH221',201910,'A');
Insert into enrollment values ('L33333333','ANTH103',201910,'A');
Insert into enrollment values ('L33333333','DA110',201920,'B');
Insert into enrollment values ('L33333333','CS120',201920,'B');
Insert into enrollment values ('L33333333','ECON200',201920,'A');
Insert into enrollment values ('L33333333','HST201',201930,'A');
Insert into enrollment values ('L33333333','PSY201',201930,'A');
Insert into enrollment values ('L33333333','SPAN201',201930,'B');
Insert into enrollment values ('L33333333','ART131',201940,'B');
Insert into enrollment values ('L33333333','CS260',201940,'B');
Insert into enrollment values ('L33333333','CS120',201940,'B');
Insert into enrollment values ('L44444444','WR121',201910,'B');
Insert into enrollment values ('L44444444','CS120',201910,'C');
Insert into enrollment values ('L44444444','CS260',201910,'B');
Insert into enrollment values ('L44444444','BA101',201920,'C');
Insert into enrollment values ('L44444444','FA232',201920,'D');
Insert into enrollment values ('L44444444','HR234',201920,'D');
Insert into enrollment values ('L44444444','MT111',201930,'D');
Insert into enrollment values ('L44444444','CS161',201930,'B');
Insert into enrollment values ('L44444444','CS162',201930,'A');
Insert into enrollment values ('L44444444','MT080',201940,'A');
Insert into enrollment values ('L44444444','ANTH101',201940,'A');
Insert into enrollment values ('L44444444','ART115',201940,'A');

commit;