create database Pinacoteca;
use Pinacoteca;

drop table escuela;
Create table Escuela (
nombre_escuela varchar(20) primary key,
escuela_pais varchar(20),
escuela_fecha date 
);


Create table Pintor (
nombre_pintor varchar(20) primary key,
pintor_pais varchar(30),
pintor_ciudad varchar(30),
nombre_escuela varchar(30),
foreign key (nombre_escuela) references Escuela(nombre_escuela)
);

Create table Mecenas(
nombre_mecenas varchar(20) primary key,
mecenas_pais varchar(20),
mecenas_ciudad varchar(20)
);

drop table Mecenazgo;
Create table Mecenazgo ( 
nombre_mecenas varchar (20) not null,
nombre_pintor varchar (20) not null,
primary key (nombre_mecenas, nombre_pintor),
foreign key (nombre_mecenas) references Mecenas(nombre_mecenas),
foreign key (nombre_pintor) references Pintor(nombre_pintor)
);

Create table Cuadro (
cuadro_codigo int (20) primary key,
cuadro_nombre varchar (20),
fecha_cuadro date,
cuadro_medidas int (20),
cuadro_tecnica varchar (7),
nombre_pintor varchar (20),
foreign key (nombre_pintor) references Pintor(nombre_pintor)
);
