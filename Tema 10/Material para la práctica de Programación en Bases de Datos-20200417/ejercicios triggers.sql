use Softuni;
/*Ejercicio 1*/
drop procedure if exists nombreApell;
delimiter $$
create procedure nombreApell()
begin
	select FirstName 'nombre', LastName 'apellido'
    from Employees
    where Salary >= 35000;
end $$
delimiter ;

call nombreApell();

/*Ejercicio 2*/
drop procedure if exists nombreApell;
delimiter $$
create procedure nombreApell(
	in salario float
    )
begin
	select FirstName 'nombre', LastName 'apellido'
    from Employees
    where Salary >= salario;
end $$
delimiter ;

/*Ejercicio 3*/
drop procedure if exists nombresciudades;
DELIMITER //
CREATE PROCEDURE nombresciudades(cadena VARCHAR(10))
BEGIN
	DECLARE todo  VARCHAR(10) DEFAULT concat(lower(cadena),  "%"); 
	SELECT Name from towns where lower(Name) like todo;
END //

call nombresciudades('bo');

/*Ejercicio 4*/
drop procedure if exists personas_ciudad;
DELIMITER //
CREATE PROCEDURE personas_ciudad(in ciudad VARCHAR(10))
BEGIN
select FirstName, LastName
from Employees, addresses, towns
where Employees.AddressID = addresses.AddressID and 
addresses.TownID = towns.TownID and
lower(towns.name) like lower(concat(ciudad, "%"));
End //

call personas_ciudad("Bo");

/*Ejercicio 5*/
drop function nivel_salario;
DELIMITER //
CREATE FUNCTION nivel_salario(salary DOUBLE)
RETURNS VARCHAR(50)
BEGIN
	DECLARE resultado VARCHAR(50);
	SET resultado = (CASE WHEN salary < 30000 THEN 'Low'
		 WHEN salary BETWEEN 30000 AND 50000 THEN 'Average'
		 ELSE 'High' END);
	RETURN resultado;
END //;

SET GLOBAL log_bin_trust_function_creators = 1;

/*Ejercicio 6*/
drop procedure empleados_salario_nivel;
DELIMITER //
CREATE PROCEDURE empleados_salario_nivel(sal_level VARCHAR(50))
BEGIN
	DECLARE resultado VARCHAR(50);
	SET resultado = (CASE WHEN salary < 30000 THEN 'Low'
		 WHEN salary BETWEEN 30000 AND 50000 THEN 'Average'
		 ELSE 'High' END);
    
	SELECT first_name, last_name FROM employees
	WHERE nivel_salario(salary) = sal_level
	ORDER BY first_name DESC, last_name DESC;
END //

/*Ejercicio 7*/


/*Ejercicio 8*/
drop trigger actualizar1;
delimiter  //
CREATE TRIGGER actualizar1 after update ON employees for each row
begin
 update resumen_salario set salario_medio = (SELECT AVG(salary) FROM employees), salario_min = (SELECT MIN (salary)FROM employees), salario_max = (SELECT MAX(salary) FROM employees);
end //

drop trigger actualizar2;  
delimiter  //
CREATE TRIGGER actualizar2 after insert ON employees for each row
begin
 update resumen_salario set salario_medio = (SELECT AVG(salary) FROM employees), salario_min = (SELECT MIN (salary)FROM employees), salario_max = (SELECT MAX(salary) FROM employees);
end //

drop trigger actualizar3;
delimiter  //
CREATE TRIGGER actualizar3 after delete ON employees for each row
begin
 update resumen_salario set salario_medio = (SELECT AVG(salary) FROM employees), salario_min = (SELECT MIN (salary)FROM employees), salario_max = (SELECT MAX(salary) FROM employees);
end //

/*Ejercicio 9*/
drop trigger actualizar1;
delimiter  //
CREATE TRIGGER actualizar_valores_actuales1 after update ON employees for each row
begin
 insert into resumen_salario set salario_medio = (SELECT AVG(salary) FROM employees), salario_min = (SELECT MIN (salary)FROM employees), salario_max = (SELECT MAX(salary) FROM employees);
end //

