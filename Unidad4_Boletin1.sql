CREATE DATABASE Centro_educativo;
USE Centro_educativo;

DROP TABLE MATRICULADO;
DROP TABLE IMPARTE;
DROP TABLE ASIGNATURA;
DROP TABLE ALUMNO;
DROP TABLE PROFESOR;
DROP TABLE PROVINCIA;

CREATE TABLE PROVINCIA 
(
	ID_PROV INT(5), 
	NOMBRE VARCHAR(100) NOT NULL,
	CONSTRAINT PK_PROVINCIA PRIMARY KEY(ID_PROV)
);
  
CREATE TABLE PROFESOR 
(	
	ID_PROF INT(5), 
	NOMBRE VARCHAR(100) NOT NULL , 
	APELLIDOS VARCHAR(100) NOT NULL , 
	DNI VARCHAR(9) NOT NULL,
	NACIDO_EN INT(5), 
	CONSTRAINT PK_PROFESOR PRIMARY KEY (ID_PROF),
    CONSTRAINT FK_PROFESOR_PROVINCIA FOREIGN KEY (NACIDO_EN) REFERENCES PROVINCIA (ID_PROV) 
);
  

CREATE TABLE ALUMNO 
(	
	ID_ALUM INT(5), 
	DNI VARCHAR(9) NOT NULL , 
	NOMBRE VARCHAR(100) NOT NULL , 
	APELLIDOS VARCHAR(100) NOT NULL , 
	FECHA_NAC DATE, 
	NACIDO_EN INT(5), 
	CONSTRAINT PK_ALUMNO PRIMARY KEY (ID_ALUM),
	CONSTRAINT FK_ALUMNO_PROVICIA FOREIGN KEY (NACIDO_EN) REFERENCES PROVINCIA (ID_PROV) 
);


CREATE TABLE ASIGNATURA 
(
	ID_ASIG INT(5), 
	NOMBRE VARCHAR(100) NOT NULL , 
	CONSTRAINT PK_ASIGNATURA PRIMARY KEY (ID_ASIG)
);
  

CREATE TABLE IMPARTE 
(	
	ID_PROF INT(5) NOT NULL , 
	ID_ASIG INT(5) NOT NULL , 
	CONSTRAINT PK_IMPARTE PRIMARY KEY (ID_PROF, ID_ASIG), 
	CONSTRAINT FK_IMPARTE_PROFESOR FOREIGN KEY (ID_PROF) REFERENCES PROFESOR (ID_PROF) ON DELETE CASCADE , 
	CONSTRAINT FK_IMPARTE_ASIGNATURA FOREIGN KEY (ID_ASIG) REFERENCES ASIGNATURA (ID_ASIG) ON DELETE CASCADE 
);

CREATE TABLE MATRICULADO
(
	ID_ALUM INT(5) NOT NULL, 
	ID_ASIG INT(5) NOT NULL, 
	NOTA1 DECIMAL(4,2), 
	NOTA2 DECIMAL(4,2), 
	NOTA3 DECIMAL(4,2), 
	CONSTRAINT PK_MATRICULADO PRIMARY KEY (ID_ALUM, ID_ASIG),
	CONSTRAINT FK_MATRICULADO_ASIGNATURA FOREIGN KEY (ID_ASIG) REFERENCES ASIGNATURA (ID_ASIG) ON DELETE CASCADE , 
	CONSTRAINT FK_MATRICULADO_ALUMNO FOREIGN KEY (ID_ALUM) REFERENCES ALUMNO (ID_ALUM) ON DELETE CASCADE
);

INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (1, 'Almeria');
INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (2, 'Cadiz');
INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (3, 'Cordoba');
INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (4, 'Granada');
INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (5, 'Huelva');
INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (6, 'Jaen');
INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (7, 'Malaga');
INSERT INTO PROVINCIA (ID_PROV, Nombre) VALUES (8, 'Sevilla');

