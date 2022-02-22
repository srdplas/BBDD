drop database boletin5;
CREATE DATABASE boletin5;
use boletin5;

drop table ventas;
drop table proyecto;
drop table pieza;
drop table proveedor;

CREATE TABLE proveedor (
	codpro VARCHAR(3),
	nompro VARCHAR(30) NOT NULL,
	status INT,
	ciudad VARCHAR(15),
	constraint codpro_pk PRIMARY KEY (codpro),
	CONSTRAINT status_chk CHECK (status >=1 AND status <=10)
);

CREATE TABLE pieza (
	codpie VARCHAR(3),
	nompie VARCHAR(10) NOT NULL,
	color VARCHAR(10),
	peso DECIMAL(5,2),
	ciudad VARCHAR(15),
	CONSTRAINT codpie_pk PRIMARY KEY (codpie),
	CONSTRAINT peso_chk CHECK (peso > 0 AND peso <= 100)
); 

CREATE TABLE proyecto (
codpj VARCHAR(3),
nompj VARCHAR(20) NOT NULL,
ciudad VARCHAR(15),
CONSTRAINT codpj_pk PRIMARY KEY (codpj)
);

CREATE TABLE ventas (
codpro VARCHAR(3),
codp VARCHAR(3),
codpj VARCHAR(3),
cantidad INT(4),
CONSTRAINT clave_pk PRIMARY KEY (codpro,codp,codpj),
CONSTRAINT codpro_fk FOREIGN KEY (codpro) REFERENCES proveedor(codpro),
CONSTRAINT codpie_fk FOREIGN KEY (codp) REFERENCES pieza(codpie),
CONSTRAINT codpj_fk FOREIGN KEY (codpj) REFERENCES proyecto(codpj)
);

INSERT INTO proveedor 
VALUES ('S1', 'Jose Fernandez', 2, 'Madrid');

INSERT INTO proveedor 
VALUES ('S2', 'Manuel Vidal', 1, 'Londres');

INSERT INTO proveedor 
VALUES ('S3', 'Luisa Gomez', 3, 'Lisboa');

INSERT INTO proveedor 
VALUES ('S4', 'Pedro Sanchez', 4, 'Paris');

INSERT INTO proveedor 
VALUES ('S5', 'Maria Reyes', 5, 'Roma');

INSERT INTO pieza
VALUES ('P1', 'Tuerca', 'Gris', 2.5, 'Madrid');

INSERT INTO pieza
VALUES ('P2', 'Tornillo', 'Rojo', 1.25, 'Paris');

INSERT INTO pieza
VALUES ('P3', 'Arandela', 'Blanco', 3, 'Londres');

INSERT INTO pieza
VALUES ('P4', 'Clavo', 'Gris', 5.5, 'Lisboa');

INSERT INTO pieza
VALUES ('P5', 'Alcataya', 'Blanco', 10, 'Roma');

INSERT INTO proyecto
VALUES ('J1', 'Proyecto 1', 'Londres');

INSERT INTO proyecto
VALUES ('J2', 'Proyecto 2', 'Londres');

INSERT INTO proyecto
VALUES ('J3', 'Proyecto 3', 'Paris');

INSERT INTO proyecto
VALUES ('J4', 'Proyecto 4', 'Roma');


INSERT INTO ventas
VALUES ('S1', 'P1', 'J2', 100);

INSERT INTO ventas
VALUES ('S1', 'P1', 'J3', 500);

INSERT INTO ventas
VALUES ('S1', 'P2', 'J1', 200);

INSERT INTO ventas
VALUES ('S2', 'P2', 'J2', 15);

INSERT INTO ventas
VALUES ('S4', 'P2', 'J3', 1700);

INSERT INTO ventas
VALUES ('S1', 'P3', 'J1', 800);

INSERT INTO ventas
VALUES ('S5', 'P3', 'J2', 30);

INSERT INTO ventas
VALUES ('S1', 'P4', 'J1', 10);

INSERT INTO ventas
VALUES ('S1', 'P4', 'J3', 250);

