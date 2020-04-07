set feedback on; 
set serveroutput on; 

DECLARE -- declaration
  FIRST_NAME VARCHAR2(25):= 'Alicia';
  LAST_NAME VARCHAR2(25):= 'Ramos';
  AREA_CIRCLE NUMBER(4,2);
  RADIUS NUMBER(4,2) := 2.3;
BEGIN -- execution
  AREA_CIRCLE := 3.14 * RADIUS * RADIUS;
  DBMS_OUTPUT.PUT_LINE('Hello. My name is ' || FIRST_NAME || ' ' || LAST_NAME || '!');
  DBMS_OUTPUT.PUT_LINE(' The area of the circle is ' || AREA_CIRCLE);
EXCEPTION -- exception
  WHEN VALUE_ERROR
  THEN
  DBMS_OUTPUT.PUT_LINE('Hello World quote is too big for string field.');
END;  