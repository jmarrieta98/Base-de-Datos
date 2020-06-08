

-- La instrucción CREATE VIEW crea una nueva vista en la base de datos. Aquí está la sintaxis básica de la instrucción CREATE VIEW:

-- CREATE VIEW [OR REPLACE] VIEW [db_name.]view_name [(column_list)]
-- AS
-- select-statement;

-- sintaxis:

-- Primero, especifique el nombre de la vista que desea crear después de las palabras clave CREATE VIEW. El nombre de la vista es único en una base de datos. Como las vistas y las tablas en la misma base de datos comparten el mismo espacio de nombres, el nombre de una vista no puede ser el mismo que el de una tabla existente.

-- En segundo lugar, use la opción OR REPLACE si desea reemplazar una vista existente. Si la vista no existe, OR REPLACE no tiene ningún efecto.

-- Tercero, especifique una lista de columnas para la vista. Por defecto, las columnas de la vista se derivan de la lista de selección de la instrucción SELECT. Sin embargo, puede especificar explícitamente la lista de columnas para la vista enumerándolas entre paréntesis después del nombre de la vista.

-- Finalmente, especifique una instrucción SELECT que defina la vista. La instrucción SELECT puede consultar datos de tablas o vistas. MySQL le permite usar la cláusula ORDER BY en la instrucción SELECT, pero la ignora si selecciona desde la vista con una consulta que tiene su propia cláusula ORDER BY.

-- De manera predeterminada, la instrucción CREATE VIEW crea una vista en la base de datos actual. Si desea crear explícitamente una vista en una base de datos dada, puede calificar el nombre de la vista con el nombre de la base de datos.
-- Ejemplos de MySQL CREATE VIEW

-- Tomemos un ejemplo del uso de la instrucción CREATE VIEW para crear nuevas vistas.
-- 1) Crear un ejemplo de vista simple

-- Echemos un vistazo a la tabla orderDetails de la base de datos de muestra:

-- Esta declaración utiliza la instrucción CREATE VIEW para crear una vista que represente las ventas totales por pedido.

CREATE VIEW salePerOrder AS
    SELECT 
        orderNumber, 
        SUM(quantityOrdered * priceEach) total
    FROM
        orderDetails
    GROUP by orderNumber
    ORDER BY total DESC;

-- Si usa el comando SHOW TABLE para ver todas las tablas en la base de datos de modelos clásicos, verá que viewsalesPerOrder se muestra en la lista.

SHOW TABLES;

-- Esto se debe a que las vistas y las tablas comparten el mismo espacio de nombres que se mencionó anteriormente.

-- Para saber qué objeto es una vista o tabla, use el comando SHOW FULL TABLES de la siguiente manera:

SHOW FULL TABLES;


-- La columna table_type en el conjunto de resultados especifica el tipo de objeto: vista o tabla (tabla base).

-- Si desea consultar las ventas totales de cada pedido de ventas, solo necesita ejecutar una simple instrucción SELECT en la vista SalePerOrder de la siguiente manera:

SELECT * FROM salePerOrder;

-- mysql create view - ejemplo de vista simple
-- 2) Crear una vista basada en otro ejemplo de vista

-- MySQL le permite crear una vista basada en otra vista.

-- Por ejemplo, puede crear una vista llamada bigSalesOrder basada en la vista salesPerOrder para mostrar cada pedido de ventas cuyo total sea mayor que 60,000 de la siguiente manera:

CREATE VIEW bigSalesOrder AS
    SELECT 
        orderNumber, 
        ROUND(total,2) as total
    FROM
        salePerOrder
    WHERE
        total > 60000;

-- Ahora, puede consultar los datos desde la vista bigSalesOrder de la siguiente manera:

SELECT 
    orderNumber, 
    total
FROM
    bigSalesOrder;

-- 3) Crear una vista con un JOIN

-- El siguiente ejemplo utiliza la instrucción CREATE VIEW para crear una vista basada en varias tablas. Utiliza las cláusulas INNER JOIN para unir tablas.

CREATE OR REPLACE VIEW customerOrders AS
SELECT 
    orderNumber,
    customerName,
    SUM(quantityOrdered * priceEach) total
FROM
    orderDetails
INNER JOIN orders o USING (orderNumber)
INNER JOIN customers USING (customerNumber)
GROUP BY orderNumber;

-- Esta declaración selecciona datos de la vista de pedidos del cliente:

SELECT * FROM customerOrders 
ORDER BY total DESC;



-- 4) Crear una vista con un ejemplo de subconsulta

-- El siguiente ejemplo usa la instrucción CREATE VIEW para crear una vista cuya instrucción SELECT usa una subconsulta. La vista contiene productos cuyos precios de compra son más altos que el precio promedio de todos los productos.

CREATE VIEW aboveAvgProducts AS
    SELECT 
        productCode, 
        productName, 
        buyPrice
    FROM
        products
    WHERE
        buyPrice > (
            SELECT 
                AVG(buyPrice)
            FROM
                products)
    ORDER BY buyPrice DESC;

-- La consulta sobre la vista aboveAvgProducts será:

SELECT * FROM aboveAvgProducts;


-- 5) Crear una vista con columnas de vista explícitas:

-- Esta declaración utiliza la declaración CREATE VIEW para crear una nueva vista basada en las tablas de clientes y pedidos con columnas de vista explícita:

drop view customerOrderStats;	
CREATE VIEW customerOrderStats (
   customerName , 
   orderCount
) 
AS
    SELECT 
        customerName, 
        COUNT(orderNumber)
    FROM
        customers
            INNER JOIN
        orders USING (customerNumber)
    GROUP BY customerName;


-- Para ver los datos de la vista
SELECT 
    customerName,
    orderCount
FROM
    customerOrderStats
ORDER BY 
    orderCount, 
    customerName;
























