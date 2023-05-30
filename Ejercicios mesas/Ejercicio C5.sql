/*DELIMITER $$
CREATE PROCEDURE calcular_suma_promedio(IN numeros_param VARCHAR(255), OUT suma_total DECIMAL(10, 2), OUT promedio DECIMAL(10, 2))
BEGIN
    DECLARE num_str VARCHAR(255);
    DECLARE pos INT DEFAULT 1;
    DECLARE delimiter_pos INT;
    DECLARE num DECIMAL(10, 2);
    DECLARE total_numeros INT DEFAULT 0;
    DECLARE total_suma DECIMAL(10, 2) DEFAULT 0;

    SET num_str = CONCAT(numeros_param, ';');
    SET suma_total = 0;
    SET promedio = 0;

    LOOP_label: LOOP
        SET delimiter_pos = LOCATE(';', num_str, pos);
        SET num = CAST(SUBSTRING(num_str, pos, delimiter_pos - pos) AS DECIMAL(10, 2));

        CASE
            WHEN num > 0 THEN
                SET total_numeros = total_numeros + 1;
                

                SET total_suma = total_suma + num;
        END CASE;

        SET pos = delimiter_pos + 1;

        IF delimiter_pos = 0 THEN
            LEAVE LOOP_label;
        END IF;
    END LOOP;

    IF total_numeros > 0 THEN
        SET suma_total = total_suma;
        SET promedio = total_suma / total_numeros;
    END IF;
END $$*/

##ALL calcular_suma_promedio('10;66;138;37;-72;0.5;', @suma_total, @promedio);
SELECT @suma_total, @promedio;