INSERT INTO PROFESOR (ID_PROF, Nombre, Apellidos, Nacido_en, dni) VALUES (1, 'Alvaro', 'Acebedo', 8, '78293485F');
INSERT INTO PROFESOR (ID_PROF, Nombre, Apellidos, Nacido_en, dni) VALUES (2, 'Manuel', 'Gutierrez', 2, '69298485J');
INSERT INTO PROFESOR (ID_PROF, Nombre, Apellidos, Nacido_en, dni) VALUES (3, 'Celia', 'Villa', 8, '23293465L');
INSERT INTO PROFESOR (ID_PROF, Nombre, Apellidos, Nacido_en, dni) VALUES (4, 'Maria', 'Munioz', 3, '19298885N');

INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (1, '28756358V', 'Juan', 'Veloso', '1977/02/11', 8);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (2, '28956157L', 'Sonia', 'Sanchez', '1981/08/24', 8);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (3, '27568011D', 'Cristina', 'Abascal', '1980/06/08', 2);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (4, '28754685C', 'Manuel', 'Perez', '1974/06/04', 8);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (5, '28546821Y', 'Manuel', 'Bueno', '1985/12/19', 2);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (6, '27656981Y', 'Jose Antonio', 'Montero', '1990/07/25', 3);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (7, '58324542B', 'Juan Jose', 'Sanchez', '1992/11/01', 2);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (8, '56846315M', 'Sandra', 'Valles', '1985/01/05', 3);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (9, '28468215X', 'Sara', 'Merida', '1986/09/09', 8);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (10, '27684214Z', 'Laura', 'Gutierrez', '1987/04/09', 8);
INSERT INTO ALUMNO (ID_ALUM, DNI, Nombre, Apellidos, FECHA_NAC, Nacido_en) VALUES (11, '28896443S', 'Inmaculada', 'Garcia', '1989/03/21', 8);

INSERT INTO ASIGNATURA (ID_ASIG, Nombre) VALUES (1, 'Redes');
INSERT INTO ASIGNATURA (ID_ASIG, Nombre) VALUES (2, 'Sistemas');
INSERT INTO ASIGNATURA (ID_ASIG, Nombre) VALUES (3, 'Ingles');

INSERT INTO IMPARTE (ID_PROF, ID_ASIG) VALUES (1, 1);
INSERT INTO IMPARTE (ID_PROF, ID_ASIG) VALUES (2, 1);
INSERT INTO IMPARTE (ID_PROF, ID_ASIG) VALUES (3, 2);

INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (1, 1, 4, 6, 8);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (2, 1, 5, 5, 5);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (2, 3, 10, 9, 7);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (3, 1, 10, 8, 9);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (4, 1, 3, 3, 4);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (4, 3, 0, 0, 0);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (5, 1, 1, 4, 8);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (5, 3, 8, 4, 4);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (6, 1, 5, 2, 7);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (7, 1, 5, 5, 5);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (7, 2, 7, 5, 6);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (7, 3, 6, 7, 7);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (8, 1, 4, 6, 5);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (8, 2, 4, 5, 6);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (9, 2, 7, 7, 7);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (9, 3, 6, 7, 8);
INSERT INTO MATRICULADO (ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3) VALUES (10, 2, 9, 5, 5);

/*	1. Mostrar el nombre de las provincias	*/
select nombre from provincia;

/*	2. Mostrar el nombre y apellidos de los alumnos	*/
select nombre, apellidos from alumno;

/*	3. Mostrar el código y el nombre de todas las asignaturas	*/
select * from asignatura;
select ID_ASIG, nombre from asignatura;
-- Como la tabla tiene solo dos campos el primer comando tambien serviría

/*	4. Mostrar el DNI, nombre y apellidos de los profesores, ordenados por DNI ascendentemente	*/
select dni, nombre, apellidos from profesor order by dni asc;

/*	5. Mostrar los datos de los alumnos de mayor a menor edad, de forma que en la columna de la
fecha de nacimiento aparezca el encabezado “Fecha_de_nacimiento”	*/
select id_alum, nombre, apellidos, fecha_nac as fecha_de_nacimiento from alumno ORDER by fecha_nac asc;

