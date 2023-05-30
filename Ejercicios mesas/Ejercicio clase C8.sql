/*1. Necesitamos crear un procedimiento almacenado que inserta un cliente,
SP_Cliente_Insert que recibe los datos del cliente y lo inserta en caso que no exista
un cliente con el mismo número de DNI o Cédula de identidad.*/
-- DROP PROCEDURE SP_Cliente_Insert

DELIMITER $$
CREATE PROCEDURE SP_Cliente_Insert (IN pId INT, pCedulaident VARCHAR(10), pApellido VARCHAR(45), pNombres VARCHAR(100), pFecha_nac DATE, pScoring INT) 
BEGIN
	DECLARE cedulaident VARCHAR(10);
    SET cedulaident = (SELECT count(*) FROM clientes WHERE cedulaident = pCedulaident);
    
    IF(cedulaident = 0) THEN 
    INSERT INTO clientes VALUES(pId, pCedulaident, pApellido, pNombres, pFecha_nac, pScoring);
    END IF;
END $$

CALL SP_Cliente_Insert(6,'2203154520', 'martinez', 'erika', '1995-02-06', 2);
	
/*2. Armar una función fn_ValidadEdad que, dada la fecha de nacimiento de una persona
(YYYYMMDD), la fecha de inicio del préstamo (YYYYMMDD) y la cantidad de cuotas,
verifique que cumpla con la condición que la persona no tenga más de 80 años al
finalizar el préstamo.*/
-- DROP FUNCTION fn_ValidadEdad

DELIMITER $$
CREATE FUNCTION fn_ValidadEdad(pFechaNac DATE, pFechaInicio DATE, pCantidadCuotas INT)
RETURNS TINYINT DETERMINISTIC
BEGIN
    DECLARE edad INT;
    DECLARE fechaFinal DATE;
    
    SET fechaFinal = DATE_ADD(pFechaInicio, INTERVAL pCantidadCuotas MONTH);
    
    SET edad = TIMESTAMPDIFF(YEAR, pFechaNac, fechaFinal);
    
    IF edad <= 80 THEN
        RETURN 1; 
    ELSE
        RETURN 0; 
    END IF;
END$$

SELECT fn_ValidadEdad('2000-01-01','2020-01-01', 1) FROM clientes;

/*3. Armar una función fn_diaHabil que, dada una fecha (YYYYMMDD), devuelva la
misma fecha si es un día hábil —lunes a viernes— o en caso de no serlo —si es
sábado o domingo— devuelva la fecha del primer día hábil siguiente.*/
-- DROP FUNCTION fn_diaHabil;

DELIMITER $$
CREATE FUNCTION fn_diaHabil(pfecha DATE)
RETURNS DATE DETERMINISTIC
BEGIN
    DECLARE diaSemana INT;
    SET diaSemana = DAYOFWEEK(pfecha);

    IF diaSemana = 1 THEN -- Domingo
        SET pfecha = DATE_ADD(pfecha, INTERVAL 1 DAY); -- Agrega 1 día
    ELSEIF diaSemana = 7 THEN -- Sábado
        SET pfecha = DATE_ADD(pfecha, INTERVAL 2 DAY); -- Agrega 2 días
    END IF;

    RETURN pfecha;
END$$

SELECT fn_diaHabil('2022-05-08');

/*4. Crear un stored procedure SP_Genera_Cuota que, dado un importe, fecha de inicio,
y cantidad de cuotas, genere el detalle de las cuotas.*/
-- DROP PROCEDURE SP_Genera_Cuota

DELIMITER $$
CREATE PROCEDURE SP_Genera_Cuota(IN pimporte INT, pfechaInicio DATE, pcantCuotas INT)
BEGIN
DECLARE nroCuota INT DEFAULT 0;
DECLARE fecha DATE DEFAULT pfechaInicio;
DECLARE importe INT DEFAULT pimporte/pcantCuotas;
CREATE TEMPORARY TABLE IF NOT EXISTS resumen (nroCuotas INT,  fecha DATE, importe INT);
	WHILE pcantCuotas > 0 DO		
		SET nroCuota = nroCuota + 1;
		INSERT INTO resumen (nroCuotas, fecha, importe)
        VALUES (nroCuota, fecha, importe);
		SET fecha = fn_diaHabil(adddate(fecha, INTERVAL 1 month));
		SET pcantCuotas = pcantCuotas - 1;
	END WHILE;
    SELECT * from resumen;
END$$

CALL SP_Genera_Cuota(100000,'2022-01-01',5);

