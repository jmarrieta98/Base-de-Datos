-- En MySQL, las vistas no solo se pueden consultar, sino que también se pueden actualizar. Significa que puede usar la instrucción INSERT o UPDATE para insertar o actualizar filas de la tabla base a través de la vista actualizable. Además, puede usar la instrucción DELETE para eliminar filas de la tabla subyacente a través de la vista.

-- Sin embargo, para crear una vista actualizable, la instrucción SELECT que define la vista no debe contener ninguno de los siguientes elementos:

--   + Funciones agregadas como MIN , MAX , SUM , AVG y COUNT .
--   + DISTINCT
--   + Cláusula GROUP BY .
--   + HAVING .
--   + UNION o UNION ALL .
--   + LEFT JOIN U OUTER JOIN.
--   + La subconsulta en la cláusula SELECT o en la cláusula WHERE que se refiere a tablas que aparecen en la cláusula FROM.
--   + Referencia a la vista no actualizable en la cláusula FROM.
--   + Referencia solo a valores literales.
--   + Múltiples referencias a cualquier columna de la tabla base.

-- Si crea una vista con el algoritmo TEMPTABLE , no puede actualizar la vista.

-- Tenga en cuenta que a veces es posible crear vistas actualizables basadas en múltiples tablas usando un INNER JOIN.
-- Ejemplo de vista actualizable de MySQL

-- Creemos una vista actualizable.

-- Primero, creamos una vista llamada officeInfo basada en la tabla de offices en la base de datos de muestra . La vista se refiere a tres columnas de la tabla de offices : phone, officeCode y city .

 CREATE   VIEW  officeInfo
  AS
    SELECT  officeCode, phone, city
    FROM  offices;

-- A continuación, podemos consultar datos desde la vista officeInfo utilizando la siguiente instrucción:

 SELECT
    *
 FROM
    officeInfo;


-- Luego, podemos cambiar el número de teléfono de la oficina con officeCode 4 a través de la vista officeInfo utilizando la siguiente instrucción UPDATE .

 UPDATE  officeInfo
 SET
    phone =  '+33 14 723 5555'
 WHERE
    officeCode = 4;

-- Finalmente, para verificar el cambio, podemos consultar los datos desde la vista officeInfo ejecutando la siguiente consulta:
 SELECT
    *
 FROM
    officeInfo
 WHERE
    officeCode = 4;

-- Comprobación de información de vista actualizable

-- Puede verificar si una vista en una base de datos es actualizable consultando la columna is_updatable de la tabla de vistas en la base de datos information_schema .

-- La siguiente consulta obtiene todas las vistas de la base de datos de modelos clásicos y muestra qué vistas son actualizables.

 SELECT
    table_name,
    is_updatable
 FROM
    information_schema.views
 WHERE
    table_schema =  'classicmodels' ;


-- Eliminar filas a través de la vista

-- Primero, creamos una tabla llamada artículos, insertamos algunas filas en la tabla de artículos y creamos una vista que contiene artículos cuyos precios son superiores a 700.

 -- create a new table named items
 CREATE   TABLE  items (
    id  INT   AUTO_INCREMENT   PRIMARY KEY ,
    name  VARCHAR (100)  NOT NULL ,
    price  DECIMAL (11 , 2 )  NOT NULL
);

 -- insert data into the items table
 INSERT   INTO  items(name,price)
 VALUES ( 'Laptop' ,700.56),( 'Desktop' ,699.99),( 'iPad' ,700.50) ;

 -- create a view based on items table
 CREATE   VIEW  LuxuryItems  AS
     SELECT
        *
     FROM
        items
     WHERE
        price  >  700;
 -- query data from the LuxuryItems view
 SELECT
    *
 FROM
    LuxuryItems;


-- En segundo lugar, usamos la instrucción DELETE para eliminar una fila con el valor de id 3.
 DELETE   FROM  LuxuryItems
 WHERE
    id = 3;

-- MySQL devuelve un mensaje que dice que 1 fila (s) afectada (s).

-- Tercero, verifiquemos los datos a través de la vista nuevamente.

 SELECT
    *
 FROM
    LuxuryItems;

-- MySQL DELETE a través de View

-- Cuarto, también podemos consultar los datos de los items tabla base para verificar si la instrucción DELETE realmente eliminó la fila.

 SELECT
    *
 FROM
    items;


-- Como puede ver, la fila con id 3 se eliminó de la tabla base.
