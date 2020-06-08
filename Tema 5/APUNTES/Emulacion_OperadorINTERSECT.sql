-- El operador INTERSECT es un operador de conjunto que devuelve solo filas distintas de dos consultas o más consultas.

-- A continuación se ilustra la sintaxis del operador INTERSECT.


(SELECT column_list 
FROM table_1)
INTERSECT 
(SELECT column_list
FROM table_2);

-- El operador INTERSECT compara los conjuntos de resultados de dos consultas y devuelve las distintas filas que generan ambas consultas.

-- Para usar el operador INTERSECT para dos consultas, siga estas reglas:

--     El orden y el número de columnas en la lista de selección de las consultas deben ser iguales.
--     Los tipos de datos de las columnas correspondientes deben ser compatibles.





DROP TABLE t1;
CREATE TABLE t1 (
    id INT PRIMARY KEY
);

DROP TABLE t2;
CREATE TABLE t2 LIKE t1;
 
INSERT INTO t1(id) VALUES(1),(2),(3);
 
INSERT INTO t2(id) VALUES(2),(3),(4);

SELECT id FROM t1;


-- id
-- ----
-- 1
-- 2
-- 3


SELECT id
FROM t2;

-- id
-- ----
-- 2
-- 3
-- 4


-- MySql no soporta el operador INTERSECT aqí que hay que emularlo

-- 1) Emular INTERSECT utilizando la cláusula DISTINCT e INNER JOIN

SELECT DISTINCT id 
FROM t1 INNER JOIN t2
USING(id);

-- id
-- ----
-- 2
-- 3


-- La siguiente instrucción utiliza el operador DISTINCT y la cláusula INNER JOIN para devolver las distintas filas en ambas tablas:

-- Cómo funciona.

--     La cláusula INNER JOIN devuelve filas de las tablas izquierda y derecha.
--     El operador DISTINCT elimina las filas duplicadas.


-- 2) Emulación de  INTERSECT usando IN y subconsulta

-- La siguiente instrucción usa el operador IN y una subconsulta para devolver la intersección de los dos conjuntos de resultados.

SELECT DISTINCT id
FROM t1
WHERE id IN (SELECT id FROM t2);

-- id
-- ----
-- 2
-- 3

-- Cómo funciona.

--     La subconsulta devuelve el primer conjunto de resultados.
--     La consulta externa utiliza el operador IN para seleccionar solo los valores que existen en el primer conjunto de resultados. El operador DISTINCT garantiza que solo se seleccionen valores distintos.

