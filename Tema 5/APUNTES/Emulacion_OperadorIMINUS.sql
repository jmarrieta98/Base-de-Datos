-- El operador MINUS es uno de los tres operadores establecidos en el estándar SQL que incluye UNION, INTERSECT y MINUS.

-- MINUS compara los resultados de dos consultas y devuelve filas distintas del conjunto de resultados de la primera consulta que no aparece en el conjunto de resultados de la segunda consulta.

-- A continuación se ilustra la sintaxis del operador MINUS:

SELECT select_list1 
FROM table_name1
MINUS;
SELECT select_list2 
FROM table_name2;

-- Las reglas básicas para una consulta que utiliza el operador MINUS son las siguientes:

--     El número y el orden de las columnas en select_list1 y select_list2 deben ser iguales.
--     Los tipos de datos de las columnas correspondientes en ambas consultas deben ser compatibles.

-- Supongamos que tenemos dos tablas t1 y t2 con la siguiente estructura y datos:
  

CREATE TABLE t1 (
    id INT PRIMARY KEY
);
 
CREATE TABLE t2 LIKE t1;
 
INSERT INTO t1(id) VALUES(1),(2),(3);
 
INSERT INTO t2(id) VALUES(2),(3),(4);


-- La siguiente consulta devuelve valores distintos de la consulta de la tabla t1 que no se encuentra en el resultado de la consulta de la tabla t2.

-- SELECT id FROM t1
-- MINUS ;
-- SELECT id FROM t2;

-- + ---- +
-- | id |
-- + ---- +
-- | 1 |
-- | 2 |
-- | 3 |
-- + ---- +

-- MINUS 

-- + ---- +
-- | id |
-- + ---- +
-- | 2 |
-- | 3 |
-- | 4 |
-- + ---- +

/* = */

-- + ---- +
-- | id |
-- + ---- +
-- | 1 |


-- Microsoft SQL Server y PostgreSQL usan EXCEPT en lugar de MINUS. Tienen la misma función.
-- Emulación de operador MySQL MINUS

-- Desafortunadamente, MySQL no es compatible con el operador MINUS. Sin embargo, puede usar join para emularlo.

-- Para emular el MENOS(MINUS) de dos consultas, utiliza la siguiente sintaxis:

-- SELECT 
--    select_list
-- FROM 
--    table1
-- LEFT JOIN table2 
--    ON join_predicate
-- WHERE        siempre quitaremos la intersección con el where 
--    table2.column_name IS NULL; 


-- Por ejemplo, la siguiente consulta usa la cláusula LEFT JOIN para devolver el mismo resultado que el operador MINUS:
SELECT 
    id
FROM
    t1
LEFT JOIN
    t2 USING (id)
WHERE
    t2.id IS NULL;

-- aside





