drop database Empresas;
create database Empresas;
use Empresas;

create table centros(
numero int,
nombre varchar(20),
direccion varchar(50),
primary key (numero)
);

create table departamentos (
numero int,
nombre varchar(20),
centro int,
director int,
tipo_dir char (1),
presupuesto float,
dpto_jefe int,
	PRIMARY KEY (numero),
	CONSTRAINT dep FOREIGN KEY (centro) REFERENCES centros (numero)
);

create table empleados (
cod		int,
departamento	int,
telefono	int,
fecha_n		date,
fecha_i		date,
salario		float,
comision	float,
numhijos	int,
nombre		varchar(40),
	primary key (cod)
);

ALTER TABLE EMPLEADOS ADD CONSTRAINT fk_emp1 FOREIGN KEY (departamento) REFERENCES DEPARTAMENTOS(numero);
insert into centros values (10, 'SEDE CENTRAL', 'C. ALCALA 820, MADRID');
insert into centros values (20, 'RELACION CON CLIENTE', 'C. ATOCHA 405, MADRID');

insert into departamentos values (100,'DIRECCION GENERAL', 10, 260, 'P', 12, null);
insert into departamentos values (110,'DIRECC.COMERCIAL', 20, 180, 'P', 15, 100);
insert into departamentos values (111,'SECTOR INDUSTRIAL', 20, 180, 'F', 11, 110);
insert into departamentos values (112,'SECTOR SERVICIOS', 20, 270, 'P', 9, 100);
insert into departamentos values (120,'ORGANIZACION', 10, 150, 'F', 3, 100);
insert into departamentos values (121,'PERSONAL', 10, 150, 'P', 2, 120);
insert into departamentos values (122,'PROCESO DE DATOS', 10, 350, 'P', 6, 120);
insert into departamentos values (130,'FINANZAS', 10, 310, 'P', 2, 100);

insert into empleados values (110, 121, 350, '2010-11-01', '1914-02-05',1310, null, 3, 'PONS, CESAR');
insert into empleados values (120, 112, 840, '2009-06-02', '1918-10-06',1350, 110, 1, 'LASA, HORACIO');
insert into empleados values (130, 112, 810, '2009-11-03', '1936-02-07',1290, 110, 2, 'TEROL, LUCIANO');
insert into empleados values (150, 121, 340, '2010-08-04', '1939-01-09',1440, null, 0, 'PEREZ, LIVIO');
insert into empleados values (160, 111, 740, '2009-07-05', '1939-11-10',1310, 110, 2, 'AGUIRRE, AUREO');
insert into empleados values (180, 110, 508, '2018-10-06', '1945-03-11',1480, 50, 2, 'PEREZ, COS');
insert into empleados values (190, 121, 350, '2012-05-07', '2011-02-12',1300, null, 4, 'VEIGA, VIVIANA');
insert into empleados values (210, 100, 200, '2028-09-08', '2022-01-13',1380, null, 2, 'GALVEZ, PILAR');
insert into empleados values (240, 111, 760, '2026-02-09', '2024-02-14',1280, 100, 3, 'SANZ, LAVINIA');
insert into empleados values (250, 100, 250, '2027-10-10', '2001-03-15',1450, null, 0, 'ALBA, ADRIANA');
insert into empleados values (260, 100, 220, '2003-12-11', '2012-07-16',1720, null, 6, 'LOPEZ, ANTONIO');
insert into empleados values (270, 112, 800, '2021-05-12', '2010-09-17',1380, 80, 3, 'GARCIA, OCTAVIO');
insert into empleados values (280, 130, 410, '2011-01-13', '2008-10-18',1290, null, 5, 'FLOR, DOROTEA');
insert into empleados values (285, 122, 620, '2025-10-14', '2015-02-19',1380, null, 0, 'POLO, OTILIA');
insert into empleados values (290, 120, 910, '2030-11-15', '2014-02-20',1270, null, 3, 'GIL, GLORIA');
insert into empleados values (310, 130, 480, '2021-11-16', '2015-01-21',1420, null, 0, 'GARCIA, JUSTO');
insert into empleados values (320, 122, 620, '2025-12-17', '2005-02-22',1405, null, 2, 'SANZ, CORNELIO');
insert into empleados values (330, 112, 850, '2019-08-18', '2001-03-23',1280, 90, 0, 'DIEZ, AMELIA');
insert into empleados values (350, 122, 610, '2013-04-19', '2010-09-24',1450, null, 1, 'CAMPS, AURELIO');
insert into empleados values (360, 111, 750, '2029-10-20', '2010-10-25',1250, 100, 2, 'LARA, DORINDA');
insert into empleados values (370, 121, 360, '2022-06-21', '2020-01-26',1190, null, 1, 'RUIZ, FABIOLA');
insert into empleados values (380, 112, 880, '2030-03-22', '2001-01-27',1180, null, 0, 'BOTIN, MICAELA');
insert into empleados values (390, 110, 500, '2019-02-23', '2008-10-28',1215, null, 1, 'MORAN, CARMEN');
insert into empleados values (400, 111, 780, '2018-08-24', '2001-11-29',1185, null, 0, 'LARA, LUCRECIA');
insert into empleados values (410, 122, 660, '2014-07-25', '2013-10-30',1175, null, 0, 'MUÑOZ, AZUCENA');
insert into empleados values (420, 130, 450, '2022-10-26', '2019-11-30',1400, null, 0, 'FIERRO, CLAUDIA');
insert into empleados values (430, 122, 650, '2026-10-27', '2019-11-03',1210, null, 1, 'MORA, VALERIANA');
insert into empleados values (440, 111, 760, '2027-09-28', '2028-02-07',1210, 100, 0, 'DURAN, LIVIA');
insert into empleados values (450, 112, 880, '2021-10-29', '2028-02-07',1210, 100, 0, 'PEREZ, SABINA');
insert into empleados values (480, 111, 760, '2004-04-30', '2028-02-08',1210, 100, 1, 'PINO, DIANA');
insert into empleados values (490, 112, 880, '2006-06-01', '2001-01-09',1180, 100, 0, 'TORRES, HORACIO');
insert into empleados values (500, 111, 750, '2008-10-02', '2001-01-10',1200, 100, 0, 'VAZQUEZ, HONORIA');

