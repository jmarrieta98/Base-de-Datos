create database festejos;
use festejos;
CREATE TABLE municipio(
nombre_municipio varchar (20) not null primary key,
superficie int (100) not null,
num_habitantes decimal (20) not null,
presupuesto int (100) not null
);
CREATE TABLE peña1(
nombre_peña varchar (20) not null primary key,
num_componentes decimal (10) not null,
año_creacion date
);
CREATE TABLE colaboracion(
nombre_municipio varchar (20) not null ,
nombre_peña varchar (20) not null,
foreign key (nombre_municipio) References municipio(nombre_municipio),
foreign key (nombre_peña) References peña1(nombre_peña),
primary key (nombre_municipio,nombre_peña)
);
CREATE TABLE grupo(
nombre_grupo varchar (10) not null primary key,
numero_compo varchar (10) not null,
año_formacion date not null,
precio_actuacion decimal (20) not null
);
CREATE TABLE peña_grupo(
nombre_grupo varchar (20) not null,
nombre_peña varchar (20) not null,
foreign key (nombre_grupo) references grupo(nombre_grupo),
foreign key (nombre_peña) references peña1(nombre_peña),
primary key (nombre_grupo, nombre_peña)
);
CREATE TABLE encierro(
fecha_encierro date not null primary key,
ganaderia varchar (10) not null,
numero_heridos decimal (20) not null
);
CREATE TABLE encierro_municipio(
nombre_municipio varchar (20) not null,
fecha_encierro date not null,
foreign key (nombre_municipio) references municipio(nombre_municipio),
foreign key (fecha_encierro) references encierro(fecha_encierro),
primary key (nombre_municipio, fecha_encierro)
);
CREATE TABLE p_e1(
nombre_peña varchar (20) not null,
fecha_encierro date not null,
foreign key (nombre_peña) references peña1(nombre_peña),
foreign key (fecha_encierro) references encierro(fecha_encierro),
primary key (nombre_peña, fecha_encierro)
);
CREATE TABLE encierros_heridos(
fecha_encierro date not null primary key,
heridos decimal (20) not null,
foreign key (fecha_encierro) references encierro(fecha_encierro)
);