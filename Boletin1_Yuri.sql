


CREATE TABLE alumnos (
    nombre varchar(20) ,
    apellido1 varchar(20),
    apllido2 varchar(20),
    DNI varchar(9),
    direccion varchar(40),
    fecha_nacimiento date,
    sexo char(1),
    curso int(11) NOT NULL,
    CONSTRAINT alumno_pk PRIMARY KEY  (DNI),
    CONSTRAINT curso_alumnos_fk FOREIGN KEY (curso) REFERENCES curso (cod_curso),
    CONSTRAINT sexo_ck CHECK (sexo = 'M' or sexo = 'H')
);



CREATE TABLE curso(
    nombre_curso varchar(40)  UNIQUE,
    cod_curso int(11),
    maximo_alumnos int(11),
    fecha_inicio date,
    fecha_fin date,
    num_horas  int(11) NOT NULL,
    dni_profesor varchar(9),
    constraint curso_pk PRIMARY KEY (cod_curso),
    CONSTRAINT dni_profesor_fk FOREIGN KEY (dni_profesor) REFERENCES profesores (DNI)
)


CREATE TABLE profesores (
  nombre varchar(20) UNIQUE,
  DNI varchar(9),
  direccion varchar(40),
  titulo varchar(30),
  gana decimal(6,2) not null,
  constraint profesores_pk PRIMARY KEY (DNI)

);




-- INSERTAMOS VALORES Y BORRAMOS--

INSERT INTO profesores values ('Juan', '32432455', 'Puerta Negra, 4', 'Ing.Informatica', 7500, 'Arch', 'Lopez');
INSERT INTO profesores values ('Maria', '43215643', 'Juan Alfonso 32', 'Lda. Fil. Inglesa', 5400, 'Oliva', 'Rubio');
INSERT INTO curso values ('Inglés Básico', 3, 15, '2000-11-01', '2000-12-22', 30, '43215643');
INSERT INTO curso values ('Administración Linux', 2, NULL, '2000-12-20', NULL, 8, '32432455');
INSERT INTO alumnos values ('Lucas', 'Manilva', 'López', '123523', 'Alhamar 3', '1979-11-01', 'V', 1);
INSERT INTO alumnos values ('Jose', 'Perez', 'Caballar', '4896765', 'Jarcha 5', '1977-02-03', 'H',  1);
INSERT INTO alumnos values ('Manuel', 'Alcantara', 'Pedros', '3123689', 'Julian 2', NULL, NULL, 1);
update alumnos set curso=2 where curso=1;
INSERT INTO alumnos values ('Antonia', 'Lopez', 'Alcantara', '2567567', 'Maniquí 21', NULL, 'M', 1);
INSERT INTO alumnos values ('Sergio', 'Navas', 'Retal', '123523', null, NULL, 'p', null); -- va a dar error dni repetido sexo no es M O H y el codigo curso no puede ser nulo
/*INSERT INTO curso (`nombre_curso`, `cod_curso`, `maximo_alumnos`, `fecha_inicio`, `fecha_fin`, `num_horas`, `dni_profesor`) VALUES
	('Entorno', 1, 25, '2019-12-01', '2020-12-01', 400, '24576578D');*/

ALTER TABLE profesores ADD constraint edad_ck CHECK (edad>=18 and edad<=65); -- Añadimos restricciones para que la edad este entre 18 y 65
-- Como no existe el campo de edad en la tabla de profesores, debemos añadirla.
ALTER TABLE profesores ADD column edad int (2);
-- AÑadimos restricciones para que minimo de alumnos de un curso sea 10
ALTER TABLE curso ADD constraint num_alumnos CHECK (maximo_alumnos>10) NOT NULL; 
-- Cambiamos las horas de los cursos para luego aplicarle la restriccion ya que los valores minimos no son 100
update curso set num_horas=100;
-- EL Numero de horas minimo del curso es de 100
ALTER TABLE curso ADD CONSTRAINT hora_ck CHECK (num_horas>100); 


-- Restriccion fecha fin > fecha inicio

alter table curso add constraint fechas CHECK (fecha_inicio<fecha_fin);


-- Añadimos los apellidos ya que no existian las columnas
alter table profesores add apellido1 VARCHAR (30);
alter table profesores add apellido2 VARCHAR (30);
-- Restriccion Not null gana a profesores
ALTER TABLE profesores add constraint not null (DNI, gana);

-- Quitamos la restriccion

ALTER TABLE alumnos DROP CONSTRAINT sexo_ck;

-- Añadimos la restriccion unique al curso matriculado;
Alter table alumnos  add constraint curso_unique_ck UNIQUE (DNI, curso);
-- Añadimos restriccion de Fecha Inicio No nulo;
Alter table curso modify fecha_inicio date not null;

-- Cambiamos la PK de profesores del DNI al nombre y apellidos
alter table curso drop dni_profesor_pk;
-- Nos daba fallos como si la cosntraint primary key no estuviese asi que borramos la primary key
alter table profesores drop primary key; 
--Añadimos la conmstraint primary key con nombre y apellidos
alter table profesores add constraint profesores_pk primary key (nombre, apellido1, apellido2); 

-- Insertamos tuplas
-- Da error columnas que no existen en alumnos
insert into alumnos values ('Juan', 'Arch', 'López', '32432455', 'Puerta Negra, 4', 'Ing. Informática', null); 
-- Tupla bien introducida no tenemos su fecha de nacimiento la dejamos a nulo, pero no tenemos el curso al que pertenece
insert into alumnos values ('Juan', 'Arch', 'López', '32432455', 'Puerta Negra, 4', null, 'H', <curso>); 
-- Orden incorrecto para introducir datos
insert into alumnos values ('Maria', 'Jaén', 'Sevilla', '789678', 'Martos 5', 'M', '1977-03-10', 3);
-- Tupla bien introducida pero daría error no hay curso con codigo 3
insert into alumnos values ('Maria', 'Jaén', 'Sevilla', '789678', 'Martos 5', '1977-03-10', 'M', 3);
--MOdificamos la fecha de nacimiento de Antonia
update alumnos set fecha_nacimiento='1976-12-23' where nombre='Antonia';
-- Cambiamos el codigo de curso de Antonia al 5 daría error porque no hay ningun curso con e codigo 5 y es una FK
update alumnos set curso=5 where nombre='Antonia';
--Eliminamos a la profesora Laura Jimenez la profesora no está en la tabla profesores.
Delete from profesores where nombre='Laura';
-- Creamos una tabla temporal partiendo de otra y concatenamos los campos en una sola columna
CREATE TABLE nombre_alumnos as select concat(nombre,'', apellido1,'', apellido2) as nombre_completo FROM alumnos;
-- Borramos las tablas

drop table profesores;
drop table nombre_alumnos;
drop table curso;
drop table alumnos;

