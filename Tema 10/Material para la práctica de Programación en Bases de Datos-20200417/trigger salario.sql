/*Ejercicio 8*/
use softuni;
DROP TRIGGER IF EXISTS Actualizar_salarios;
DELIMITER $$
CREATE TRIGGER Actualizar_salarios AFTER UPDATE ON employees FOR EACH ROW
BEGIN
update resumen_salario set salario_medio = new.avg(salary), salario_maximo = new.max(Salary), salario_minimo = new.min(Salary);
END $$
DELIMITER ;