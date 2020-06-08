-- Operador MySQL UNION

-- El operador UNION MySQL le permite combinar dos o más conjuntos de resultados de consultas en un solo conjunto de resultados. A continuación se ilustra la sintaxis del operador UNION:


-- SELECT column_list
-- UNION [DISTINCT | ALL]
-- SELECT column_list
-- UNION [DISTINCT | ALL]
-- SELECT column_list
-- ...
-- Para combinar el conjunto de resultados de dos o más consultas con el operador UNION, estas son las reglas básicas que debe seguir:

--    Primero, el número y el orden de las columnas que aparecen en todas las instrucciones SELECT deben ser iguales.
--    En segundo lugar, los tipos de datos de las columnas deben ser iguales o compatibles.

-- De forma predeterminada, el operador UNION elimina filas duplicadas incluso si no especifica explícitamente el operador DISTINCT.

-- Veamos las siguientes tablas de muestra: t1 y t2:


DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
 
CREATE TABLE t1 (
    id INT PRIMARY KEY
);
 
CREATE TABLE t2 (
    id INT PRIMARY KEY
);
 
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);
 


-- La siguiente instrucción combina conjuntos de resultados devueltos de las tablas t1 y t2:

SELECT id
FROM t1
UNION
SELECT id
FROM t2;

-- El conjunto de resultados finales contiene los valores distintos de conjuntos de resultados separados devueltos por las consultas:

-- + ---- +
-- | id |
-- + ---- +
-- | 1 |
-- | 2 |
-- | 3 |
-- | 4 |
-- + ---- +
-- 4 rows in set (0.00 sec)

-- Debido a que las filas con valores 2 y 3 son duplicados, UNION las eliminó y mantuvo solo valores únicos.


-- Si usa UNION ALL explícitamente, las filas duplicadas, si están disponibles, permanecerán en el resultado. Debido a que UNION ALL no necesita manejar duplicados, funciona más rápido que UNION DISTINCT.


SELECT id
FROM t1
UNION ALL
SELECT id
FROM t2;


-- + ---- +
-- | id |
-- + ---- +
-- | 1 |
-- | 2 |
-- | 3 |
-- | 2 |
-- | 3 |
-- | 4 |
-- + ---- +
-- 6 rows in set (0.00 sec)

-- Como puede ver, los duplicados aparecen en el conjunto de resultados combinados debido a la operación UNION ALL.
--  UNIÓN vs. JOIN

-- JOIN combina los conjuntos de resultados horizontalmente,  UNION  verticalmente:

-- + ---- +
-- | id |
-- + ---- +
-- | 1 |
-- | 2 |
-- | 3 |
-- + ---- +

-- UNION 

-- + ---- +
-- | id |
-- + ---- +
-- | 2 |
-- | 3 |
-- | 4 |
-- + ---- +

-- =


-- + ---- +
-- | id |
-- + ---- +
-- | 1 |
-- | 2 |
-- | 3 |
-- | 4 |
-- + ---- +



-- + ---- +
-- | id |
-- + ---- +
-- | 1 |
-- | 2 |
-- | 3 |
-- + ---- +

-- JOIN 

-- + ---- +
-- | id |
-- + ---- +
-- | 2 |
-- | 3 |
-- | 4 |
-- + ---- +

-- =


-- + ---- +-----+
-- | id   | id  | 
-- + ---- +-----+
-- | 2    |  2  | 
-- | 3    |  3  |
-- + ---- +-----+




-- MySQL UNION y ejemplos de alias de columna

-- Utilizaremos las tablas de customers y employees de la base de datos de muestra para la demostración:


-- Suponga que desea combinar el nombre y el apellido de empleados y clientes en un único conjunto de resultados, puede usar el operador UNION de la siguiente manera:


SELECT 
    firstName, 
    lastName
FROM
    employees 
UNION 
SELECT 
    contactFirstName, 
    contactLastName
FROM
    customers;



-- Como puede ver en la salida, MySQL UNION utiliza los nombres de columna de la primera instrucción SELECT para los encabezados de columna de la salida.

-- Si desea usar otros encabezados de columna, debe usar alias de columna explícitamente en la primera instrucción SELECT como se muestra en el siguiente ejemplo:

-- MySQL UNION con ejemplo de alias de columna	
SELECT 
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers;



-- Este ejemplo utiliza el encabezado de columna de la primera consulta para la salida. Utiliza la función CONCAT () para concatenar el nombre, el espacio y el apellido en un nombre completo.

-- Ejemplo de MySQL UNION y ORDER BY

-- Si desea ordenar el conjunto de resultados de una unión, use una cláusula ORDER BY en la última instrucción SELECT como se muestra en el siguiente ejemplo:

SELECT 
    concat(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    concat(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY fullname;


-- Tenga en cuenta que si coloca la cláusula ORDER BY en cada instrucción SELECT, no afectará el orden de las filas en el conjunto de resultados final.

-- Para diferenciar entre empleados y clientes, puede agregar una columna como se muestra en la siguiente consulta:

	
SELECT 
    CONCAT(firstName, ' ', lastName) fullname, 
    'Employee' as contactType
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName, ' ', contactLastName),
    'Customer' as contactType
FROM
    customers
ORDER BY 
    fullname;



-- MySQL también le proporciona una opción alternativa para ordenar un conjunto de resultados basado en la posición de la columna utilizando la cláusula ORDER BY de la siguiente manera :

SELECT 
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY 1;

-- Sin embargo, no es una buena práctica ordenar el conjunto de resultados por posición de columna.

SELECT 
    CONCAT(firstName, ' ', lastName) AS fullname
FROM employees
UNION
SELECT
	CONCAT (contactfirstName,' ', contactlastName)
FROM customers
ORDER BY fullname;




