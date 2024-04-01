--Muy Fáciles

--1 .Devuelve todas las películas
SELECT MOVIE_NAME AS "Peliculas"
FROM PUBLIC.MOVIES;

--2. Devuelve todos los géneros existentes
SELECT GENRE_NAME AS "Géneros"
FROM PUBLIC.GENRES;

--3. Devuelve la lista de todos los estudios de grabación que estén activos
SELECT STUDIO_NAME AS "Estudios Activos"
FROM PUBLIC.STUDIOS 
WHERE STUDIO_ACTIVE = 1;

--4. Devuelve una lista de los 20 últimos miembros en anotarse al videoclub
SELECT MEMBER_NAME AS "Miembro"
FROM MEMBERS 
ORDER BY MEMBER_DISCHARGE_DATE DESC LIMIT 20;

--5. Devuelve las 20 duraciones de películas más frecuentes, ordenados de mayor a menor.
SELECT MOVIE_DURATION AS "Duración Media", COUNT(MOVIE_DURATION) AS "Número de peliculas"
FROM MOVIES
GROUP BY  MOVIE_DURATION
ORDER BY COUNT(MOVIE_DURATION) DESC 
LIMIT 20;

--6. Devuelve las películas del año 2000 en adelante que empiecen por la letra A.
SELECT MOVIE_NAME , MOVIE_LAUNCH_DATE 
FROM PUBLIC.MOVIES 
WHERE MOVIE_LAUNCH_DATE > '2000-01-01'AND MOVIE_NAME LIKE 'A%';

--7. Devuelve los actores nacidos un mes de Junio
SELECT ACTOR_NAME AS "Nombre del Actor"
FROM PUBLIC.ACTORS 
WHERE ACTOR_BIRTH_DATE LIKE '%-06-%';

--8. Devuelve los actores nacidos cualquier mes que no sea Junio y que sigan vivos.
SELECT ACTOR_NAME AS "Nombre del Actor"
FROM PUBLIC.ACTORS 
WHERE ACTOR_BIRTH_DATE NOT LIKE '%-06-%' AND ACTOR_DEAD_DATE IS NULL;

--9. Devuelve el nombre y la edad de todos los directores menores o iguales de 50 años que estén vivos
SELECT DIRECTOR_NAME AS "Director", DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY()) AS "Edad Actual"
FROM PUBLIC.DIRECTORS 
WHERE DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY())<= 50
AND DIRECTOR_DEAD_DATE IS NULL;

--10. Devuelve el nombre y la edad de todos los actores menores de 50 años que hayan fallecido
SELECT ACTOR_NAME AS "Actores", DATEDIFF(YEAR, ACTOR_BIRTH_DATE, TODAY()) AS "Edad"
FROM PUBLIC.ACTORS 
WHERE DATEDIFF(YEAR, ACTOR_BIRTH_DATE, TODAY()) < 50
AND ACTOR_DEAD_DATE IS NOT NULL;

--11. Devuelve el nombre de todos los directores menores o iguales de 40 años que estén vivos
SELECT DIRECTOR_NAME AS "Director"
FROM PUBLIC.DIRECTORS 
WHERE DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY())<= 40
AND DIRECTOR_DEAD_DATE IS NULL;

--12. Indica la edad media de los directores vivos
SELECT AVG(DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY())) AS "Edad"
FROM PUBLIC.DIRECTORS 
WHERE DIRECTOR_DEAD_DATE IS NULL;

--13. Indica la edad media de los actores que han fallecido
SELECT AVG(DATEDIFF(YEAR, ACTOR_BIRTH_DATE, TODAY())) AS "Edad"
FROM PUBLIC.ACTORS 
WHERE ACTOR_BIRTH_DATE IS NOT NULL;



