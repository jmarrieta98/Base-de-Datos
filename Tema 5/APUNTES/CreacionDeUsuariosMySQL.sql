-- Sintaxis de MySQL CREATE USER

-- La instrucción CREATE USER crea un nuevo usuario en el servidor de bases de datos.

-- Aquí está la sintaxis básica de la instrucción CREATE USER:

-- CREAR USUARIO [SI NO EXISTE] nombre_cuenta
-- IDENTIFICADO POR 'contraseña';
Create User if not exists nombre_cuenta
identified by 'contraseña';

-- En esta sintaxis:

-- Primero, especifique el nombre de la cuenta después de las palabras
-- clave CREAR USUARIO. El nombre de la cuenta tiene dos partes: nombre
-- de usuario y nombre de host, separados por el signo @:

-- username@hostname

-- El nombre de usuario es el nombre del usuario. Y hostname es el nombre
-- del host desde el cual el usuario se conecta al servidor MySQL.

-- La parte del nombre de host del nombre de la cuenta es opcional. Si lo
-- omite, el usuario puede conectarse desde cualquier host.

-- Un nombre de cuenta sin un nombre de host es equivalente a:

-- username@%

-- Si el nombre de usuario y el nombre de host contienen caracteres
-- especiales como espacio o -, debe citar el nombre de usuario y el
-- nombre de host por separado de la siguiente manera: 1

-- 'username'@'hostname'

-- Además de la comilla simple ('), puede usar comillas invertidas (`) o
-- comillas dobles (").

-- En segundo lugar, especifique la contraseña para el usuario después de
-- las palabras clave IDENTIFICADAS POR.

-- La opción SI NO EXISTE crea condicionalmente un nuevo usuario solo si
-- no existe.

-- Tenga en cuenta que la instrucción CREATE USER crea un nuevo usuario
-- sin ningún privilegio. Para otorgar privilegios al usuario, utilice la
-- declaración GRANT.

-- MySQL CREATE USER. Ejemplo.

-- 1º, conectar con el servidor de  MySQL :

--    mysql -u root -p (root o cualquier usuario con privilegios adecuados)

-- Introducir la contraseña:

-- Enter password: ********

-- 2º, ver los usuario que hay registrados en el servidor MySQ:

-- mysql> select user from mysql.user; <-- tabla donde se guardan los usarios DC o DD

-- Ejemplo de salida:

-- +------------------+
-- | user             |
-- +------------------+
-- | mysql.infoschema |
-- | mysql.saession   |
-- | mysql.sys        |
-- | root             |
-- +------------------+

-- 3º, Crear un usuario nuevo llamado bob:

-- mysql> create user bob@localhost identified by 'Secure1pass!';

-- 4º, vemos de nuevo los usuarios

-- mysql> select user from mysql.user;

-- +------------------+
-- | user             |
-- +------------------+
-- | bob              |
-- | mysql.infoschema |
-- | mysql.session    |
-- | mysql.sys        |
-- | root             |
-- +------------------+
-- 5 rows in set (0.00 sec)

-- El usuario bob sido creado con éxito.

-- 5º, abrimos otra sesión en el servidor y entramos como Bob:

-- mysql -u bob -p

-- Introduce la contraseña de bor y pulsa Enter:

-- Enter password: ********

-- 6º, ver las bases de datos a las que bob tiene acceso:

-- mysql> show databases;

-- Y la lista es...:

-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- +--------------------+
-- 1 row in set (0.01 sec)

-- 7º vamos a la sesión del administrador creamos una nueva base de datos llamada bobdb:

-- mysql> create database bobdb;

-- 8º seleccionar la base de datos bobdb:

-- mysql> use bobdb;

-- 9º crear una nueva tabla llamada  listas:

-- mysql> create table lists(
-- -> id int auto_increment primary key,
-- -> todo varchar(100) not null,
-- -> completed bool default false);

-- Ten en cuanta que -> es lo que muestra MySQL cuando pulsass enter y
-- el comando no está terminado. Espera que lo continúes en la
-- siguiente línea.

-- 10, dar todos privilegios (grant all privileges) sobre la base bobdb a bob:

-- mysql> grant all privileges on bobdb.* to bob@localhost;

-- Más adelante veremos con más detalle la concesión y revocación de privilegios:

-- 11º, vuelve a la sesión de bos y muestra las bases de datos de nuevo:

-- mysql> show databases;

-- Ahora, bob puede bobdb:

-- +--------------------+
-- | Database           |
-- +--------------------+
-- | bobdb              |
-- | information_schema |
-- +--------------------+
-- 2 rows in set (0.00 sec)

-- 12º, selecciona la base bobdb:

-- mysql> use bobdb;

-- 13º, muestra las tablas de bobdb:

-- mysql> show tables;

-- bob puede ver la tabla lists:

-- +-----------------+
-- | Tables_in_bobdb |
-- +-----------------+
-- | lists           |
-- +-----------------+
-- 1 row in set (0.00 sec)

-- 14º, inserta una fila en la tabla lists:

-- mysql> insert into lists(todo) values('Learn MySQL');

-- 15º, consulta los datos de la tabla:

-- mysql> select * from lists;

-- La salida es:

-- +----+-------------+-----------+
-- | id | todo        | completed |
-- +----+-------------+-----------+
-- |  1 | Learn MySQL |         0 |
-- +----+-------------+-----------+
-- 1 row in set (0.00 sec)

-- Ahora bob puede hacer de todo en la base de datos bobdb.

-- Podemos cerrar las sesiones.

-- mysql> exit
