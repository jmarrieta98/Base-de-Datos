drop database trabajador;
create database trabajador;
use trabajador;


-- ---------------- --
-- TABLA TRABAJADOR --
-- ---------------- --
CREATE TABLE TRABAJADOR (
ID_T INT PRIMARY KEY,
NOMBRE CHAR(20) NOT NULL,
TARIFA REAL NOT NULL,
OFICIO CHAR(15) NOT NULL
);

ALTER TABLE TRABAJADOR ADD ID_SUPV INT NULL REFERENCES TRABAJADOR;

-- -------------- --
-- TABLA EDIFICIO --
-- -------------- --
CREATE TABLE EDIFICIO (
ID_E INT NOT NULL PRIMARY KEY,
DIR CHAR(15) NOT NULL,
TIPO CHAR (10) NOT NULL,
NIVEL_CALIDAD INT NOT NULL,
CATEGORIA INT NOT NULL
);

-- ---------------- --
-- TABLA ASIGNACION --
-- ---------------- --
CREATE TABLE ASIGNACION (
ID_T INT NOT NULL REFERENCES TRABAJADOR,
ID_E INT NOT NULL REFERENCES EDIFICIO,
FECHA_INICIO DATETIME NOT NULL,
NUM_DIAS INT,
PRIMARY KEY (ID_T, ID_E, FECHA_INICIO)
);
DELETE FROM TRABAJADOR;
DELETE FROM EDIFICIO;
DELETE FROM ASIGNACION;
-- ---------------- --
-- TABLA TRABAJADOR --
-- ---------------- --
INSERT INTO TRABAJADOR VALUES (1235,"M. FARADAY",12.5,"ELECTRICISTA",1311);
INSERT INTO TRABAJADOR VALUES (1311,"C. COULOMB",15.5,"ELECTRICISTA",1311);
INSERT INTO TRABAJADOR VALUES (1412,"C. NEMO",13.75,"FONTANERO",1520);
INSERT INTO TRABAJADOR VALUES (1520,"H. RICKOVER",11.75,"FONTANERO",1520);
INSERT INTO TRABAJADOR VALUES (2920,"R. GARRET",10.0,"ALBAÑIL",2920);
INSERT INTO TRABAJADOR VALUES (3001,"J. BARRISTER",8.2,"CARPINTERO",3231);
INSERT INTO TRABAJADOR VALUES (3231,"P. MASON",17.4,"CARPINTERO",3231);


-- -------------- --
-- TABLA EDIFICIO --
-- -------------- --
INSERT INTO EDIFICIO VALUES (111,"1213 ASPEN","OFICINA",4,1);
INSERT INTO EDIFICIO VALUES (210,"1011 BIRCH","OFICINA",3,1);
INSERT INTO EDIFICIO VALUES (312,"123 ELM","OFICINA",2,2);
INSERT INTO EDIFICIO VALUES (435,"456 MAPLE","COMERCIO",1,1);
INSERT INTO EDIFICIO VALUES (460,"1415 BEACH","ALMACEN",3,3);
INSERT INTO EDIFICIO VALUES (515,"789 OAK","RESIDENCIA",3,2);
-- ---------------- --
-- TABLA ASIGNACION --
-- ---------------- --
INSERT INTO ASIGNACION VALUES (1235,312,'2001-10-10',5);
INSERT INTO ASIGNACION VALUES (1235,515,'2001-10-17',22);
INSERT INTO ASIGNACION VALUES (1311,435,'2001-10-08',12);
INSERT INTO ASIGNACION VALUES (1311,460,'2001-10-23',24);
INSERT INTO ASIGNACION VALUES (1412,111,'2001-12-01',4);
INSERT INTO ASIGNACION VALUES (1412,210,'2001-11-15',12);
INSERT INTO ASIGNACION VALUES (1412,312,'2001-10-01',10);
INSERT INTO ASIGNACION VALUES (1412,435,'2001-10-15',15);
INSERT INTO ASIGNACION VALUES (1412,460,'2001-10-08',18);
INSERT INTO ASIGNACION VALUES (1412,515,'2001-11-05',8);
INSERT INTO ASIGNACION VALUES (1520,312,'2001-10-30',17);
INSERT INTO ASIGNACION VALUES (1520,515,'2001-10-09',14);
INSERT INTO ASIGNACION VALUES (2920,210,'2001-11-10',15);
INSERT INTO ASIGNACION VALUES (2920,435,'2001-10-28',10);
INSERT INTO ASIGNACION VALUES (2920,460,'2001-10-05',18);
INSERT INTO ASIGNACION VALUES (3001,111,'2001-10-08',14);
INSERT INTO ASIGNACION VALUES (3001,210,'2001-10-27',14);
INSERT INTO ASIGNACION VALUES (3231,111,'2001-10-10',8);
INSERT INTO ASIGNACION VALUES (3231,312,'2001-10-24',20);

