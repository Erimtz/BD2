/*ALTER TABLE empleados
ADD Edad INT;*/

/*DELIMITER $$
CREATE FUNCTION edad(fecha_nacimiento DATE) 
RETURNS INT DETERMINISTIC
BEGIN 
    DECLARE edad INT;
    SET edad = TIMESTAMPDIFF(YEAR, fecha_nacimiento, NOW());
    RETURN edad;
END$$*/

/*DELIMITER $$
CREATE PROCEDURE actualizar_edad()
BEGIN
    UPDATE empleados
    SET Edad = edad(fecha_nacimiento);
END$$*/
##CALL actualizar_edad();

##SELECT * FROM empleados



