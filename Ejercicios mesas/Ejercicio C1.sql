/*traer el top 5 de usuario que más playlist tiene*/
SELECT COUNT(*) AS CantidadPlayList, idUsuario AS usuario, usuario.nombre
FROM usuario
INNER JOIN playlist
ON usuario.idUsuario = playlist.Usuario_idUsuario
GROUP BY Usuario_idUsuario, usuario.nombre
ORDER BY COUNT(*) desc
LIMIT 5;

/*usuario que tiene más videos*/
SELECT COUNT(*) cantidadDeVideos, idUsuario AS usuario, usuario.nombre
FROM usuario
INNER JOIN video
ON usuario.idUsuario = video.Usuario_idUsuario
GROUP BY Usuario_idUsuario, usuario.nombre
ORDER BY COUNT(*) desc
LIMIT 1;

/*Cantidad de videos por usuario*/
SELECT COUNT(*) AS CantidadVideo, idUsuario AS usuario, usuario.nombre
FROM  video
INNER JOIN usuario 
ON idUsuario = video.Usuario_idUsuario
GROUP BY idUsuario
ORDER BY COUNT(*);

/*Usuarios por país*/
SELECT COUNT(*) AS numeroUsuarios, pais.nombre AS pais
FROM pais
INNER JOIN usuario 
ON pais.idPais = usuario.Pais_idPais
GROUP BY idPais
ORDER BY COUNT(*);

/*promedio de videos por etiqueta*/
SELECT AVG (idVideo) AS conteo_prom_etiqueta, video.nombreArchivo AS video
FROM video
INNER JOIN etiqueta
ON video.idVideo = etiqueta.Video_idVideo
GROUP BY idVideo
ORDER BY COUNT(idVideo);




