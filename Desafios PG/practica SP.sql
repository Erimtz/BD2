/*SP: Facturas de clientes por país y ciudad 
Tabla: clientes y facturas*/
/*1. Crear un stored procedure que solicite como parámetros de entrada el nombre de un país 
y una ciudad, y que devuelva como resultado la información de contacto de todos los clientes 
y sus facturas para ese país y ciudad. En el caso de que el parámetro de ciudad esté vacío, 
se debe devolver todos los clientes del país indicado. */
/*DELIMITER $$
CREATE PROCEDURE `clientes_facturas` (IN pPais INT, pCiudad INT)
BEGIN
    INSERT INTO clientes
    SELECT COUNT(*) id, primer_nombre, apellido, pais_de_facturacion, ciudad_de_facturacion AS Age FROM clientes
    INNER JOIN clientes ON facturas.id_cliente = clientes.id
    WHERE ciudad = null ;
END$$*/

##CALL clientes_facturas(pPais);

/*2. Invocar el procedimiento para obtener la información de los clientes de Canadá. 
SP: Artistas 
Tabla: Géneros */

/*DELIMITER $$
CREATE PROCEDURE `Artistas` (IN id INT, nombre INT)
BEGIN
    INSERT INTO generos
    SELECT COUNT(*) id, nombre FROM generos
    INNER JOIN clientes ON artistas.id = clientes.id
    WHERE ciudad = "Canadá";
END$$*/

##SELECT * FROM clientes;

/*1. Crear un stored procedure que reciba como parámetro el nombre de un artista, 
su rating y lo inserte en la tabla de artistas. 
Además, el stored procedure debe devolver el id que se insertó. */


/*2. Invocar el stored procedure creado para insertar el artista Ed Sheeran.
 ¿Qué id devolvió el SP ? Consultar la tabla de artistas para ver los cambios. */
 
/*3. Repetir el paso anterior insertando esta vez la artista Dua Lipa. */