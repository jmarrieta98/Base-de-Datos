create database VideoClub;
use VideoClub;
Create Table Peliculas(
Codpelicula int(4) NOT NULL PRIMARY KEY,
Nombre_Pelicula varchar(20),
Categoria enum("Comedia", "Drama", "Terror","Suspense", "Ficcion")
);
Create Table Copias(
Codcopia int (2) NOT NULL PRIMARY KEY,
Codpelicula int(4) NOT NULL,
Esdado enum("Alquilado","Libre","Vendida"),
Foreign Key (Codpelicula) references Peliculas(Codpelicula)
);
Create Table Clientes(
Codcliente int (4) NOT NULL PRIMARY KEY,
Nombre_Cliente varchar(30),
DNI_Cliente varchar(9),
Telefono_Cliente int(9)
);
Create Table Alquileres(
Codcliente int (4) NOT NULL,
Codpelicula int (4) NOT NULL,
Codcopia int (2) NOT NULL,
Fecha datetime NOT NULL,
foreign Key (Codcliente) references Clientes(Codcliente),
foreign key (Codcopia) references Copias(Codcopia),
foreign key (Codpelicula) references Peliculas(Codpelicula)
);
