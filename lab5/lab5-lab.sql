-- PART 1

DROP TABLE RESORT_TYPE CASCADE CONSTRAINTS;
DROP TABLE RESORT CASCADE CONSTRAINTS;
DROP TABLE ACCOMMODATIONS CASCADE CONSTRAINTS;


CREATE TABLE RESORT_TYPE (
RESORT_TYPE_ID VARCHAR2(1) PRIMARY KEY NOT NULL,
RESORT_TYPE_DESCRIPT	VARCHAR(35) NOT NULL
);

CREATE TABLE RESORT (
RESORT_ID VARCHAR2(2) PRIMARY KEY NOT NULL,
RESORT_TYPE_ID_FK VARCHAR2(1) NOT NULL,
RESORT_NAME VARCHAR2(35) NOT NULL,
CONSTRAINT RESORT_TYPE_ID_FK
FOREIGN KEY (RESORT_TYPE_ID_FK) REFERENCES RESORT_TYPE (RESORT_TYPE_ID));

CREATE TABLE ACCOMMODATIONS (
ACCOMMODATIONS_ID VARCHAR2(24) PRIMARY KEY NOT NULL,
RESORT_ID_FK  VARCHAR2(2) NOT NULL,
ACCOMMODATIONS_DESC VARCHAR2(50) NOT NULL,
COST_PER_NIGHT NUMBER(8,2),
CONSTRAINT RESORT_ID_FK
FOREIGN KEY (RESORT_ID_FK) REFERENCES RESORT (RESORT_ID));


--CREATE TABLE RESORT_TYPE (
--RESORT_TYPE_ID VARCHAR2(1) PRIMARY KEY NOT NULL,
--RESORT_TYPE_DESCRIPT	VARCHAR(35) NOT NULL
--);
--
--CREATE TABLE RESORT (
--RESORT_ID VARCHAR2(2) PRIMARY KEY NOT NULL,
--RESORT_TYPE_ID_FK VARCHAR2(1) NOT NULL,
--RESORT_NAME VARCHAR2(35) NOT NULL
--);
--
--CREATE TABLE ACCOMMODATIONS (
--ACCOMMODATIONS_ID VARCHAR2(24) PRIMARY KEY NOT NULL,
--RESORT_ID_FK  VARCHAR2(2) NOT NULL,
--ACCOMMODATIONS_DESC VARCHAR2(50) NOT NULL,
--COST_PER_NIGHT NUMBER(8,2)
--);
--
--ALTER TABLE RESORT
--ADD CONSTRAINT RESORT_TYPE_FK
--FOREIGN KEY(RESORT_TYPE_ID_FK)
--REFERENCES RESORT_TYPE (RESORT_TYPE_ID);
--
--ALTER TABLE ACCOMMODATIONS
--ADD CONSTRAINT RESORT_FK
--FOREIGN KEY(RESORT_ID_FK)
--REFERENCES RESORT (RESORT_ID);




INSERT INTO RESORT_TYPE (RESORT_TYPE_ID, RESORT_TYPE_DESCRIPT) VALUES ('F', 'Foodie');  
INSERT INTO RESORT_TYPE (RESORT_TYPE_ID, RESORT_TYPE_DESCRIPT) VALUES ('S', 'Spa');
INSERT INTO RESORT_TYPE (RESORT_TYPE_ID, RESORT_TYPE_DESCRIPT) VALUES ('E', 'Ecological');
INSERT INTO RESORT_TYPE (RESORT_TYPE_ID, RESORT_TYPE_DESCRIPT) VALUES ('G', 'Golf');


INSERT INTO RESORT (RESORT_ID, RESORT_NAME, RESORT_TYPE_ID_FK) VALUES ('G1', 'Golfing by the Sea', 'G');
INSERT INTO RESORT (RESORT_ID, RESORT_NAME, RESORT_TYPE_ID_FK) VALUES ('S1', 'Atlantis Spa', 'S');
INSERT INTO RESORT (RESORT_ID, RESORT_NAME, RESORT_TYPE_ID_FK) VALUES ('E1', 'Amazing Oregon', 'E');
INSERT INTO RESORT (RESORT_ID, RESORT_NAME, RESORT_TYPE_ID_FK) VALUES ('L1', 'Gentle Waves Spa', 'S');



INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Bunk 1', 'Cabin on far North Beach', 'G1', 324.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Bunk 2', 'Cabin at Middle Beach', 'G1', 324.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Bunk 3', 'Cabin at South Beach', 'G1', 425.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Chamber 1', 'Room First Floor', 'E1', 250.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Chamber 2', 'Room Second Floor', 'E1', 250.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Chamber 3', 'Room Third Floor', 'E1', 300.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Chamber 4', 'Room Fourth Floor, Ocean View', 'E1', 350.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Room 10', 'Room First Floor, Spa Side', 'S1', 200.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Room 15', 'Room First Floor, Family Area', 'S1', NULL);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Suite 1', 'Suite First Floor, Ocean View', 'L1', 450.00);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Suite 2', 'Suite Second Floor, Ocean View', 'L1', NULL);
INSERT INTO ACCOMMODATIONS (ACCOMMODATIONS_ID, ACCOMMODATIONS_DESC, RESORT_ID_FK, COST_PER_NIGHT) VALUES ('Suite 3', 'Suite Third Floor, Ocean View', 'L1', 400.00);


COMMIT;

-- PART 2

SELECT COUNT(ACCOMMODATIONS_ID)
FROM ACCOMMODATIONS;


SELECT MIN(COST_PER_NIGHT)
FROM ACCOMMODATIONS;


SELECT RESORT_TYPE.RESORT_TYPE_ID, RESORT_TYPE.RESORT_TYPE_DESCRIPT, COUNT(RESORT.RESORT_ID) AS NR_RESORTS
FROM RESORT_TYPE
JOIN RESORT 
ON RESORT_TYPE.RESORT_TYPE_ID = RESORT.RESORT_TYPE_ID_FK
GROUP BY RESORT_TYPE.RESORT_TYPE_ID, RESORT_TYPE.RESORT_TYPE_DESCRIPT
ORDER BY NR_RESORTS DESC;


SELECT RESORT_TYPE.RESORT_TYPE_ID, RESORT_TYPE.RESORT_TYPE_DESCRIPT, COUNT(ACCOMMODATIONS.ACCOMMODATIONS_ID) AS NR_ACCOMMODATIONS
FROM RESORT_TYPE
JOIN RESORT ON RESORT.RESORT_TYPE_ID_FK = RESORT_TYPE.RESORT_TYPE_ID
JOIN ACCOMMODATIONS ON ACCOMMODATIONS.RESORT_ID_FK = RESORT.RESORT_ID
GROUP BY RESORT_TYPE.RESORT_TYPE_ID, RESORT_TYPE.RESORT_TYPE_DESCRIPT
HAVING COUNT(ACCOMMODATIONS.ACCOMMODATIONS_ID) < 4;


-- PART 3

DROP TABLE ARCHAEOLOGIST CASCADE CONSTRAINTS;
DROP TABLE LOCATION CASCADE CONSTRAINTS;
DROP TABLE DINOSAUR  CASCADE CONSTRAINTS;
DROP TABLE DISCOVERY  CASCADE CONSTRAINTS;


CREATE TABLE ARCHAEOLOGIST (
ARCHAEOLOGIST_ID INTEGER PRIMARY KEY NOT NULL,
FIRST_NAME VARCHAR2(25) NOT NULL, 
LAST_NAME VARCHAR2(25) NOT NULL
);

CREATE TABLE LOCATION (
LOCATION_ID INTEGER PRIMARY KEY NOT NULL,
LOCATION_NAME VARCHAR2(50) NOT NULL,
STATE_NAME VARCHAR2(60) NOT NULL
);

CREATE TABLE DINOSAUR (
DINOSAUR_ID INTEGER PRIMARY KEY NOT NULL, 
DINOSAUR_NAME VARCHAR2(100) NOT NULL,
DIET_TYPE VARCHAR2(25) NOT NULL,
COST NUMBER(12,2)
);

