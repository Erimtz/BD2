/*1. En una base de datos cualquiera, debemos confeccionar un stored procedure que 
le enviemos un entero comprendido entre 0 y 999 inclusive. El segundo parámetro 
debe retornar la cantidad de dígitos que tiene dicho número. Debemos utilizar la sentencia IF.*/

/*DELIMITER $$
CREATE PROCEDURE contar_digitos(IN numero INT, OUT cantidad_digitos INT)
BEGIN
    IF numero >= 0 AND numero <= 9 THEN
        SET cantidad_digitos = 1;
    ELSEIF numero >= 10 AND numero <= 99 THEN
        SET cantidad_digitos = 2;
    ELSEIF numero >= 100 AND numero <= 999 THEN
        SET cantidad_digitos = 3;
    ELSE
        SET cantidad_digitos = 0;
    END IF;
END$$*/

##CALL contar_digitos(123, @cantidad);
##SELECT @cantidad;

/*2. En la base de datos Musimundos, vamos a generar un SP donde le vamos
 a pasar por parámetro diferentes nombres de géneros en un varchar separados por |.
 Importante: al final siempre poner un |. Un ejemplo, 'Trap|Reggaeton|House|'. 
 Luego, debemos insertar cada uno de ellos en nuestra tabla de géneros. Utilizar la sentencia WHILE.
 Tener en cuenta que para insertar el id, debemos ir a buscar el último número de id de la tabla de géneros.*/
 
/*DELIMITER $$
CREATE PROCEDURE insertar_generos(IN generos_param VARCHAR(255))
BEGIN
    DECLARE genero VARCHAR(255);
    DECLARE separador VARCHAR(1);
    DECLARE done INT DEFAULT FALSE;
    DECLARE ultimo_id INT;
    
    SET separador = '|';
    SET generos_param = CONCAT(generos_param, separador);
    SET ultimo_id = (SELECT MAX(id) FROM generos);
    
    WHILE generos_param != '' DO
        SET genero = SUBSTRING_INDEX(generos_param, separador, 1);
        SET generos_param = SUBSTRING(generos_param, LENGTH(genero) + 2);
        
        IF genero != '' THEN
            SET ultimo_id = ultimo_id + 1;
            INSERT INTO generos (id, nombre) VALUES (ultimo_id, genero);
        END IF;
    END WHILE;
END $$*/

##CALL insertar_generos('Trap|Reggaeton|House|');
##SELECT * FROM generos;