INSERT INTO ventas
VALUES ('S2', 'P5', 'J2', 300);

INSERT INTO ventas
VALUES ('S2', 'P2', 'J1', 4500);

INSERT INTO ventas
VALUES ('S3', 'P1', 'J1', 90);

INSERT INTO ventas
VALUES ('S3', 'P2', 'J1', 190);

INSERT INTO ventas
VALUES ('S3', 'P5', 'J3', 20);

INSERT INTO ventas
VALUES ('S4', 'P5', 'J1', 15);

INSERT INTO ventas
VALUES ('S4', 'P1', 'J3', 1500);

INSERT INTO ventas
VALUES ('S1', 'P1', 'J1', 150);

INSERT INTO ventas
VALUES ('S1', 'P4', 'J4', 290);

INSERT INTO ventas
VALUES ('S1', 'P2', 'J4', 175);


/*  1. Obtener todos los atributos de todos los proyectos.      */

select * from proyecto;
-- VISTAS
CREATE VIEW VISTA1 AS select * from proyecto;

/*  2. Obtener todos los atributos de todos los proyectos desarrollados en Londres. */
select * from proyecto where ciudad like 'Londres';
--VISTAS 
CREATE VIEW VISTA2 AS select * from proyecto where ciudad like 'Londres';

/*  3. Obtener los códigos de las piezas suministradas por el proveedor s2, ordenados.  */
select codpie from pieza join ventas on pieza.codpie=ventas.codp 
where codpie in (select codp from ventas where codpro='S2') 
group by codpie order by codpie asc;

--VISTAS
CREATE VIEW VISTA3 AS select codpie from pieza join ventas on pieza.codpie=ventas.codp 
where codpie in (select codp from ventas where codpro='S2') 
group by codpie order by codpie asc;

/*  4. Obtener los códigos de los proveedores del proyecto j1, ordenados.   */

select codpro from proveedor where codpro in (select codpro from ventas where codpj like 'J1') order by codpro asc;

/*  5. Obtener todas las ocurrencias pieza.color, pieza.ciudad eliminando los pares duplicados. */
select DISTINCT color, ciudad from pieza;

/* 6.   Obtener los códigos de los cargamentos en los que la cantidad no sea nula.   */
select codp from ventas where cantidad is not null;

/*  7. Obtener códigos de los proyectos y ciudades en las que la ciudad del proyecto tenga una 'o' en la segunda letra.    */
select codpj, ciudad from proyecto where ciudad like '_o%';

/*  8. Obtener un listado ascendente de los nombres de las piezas con más de 5 letras.  */
select nompie from pieza where length(nompie)>5 order by nompie asc;

/*  9. Obtener nombres abreviados de proyectos tomando sus primeras 3 letras.   */
select left(nompj, 3) from proyecto;

/*  10. Obtener los tres últimos caracteres de los nombres de proveedores por orden alfabético. */
select right(nompro,3) from proveedor order by nompro asc;

/*  11. Hallar cuántas piezas distintas existen.    */
select count(codpie) from pieza;

/*	12. Hallar cuántas piezas distintas existen dando nombre a la columna resultante Número.	*/
select count(codpie) as numero from pieza;

/*	13. Obtener el número total de proyectos suministrados por el proveedor sl.	*/
select count(codpro) as num_proyecto from ventas where codpro='S1';

/*	14. Obtener la cantidad total de piezas p1 suministrada por s1.	*/
select count(codp) as num_p1 from ventas where codpro='S1' and codp='P1';

/*	15. Obtener la cantidad media de piezas suministradas, cantidad máxima y mínima suministrada.	*/
select avg(cantidad) as media_pieza, max(cantidad) as max_piezas, min(cantidad) as min_piezas from ventas;

/*	16. Obtener los cargamentos en los que la cantidad de piezas esté entre 300 y 750 inclusive.	*/
select * from ventas where cantidad between 300 and 750;

/*	17. Construir una consulta que devuelva cod_p y VERDADERO si en la tabla piezas el color de la pieza
 no es ni azul ni gris.*/