Select * From empleados;

/*1,Hallar la comisión, el nombre y el salario de los empleados con más de tres hijos,
ordenados por comisión y, dentro de comisión, alfabéticamente.*/
Select nombre,comision,salario
From empleados
Where numhijos >3
Order by comision desc;

/*2,Obtener los nombres de los departamentos que no dependen de otros.*/
Select nombre
From departamentos
Where dpto_jefe is not null;

/*3,Obtener, por orden alfabético, los nombres y los salarios de los empleados cuyo salario
esté comprendido entre 1250 y 1300 euros.*/
Select nombre, salario
From empleados
Where salario between 1250 and 1300
Order by nombre asc;

/*4,Datos de los empleados que cumplen la condición anterior o tienen al menos un hijo.*/
Select nombre, salario
From empleados
Where salario between 1250 and 1300 or numhijos >= 1
Order by nombre asc;

/*5,Obtener, por orden alfabético, los nombres de los departamentos que no contengan la
palabra 'Dirección' ni 'Sector'.*/
Select nombre
From departamentos     
Where nombre not like '%DIRECCION%' and nombre not like '%SECTOR%'
Order by nombre asc;

/*6. Obtener, por orden alfabético, los nombres de los departamentos que, o bien tienen
directores en funciones y su presupuesto no excede los 5 mil euros, o bien no dependen
de ningún otro departamento.*/
Select nombre
From departamentos
Where dpto_jefe is null or tipo_dir="F" and presupuesto < 5000
Order by nombre asc;

/*7. Hallar, por orden de número de empleado, el nombre y el salario total (salario más comisión) de los empleados cuyo salario total supera los 1300 euros mensuales.*/
Select nombre,cod,(salario+comision) as Total
From empleados 
Where (salario + comision) > 1300
Order by cod;

/*8.Hallar el número de empleados de toda la empresa.*/
Select count(distinct cod) as Numero_empleados
From empleados;

/*9. Hallar cuántos departamentos existen y el presupuesto anual medio de la empresa para el global de todos los departamentos.*/
Select count(numero) as numero_departamentos, sum(presupuesto)/count(numero) as Presupuesto_medio
From departamentos;


/*10. Hallar el número de empleados y de extensiones telefónicas distintas del departamento 112. */
Select distinct empleados.telefono 
From departamentos, empleados
Where departamentos.numero = empleados.departamento and
departamentos.numero = 112;

/*15. Indica la media de salario de cada uno de los departamentos. */
Select avg(salario), departamentos.numero
From empleados, departamentos
Where empleados.departamento= departamentos.numero
group by empleados.departamento;

/*17. Indica el número de departamentos que tienen algún empleado que cobra comisión.*/
Select distinct departamentos.numero
From departamentos, empleados
Where empleados.departamento=departamentos.numero and  empleados.comision >=0;

/*18. Lista el nombre, código y sueldo total (sueldo+comisión) de los empleados. */
Select nombre, cod, salario+comision as sueldo_total
From empleados
Where salario+comision is not null;

/*19. Calcula el sueldo completo (sueldo+comisión) medio, por departamento. */
select departamentos.nombre, avg(empleados.salario+empleados.comision) as sueldo_medio
from departamentos, empleados
where empleados.departamento=departamentos.numero and empleados.salario is not null and empleados.comision is not null
group by departamentos.nombre;

/*20. Indica cual es el empleado con sueldo completo mayor (sueldo+comisión)*/
Select nombre, empleados.salario+empleados.comision as Sueldo_Total
from empleados
where empleados.salario+empleados.comision=(
select max(salario+comision)
from empleados);

/*21. Indica cual es el empleado con sueldo completo menor (sueldo+comisión)*/
Select nombre, empleados.salario+empleados.comision as Sueldo_Total
from empleados
where empleados.salario+empleados.comision=(
select min(salario+comision)
from empleados);




