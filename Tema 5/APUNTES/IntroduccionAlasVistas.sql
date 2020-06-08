-- Introducción a las vistas de MySQL

-- trabajaremos con las tablas customers y payments

-- Esta consulta devuelve datos de las tablas clientes y pagos mediante la combinación interna:

SELECT 
    customerName, 
    checkNumber, 
    paymentDate, 
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);


-- La próxima vez, si desea obtener la misma información, incluido el nombre del cliente, el número de cheque, la fecha de pago y el monto, debe volver a realizar la misma consulta.

-- Una forma de hacerlo es guardar la consulta en un archivo, ya sea .txt o .sql, para que luego pueda abrirlo y ejecutarlo desde MySQL Workbench o cualquier otra herramienta cliente de MySQL.

-- Una mejor manera de hacerlo es guardar la consulta en el servidor de la base de datos y asignarle un nombre. Esta consulta con nombre se denomina vista de base de datos, o simplemente vista.

-- Por definición, una vista es una consulta con nombre almacenada en el catálogo de la base de datos.

-- Para crear una nueva vista, use la instrucción CREATE VIEW. Esta declaración crea una vista CustomerPayments basada en la consulta anterior anterior:

CREATE VIEW customerPayments
AS 
SELECT 
    customerName, 
    checkNumber, 
    paymentDate, 
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);


-- Una vez que ejecuta la instrucción CREATE VIEW, MySQL crea la vista y la almacena en la base de datos.

-- Ahora, puede hacer referencia a la vista como una tabla en las instrucciones SQL. Por ejemplo, puede consultar datos desde la vista customerPayments utilizando la instrucción SELECT:

SELECT * FROM customerPayments;

-- Como puede ver, la sintaxis es mucho más simple.

-- Tenga en cuenta que una vista no almacena físicamente los datos. Cuando emite la instrucción SELECT contra la vista, MySQL ejecuta la consulta subyacente especificada en la definición de la vista y devuelve el conjunto de resultados. Por este motivo, a veces, una vista se denomina tabla virtual.

-- MySQL le permite crear una vista basada en una instrucción SELECT que recupera datos de una o más tablas. Esta imagen ilustra una vista basada en columnas de varias tablas,


-- Por ejemplo, puede crear una vista llamada daysofweek que devuelva 7 días de la semana ejecutando la siguiente consulta:
CREATE VIEW daysofweek (day) AS
    SELECT 'Mon' 
    UNION 
    SELECT 'Tue'
    UNION 
    SELECT 'Web'
    UNION 
    SELECT 'Thu'
    UNION 
    SELECT 'Fri'
    UNION 
    SELECT 'Sat'
    UNION 
    SELECT 'Sun';

-- Y puede consultar los datos de la vista de días de la semana de la siguiente manera:


SELECT * FROM daysofweek;



-- Ventajas de las vistas MySQL


-- 1) Simplificar consulta compleja

-- Las vistas ayudan a simplificar consultas complejas. Si tiene alguna consulta compleja de uso frecuente, puede crear una vista basada en ella para que pueda hacer referencia a la vista utilizando una simple instrucción SELECT en lugar de escribir la consulta nuevamente.
-- 2) Hacer coherente la lógica de negocios

-- Suponga que tiene que escribir repetidamente la misma fórmula en cada consulta. O tiene una consulta que tiene una lógica empresarial compleja. Para que esta lógica sea coherente en todas las consultas, puede usar una vista para almacenar el cálculo y ocultar la complejidad.
-- 3) Agregue capas de seguridad adicionales

-- Una tabla puede exponer una gran cantidad de datos, incluidos datos confidenciales, como información personal y bancaria.

-- Mediante el uso de vistas y privilegios, puede limitar a qué datos pueden acceder los usuarios al exponerles solo los datos necesarios.

-- Por ejemplo, los empleados de la tabla pueden contener SSN e información de dirección, a la que solo debe poder acceder el departamento de recursos humanos.

-- Para exponer información general, como nombre, apellido y género al departamento de Administración General (GA), puede crear una vista basada en estas columnas y otorgar a los usuarios del departamento GA a la vista, no a todos los empleados de la tabla.

-- 4) Habilita la compatibilidad con versiones anteriores

-- En sistemas heredados, las vistas pueden permitir la compatibilidad con versiones anteriores.

-- Suponga que desea normalizar una tabla grande en muchas más pequeñas. Y no desea afectar las aplicaciones actuales que hacen referencia a la tabla.

-- En este caso, puede crear una vista cuyo nombre sea el mismo que la tabla basada en las nuevas tablas para que todas las aplicaciones puedan hacer referencia a la vista como si fuera una tabla.

-- Tenga en cuenta que una vista y una tabla no pueden tener el mismo nombre, por lo que primero debe soltar la tabla antes de crear una vista cuyo nombre sea el mismo que la tabla eliminada.
