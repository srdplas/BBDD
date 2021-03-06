-- Creamos las tablas de la base de datos
Create database Boletin2;
-- Cambiamos los varchar2 y los number por int ya que me da error de syntaxis
-- Tabla empleados
CREATE TABLE empleados (
    dni int(8),
    nombre VARCHAR(10) not null,
    apellido1 varchar(15),
    apellido2 varchar(15),
    direcc1 varchar(25),
    direcc2 varchar(20),
    ciudad varchar(20),
    municipio varchar(20),
    cod_postal varchar(5),
    sexo CHAR(1),
    fecha_nac DATE,
    constraint empleado_pk primary key (dni)
);

-- Creamos la tabla trabajos
CREATE TABLE trabajos(
    trabajo_cod int(5),
    nombre_trab varchar(20) not null,
    salario_min decimal(6,2),
    salario_max decimal(6,2),
    constraint trabajo_pk primary key (trabajo_cod)
);

-- Creamos la tabla universidades
CREATE TABLE universidades(
    univ_cod int(5),
    nombre_univ varchar(25) not null,
    ciudad varchar(20),
    municipio char(20),
    cod_postal char(5),
    constraint universidades_pk primary key (univ_cod)
);

-- Tabla departamentos
CREATE TABLE departamentos(
    dpto_cod int(5),
    nombre_dpto varchar(30) not null,
    jefe int(8),
    presupuesto INTEGER,
    pres_actual INTEGER,
    constraint departamentos_pk primary key (dpto_cod),
    constraint jefe_fk foreign key (jefe) REFERENCES empleados(dni) on update cascade on delete cascade
);
-- Tabla estudios con fk en tabla universidades y empleados
CREATE TABLE estudios(
    empleado_dni int(8),
    universidad int(5),
    año SMALLINT,
    grado varchar(30),
    especialidad varchar(20),
    constraint estudios_empleado_fk foreign key (empleado_dni) references empleados (dni) ON UPDATE cascade ON DELETE CASCADE,
    constraint estudios_universidad_fk foreign key (universidad) references universidades (univ_cod) ON UPDATE cascade ON DELETE CASCADE
    
);

-- Creamos la tabla historial laboral con 3 fk 2 de tabla empleados 1 tabla departamentos 
CREATE TABLE historial_laboral(
    empleado_dni int(8),
    trab_cod int(5),
    fecha_inicio date,
    fecha_fin date,
    dpto_cod int(5),
    supervisor_dni int(8),
    constraint historial_laboral_fk foreign key (empleado_dni) references empleados(dni) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint dpto_fk foreign key (dpto_cod) references departamentos(dpto_cod) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint supervisor_dni_fk foreign key (supervisor_dni) references empleados(dni) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint trabajo_fk foreign key (trab_cod) references trabajos(trabajo_cod) ON UPDATE CASCADE ON DELETE CASCADE
);
-- Creamos la tabla historial salarial con fk de empleados
CREATE TABLE historial_salarial(
    empleado_dni int(8),
    salario INTEGER,
    fecha_comienzo date,
    fecha_fin date,
    constraint historial_salarial_fk foreign key (empleado_dni) references empleados(dni) ON UPDATE CASCADE ON DELETE CASCADE
    
);
--alter table historial_salarial add constraint salario_inicio_fk foreign key (fecha_comienzo) references historial_laboral(fecha_inicio);
--alter table historial_salarial add constraint salario_fin_fk foreign key (fecha_fin) references historial_laboral(fecha_fin);

/* ORDEN AL INSERTAR LAS TABLAS
1 empleados          5 estudios 
2 trabajos           6 historial laboral
3 universidades      7 historial salarial 
4 departamentos                        
*/

-- Ejercicio 1 restricciones a nombre, apellido1, presupuesto, salario, salario max y salario min
alter table empleados modify nombre varchar(8) not null; -- tras insertar ya las tablas pero se puede poner al crearlas. (la ponemos al crearlas)
alter table empleados modify apellido1 varchar(15) not null; -- apellido 1 de empleados obligatorio.
alter table departamentos modify presupuesto integer not null; -- presupuesto obligatorio a departamentos
alter table historial_salarial modify salario integer not null; -- salario de un empleado obligatorio
alter table trabajos modify salario_max decimal(6,2) not null; -- Salario maximo obligatorio de cada trabajo
alter table trabajos modify salario_min decimal(6,2) not null; -- Salario minimo obligatorio de cada trabajo

