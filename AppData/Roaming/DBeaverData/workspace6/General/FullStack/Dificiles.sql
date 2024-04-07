--26. Lista nombre, nacionalidad y director de todas las películas
SELECT m.MOVIE_NAME, n.NATIONALITY_NAME, d.DIRECTOR_NAME 
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.NATIONALITIES n
ON m.NATIONALITY_ID = n.NATIONALITY_ID
INNER JOIN PUBLIC.DIRECTORS d
ON m.DIRECTOR_ID = d.DIRECTOR_ID;

--27. Muestra las películas con los actores que han participado en cada una de ellas
SELECT m.MOVIE_NAME, A.ACTOR_NAME
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.MOVIES_ACTORS ma ON ma.MOVIE_ID = m.MOVIE_ID
INNER JOIN PUBLIC.ACTORS a ON a.ACTOR_ID = ma.ACTOR_ID
GROUP BY m.MOVIE_NAME, a.ACTOR_NAME;

--28. Indica cual es el nombre del director del que más películas se han alquilado
SELECT d.DIRECTOR_NAME, COUNT(DISTINCT mm.MOVIE_ID)
FROM DIRECTORS d INNER JOIN MOVIES m ON d.DIRECTOR_ID = m.DIRECTOR_ID
INNER JOIN MEMBERS_MOVIE_RENTAL mm ON m.MOVIE_ID = mm.MOVIE_ID
GROUP BY d.DIRECTOR_NAME
ORDER BY COUNT(DISTINCT mm.MOVIE_ID) DESC LIMIT 1;

--29. Indica cuantos premios han ganado cada uno de los estudios con las películas que han creado				 
SELECT S.STUDIO_NAME AS "Estudio", SUM(a.AWARD_WIN) AS "Premios Ganados"
FROM PUBLIC.AWARDS a
INNER JOIN PUBLIC.MOVIES m ON m.MOVIE_ID = a.MOVIE_ID
INNER JOIN PUBLIC.STUDIOS s ON s.STUDIO_ID = m.STUDIO_ID
GROUP BY s.STUDIO_NAME
ORDER BY SUM(a.AWARD_WIN);
		
--30. Indica el número de premios a los que estuvo nominado un actor, pero que no ha conseguido (Si una película está nominada a un premio, su actor también lo está)
SELECT a.ACTOR_NAME AS "Nombre del Actor", SUM(aw.AWARD_ALMOST_WIN) AS "Nominaciones No Logradas"
FROM PUBLIC.AWARDS aw
INNER JOIN PUBLIC.MOVIES m ON m.MOVIE_ID = aw.MOVIE_ID
INNER JOIN PUBLIC.MOVIES_ACTORS ma ON ma.MOVIE_ID = m.MOVIE_ID
INNER JOIN PUBLIC.ACTORS a ON a.ACTOR_ID = ma.ACTOR_ID
GROUP BY a.ACTOR_NAME
ORDER BY SUM(aw.AWARD_ALMOST_WIN)DESC;

--31. Indica cuantos actores y directores hicieron películas para los estudios no activos
SELECT COUNT(DISTINCT ma.ACTOR_ID) AS "Numero de Actores", COUNT(DISTINCT d.DIRECTOR_ID) AS "Numero de Directores"
FROM PUBLIC.MOVIES_ACTORS ma
INNER JOIN PUBLIC.MOVIES m ON ma.MOVIE_ID = m.MOVIE_ID
INNER JOIN PUBLIC.DIRECTORS d ON d.DIRECTOR_ID = m.DIRECTOR_ID
WHERE m.STUDIO_ID IN (SELECT s.STUDIO_ID
					     FROM PUBLIC.STUDIOS s
					     WHERE s.STUDIO_ACTIVE IS FALSE);

--32. Indica el nombre, ciudad, y teléfono de todos los miembros del videoclub que hayan alquilado películas que hayan sido nominadas a más de 150 premios y ganaran menos de 50
SELECT DISTINCT me.MEMBER_NAME, me.MEMBER_TOWN, me.MEMBER_PHONE
FROM MEMBERS me
INNER JOIN MEMBERS_MOVIE_RENTAL mmr ON me.MEMBER_ID = mmr.MEMBER_ID
INNER JOIN MOVIES mo ON mmr.MOVIE_ID = mo.MOVIE_ID 
INNER JOIN AWARDS a ON mo.MOVIE_ID = a.MOVIE_ID
WHERE a.AWARD_ID IN (SELECT a.AWARD_ID 
					 FROM AWARDS a
					 WHERE a.AWARD_NOMINATION > 150
					 AND a.AWARD_WIN < 50);
					   
--33. Comprueba si hay errores en la BD entre las películas y directores (un director fallecido en el 76 no puede dirigir una película en el 88)
SELECT d.DIRECTOR_NAME AS "Director ya fallecido", m.MOVIE_NAME AS "Dirigiendo esta pelicula"
FROM PUBLIC.DIRECTORS d
INNER JOIN PUBLIC.MOVIES m ON m.DIRECTOR_ID  = d.DIRECTOR_ID
WHERE d.DIRECTOR_DEAD_DATE < m.MOVIE_LAUNCH_DATE;