select codpie from pieza where color!='Gris' and color not in (select codpie from pieza where color!='Azul') group by codpie;

/*	18. Añade una nueva columna llamada fecha que indique la fecha de adquisición de una pieza por proveedor y proyecto.	*/
alter table ventas add fecha_adquisicion date;

/*	19. Modificar la fecha de adquisición de todas las piezas p2 a la fecha actual.	*/
update ventas set fecha_adquisicion=now() where codp='p2';

/*	20. Se desea visualizar la fecha con formato del ejemplo ’11-NOV-2002’.	*/
select date_format(fecha_adquisicion, "%d-%b-%Y") from ventas;

/*	21. Modificar la fecha de adquisición en los que participan los proyectos j1 y j2 a la fecha
12-11-2001	*/

update ventas set fecha_adquisicion='2001-11-12' where codpj between 'j1' and 'j2';

-- 04-02-2022
select codpro, codp, codpj, cantidad, date_format(fecha_adquisicion, '%d-%m-%Y')as 'Formato Fechas' from ventas;
-- 04 Febrero del 2022
select codpro, codp, codpj, cantidad, date_format(fecha_adquisicion, '%d del %M del %Y')as 'Formato Fechas' from ventas;
-- 04/02/22
select codpro, codp, codpj, cantidad, date_format(fecha_adquisicion, '%d-%m-%y')as 'Formato Fechas' from ventas;
-- 11-NOV-2002
select codpro, codp, codpj, cantidad, date_format(fecha_adquisicion, '%d-%b-%Y')as 'Formato Fechas' from ventas;

/*22. Construir una lista ordenada de todas las ciudades en las que al menos resida un
suministrador, una pieza o un proyecto.	*/
select ciudad as ciudades from proveedor where codpro is not null union
(select ciudad from pieza where codpie is not null union 
(select ciudad from proyecto where codpj is not null));

/*	23. Obtener todas las posibles combinaciones entre piezas y proveedores.	*/
select distinct codpro, codp from ventas;

/*24. Obtener todos los posibles tríos de código de proveedor, código de pieza y código de
proyecto en los que el proveedor, pieza y proyecto estén en la misma ciudad.*/
select codpro, codpie, codpj 
from proyecto, proveedor, pieza where proveedor.ciudad=proyecto.ciudad and proyecto.ciudad=pieza.ciudad;

/*	25. Obtener los códigos de proveedor, de pieza y de proyecto de aquellos cargamentos en
los que proveedor, pieza y proyecto estén en la misma ciudad.*/

select distinct codpro, codpie, codpj 
from proyecto, proveedor, pieza 
where proveedor.ciudad=proyecto.ciudad and proyecto.ciudad=pieza.ciudad union (select codpro, codp, codpj from ventas);

/*	26. Obtener todos los posibles tríos de código de proveedor, código de pieza y código de
proyecto en los que el proveedor, pieza y proyecto no estén todos en la misma ciudad.	*/
select distinct codpro, codpie, codpj 
from proyecto, proveedor, pieza 
where proveedor.ciudad<>proyecto.ciudad or proyecto.ciudad<>pieza.ciudad;

/*	27. Obtener todos los posibles tríos de código de proveedor, código de pieza y código de proyecto en los que el proveedor, pieza
 y proyecto no estén ninguno en la misma ciudad.*/
select distinct codpro, codpie, codpj 
from proyecto, proveedor, pieza where proveedor.ciudad<>proyecto.ciudad and proyecto.ciudad<>pieza.ciudad;

/*	28. Obtener los códigos de las piezas suministradas por proveedores de	Londres*/
select ventas.codp from ventas natural join proveedor where ciudad like 'Londres';

/*	29. Obtener los códigos de las piezas suministradas por proveedores de Londres a proyectos en Londres.*/
select ventas.codp from ventas natural join proveedor natural join proyecto where proveedor.ciudad like 'Londres' and proyecto.ciudad like 'Londres';

