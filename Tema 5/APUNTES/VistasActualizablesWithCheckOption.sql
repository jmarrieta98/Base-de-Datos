-- A veces, crea una vista para revelar los datos parciales de una tabla. Sin embargo, una vista simple es actualizable, por lo tanto, es posible actualizar datos que no son visibles a través de la vista. Esta actualización hace que la vista sea inconsistente. Para garantizar la coherencia de la vista, utilice la cláusula WITH CHECK OPTION cuando cree o modifique la vista .

-- La cláusula WITH CHECK OPTION es una cláusula opcional de la instrucción CREATE VIEW . La cláusula WITH CHECK OPTION evita que una vista actualice o inserte filas que no son visibles a través de ella. En otras palabras, cada vez que actualiza o inserta una fila de las tablas base a través de una vista, MySQL asegura que la operación de inserción o actualización se ajuste a la definición de la vista.

-- A continuación se ilustra la sintaxis de la cláusula WITH CHECK OPTION .

-- CREATE  [ OR REPLACE   VIEW ] view_name
-- AS
--  select_statement
--   WITH   CHECK OPTION ;

-- Observe que coloca el punto y coma (;) al final de la cláusula WITH CHECK OPTION , no al final de la instrucción SELECT que define la vista.

-- Veamos un ejemplo del uso de la cláusula WITH CHECK OPTION .
-- Vista MySQL y ejemplo WITH CHECK OPTION

-- Primero, cree una vista llamada vps basada en la tabla de employees para revelar empleados cuyos títulos de trabajo sean VP, por ejemplo, VP Sales, VP Marketing.

 CREATE   OR REPLACE   VIEW  vps  AS
     SELECT
        employeeNumber,
        lastname,
        firstname,
        jobtitle,
        extension,
        email,
        officeCode,
        reportsTo
     FROM
        employees
     WHERE
        jobTitle  LIKE   '%VP%' ;

-- A continuación, consulte los datos de la vista vps utilizando la siguiente instrucción SELECT :

 SELECT  *  FROM  vps;

-- Debido a que vps es una vista simple, es actualizable.

-- Luego, inserte una fila en la tabla de employees través de la vista vps .


 INSERT   INTO  vps(
    employeeNumber,
    firstName,
    lastName,
    jobTitle,
    extension,
    email,
    officeCode,
    reportsTo
)
 VALUES (
    1703,
     'Lily' ,
     'Bush' ,
     'IT Manager' ,
     'x9111' ,
     'lilybush@classicmodelcars.com' ,
    1,
    1002
);

-- Observe que el empleado recién creado no es visible a través de la vista vps porque su cargo es IT Manager , que no es el VP. Puede verificarlo utilizando la siguiente instrucción SELECT .

 SELECT
   *
 FROM
   employees
 ORDER BY
   employeeNumber  DESC ;

-- Es posible que esto no sea lo que queremos porque solo queremos exponer a los empleados de VP solo a través de la vista vps , no a otros empleados.

-- Para garantizar la coherencia de una vista de modo que los usuarios solo puedan mostrar o actualizar los datos visibles a través de la vista, use la WITH CHECK OPTION cuando cree o modifique la vista.

-- Modifiquemos la vista para incluir la WITH CHECK OPTION .

 CREATE   OR REPLACE   VIEW  vps  AS
     SELECT
        employeeNumber,
        lastName,
        firstName,
        jobTitle,
        extension,
        email,
        officeCode,
        reportsTo
     FROM
        employees
     WHERE
        jobTitle  LIKE   '%VP%'
 WITH CHECK OPTION ;

-- Observe  WITH CHECK OPTION al final de la instrucción CREATE OR REPLACE .

-- Después de eso, inserte una fila en la tabla de employees través de la vista vps :

INSERT   INTO  vps(employeeNumber,firstname,lastname,jobtitle,extension,email,officeCode,reportsTo)
 VALUES (1704, 'John' , 'Smith' , 'IT Staff' , 'x9112' , 'johnsmith@classicmodelcars.com' ,1,1703);

-- Esta vez, MySQL rechazó la inserción y emitió el siguiente mensaje de error:


-- Error Code: 1369.  CHECK OPTION  failed  'classicmodels.vps'

-- Finalmente, inserte un empleado cuyo título de trabajo sea SVP Marketing en la tabla de employees través de la vista vps para ver si está permitido.


 INSERT   INTO  vps(employeeNumber,firstname,lastname,jobtitle,extension,email,officeCode,reportsTo)
 VALUES (1704, 'John' , 'Smith' , 'SVP Marketing' , 'x9112' , 'johnsmith@classicmodelcars.com' ,1,1076);

-- MySQL emitió el mensaje:


-- 1 rows(s) affected.

-- Puede verificar la inserción consultando los datos desde la vista vps .

 SELECT  *  FROM  vps;
