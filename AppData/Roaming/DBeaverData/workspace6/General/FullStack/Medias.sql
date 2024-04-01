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
SELECT me.MEMBER_TOWN AS "Ciudad del Socio", d.DIRECTOR_BIRTH_PLACE AS "Ciudad del Director"
FROM PUBLIC.MEMBERS me
INNER JOIN PUBLIC.MEMBERS_MOVIE_RENTAL mr ON mr.MEMBER_ID = me.MEMBER_ID 
INNER JOIN PUBLIC.MOVIES m ON m.MOVIE_ID = mr.MOVIE_ID 
INNER JOIN PUBLIC.DIRECTORS d ON d.DIRECTOR_ID = m.DIRECTOR_ID 
WHERE d.DIRECTOR_BIRTH_PLACE = me.MEMBER_TOWN;