/*	30. Obtener todos los pares de nombres de ciudades en las que un proveedor de la primera sirva a un proyecto de la segunda.*/
select proyecto.ciudad, proveedor.ciudad from ventas 
join proveedor on ventas.codpro=proveedor.codpro join proyecto on ventas.codpj=proyecto.codpj
where ventas.codpro like 'S1' and ventas.codpj like 'J2';

/*	31. Obtener códigos de piezas que sean suministradas a un proyecto por un proveedor de la
misma ciudad del proyecto.*/
select distinct codp from ventas 
join proveedor on ventas.codpro=proveedor.codpro join proyecto on ventas.codpj=proyecto.codpj
join pieza on pieza.codpie=ventas.codp where proyecto.ciudad=proveedor.ciudad;

/*	32. Obtener códigos de proyectos que sean suministrados por un proveedor de una ciudad
distinta a la del proyecto. Visualizar el código de proveedor y el del proyecto.*/

select distinct ventas.codpj, ventas.codpro from ventas 
where codpro in (select codpro from proveedor 
where ciudad not in (select ciudad from proyecto));

/*	33. Obtener todos los pares de códigos de piezas suministradas por el mismo proveedor.	*/
select codp, codpro from ventas where codpro in(select codpro from ventas);

/*	34. Obtener todos los pares de códigos de piezas suministradas por el mismo proveedor.
(eliminar pares repetidos)*/
select distinct codp, codpro from ventas where codpro in(select codpro from ventas);

/*	35. Obtener para cada pieza suministrada a un proyecto, el código de pieza, el código de
proyecto y la cantidad total correspondiente.	*/
select codp, codpro, codpj, SUM(cantidad)as cantidad_total from ventas group by codp;

/*	36. Obtener los códigos de proyectos y los códigos de piezas en los que la cantidad media suministrada a algún proyecto 
sea superior a 320.	*/
select codpj, codp from ventas where cantidad>all (select avg(cantidad) from ventas) group by codp;

/*	37. Obtener un listado ascendente de los nombres de todos los proveedores que hayan suministrado una cantidad 
superior a 100 de la pieza p1. Los nombres deben aparecer en mayúsculas.*/
select distinct UPPER(nompro)as nombre_proveedor from proveedor
where codpro in(select codpro from ventas where codp like 'p1' and cantidad>100) order by nompro asc;

/*	38. Obtener los nombres de los proyectos a los que suministra s1.*/
select nompj, codpj from proyecto where codpj in (select codpj from ventas where codpro like 's1');

/*	39. Obtener los colores de las piezas suministradas por s1.*/
select distinct color from pieza join ventas on pieza.codpie=ventas.codp where codp in (select codp from ventas where codpro like 's1');

/*	40. Obtener los códigos de las piezas suministradas a cualquier proyecto de Londres.	*/
select distinct codp from ventas where codpj in (select codpj from proyecto where ciudad like 'Londres');

/*	41. Obtener los códigos de los proveedores con estado menor que s1.	*/
select codpro from proveedor where proveedor.status<(select proveedor.status from proveedor where codpro like 's1');

/*	42. Obtener los códigos de los proyectos que usen la pieza pl en una cantidad media mayor que la mayor cantidad en la
 que cualquier pieza sea suministrada al proyecto j1.*/
select distinct codpj from ventas where codp like 'p1' in 
(select codp from ventas where cantidad>some
(select avg(cantidad) from ventas where cantidad >some
(select cantidad from ventas where codpj like 'j1')));

/*	43. Obtener códigos de proveedores que suministren a algún proyecto la pieza p1 en una cantidad mayor 
que la cantidad media en la que se suministra la pieza p1 a dicho proyecto.*/
select distinct codpro from ventas where codpro in 
(select codpro from ventas where codp like 'p1' in 
(select codp from ventas where cantidad>some
(select avg(cantidad) from ventas where codp like 'p1')));

/*	44. Obtener los códigos de los proyectos que usen al menos una pieza suministrada por s1.	*/
select distinct codpj from ventas where codp in (select codp from ventas where codpro like 's1');

select codpj from ventas where codp in (select codp from ventas where codpro like 's1') group by codpj; -- OTRA OPCION PARA TUPLAS REPETIDAS

