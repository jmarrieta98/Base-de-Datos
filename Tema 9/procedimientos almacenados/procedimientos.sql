/* Escriba una función para convertir millas por galón a litros por 100 kilómetros.*/
drop PROCEDURE if exists mpgto100kilometer;
DELIMITER $$

CREATE PROCEDURE mpgto100kilometer(
     IN  mpg DECIMAL 
)
BEGIN
	DECLARE resultado DECIMAL;
    SET resultado = (202.48/mpg);   
    SELECT resultado;
END $$


DELIMITER ;

CALL mpgto100kilometer(5);
show warnings;

/*Escriba un procedimiento para aumentar el precio de una categoría de producto especificada en un porcentaje dado.*/
drop procedure aumentarprecio;
DELIMITER $$

CREATE PROCEDURE aumentarprecio(IN porcentaje DECIMAL, IN categoria varchar(40)) 
BEGIN
     UPDATE products SET buyPrice = buyPrice + buyPrice *(porcentaje/100)
     WHERE  LOWER(products.productLine) = LOWER(categoria);
END $$

DELIMITER ;

CALL aumentarprecio(5,"motorcycles");