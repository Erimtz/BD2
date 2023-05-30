#Use AdventureWorks
# Crear un SP que dada una edad como parametro, inserte en la tabla Employee_Age todos los registros de Employee que cumplan
# con la edad pasada
# por parametro. Insertar los datos FirstName, LastName y Age (datos en tabla Contact).
# Para calcular la edad, crear una funcion.

/*CREATE TABLE Employee_Age(FirstName varchar(50), LastName varchar(50), Age TinyInt);*/

/*DELIMITER $$
CREATE FUNCTION `calcular_edad` (pfecha_nacimiento DATETIME)
RETURNS INT DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, pfecha_nacimiento, NOW());
END$$*/

/*DELIMITER $$
CREATE PROCEDURE `insertar_employee_ages` (IN pEdad INT)
BEGIN
    INSERT INTO Employee_Age
    SELECT FirstName, LastName, calcular_edad(BirthDate) AS Age FROM employee
    INNER JOIN contact ON employee.ContactID = contact.ContactID
    WHERE calcular_edad(BirthDate) = pEdad;
END$$*/

/*SELECT * FROM employee_age;*/

/*CALL insertar_employee_ages(65);*/