drop trigger actualizar2;  
delimiter  //
CREATE TRIGGER actualizar_valores_actuales2 after insert ON employees for each row
begin
 insert into resumen_salario set salario_medio = (SELECT AVG(salary) FROM employees), salario_min = (SELECT MIN (salary)FROM employees), salario_max = (SELECT MAX(salary) FROM employees);
end //

drop trigger actualizar3;
delimiter  //
CREATE TRIGGER actualizar_valores_actuales3 after delete ON employees for each row
begin
 insert into resumen_salario set salario_medio = (SELECT AVG(salary) FROM employees), salario_min = (SELECT MIN (salary)FROM employees), salario_max = (SELECT MAX(salary) FROM employees);
end //







/*-----------Base de datos Bank--------------*/

/*Ejercicio 10*/
use bank;
drop procedure nombre_completo_cuenta;
delimiter //
CREATE PROCEDURE nombre_completo_cuenta(total_amount DECIMAL(19,4))
BEGIN
	SELECT total_balance.first_name, total_balance.last_name
	FROM
	(SELECT ah.first_name, ah.last_name, SUM(a.balance) as `sum`
	FROM `account_holders` AS ah
	INNER JOIN `accounts` AS a
	ON ah.id = a.account_holder_id
	GROUP BY ah.first_name, ah.last_name) as total_balance
	WHERE total_balance.`sum` > total_amount
	ORDER BY total_balance.first_name, total_balance.last_name;
END//

call nombre_completo_cuenta(40000);

/*Ejercicio 11*/
use bank;
drop procedure if exists cantidad_nombre;
delimiter //
CREATE PROCEDURE cantidad_nombre(total_amount DECIMAL(19,4))
BEGIN
	SELECT total_balance.first_name, total_balance.last_name
	FROM
	(SELECT ah.first_name, ah.last_name, SUM(a.balance) as `sum`
	FROM `account_holders` AS ah
	INNER JOIN `accounts` AS a
	ON ah.id = a.account_holder_id
	GROUP BY ah.first_name, ah.last_name) as total_balance
	WHERE total_balance.`sum` > total_amount
	ORDER BY total_balance.first_name, total_balance.last_name;
END //

call cantidad_nombre(10000);

/*Ejercicio 12*/
use bank;
DROP FUNCTION IF EXISTS formula_grande;
DELIMITER $$
CREATE FUNCTION formula_grande(
	I 	DECIMAL(14,4), # cantidad incial
    R 	DECIMAL(14,4), # tasa de interés anual
    T 	DECIMAL(14,4) # número de años
)
RETURNS DECIMAL(15,4)
DETERMINISTIC
BEGIN
	DECLARE FV DECIMAL(14,4);
    SET FV = I * (1 + R);
    RETURN POW(FV,T);
END $$
DELIMITER ;

SELECT formula_grande(4,3,9);

/*Ejercicio 13*/
use bank;
drop procedure if exists calculo_dinero;
DELIMITER $$
create procedure calculo_dinero(IN account_id INT,IN money_amount DECIMAL(19,4))
begin
    start transaction;
    update accounts set accounts.balance = accounts.balance + money_amount
    where accounts.id = account_id;    
    
    if money_amount <= 0
    then 
	    ROLLBACK;
    else
       COMMIT;
    end if;

end$$
DELIMITER  ; 

call calculo_dinero(1,100);
select*from accounts as a where a.id = 1; 


/*Ejercicio 14*/

use bank;
drop table if exists info_cambios;
create table info_cambios(
`id` int(11) NOT NULL,
`account_holder_id` int(11) NOT NULL,
`balance` decimal(19,4) DEFAULT '0.0000');


drop trigger if exists info_cuentas;
delimiter $$
create trigger info_cuentas after update on accounts for each row
BEGIN
	-- Primero declaro el valor que se actualiza --
    insert into info_cambios
    values(NEW.id, NEW.account_holder_id, NEW.balance);
end $$
delimiter ;

update accounts
set balance = 2333
where id= 8;

select balance from info_cambios;

/*Ejercicio 15*/
use bank;
drop trigger if exists no_retirar;
delimiter //
create trigger no_retirar
before insert on money_amount
for each row
begin
  if (new.account_holder_id < 1 or new.account_holder_id >5) then
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'your error message';
  end if;
end //


