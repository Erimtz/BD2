DELIMITER $$
CREATE PROCEDURE sumarYpromediar(IN pNumeros VARCHAR(100), OUT pSuma DECIMAL(10,2), OUT pPromedio DECIMAL(10,2))
BEGIN

	DECLARE vNumeros VARCHAR(100) DEFAULT pNumeros;
	DECLARE vSuma DECIMAL(10,2) DEFAULT 0;
    DECLARE vCantNumeros INT DEFAULT 0;
    
    loop_contador: LOOP
    
		IF vNumeros = '' THEN
			LEAVE loop_contador;
		END IF;
        
        CASE 
			WHEN (CAST((SELECT LEFT(vNumeros, LOCATE(';', vNumeros) -1)) AS DECIMAL(10, 2))) > 0 THEN
				SET vSuma = vSuma +  CAST((SELECT LEFT(vNumeros, LOCATE(';', vNumeros) -1)) AS DECIMAL(10, 2));
				SET vCantNumeros = vCantNumeros + 1;
                SET vNumeros = (SELECT RIGHT(vNumeros, CHAR_LENGTH(vNumeros) - LOCATE(';', vNumeros)));
                
			ELSE SET vNumeros = (SELECT RIGHT(vNumeros, CHAR_LENGTH(vNumeros) - LOCATE(';', vNumeros)));
		END CASE;
    
    END LOOP loop_contador;
    
    SET pSuma = vSuma;
    SET pPromedio = vSuma / vCantNumeros;
END $$
DELIMITER ;

DROP PROCEDURE sumarYpromediar;

CALL sumarYpromediar('1.2;2.2;3;-2;-6;4.5;', @suma, @promedio);
SELECT @suma, @promedio;

CALL sumarYpromediar('-1.2, 1.5, 1.5;', @suma, @promedio);
SELECT @suma, @promedio;