/*	6. Mostrar los datos del alumno cuyo DNI es 56846315M.	*/
select * from alumno where dni='56846315M';

/*	7. Mostra los alumnos nacidos en las provincias cuyos códigos estén comprendidos entre 3 y 7	*/
select * from alumno where nacido_en>=3 or 7<=nacido_en;
select * from alumno where nacido_en BETWEEN "3" and "7";

/*	8. Mostrar los profesores nacidos en alguna de estas provincias: 1, 3, 5, 7.	*/
select * from profesor where nacido_en=1 or nacido_en=3 or nacido_en=5 or nacido_en=7;
select * from profesor where nacido_en in (1,3,5,7);
/*	9. Mostrar los alumnos nacidos entre el 19/02/1980 y el 20/07/1984.	*/
select * from alumno where fecha_nac between '1980-02-19' and '1984-07-20';

/*	10. Mostrar los registros de la tabla “Matriculado” del alumno 7.	*/
select * from matriculado where id_alum=7;

/*	11. Mostrar el nombre y apellidos de los alumnos mayores de 24 años. (2021-1997= 24 años)	*/
-- Si ponemos 1997 todos van a ser mayores de 24 años a dia de hoy, el boletin es antiguo y pondre 1977
select nombre, apellidos from alumno where fecha_nac<'1997-01-01'; -- Si fuese a dia de hoy
select nombre, apellidos from alumno where fecha_nac<'1977-01-01'; -- Fecha de cuando se hizo el boletin
-- Variante para mayores de 30

select nombre, apellidos as anio from alumno where fecha_nac>=DATE_ADD(curdate(),INTERVAL -30 YEAR);
select nombre, apellidos from alumno where TIMESTAMPDIFF(YEAR,Fecha_Nac,now())>30;
/*	12. Mostrar aquellos alumnos cuyo DNI contenga la letra ‘Y’.	*/
select * from alumno where dni like '%y';	-- Busca en dni que contenga x caracteres pero acabe en Y

/*	13. Mostrar aquellos alumnos cuyo nombre empiece por ‘S’.	*/
select * from alumno where nombre like 'S%'; -- Busca en nombre que empiece por S y los demas caracteres le da igual


--(En windows mysql no distingue entre maysuculas y minusculas)

/*	14. Mostrar el nombre de aquellos alumnos cuyo nombre contenga la letra ‘n’, ya sea
mayúscula o minúscula.	*/
select nombre from alumno where nombre like '%n%'; -- Busca en el nombre cualquiera que tras x caracteres tenga una n y los demas caracteres le da igual

/*	15. Mostrar el nombre de aquellos alumnos cuyo apellido contenga la letra ‘z’, mayúscula o
minúscula.	*/
select nombre from alumno where apellidos like '%z%'; -- Busca en el apellidos cualquiera que tras x caracteres tenga una z y los demas caracteres le da igual

/*	16. Mostrar aquellos alumnos que tengan por primer nombre “Manuel”.	*/
select * from alumno where nombre like 'Manuel%';

/*	17. Mostrar aquellos alumnos que se llamen “Manuel” o “Cristina”.	*/
select * from alumno where nombre='Manuel' or nombre='Cristina';

/*	18. Mostrar los datos de los alumnos cuyo DNI empiece por 2.	*/
select * from alumno where dni like '2%'; -- Busca un dni que empiece por el 2 y el resto de caracteres les da igual

/*	19. Mostrar los identificadores de provincia en las que han nacido los alumnos, sin que estos
identificadores se repitan.	*/
select DISTINCTROW nacido_en from centro_educativo.alumno; --No muestra los campos repetidos

/*	20. Mostrar la tabla de “Matriculado” y añadir una columna más que sea la media de las tres
notas de cada alumno, ordenados de la mejor nota a la peor.	*/
select id_alum, id_asig, (nota1+nota2+nota3)/3 as media from matriculado order by media desc;

