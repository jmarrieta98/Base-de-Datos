create database MediaMarkting;
use MediaMarkting;  
Create table cliente(
cod_cliente char (8) not null primary key,
datos_cliente varchar (100) not null,
nom_cliente varchar (8) not null,
dir_cliente varchar (8) not null,
cp_direccion int (4) not null,
telef_cliente int (10) not null,
edad_cliente int (3) not null,
fechanaccli date  not null
);
Create table alquiler(
cod_alquiler char (8) not null primary key,
valor_alquiler int not null,
cod_cliente char (8) not null,
foreign key (cod_cliente) references cliente(cod_cliente)
);  
Create table alquilado(
cod_alquiler char (8) not null primary key,
cod_pelicula char (8) not null,
fecha_alquiler date not null,
fecha_dev date not null,
cantidad decimal (10) not null,
foreign key (cod_alquiler) references alquiler(cod_alquiler)
);

Create table tipo(
cod_tipo char (8) not null primary key,
categoria enum ("comedia","suspense","drama","accion","ciencia ficcion")
);
Create table pelicula(
cod_pelicula char (8) not null primary key,
titulo varchar (10) not null,
cod_tipo char (8) not null,
foreign key (cod_tipo) references tipo (cod_tipo)
);

Create table dvds(
cod_dvds char (8) not null primary key,
num_copias int (100) not null,
formato varchar (8) not null,
cod_pelicula char (8) not null,
foreign key (cod_pelicula) references pelicula(cod_pelicula)
);

Create table actor(
cod_actor char (8) not null primary key,
nom_actor varchar (9) not null,
fechanac_actor date not null
);

