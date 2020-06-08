drop database Colegio;
CREATE DATABASE Colegio;
USE Colegio;

CREATE TABLE Profesores(
	Nombre VARCHAR (20),
	Apellido1 VARCHAR (20),
	Apellido2 VARCHAR (20),
	DNI VARCHAR (9), 
	Direccion VARCHAR (100),
	Titulo VARCHAR (100),
	Gana INT NOT NULL,
	CONSTRAINT Profesores_Nombre_uu UNIQUE(Nombre, Apellido1,Apellido2),
	CONSTRAINT Profesores_DNI_pk PRIMARY KEY(DNI));

CREATE TABLE Cursos(
	Nombre_Curso VARCHAR (50),
	Cod_Curso INT,
	DNI_Profesor VARCHAR(9),
	Maximo_Alumnos INT,
	Fecha_Inicio DATE,
	Fecha_Fin DATE,
	Num_Horas INT NOT NULL,
	CONSTRAINT Cursos_Nombre_Curso_uu UNIQUE(Nombre_Curso),
	CONSTRAINT Cursos_Cod_Curso_pk PRIMARY KEY(Cod_Curso),
	CONSTRAINT Cursos_Fechas_ck CHECK (Fecha_Inicio<Fecha_Fin),
	CONSTRAINT Cursos_Profesor_fk FOREIGN KEY(DNI_Profesor) REFERENCES Profesores(DNI) ON DELETE CASCADE);

CREATE TABLE Alumnos(
	Nombre VARCHAR(20),
	Apellido1 VARCHAR (20),
	Apellido2 VARCHAR(20),
	DNI VARCHAR(9), 
	Direccion VARCHAR (100),
	Sexo CHAR(1),
	Fecha_Nacimiento DATE,
	Curso INT NOT NULL,
	CONSTRAINT Alumnos_Nombre_pk PRIMARY KEY(DNI),
	CONSTRAINT Alumnos_Sexo_ck CHECK (Sexo='H' OR Sexo='M'),
	CONSTRAINT Alumnos_Curso_fk FOREIGN KEY (Curso) REFERENCES Cursos(Cod_Curso) ON DELETE CASCADE);
    
INSERT INTO Profesores values
("Juan", "Arch", "López" ,32432455, "Puerta Negra 4" ,"Ing. Informática", 7500);
INSERT INTO Profesores values
("María", "Oliva", "Rubio" ,43215643, "Juan Alfonso 32" , "Lda. Fil. Inglesa", 5400);

INSERT INTO Cursos values
("Inglés Básico" , 1, 43215643, 15 ,"2019-11-01" ,"2019-12-22" ,120);
INSERT INTO Cursos values
("Administración Linux", 2, 32432455,NULL, "2019-09-04", NULL,100);

INSERT INTO Alumnos values 
("Lucas", "Manilva", "López", 123527, "Alhamar 3", "H", "1979-11-01", 1);
INSERT INTO Alumnos values
("Antonia", "López", "Alcantara", 2567597, "Maniquí 21", "M", NULL, 2);
INSERT INTO Alumnos values
("Manuel", "Alcantara", "Pedrós", 3123689, "Julian 2", NULL, NULL, 2);
INSERT INTO Alumnos values 
("José", "Pérez", "Caballar", 4896765, "Jarcha 5", "H", "1977-2-03", 1);
INSERT INTO Alumnos values
("Sergio", "Navas", "Retal", 123528, NULL, "H", NULL, 2);

Alter Table Profesores Add
edad INT Check(edad >= 18 and edad<=65);

Alter Table Cursos Add
Check(maximo_alumnos >= 10);

Alter Table Cursos Add
Check(num_horas >=100);

Alter Table Profesores
Modify Column Gana Int;

Alter Table Cursos 
Modify Column Fecha_Inicio date Not Null;

Alter Table Cursos
Drop foreign key Cursos_Profesor_fk;

Alter Table Profesores
drop primary key, 
add constraint profesores_pk primary key(nombre,apellido1,apellido2);

INSERT INTO Alumnos values 
("María", "Jaén", "Sevilla", 789678, "Martos 5", "M", "1977-03-10", 2);

UPDATE Alumnos
SET Fecha_Nacimiento = "1976-12-23"
WHERE Alumnos.dni = '2567597';


CREATE TABLE Nombre_de_Alumnos(
nombre_completo varchar (20) primary key
);

UPDATE Nombre_de_Alumnos
INNER JOIN Alumnos ON Nombre_de_Alumnos.nombre_completo =  CONCAT (Alumnos.nombre, Alumnos.Apellido1, Alumnos.Apellido2)
SET Nombre_de_Alumnos.nombre_completo = CONCAT (Alumnos.nombre, Alumnos.Apellido1, Alumnos.Apellido2);