/*	21. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya superado los 3
exámenes de la asignatura 1.	*/
select * from matriculado where id_asig=1 and nota1>5 and nota2>5 and nota3>5;

/*	22. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya sacado un 10 en
alguna de las 3 notas en cualquier asignatura.	*/
select * from matriculado where nota1=10 or nota2=10 or nota3=10;

/*	23. Mostrar aquellos registros de la tabla “Matriculado” en los que un alumno haya superado
alguno de los 3 exámenes de la asignatura 2.	*/
select * from matriculado where id_asig=2 and (nota1>=5 or nota2>=5 or nota3>=5);

/*	24. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya superado el
primer examen ordenando los registros por “nota2” y “nota3” de menor a mayor para
ambos campos.	*/
select * from matriculado where nota1>=5 order by nota2 asc, nota3 asc;
select * from matriculado where nota1>=5 order by nota2, nota3 asc;
-- No se porque me ordena nota2 pero no nota3 cuando está bien escrito la consulta

/*	25. Mostrar aquellos alumnos nacidos en el 1985	*/
select * from alumno where fecha_nac like '1985%'; -- Busca en fecha_nac el año 1985 lo primero porque el formato es Y/M/D 

/*	26. Mostrar los datos de los alumnos y además una columna calculada “mes” que represente el
mes en el que nació el alumno. Además se debe ordenar por dicha columna.	*/
select *, extract(month from fecha_nac)  as mes from alumno order by mes asc;
select *, month(fecha_nac) as mes from alumno order by mes asc;

/*	27. Mostrar los datos de los alumnos y además una columna calculada “fecha_de_ nacimiento”
que represente el día en el que nació el alumno con el siguiente formato “Nacido el día xx
del xx de xxxx”.	*/
select *, date_format(fecha_nac, 'Nacio el %d del %m de %y') as fecha_de_nacimiento from alumno order by fecha_de_nacimiento asc;
/*	28. Mostrar el nombre, apellidos y la edad de los alumnos	*/
select nombre, apellidos, 2021-extract(year from fecha_nac)  as edad from alumno;

/*	29. Mostrar los datos de los alumnos y además una columna calculada “dias_vividos” que
represente los días que lleva vivido el alumno hasta la fecha de hoy.	*/
select *, extract(year from fecha_nac)*365  as dias_vividos from alumno;

/*	30. Mostrar el nombre y apellidos de los 4 alumnos con mayor edad.	*/
select nombre, apellidos from alumno order by fecha_nac asc limit 4;

/*	31. Contar el número de alumnos que hay en el centro educativo.	*/
select COUNT(id_alum)as numero_alumnos from alumno;

/*	32. Contar el número de profesores nacidos en la provincia 2 (Sevilla) que hay en el centro educativo.	*/
select COUNT(nacido_en) as nacidos_cadiz from profesor where nacido_en=2; -- Codigo pronvincia 2 como pone en enunciado pero no es sevilla
select COUNT(nacido_en) as nacidos_sevilla from profesor where nacido_en=8; -- Pronvicia Sevilla tiene el codigo 8

/*	33. Mostrar la nota2 más alta de todas.	*/
select MAX(nota2)as Max_Nota2 from matriculado;

/*	34. Mostrar la nota1 más baja de la asignatura 1 (Redes)	*/
select MIN(nota1)as Min_Nota1 from matriculado where id_asig=1;

/*	35. Mostrar el sumatorio de todas las notas1 de la asignatura 1 (Redes)	*/
select SUM(nota1) as Suma_nota1_Redes from matriculado where id_asig=1;

/*	36. Mostrar la suma de todas las notas1 de la asignatura 1 (Redes) fabricando una columna llamada suma. 
Además se deben añadir 2 columnas más que se correspondan con el número de notas1 existentes y con el valor de la nota media.	*/
select SUM(nota1) as suma, COUNT(nota1)as num_notas1_existentes, avg(nota1) as nota_media from matriculado where id_asig=1;

