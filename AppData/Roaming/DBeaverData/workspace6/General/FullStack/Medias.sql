--14. Devuelve el nombre de todas las películas y el nombre del estudio que las ha realizado
SELECT m.MOVIE_NAME AS "Título Pelicula", s.STUDIO_NAME AS "Nombre del Estudio"
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.STUDIOS s ON s.STUDIO_ID = m.STUDIO_ID;

--15. Devuelve los miembros que alquilaron al menos una película entre el año 2010 y el 2015
SELECT M.MEMBER_NAME AS "Nombre", mr.MEMBER_RENTAL_DATE AS "Año"
FROM PUBLIC.MEMBERS_MOVIE_RENTAL mr
INNER JOIN PUBLIC.MEMBERS m ON m.MEMBER_ID = mr.MEMBER_ID
WHERE mr.MEMBER_RENTAL_DATE >= '2010-01-01' AND mr.MEMBER_RENTAL_DATE <= '2015-12-31';

--16. Devuelve cuantas películas hay de cada país
SELECT n.NATIONALITY_NAME AS "Nacionalidad", COUNT(m.NATIONALITY_ID) AS "Veces por Pais"
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.NATIONALITIES n ON n.NATIONALITY_ID = m.NATIONALITY_ID 
GROUP BY n.NATIONALITY_NAME 
ORDER BY COUNT(m.NATIONALITY_ID);

--17. Devuelve todas las películas que hay de género documental
SELECT m.MOVIE_NAME AS "Titulo"
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.GENRES g ON g.GENRE_ID = m.GENRE_ID
WHERE m.GENRE_ID = 2;

--18. Devuelve todas las películas creadas por directores nacidos a partir de 1980 y que todavía están vivos
SELECT m.MOVIE_NAME AS "Titulo"
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.DIRECTORS d ON d.DIRECTOR_ID = m.DIRECTOR_ID 
WHERE d.DIRECTOR_BIRTH_DATE >= '1980-01-01'
AND d.DIRECTOR_DEAD_DATE IS NULL;

--19. Indica si hay alguna coincidencia de nacimiento de ciudad (y si las hay, indicarlas) entre los miembros del videoclub y los directores.
SELECT me.MEMBER_NAME AS "Nombre Socio", me.MEMBER_TOWN AS "Ciudad del Socio",d.DIRECTOR_NAME AS "Nombre Director", d.DIRECTOR_BIRTH_PLACE AS "Ciudad del Director"
FROM PUBLIC.MEMBERS me
INNER JOIN PUBLIC.MEMBERS_MOVIE_RENTAL mr ON mr.MEMBER_ID = me.MEMBER_ID 
INNER JOIN PUBLIC.MOVIES m ON m.MOVIE_ID = mr.MOVIE_ID 
INNER JOIN PUBLIC.DIRECTORS d ON d.DIRECTOR_ID = m.DIRECTOR_ID 
WHERE d.DIRECTOR_BIRTH_PLACE = me.MEMBER_TOWN;

--20. Devuelve el nombre y el año de todas las películas que han sido producidas por un estudio que actualmente no esté activo
SELECT m.MOVIE_NAME AS "Titulo" , m.MOVIE_LAUNCH_DATE AS "Fecha Estreno"
FROM PUBLIC.STUDIOS s
INNER JOIN PUBLIC.MOVIES m ON m.STUDIO_ID = s.STUDIO_ID 
WHERE s.STUDIO_ACTIVE = 0;

--21. Devuelve una lista de las últimas 10 películas que se han alquilado
SELECT m.MOVIE_NAME AS "Titulo", mr.MEMBER_RENTAL_DATE AS "Fecha Alquiler"
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.MEMBERS_MOVIE_RENTAL mr ON mr.MOVIE_ID  = m.MOVIE_ID
ORDER BY mr.MEMBER_RENTAL_DATE DESC LIMIT 10;

--22. Indica cuántas películas ha realizado cada director antes de cumplir 41 años
SELECT d.DIRECTOR_NAME AS "Nombre Director", COUNT(m.MOVIE_ID) AS "Peliculas Dirigidas"
FROM PUBLIC.DIRECTORS d
INNER JOIN PUBLIC.MOVIES m ON m.DIRECTOR_ID = d.DIRECTOR_ID 
WHERE DATEADD(YEAR, 40, d.DIRECTOR_BIRTH_DATE) >= m.MOVIE_LAUNCH_DATE
GROUP BY d.DIRECTOR_NAME
ORDER BY COUNT(m.MOVIE_ID) DESC;

--23. Indica cuál es la media de duración de las películas de cada director
SELECT d.DIRECTOR_NAME AS "Director", AVG(m.MOVIE_DURATION) AS "Media Duración"
FROM PUBLIC.DIRECTORS d
INNER JOIN PUBLIC.MOVIES m ON m.DIRECTOR_ID = d.DIRECTOR_ID
GROUP BY d.DIRECTOR_NAME;

--24. Indica cuál es el nombre y la duración mínima de la película que ha sido alquilada en los últimos 2 años por los miembros del videoclub (La "fecha de ejecución" en este script es el 25-01-2019)
SELECT m.MOVIE_NAME AS "Titulo Pelicula", m.MOVIE_DURATION AS "Duración"
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.MEMBERS_MOVIE_RENTAL mmr
ON m.MOVIE_ID = MMR.MOVIE_ID
WHERE DATEDIFF(YEAR, mmr.MEMBER_RENTAL_DATE, '2019-01-25') <= 2
ORDER BY m.MOVIE_DURATION ASC
LIMIT 1;

--25. Indica el número de películas que hayan hecho los directores durante las décadas de los 60, 70 y 80 que contengan la palabra "The" en cualquier parte del título.
SELECT COUNT (m.MOVIE_ID) AS "Total de Peliculas", d.DIRECTOR_NAME AS "Director"
FROM PUBLIC.MOVIES m
INNER JOIN PUBLIC.DIRECTORS d
ON m.DIRECTOR_ID = d.DIRECTOR_ID
WHERE YEAR(m.MOVIE_LAUNCH_DATE) BETWEEN '1960' AND '1989'
AND ((m.MOVIE_NAME LIKE 'The %') OR (m.MOVIE_NAME LIKE '% The %') OR (m.MOVIE_NAME LIKE '% The'))
GROUP BY d.DIRECTOR_NAME, m.MOVIE_NAME;
