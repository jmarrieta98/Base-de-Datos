create database Multas;
use Multas;
CREATE Table infraccion(
cod_infraccion decimal(4) primary key not null,
importe_sancion decimal(5) not null ,
descripcion varchar(300) not null,
check(importe_sancion>30)
);
create table infractor(
nif_sancionado varchar(9) primary key not null,
nombre_sancionado varchar(100)
);
create table agente(
nif_agente varchar(9) primary key not null,
num_agente decimal(4) unique not null,
nombre_agente varchar(100) not null,
rango_agente varchar(20) default ("Agente")
);
create table propietario(
nif_propietario varchar(9) primary key not null,
nombre_propietario varchar(50) not null
);
create table vehiculo(
matricula varchar(7) primary key not null,
marca varchar(30) not null,
modelo varchar (30) not null,
color varchar(30),
nif_propietario varchar(9) not null,
foreign key (nif_propietario) references propietario(nif_propietario),
cia_aseguradora varchar(30),
num_poliza decimal(5) unique
);

create table denuncia(
nif_agente varchar(9)not null,
foreign key (nif_agente) references agente(nif_agente),
fechahora_infraccion datetime primary key not null,
lugar varchar(100) not null,
cod_infraccion decimal(4) not null,
matricula varchar(7) not null,
foreign key (matricula) references vehiculo(matricula),
foreign key (cod_infraccion) references infraccion(cod_infraccion),
nif_sancionado varchar(9) not null,
foreign key (nif_sancionado) references infractor(nif_sancionado),
papel_sancionado varchar(20) not null,
inmovilizado enum("S","N") not null default ("N"),
matricula_grua varchar(7),
nif_grua varchar(9)
);