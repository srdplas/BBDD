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

/*  2. Obtener todos los atributos de todos los proyectos desarrollados en Londres. */
select * from proyecto where ciudad like 'Londres';

/*  3. Obtener los códigos de las piezas suministradas por el proveedor s2, ordenados.  */
select codpie from pieza join ventas on pieza.codpie=ventas.codp 
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