/*	45. Obtener los códigos de los proveedores que suministren al menos una pieza suministrada 
al menos por un proveedor que suministre al menos una pieza roja.*/	
SELECT distinct codpro from ventas where codp=any (select codp from ventas join pieza on ventas.codp=pieza.codpie where color like 'Rojo');

/*	46. Obtener los códigos de las piezas suministradas a cualquier proyecto de Londres usando EXISTS.*/
select distinct codp from ventas where codpj in (select codpj from ventas where exists (select codpj from proyecto where ciudad like 'Londres'));

/*	47. Obtener los códigos de los proyectos que usen al menos una pieza suministrada por s1 usando EXISTS.	*/
select distinct codpj from ventas where exists (select codp from ventas where codpro like 's1');-- SubConsulta usando Exists

select distinct codpj from ventas where codpj in 
(select codpj from ventas where codp in 
(select codp from ventas where codpro like 's1')); -- SubConsulta sin el Exists

/*	48. Obtener los códigos de los proyectos que no reciban ninguna pieza roja suministrada por algún proveedor de Londres.*/
select distinct codpj from ventas where codpj not in
(select codpj from ventas where codp>any
(select codpie from ventas join pieza on ventas.codp=pieza.codpie join proveedor on ventas.codpro=proveedor.codpro
where color like 'Rojo' and proveedor.ciudad like 'Londres'));

/*	49. Obtener los códigos de los proyectos suministrados únicamente por s1.	*/
select codpj from ventas where 1=(select count(codpro) from ventas where codpro like 's1');

/*	50. Obtener los códigos de las piezas suministradas a todos los proyectos en Londres.	*/
select distinct codp from ventas where codp>some
(select codp from ventas where codpj>all
(select codpj from proyecto where ciudad like 'Londres'));

/*	51. Obtener los códigos de los proveedores que suministren la misma pieza todos a los proyectos.*/
select distinct codpro from ventas where codpro>all (select codpro from ventas where codpj>all(select codpj from ventas ));

/*	52. Obtener los códigos de los proyectos que reciban al menos todas las piezas que suministra s1.*/
select distinct codpj from ventas where codpj>some 
(select codpj from ventas where codp>all 
(select codp from ventas where codpro like 's1'));

/*	53. Cambiar el color de todas las piezas rojas a naranja.	*/
update pieza set color='Naranja' where color like 'Rojo';

/*	54. Borrar todos los proyectos para los que no haya cargamentos.	*/
delete from proyecto where not exists (select codpro from ventas);

/*	55. Borrar todos los proyectos en Roma y sus correspondientes cargamentos.	*/
delete from ventas where codpj>all(select codpj from proyecto where ciudad like 'Roma'); -- Borramos primero la FK
delete from proyecto where ciudad like 'Roma'; -- Después con la misma condicion de la tabla original

/*	56. Insertar un nuevo suministrador s lo en la tabla S. El nombre y la ciudad son 'White'y ‘New York' respectivamente. 
El estado no se conoce todavía.*/
insert into proveedor (codpro, nompro, status, ciudad) values ('s', 'White', null, 'New York');

/*	57. Construir una tabla conteniendo una lista de los códigos de las piezas suministrada.s a
proyectos en Londres o suministradas por un suministrador de Londres.	*/
CREATE or replace VIEW codigos as 
select distinct codp from ventas where codpro in
(select codpro from ventas where codpro in 
(select codpro from proveedor where ciudad like 'Londres')or codpj in 
(select codpj from ventas where codpj in
(select codpj from proyecto where ciudad like 'Londres')));

/*	58. Construir una tabla conteniendo una lista de los códigos de los proyectos de Londres o
que tengan algún suministrador de Londres.	*/
create or replace view lista as 
select distinct codpj from ventas where codpj in 
(select codpj from proyecto where ciudad like 'Londres')or codpro in 
(select codpro from ventas where codpro in 
(select codpro from proveedor where ciudad like 'Londres'));


/*	59. Listar las tablas y secuencias definidas por el usuario ZEUS.	

No hemos dado usuarios

*/
