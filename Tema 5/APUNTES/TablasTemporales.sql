-- Una tabla temporal de MySQL tiene las siguientes características especializadas:

--  Se crea una tabla temporal utilizando la instrucción CREATE TEMPORARY TABLE. Observe que la palabra clave TEMPORARY se agrega entre las palabras clave CREATE y TABLE.
--  MySQL elimina la tabla temporal automáticamente cuando finaliza la sesión o se termina la conexión. Por supuesto, puede usar la instrucción DROP TABLE para eliminar una tabla temporal explícitamente cuando ya no la use.
--  Una tabla temporal solo está disponible y accesible para el cliente que la crea. Diferentes clientes pueden crear tablas temporales con el mismo nombre sin causar errores porque solo el cliente que crea la tabla temporal puede verla. Sin embargo, en la misma sesión, dos tablas temporales no pueden compartir el mismo nombre.
--  Una tabla temporal puede tener el mismo nombre que una tabla normal en una base de datos. Por ejemplo, si crea una tabla temporal llamada empleados en la base de datos de muestra, la tabla de empleados existente se vuelve inaccesible. Cada consulta que emite contra la tabla de empleados ahora se refiere a los empleados de la tabla temporal. Cuando suelta la tabla temporal de empleados, la tabla de empleados permanentes está disponible y accesible.

-- Sintaxis

-- CREATE TEMPORARY TABLE table_name(
--   column_1_definition,
--   column_2_definition,
--   ...,
--   table_constraints
-- );


-- Existe el comando: CREATE TABLE destino LIKE origen, pero CREATE TEMPORARY TABLE destino LIKE origen NO SIRVE, hay que usar:
-- CREATE TEMPORARY TABLE temp_table_name
-- SELECT * FROM original_table
-- LIMIT 0;

-- 1) Crear un ejemplo de tabla temporal

-- Primero, cree una nueva tabla temporal llamada créditos que almacene los créditos de los clientes:


CREATE TEMPORARY TABLE credits (
    customerNumber INT PRIMARY KEY,
    creditLimit DEC (10,2)
);

-- Luego, inserte filas de la tabla de clientes en los créditos de la tabla temporal:

INSERT INTO credits(customerNumber,creditLimit)
SELECT customerNumber, creditLimit
FROM customers
WHERE creditLimit > 0;

-- 2) Crear una tabla temporal cuya estructura se base en un ejemplo de consulta

-- El siguiente ejemplo crea una tabla temporal que almacena los 10 principales clientes por ingresos. La estructura de la tabla temporal se deriva de una instrucción SELECT:



CREATE TEMPORARY TABLE top_customers
SELECT p.customerNumber, 
       c.customerName, 
       ROUND(SUM(p.amount),2) sales
FROM payments p
INNER JOIN customers c ON c.customerNumber = p.customerNumber
GROUP BY p.customerNumber
ORDER BY sales DESC
LIMIT 10;

-- Ahora, puede consultar datos de la tabla temporal de top_customers, como consultar desde una tabla permanente:


SELECT 
    customerNumber, 
    customerName, 
    sales
FROM
    top_customers
ORDER BY sales;


-- Descartar una tabla temporal de MySQL

-- Puede usar la instrucción DROP TABLE para eliminar tablas temporales, sin embargo, es una buena práctica agregar la palabra clave TEMPORARY de la siguiente manera:

-- DROP TEMPORARY TABLE ; TIENES QUE PONER EL PONER EL NOMBRE DE LA TABLA QUE VAS A CREAR TEMPORALMENTE

-- La instrucción DROP TEMPORARY TABLE elimina solo una tabla temporal, no una tabla permanente. Le ayuda a evitar el error de descartar una tabla permanente cuando nombra su tabla temporal igual que el nombre de una tabla permanente

-- Por ejemplo, para eliminar la tabla temporal de topcustomers, use la siguiente instrucción:

DROP TEMPORARY TABLE top_customers;

-- Tenga en cuenta que si intenta eliminar una tabla permanente con la instrucción DROP TEMPORARY TABLE, recibirá un mensaje de error que indica que la tabla que está intentando eliminar es desconocida.

-- Si desarrolla una aplicación que utiliza una agrupación de conexiones o conexiones persistentes, no se garantiza que las tablas temporales se eliminen automáticamente cuando finalice su aplicación. Debido a que la conexión de base de datos que usa la aplicación aún puede estar abierta y colocada en un grupo de conexiones para que otros clientes la reutilicen más tarde. Por lo tanto, es una buena práctica eliminar siempre las tablas temporales cuando ya no las use.

-- Comprobando si existe una tabla temporal

-- MySQL no proporciona una función o declaración para verificar directamente si existe una tabla temporal. Sin embargo, podemos crear un procedimiento almacenado que verifique si existe una tabla temporal o no de la siguiente manera***:


DELIMITER //
CREATE PROCEDURE check_table_exists(table_name VARCHAR(100)) 
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @err = 1;
    SET @err = 0;
    SET @table_name = table_name;
    SET @sql_query = CONCAT('SELECT 1 FROM ',@table_name);
    PREPARE stmt1 FROM @sql_query;
    IF (@err = 1) THEN
        SET @table_exists = 0;
    ELSE
        SET @table_exists = 1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END //
DELIMITER ;


-- En este procedimiento, intentamos seleccionar datos de una tabla temporal. Si la tabla temporal existe, la variable @table_exists se establece en 1; de lo contrario, se establece en 0.

-- Esta declaración llama a check_table_exists para verificar si existen los créditos de la tabla temporal:


CALL check_table_exists ('credits');
SELECT @table_exists;



-- *** Para tablas InnoDB si existe una manera de comprobar si hay tablas temporales
CREATE TEMPORARY TABLE t1 (c1 INT PRIMARY KEY) ENGINE=INNODB;
SHOW TABLES FROM INFORMATION_SCHEMA LIKE 'INNODB_TEMP%';
SELECT * FROM INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFOG











