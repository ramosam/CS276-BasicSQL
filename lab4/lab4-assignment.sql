

-------------------------------------------------------------------------
--------------------  Part 1  -------------------
-- 1
SELECT DORM_ROOM_ID, BUILDING_ID, STUDENT_ID
FROM DORM_ROOM LEFT OUTER JOIN STUDENT
ON STUDENT.FK_DORM_ROOM_ID= DORM_ROOM.DORM_ROOM_ID;

-- 2
SELECT STUDENT_ID, STUDENT_FIRST_NAME, STUDENT_LAST_NAME, BUILDING_ID
FROM STUDENT LEFT OUTER JOIN DORM_ROOM
ON STUDENT.FK_DORM_ROOM_ID=DORM_ROOM.DORM_ROOM_ID;

-- 3
SELECT STUDENT_ID, STUDENT_FIRST_NAME, STUDENT_LAST_NAME, BUILDING_ID
FROM STUDENT LEFT OUTER JOIN DORM_ROOM
ON STUDENT.FK_DORM_ROOM_ID=DORM_ROOM.DORM_ROOM_ID;

-- 4
Select DORM_ROOM_ID, BUILDING_ID, STUDENT_ID, STUDENT_LAST_NAME
FROM DORM_ROOM RIGHT OUTER JOIN STUDENT
ON STUDENT.FK_DORM_ROOM_ID= DORM_ROOM.DORM_ROOM_ID;

-- 5
SELECT STUDENT_ID, STUDENT_LAST_NAME, BUILDING_ID
FROM STUDENT RIGHT OUTER JOIN DORM_ROOM
ON STUDENT.FK_DORM_ROOM_ID= DORM_ROOM.DORM_ROOM_ID;

-- 6
SELECT DORM_ROOM_ID, BUILDING_ID, STUDENT_ID, STUDENT_LAST_NAME
FROM DORM_ROOM FULL OUTER JOIN STUDENT
ON STUDENT.FK_DORM_ROOM_ID= DORM_ROOM.DORM_ROOM_ID;

-- 7
SELECT DORM_ROOM_ID, BUILDING_ID, STUDENT_ID, STUDENT_LAST_NAME
FROM DORM_ROOM CROSS JOIN STUDENT;

-------------------------------------------------------------------------
-------------------  Part 2  --------------------
-- 1
-- inner join
select textbook_title, student_first_name, student_last_name
from textbook join student
on textbook.FK_STUDENT_ID = student.STUDENT_ID;

-- 2
-- Left join
select textbook_title, student_first_name, student_last_name
from textbook left join student
on textbook.FK_STUDENT_ID = student.STUDENT_ID;

-- 3
select student_first_name, student_last_name, textbook_title
from student left join textbook
on textbook.FK_STUDENT_ID = student.STUDENT_ID;

-- 4
select student_first_name, student_last_name, textbook_title
from student full outer join textbook
on textbook.FK_STUDENT_ID = student.STUDENT_ID;

-- 5/text
-- 6
--Left outer
select student_first_name, student_last_name, textbook_title
from student left outer join textbook
on textbook.FK_STUDENT_ID = student.STUDENT_ID;

-- Right outer
select student_first_name, student_last_name, textbook_title
from student right outer join textbook
on textbook.FK_STUDENT_ID = student.STUDENT_ID;

--Cross join
select student_first_name, student_last_name, textbook_title
from student CROSS JOIN TEXTBOOK;

-------------------------------------------------------------------------
-------------------  Part 3  --------------------
-- Different table FOR STUDENT
-- 1
select course.description, section.location, course.prerequisite
from course left join section
on course.COURSE_NO = section.COURSE_NO
WHERE course.PREREQUISITE = 350;

-- 2
SELECT C.COURSE_NO, C.DESCRIPTION, C.COST, S.LOCATION, I.LAST_NAME
FROM COURSE C LEFT OUTER JOIN SECTION S
ON C.COURSE_NO = S.COURSE_NO
LEFT OUTER JOIN INSTRUCTOR I
ON S.INSTRUCTOR_ID = I.INSTRUCTOR_ID;

-- 3
SELECT S.STUDENT_ID, E.SECTION_ID, G.NUMERIC_GRADE, G.GRADE_TYPE_CODE
FROM STUDENT S
LEFT OUTER JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
LEFT OUTER JOIN GRADE G
ON G.STUDENT_ID = E.STUDENT_ID
WHERE S.STUDENT_ID = 102 OR S.STUDENT_ID = 301;

