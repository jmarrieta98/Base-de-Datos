CREATE TABLE tienda(
cod_tienda decimal(4),
nomtienda varchar (100) NOT NULL,
direc_tienda varchar (100) NOT NULL,
telef_tienda char(9) NOT NULL,
CONSTRAINT tienda_cod_tienda_pk primary key (cod_tienda),
CONSTRAINT tienda_cod_tienda_ck check (cod_tienda > 999 AND cod_tienda < 10000));

CREATE TABLE electros(
cod_elect char(9) NOT NULL,
descripcion varchar (100) NOT NULL,
CONSTRAINT electros_codelect_pk primary key (cod_elect));

CREATE TABLE clientes2(
cod_cliente decimal(6) NOT NULL,
nom_cliente varchar (100) NOT NULL,
domicilio_cli varchar (100) NOT NULL,
telefono_cli char(9) NOT NULL,
CONSTRAINT clientes_cod_cli_pk primary key (cod_cliente),
CONSTRAINT clientes_cod_cli_ck check (cod_cliente > 10000));

CREATE TABLE precios(
cod_elect varchar(10),
cod_tienda decimal(4),
precio_unidad decimal(6,2) NOT NULL,
CONSTRAINT precios_codelect_pk primary key (cod_elect, cod_tienda),
CONSTRAINT precios_codelect_fk foreign key (cod_elect) references electros (cod_elect),
CONSTRAINT precios_codtienda_fk foreign key (cod_tienda) references tienda (cod_tienda));

CREATE TABLE vendedor(
nif_vendedor varchar(9),
nombre_vendedor varchar(100) NOT NULL,
telefono_vendedor varchar(9) NOT NULL,
CONSTRAINT vendedor_nif_vendedor_pk primary key (nif_vendedor),
CONSTRAINT vendedor_telefono_vendedor_uu unique (telefono_vendedor));

CREATE TABLE ventas(
cod_elect varchar(9),
cod_tienda decimal(4),
cod_cliente decimal(6),
fechahora_venta date,
unidades_vendidas decimal(2) NOT NULL,
descuento decimal(4,2) NOT NULL,
nif_vendedor varchar(9) NOT NULL,
CONSTRAINT ventas_cod_elect_pk primary key (cod_elect, cod_tienda, cod_cliente, fechahora_venta),
CONSTRAINT ventas_unidades_vendidas_ck check (unidades_vendidas > 1),
CONSTRAINT ventas_cod_elelect_fk foreign key (cod_elect, cod_tienda) references precios (cod_elect, cod_tienda),
CONSTRAINT ventas_cod_cliente_fk foreign key (cod_cliente) references clientes2 (cod_cliente),
CONSTRAINT ventas_nif_vendedor_fk foreign key (nif_vendedor) references vendedor (nif_vendedor));