-- Ejercicio 2 restricciones sexo
alter table empleados add constraint sexo_ck CHECK (sexo='H' OR sexo='M'); -- añadimos restriccion al sexo de empleados para que tome 2 valores.

-- Ejercicio 3 restriccion departamentos y trabajos
alter table departamentos modify nombre_dpto varchar(30) not null unique; -- Restriccion nombre departamento unico
alter table trabajos modify nombre_trab varchar(20) not null unique; -- Restriccion nombre trabajo unico

-- Ejercicio 4 respetar orden cronologico fechas historiales
alter table historial_laboral add constraint f_inicio_ck CHECK (fecha_inicio<fecha_fin); -- restriccion fecha inicio menor que fecha fin
alter table historial_salarial add constraint f_inicio_laboral_ck CHECK (fecha_comienzo<fecha_fin or salario=null); -- restriccion fecha inicio menor que fecha fin
-- Restriccion 1 solo salario 1 solo trabajo con update y delete cascade al crear tablas
-- Y la cadena del dni, el salario y la fecha de inicio sea unica en su conjunto
alter table historial_salarial add constraint salario_ck unique (empleado_dni, salario, fecha_comienzo);
-- Establecemos una restriccion para que el dni, la fecha de inicio y fecha fin sean unicos en base al conjunto
alter table historial_laboral add constraint trabajo_ck unique (empleado_dni, fecha_inicio,fecha_fin);

-- Insertamos 2 tuplas a cada tabla
insert into empleados values('85678432','Yuri', 'Zayas', 'Martinez', 'c/ san juan n1º 13', null, 'Sevilla', 'San Juan', '45609', 'H', '2000-12-04');
insert into empleados values('85328432','Manuela', 'Rodriguez', 'Lopez', 'c/ san tomas nº 2', null, 'Sevilla', 'Mairena', '32609', 'M', '1999-05-11');

insert into trabajos values(1, 'Programador BackEnd', 1200, 1995.99);
insert into trabajos values(3, 'Barrendero', 540.45, 785.82);

insert into universidades values(4, 'Palo Olavide', 'Sevilla', 'Antequera', '78095');
insert into universidades values(6, 'Universidad Sevilla', 'Sevilla', 'Bermejales', '42095');

insert into departamentos values(11, 'Recursos Humanos', '85678432', 3000, 2500);
insert into departamentos values(9, 'Mano de obra', null, 2000, 1500);

insert into estudios values('85678432', 6, '2018', 'INFORMATICA', 'Programacion Objetos');
insert into estudios values('85328432', 4, '2017', 'RELACIONES PUBLICAS', 'Marketing WEB');

  
insert into historial_laboral values('85678432', 1, '2021-12-12', null, 11, null);
insert into historial_laboral values('85328432', 3, '2018-12-12','2020-12-13', 9, null);

-- Teniendo en cuenta que la fecha de inicio y fin viene del historial laboral, dichas fechas son FK la cual pusimos al crear tablas
insert into historial_salarial values('85678432', 1500, '2021-12-12', null);
insert into historial_salarial values('85328432', 600, '2018-12-12', '2020-12-13');

-- ---------------------------------------------------------------------------------------------------------------- --

alter table empleados disable keys;

insert into empleados values('111222', 'Sergio', 'Palma', 'Entrena', null, null, null, null, null, 'P', null);
insert into empleados values('222333', 'Lucia', 'Ortega', 'Plus', null, null, null, null, null, null, null);

insert into historial_laboral values ('111222', null, '1996-06-16', null, null, '222333');
alter table empleados enable keys;

/*
Borramos la constraint nos deja introducir los valores y para añadirla de nuevo
tenemos que borrar los datos introducidos para poder volver a poner la restriccion
alter table empleados drop constraint sexo_ck;
alter table empleados add constraint sexo_ck CHECK (sexo='H' OR sexo='M');

*/