CREATE TABLE DISCOVERY (
DISCOVERY_ID INTEGER PRIMARY KEY NOT NULL,
DISCOVERY_DATE DATE NOT NULL,
DINOSAUR_ID_FK INTEGER NOT NULL,
LOCATION_ID_FK INTEGER NOT NULL,
ARCHAEOLOGIST_ID_FK INTEGER NOT NULL
);

ALTER TABLE DISCOVERY
ADD CONSTRAINT DINOSAUR_FK
FOREIGN KEY (DINOSAUR_ID_FK)
REFERENCES DINOSAUR (DINOSAUR_ID);

ALTER TABLE DISCOVERY
ADD CONSTRAINT LOCATION_FK
FOREIGN KEY (LOCATION_ID_FK)
REFERENCES LOCATION (LOCATION_ID);

ALTER TABLE DISCOVERY
ADD CONSTRAINT ARCHAEOLOGIST_FK
FOREIGN KEY (ARCHAEOLOGIST_ID_FK)
REFERENCES ARCHAEOLOGIST (ARCHAEOLOGIST_ID);


-- Archaeologist
INSERT ALL
INTO ARCHAEOLOGIST (ARCHAEOLOGIST_ID, FIRST_NAME, LAST_NAME) VALUES (1, 'Ernest', 'Hemingway')
INTO ARCHAEOLOGIST (ARCHAEOLOGIST_ID, FIRST_NAME, LAST_NAME) VALUES (2, 'Ayn ', 'Rand')
INTO ARCHAEOLOGIST (ARCHAEOLOGIST_ID, FIRST_NAME, LAST_NAME) VALUES (3, 'Greta', 'Garbo')
INTO ARCHAEOLOGIST (ARCHAEOLOGIST_ID, FIRST_NAME, LAST_NAME) VALUES (4, 'Fred', 'Astaire')
INTO ARCHAEOLOGIST (ARCHAEOLOGIST_ID, FIRST_NAME, LAST_NAME) VALUES (5, 'Ginger', 'Rogers')
SELECT * FROM DUAL;


-- Location
INSERT ALL
INTO LOCATION (LOCATION_ID, LOCATION_NAME, STATE_NAME) VALUES (1, 'Black Hills', 'South Dakota')
INTO LOCATION (LOCATION_ID, LOCATION_NAME, STATE_NAME) VALUES (2, 'Los Angeles', 'California')
INTO LOCATION (LOCATION_ID, LOCATION_NAME, STATE_NAME) VALUES (3, 'Grand Canyon', 'Arizona')
INTO LOCATION (LOCATION_ID, LOCATION_NAME, STATE_NAME) VALUES (4, 'Tampa', 'Florida')
INTO LOCATION (LOCATION_ID, LOCATION_NAME, STATE_NAME) VALUES (5, 'Rome', 'New York')
INTO LOCATION (LOCATION_ID, LOCATION_NAME, STATE_NAME) VALUES (6, 'Calgary', 'Canada')
INTO LOCATION (LOCATION_ID, LOCATION_NAME, STATE_NAME) VALUES (7, 'Milwaukee', 'Wisconsin')
select * from dual;


-- Dinosaur
INSERT ALL
INTO DINOSAUR (DINOSAUR_ID, DINOSAUR_NAME, DIET_TYPE, COST) VALUES (1, 'Tyrannosaurus Rex', 'Carnivore', 100000.00)
INTO DINOSAUR (DINOSAUR_ID, DINOSAUR_NAME, DIET_TYPE, COST) VALUES (2, 'Allosaurus', 'Carnivore', 500000.00)
INTO DINOSAUR (DINOSAUR_ID, DINOSAUR_NAME, DIET_TYPE, COST) VALUES (3, 'Diplodocus', 'Herbivore', 250000.00)
INTO DINOSAUR (DINOSAUR_ID, DINOSAUR_NAME, DIET_TYPE, COST) VALUES (4, 'Triceratops', 'Herbivore', null)
INTO DINOSAUR (DINOSAUR_ID, DINOSAUR_NAME, DIET_TYPE, COST) VALUES (5, 'Nodosaur', 'Herbivore', 500000.00)
INTO DINOSAUR (DINOSAUR_ID, DINOSAUR_NAME, DIET_TYPE, COST) VALUES (6, 'Spinosaurus', 'Carnivore', 750000.00)
select * from dual;