/*Ejercicio 17*/
use bank;
drop procedure dinero_retirar;
delimiter $$
create procedure dinero_retirar  (IN account_id INT, IN money_amount DECIMAL(19,4))
begin
start transaction;
	UPDATE accounts SET accounts.balance = accounts.balance-money_amount
	WHERE accounts.id = account_id;	

 if((select a1.balance from accounts as `a1` where account_id = a1.id) < 0)
  then rollback;
 end if;
 if(money_amount <= 0 or account_id > 18 or account_id < 1) 
 then rollback;
 end if;
commit;	
END $$


/*Ejercicio 18*/
use bank;
drop procedure deposito_dinero;
delimiter $$
CREATE PROCEDURE deposito_dinero (account_id INT, interest_rate DECIMAL(19,4))
BEGIN

  DECLARE future_value DECIMAL(19,4);

  DECLARE balance DECIMAL(19, 4);
  SET balance := (SELECT a.balance FROM accounts AS a WHERE a.id = account_id);
  SET future_value := balance * (POW((1 + interest_rate), 5));
  
  SELECT a.id AS account_id, ah.first_name, ah.last_name, a.balance, future_value
    FROM accounts AS a
   INNER JOIN account_holders AS ah
      ON a.account_holder_id = ah.id
     AND a.id = account_id;
END $$

call deposito_dinero(1,1)

/*Ejercicio 19*/
use bank;
drop procedure transferencia;
delimiter $$
SET autocommit = 0;
CREATE PROCEDURE transferencia( cuenta_origen INT, cuenta_destino INT, IN cantidad DECIMAL(19,4))
BEGIN 
     START TRANSACTION;
     UPDATE accounts SET balance = balance - cantidad
     WHERE id = cuenta_origen;
     
     UPDATE accounts SET balance = balance + cantidad
     WHERE id = cuenta_destino;
     
     IF((SELECT COUNT(*) FROM accounts
		 WHERE id = cuenta_origen) <> 1) -- <>:  significa distinto --
	 THEN ROLLBACK;
     ELSEIF (cantidad > (SELECT balance FROM accounts WHERE id = cuenta_origen))
		THEN ROLLBACK;
     ELSEIF (cantidad <= 0)
        THEN ROLLBACK;
     ELSEIF((SELECT balance FROM accounts WHERE id = cuenta_origen) <= 0 )
        THEN ROLLBACK;
     ELSEIF((SELECT COUNT(*) FROM accounts
		 WHERE id = cuenta_destino) <> 1)
         THEN ROLLBACK;
     ELSEIF(cuenta_origen = cuenta_destino)
		 THEN ROLLBACK;
     ELSE
         COMMIT;
	 END IF;
     
END $$

delimiter ;    

select * from accounts ;

call transferencia(1,2,10000);
select * from accounts;
call transferencia(2,1,20000);

call transferencia(9,1,-90000);
/*Ejercicio 21*/
use bank;

create table logs 
(
	log_id INT AUTO_INCREMENT PRIMARY KEY, 
	account_id INT, 
	old_sum DECIMAL(19,4), 
	new_sum DECIMAL(19,4)
); 

drop trigger actualicacion_cuentas;
delimiter //
CREATE TRIGGER actualizacion_cuentas
AFTER UPDATE 
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO logs (account_id, old_sum, new_sum)
	VALUES (OLD.id, OLD.balance, NEW.balance);
END //

/*Ejercicio 22*/
use bank;

CREATE TABLE notificacion_emails(
	id INT AUTO_INCREMENT PRIMARY KEY,
	recipient INT,
	subject VARCHAR(50),
	body TEXT
);

drop trigger if exists noti_emails;
delimiter //
CREATE TRIGGER noti_emails
AFTER UPDATE
ON accounts
FOR EACH ROW 
BEGIN
	INSERT INTO logs(account_id, old_sum, new_sum)
	VALUES(old.id, old.balance, new.balance);
	INSERT INTO notification_emails(recipient, subject, body)
	VALUES(
		old.id,
		CONCAT_WS(': ', 'El balance de la cuenta', old.id),
		CONCAT('On ', NOW(), ' has cambiado el balance ', old.balance, ' to ', new.balance, '.' ));
END //

