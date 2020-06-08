Create Database Empleados;
use Empleados;
Create Table Empleado (
DNI decimal (8) not null primary key,
Apellido1 varchar (10) not null,
Apellido2 varchar (15) not null,
Direcc1 varchar (25) not null,
Direcc2 varchar (20) not null,
Ciudad varchar (20) not null,
Municipio varchar (20) not null,
Codpostal varchar (5),
sexo enum ("H","M"),
fecha_nac datetime not null
);
Create Table Historial_Laboral (
empleado_dni decimal(8) not null primary key,
traba_cod decimal (5) not null,
fecha_inicio datetime not null,
fecha_fin datetime not null,
dpt_cod decimal (5) not null,
supervisor_dni decimal (8) not null,
foreign key (empleado_DNI) references Empleado(DNI)
);
Create Table Historial_Salarial (
empleado_dni decimal (8) not null primary key,
salario int (100) not null,
fecha_comienzo datetime not null,
fecha_fin datetime not null,
foreign key (empleado_DNI) references Empleado(DNI)
);
Create Table Departamentos (
Dpt_Cod decimal (5) not null primary key,
nombre_dpt varchar (30) not null,
jefe varchar (5) not null,
presupuesto int (100) not null,
pres_actual int (100) not null
);
Create Table Estudios (
empleado_dni decimal (8) not null primary key,
universidad decimal (5) not null,
año datetime  not null,
grado varchar (3) not null,
especialidad varchar (20) not null,
foreign key (empleado_DNI) references Empleado(DNI)
);
Create Table Universidades (
univ_cod decimal (5) not null primary key,
nombre_univ varchar (20) not null,
ciudad varchar (20) not null,
municipio varchar (2) not null,
cod_postal varchar (5) not null
);
Create Table Trabajos (
codigo decimal (5) not null primary key,
nombre varchar (20) not null,
salario_min decimal (2) not null,
salario_max decimal (2) not null
);