-- Si asignamos un supervisor que no está en la lista de empleados, violaría la segunda regla de integridad, puede ser nulo pero 
-- no puede tomar un valor que no esté en la lista de empleados.

-- Borramos una universidad de la tabla universidades

delete from universidades where univ_cod=4; -- Al borrar la universidad desaparece el empleado asociado a esta en la tabla estudios.
-- Añadimos lo que hemos perdido al borrar la universidad, editamos para que aunque borramos se siga manteniendo los datos.

alter table estudios drop constraint estudios_universidad_fk;
alter table estudios add constraint estudios_universidad_fk foreign key (universidad) references universidades (univ_cod);

delete from universidades where univ_cod=4;
-- Si borramos la universidad sin el on update cascade on delete cascade no nos dejará borrar la universidad porque 
-- Hace referencia a otra tabla.

-- Añadimos restriccion para que las personas de sexo masculino tengan que tener el campo de f_nacimiento en not null
alter table empleados add constraint hombre_check check (fecha_nac is not null and sexo='H');

-- Añadimos un nuevo atributo a la tabla de empleados , valoracion con un valor por defecto de 5
alter table empleados add column valoracion DECIMAL (4,2) default 5 check(valoracion>=1 and valoracion<=10);
-- Nada mas insertarlo como no le hemos dado valores , la valoracion de las tuplas de todos los empleados se pone a 5
insert into empleados (dni, nombre, apellido1, apellido2, direcc1, direcc2, ciudad, municipio, cod_postal, sexo, fecha_nac) 
values('25678943','Carmen', 'Perez', 'Gomez', 'c/ tomas destro n1º 13', null, 'Malaga', 'Marbella', '61230', 'M', '1995-01-07');
-- Insertamos todos los campos menos el de valoracion y por defecto en vez de null pone 5 como hemos puesto antes.

-- Borramos la restriccion de que el nombre del empleado no pueda ser nulo

alter table empleados modify nombre VARCHAR(10);

-- Modificamos la columna de direc1 para que sea una cadena de caracteres como maximo de 40
alter table empleados modify direcc1 varchar(40),

-- Modificamos el tipo de dato del codigo de empleado, dni
alter table empleados modify dni varchar(40); -- no nos dejaría porque es foreign key en otras tablas y todas deben ser del mismo tipo
-- Habría que cambiar el tipo de dato de todas las columnas de las tablas a las que hace referencia y ponerlo al mismo tipo

-- Modificamos el tipo de dato de la fecha de nacimiento de los empleados
alter table empleados modify fecha_nac varchar(40); 
-- Nos deja cambiarle el tipo de dato, ya que no hace referencia en otra tabla como en el caso anterior

-- cambiamos la primary key de empleado a nombre y apellidos
alter table empleados drop constraint empleado_pk;
alter table empleados add constraint empleado_pk primary key (nombre, apellido1, apellido2);
-- Error on rename of '.\boletin2\#sql-alter-2780-1e' to '.\boletin2\empleados' (errno: 150 "Foreign key constraint is incorrectly formed")
-- Me sale ese error al intentar borrar la primary key pero esto funciona porque se hizo en el boletin 1.

delete from empleados where nombre='Yuri'; -- borramos al empleado yuri
-- como le tenemos puesto on update cascade on delete cascade, el empleado Yuri ha sido borrado de historial_laboral
-- y tambien de la tabla historial_salarial.

-- Creamos una tabla con la concatenacion de nombre, apellido1, apellido2 y universidad de los datos de dos tablas
create table informacion_universitaria as select concat(nombre, ' ', apellido1, ' ', apellido2, ' ', nombre_univ) as info_empleado from empleados, universidades;

-- borramos las tablas en el orden inverso en el las creamos ya que al tener foreign keys no nos dejarán borrarla
drop table historial_salarial;
drop TABLE historial_laboral;
drop TABLE estudios;
drop table departamentos;
drop TABLE universidades;
drop TABLE trabajos;
drop TABLE empleados;
-- informacion universitaria no tiene fk el orden en esta es indiferente
drop TABLE informacion_universitaria;