Drop database Farmacia;
Create Database Farmacia;
Use Farmacia;
Create table Familia (
Codigo_Fam decimal (20) NOT NULL primary key,
Descripcion_Fam Varchar(100)
);

Create table Laboratorio (
Codigo_Lab decimal (20) NOT NULL PRIMARY KEY,
Nombre_Lab Varchar(100),
Telefono_Lab decimal (11),
Direccion_Lab varchar(100),
Fax_Lab int (11),
Contacto_Lab int (9)
);

Create Table Cliente (
DNI_Cli varchar (9) NOT NULL PRIMARY KEY,
Telefono_Cli int (9),
Direccion_Cli varchar(100)
);

Create Table Medicamento (
Codigo_Med decimal (20) NOT NULL PRIMARY KEY,
Nombre_Med varchar (100),
Tipo_Med varchar (100),
Stock_Med decimal (5),
Vendidas_Med decimal (10),
Precio_Med decimal (10),
Receta_Med varchar (100),
Codigo_Fam decimal (20) NOT NULL,
Codigo_Lab decimal (20) NOT NULL,
foreign key (Codigo_Fam) References Familia(Codigo_Fam),
foreign key (Codigo_Lab) References Laboratorio(Codigo_Lab)
);
Create Table C_Credito (
DNI_Cli varchar(9) NOT NULL PRIMARY KEY,
Datos_Banco varchar (200),
foreign key(DNI_Cli) References Cliente(DNI_Cli)
);
Create Table Comp_Efec(
Codigo_Med decimal(20) NOT NULL,
DNI_Cli varchar(9) NOT NULL,
Fecha_Comp datetime NOT NULL,
foreign key(Codigo_Med) references Medicamento(Codigo_Med),
foreign key(DNI_Cli) references Cliente(DNI_Cli)
);
Create Table Comp_Cred(
Codigo_Medi decimal(20) NOT NULL,
DNI_cli varchar(9) NOT NULL,
Fecha_Comp datetime NOT NULL,
Unidades decimal (50),
Fecha_Pago datetime,
foreign key(Codigo_Medi) references Medicamento(Codigo_Med),
foreign key(DNI_Cli) references Cliente(DNI_Cli)
);


