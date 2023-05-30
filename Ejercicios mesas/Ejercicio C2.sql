/*1) Empleados
a) Crear un SP que liste los apellidos, nombres y edad de los empleados ordenados
alfabéticamente.
Tip: Para la edad, crear una función que tenga como parámetro de entrada la fecha de
nacimiento y devuelva la edad.
b) Invocar el SP para verificar el resultado.*/

/*DELIMITER $$
CREATE FUNCTION `obtenerEdad` (pfecha_nacimiento DATETIME) 
RETURNS INT DETERMINISTIC
BEGIN
RETURN TIMESTAMDIFF(YEAR, pfecha_nacimiento, NOW());
END$$*/

/*DELIMITER $$
CREATE PROCEDURE `listarApellidoNombres` ()
BEGIN
    SELECT nombre, apellido, obtenerEdad(FechaNacimiento) FROM empleados ORDER BY nombre;
END$$*/

/*CALL listarApellidoNombres();*/

/*2) Empleados por ciudad
a) Crear un SP que reciba el nombre de una ciudad y liste los empleados de esa ciudad que sean mayores
 a 25 años.
Tip: Utilizar la función creada en punto 1.
b) Invocar al SP para listar los empleados de London.*/

/*DELIMITER $$
CREATE PROCEDURE listar_por_ciudad_y_edad (IN pCiudad VARCHAR(15))
BEGIN
	SELECT calcular_edad(FechaNacimiento) AS Edad, empleados.* FROM empleados
	WHERE calcular_edad(FechaNacimiento) > 25 AND Ciudad = pCiudad;
END$$*/

/*CALL listar_por_ciudad_y_edad("London");*/

/*3) Clientes por país
a) Crear un SP que liste los apellidos, nombres, edad y la diferencia en años de edad con el valor máximo de edad que tiene la tabla de clientes.
Tip: Utilizar la función creada en punto 1. Crear una función que devuelva la fecha de nacimiento mínima de la tabla clientes.*/

/*DELIMITER $$
CREATE FUNCTION `calcular_fecha_minima` ()
RETURNS datetime DETERMINISTIC
BEGIN
	DECLARE fechaMinima DATETIME;
    SET fechaMinima = MIN(FechaNacimiento);
    RETURN fechaMinima;
END$$*/

SELECT MIN(FechaNacimiento) FROM empleados;

SELECT Nombre, Apellido, calcular_edad(FechaNacimiento) AS Edad, Pais, calcular_fecha_minima() AS FechaMinima FROM empleados
GROUP BY Nombre, Apellido, Edad, Pais, FechaMinima;

/*4) Ventas con descuento
a) Crear un SP que reciba un porcentaje y liste los nombres de los productos que hayan sido vendidos con un descuento igual o superior al valor indicado,
indicando además el nombre del cliente al que se lo vendió. Además devolver el precio del producto con un aumento.
Tip: Para devolver el precio del producto con aumento, crear una función que reciba un porcentaje y el precio del producto.*/