-- Discovery
INSERT ALL 
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (1, TO_DATE('12/12/2010', 'MM/DD/YYYY'), 1, 1, 1)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (2, TO_DATE('12/15/2011', 'MM/DD/YYYY'), 1, 1, 3)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (3, TO_DATE('07/18/2012', 'MM/DD/YYYY'), 3, 5, 1)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (4, TO_DATE('06/15/2009', 'MM/DD/YYYY'), 4, 4, 5)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (5, TO_DATE('05/10/2011', 'MM/DD/YYYY'), 4, 1, 6)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (6, TO_DATE('08/20/2012', 'MM/DD/YYYY'), 2, 5, 7)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (7, TO_DATE('05/10/2012', 'MM/DD/YYYY'), 5, 1, 6)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (8, TO_DATE('07/25/2010', 'MM/DD/YYYY'), 1, 2, 4)
INTO DISCOVERY (DISCOVERY_ID, DISCOVERY_DATE, DINOSAUR_ID_FK, ARCHAEOLOGIST_ID_FK, LOCATION_ID_FK) VALUES (9, TO_DATE('08/01/2016', 'MM/DD/YYYY'), 5, 5, 2)
SELECT * FROM DUAL;


-- 1
select DISCOVERY_ID, DINOSAUR_NAME, LAST_NAME, LOCATION_NAME
FROM DISCOVERY
JOIN DINOSAUR ON DISCOVERY.DINOSAUR_ID_FK = DINOSAUR.DINOSAUR_ID
JOIN ARCHAEOLOGIST ON DISCOVERY.ARCHAEOLOGIST_ID_FK = ARCHAEOLOGIST.ARCHAEOLOGIST_ID
JOIN LOCATION ON DISCOVERY.LOCATION_ID_FK = LOCATION.LOCATION_ID
ORDER BY DISCOVERY.DISCOVERY_ID;


-- 2
SELECT COUNT(DISCOVERY_ID) AS TOTAL_DISCOVERIES
FROM DISCOVERY;

-- 3
SELECT MIN(COST) AS MINIMUM_COST
FROM DINOSAUR;
SELECT MAX(COST) AS MAXIMUM_COST
FROM DINOSAUR;

-- 5
SELECT FIRST_NAME, LAST_NAME, COUNT(DISCOVERY.ARCHAEOLOGIST_ID_FK) AS NUM_ARCH_DISCOVERIES
FROM DISCOVERY
RIGHT OUTER JOIN ARCHAEOLOGIST ON DISCOVERY.ARCHAEOLOGIST_ID_FK = ARCHAEOLOGIST.ARCHAEOLOGIST_ID
GROUP BY FIRST_NAME, LAST_NAME;

-- 6
SELECT FIRST_NAME, LAST_NAME, COUNT(DISCOVERY.ARCHAEOLOGIST_ID_FK) AS NUM_ARCH_DISCOVERIES
FROM DISCOVERY
RIGHT OUTER JOIN ARCHAEOLOGIST ON DISCOVERY.ARCHAEOLOGIST_ID_FK = ARCHAEOLOGIST.ARCHAEOLOGIST_ID
GROUP BY FIRST_NAME, LAST_NAME
HAVING COUNT(DISCOVERY.ARCHAEOLOGIST_ID_FK) > 2;

-- 7

SELECT FIRST_NAME, LAST_NAME, COUNT(S.DISCOVERY_ID) 
FROM ARCHAEOLOGIST A 
LEFT JOIN DISCOVERY S ON A.ARCHAEOLOGIST_ID = S.ARCHAEOLOGIST_ID_FK 
  AND S.DINOSAUR_ID_FK = 
    (SELECT D.DINOSAUR_ID FROM DINOSAUR D WHERE D.DINOSAUR_NAME = 'Tyrannosaurus Rex')
GROUP BY FIRST_NAME, LAST_NAME;


-- 8
SELECT COUNT(DISCOVERY_DATE)
FROM DISCOVERY
WHERE DISCOVERY_DATE >= TO_DATE('01/01/2012', 'MM/DD/YYYY') AND DISCOVERY_DATE < TO_DATE('01/01/2013', 'MM/DD/YYYY');


