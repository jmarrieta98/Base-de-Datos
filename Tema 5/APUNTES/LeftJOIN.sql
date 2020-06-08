

-- SELECT 
--    select_list
-- FROM
--    t1
-- LEFT JOIN t2 ON 
--    join_condition;

-- Cuando utiliza la cláusula LEFT JOIN, se introducen los conceptos de la tabla izquierda y la tabla derecha.

-- En la sintaxis anterior, t1 es la tabla izquierda y t2 es la tabla derecha.

-- La cláusula LEFT JOIN selecciona datos a partir de la tabla izquierda (t1). Hace coincidir cada fila de la tabla izquierda (t1) con cada fila de la tabla derecha (t2) según la condición de unión.

-- Si las filas de ambas tablas provocan que la condición de unión se evalúe como VERDADERA, la UNIÓN IZQUIERDA combina columnas de filas de ambas tablas en una nueva fila e incluye esta nueva fila en las filas de resultados.

-- En caso de que la fila de la tabla izquierda (t1) no coincida con ninguna fila de la tabla derecha (t2), la LEFT JOIN aún combina columnas de filas de ambas tablas en una nueva fila e incluye la nueva fila en las filas de resultados. Sin embargo, usa NULL para todas las columnas de la fila de la tabla derecha.

-- En otras palabras, LEFT JOIN devuelve todas las filas de la tabla izquierda, independientemente de si una fila de la tabla izquierda tiene una fila coincidente de la -- tabla derecha o no. Si no hay coincidencia, las columnas de la fila de la tabla derecha contendrán NULL.
