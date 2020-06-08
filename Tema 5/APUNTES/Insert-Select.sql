-- INSERT normal
-- INSERT INTO table_name(c1,c2,...)
-- VALUES(v1,v2,..);

-- Sintaxis de la sentencia INSERT INTO SELECT:

	
-- INSERT INTO table_name(column_list)
-- SELECT 
--   select_list 
-- FROM 
--   another_table
-- WHERE
--   condition;

-- Ejemplo, primero creamos la tabla suppliers, proveedores:

CREATE TABLE suppliers (
    supplierNumber INT AUTO_INCREMENT,
    supplierName VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(50),
    country VARCHAR(50),
    customerNumber INT,
    PRIMARY KEY (supplierNumber)
);

-- De repente todos los customers(clientes) de California, USA (CA), se convierten en
-- nuestros suminstradores. Los podemos ver con
	
SELECT 
    customerNumber,
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country
FROM
    customers
WHERE
    country = 'USA' AND 
    state = 'CA';



-- Ahora con un INSERT INTO SELECT los cogemos de la tabla customers y los metemos
-- en la suppliers:

	
INSERT INTO suppliers (
    supplierNumber,
    supplierName, 
    phone, 
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country
)
SELECT 
    customerNumber,
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country
FROM
    customers
WHERE
    country = 'USA' AND 
    state = 'CA';

SELECT * FROM suppliers;


-- Podemos decir que hemos copiado una tabla en otra.


-- ###################################
-- Usar la sentencia SELECT en la lista de VALUES

-- Primero creamos la tabla stats(estadísticas):
	
CREATE TABLE stats (
    totalProduct INT,
    totalCustomer INT,
    totalOrder INT
);

-- Segundo, usamos INSERT para meter valores extraidos con SELECT:


INSERT INTO stats(totalProduct, totalCustomer, totalOrder)
VALUES(
    (SELECT COUNT(*) FROM products),
    (SELECT COUNT(*) FROM customers),
    (SELECT COUNT(*) FROM orders)
);