/*1. Nombre de los trabajadores cuya tarifa este entre 10 y 12 euros.*/
Select NOMBRE, TARIFA
From TRABAJADOR
Where TARIFA between 10 and 12 
Order by NOMBRE asc;

/*2.¿Cuáles son los oficios de los trabajadores asignados al edificio 435?*/
Select distinct OFICIO 
From TRABAJADOR T, ASIGNACION A
Where T.ID_T = A.ID_T and A.ID_E = 435
order by OFICIO asc;

/*3. Indicar el nombre del trabajador y el de su supervisor.*/
Select  SUP.NOMBRE  as TRABAJADOR,  T.NOMBRE as SUPERVISOR
From TRABAJADOR SUP, TRABAJADOR T
Where SUP.ID_SUPV =  T.ID_T;

/*4. Nombre de los trabajadores asignados a oficinas*/
Select distinct NOMBRE
From TRABAJADOR, ASIGNACION
where TRABAJADOR.ID_T = ASIGNACION.ID_T AND ASIGNACION.ID_E in (111,218,312);


/*5. ¿Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?*/
Select T.NOMBRE
From TRABAJADOR T, TRABAJADOR S
Where T.ID_SUPV = S.ID_T and
T.TARIFA > S.TARIFA;

/*6. ¿Cuál es el número total de días que se han dedicado a fontanería en el edificio 312?*/
Select sum(NUM_DIAS) as DIAS
From ASIGNACION
Where ASIGNACION.ID_T in (1412,1520) and ASIGNACION.ID_E = 312;

/*7. ¿Cuántos tipos de oficios diferentes hay?*/
Select count(distinct OFICIO) as OFICIOS
From TRABAJADOR;

/*8. Para cada supervisor, ¿Cuál es la tarifa por hora más alta que se paga a un trabajador
que informa a ese supervisor?*/
SELECT T.NOMBRE "TRABAJADOR", max(T.TARIFA) "TARIFA", SUP.NOMBRE "SUPERVISOR"
FROM TRABAJADOR T, TRABAJADOR SUP
WHERE (T.ID_SUPV =  SUP.ID_T)
GROUP BY T.ID_SUPV
ORDER BY SUP.ID_SUPV;

/*9. Para cada supervisor que supervisa a más de un trabajador, ¿cuál es la tarifa más alta
que se para a un trabajador que informa a ese supervisor?*/
SELECT SUP.ID_SUPV AS SUPERVISOR, MAX(T.TARIFA) AS TARIFA
FROM TRABAJADOR T , TRABAJADOR SUP
WHERE T.ID_SUPV = SUP.ID_T
GROUP BY T.ID_SUPV
HAVING COUNT(SUP.ID_SUPV) > 1;

/*10. Para cada tipo de edificio, ¿Cuál es el nivel de calidad medio de los edificios con
categoría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
máximo no mayor que 3.*/
SELECT  TIPO, NIVEL_CALIDAD AS MEDIA
FROM EDIFICIO WHERE (CATEGORIA = 1 AND NIVEL_CALIDAD < 4);

/*11. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio?*/
select NOMBRE
from TRABAJADOR
where TARIFA<(
select avg(TARIFA)
from TRABAJADOR);

/*12. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores que tienen su mismo oficio?*/
select S.NOMBRE, S.OFICIO
from TRABAJADOR S, TRABAJADOR T
where S.TARIFA<(
select avg(T.TARIFA)
from TRABAJADOR
where T.OFICIO=S.OFICIO
group by S.OFICIO);

/*13. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores que dependen del mismo supervisor que él?*/
select S.OFICIO, S.OFICIO
from TRABAJADOR S, TRABAJADOR T
where S.TARIFA<(
select avg(T.TARIFA)
from TRABAJADOR
where T.ID_T=S.ID_SUPV);

/*14. Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que empezaron a trabajar en él.*/
select distinct NOMBRE, min(FECHA_INICIO)
from TRABAJADOR , EDIFICIO
where T.OFICIO = "ELECTRICISTA" and EDIFICIO.ID_E = "435";