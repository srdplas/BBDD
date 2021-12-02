-- Creamos las tablas de la base de datos
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

-- Tabla departamentos
CREATE TABLE departamentos(
    dpto_cod int(5),
    nombre_dpto varchar(30) not null,
    jefe int(5),
    presupuesto INTEGER,
    pres_actual INTEGER,
    constraint departamentos_pk primary key (dpto_cod)
);
-- Tabla estudios con fk en tabla universidades y empleados
CREATE TABLE estudios(
    empleado_dni int(8),
    universidad int(5),
    año SMALLINT,
    grado varchar(3),
    especialidad varchar(20),
    constraint estudios_empleado_fk foreign key (empleado_dni) references empleados (dni) ON UPDATE cascade ON DELETE CASCADE,
    constraint estudios_universidad_fk foreign key (universidad) references universidades (univ_cod) ON UPDATE cascade ON DELETE CASCADE
    
);
-- Creamos la tabla universidades
CREATE TABLE universidades(
    univ_cod int(5),
    nombre_univ varchar(25) not null,
    ciudad varchar(20),
    municipio varchar(2),
    cod_postal varchar(5),
    constraint universidades_pk primary key (univ_cod)
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
    constraint supervisor_dni_fk foreign key (supervisor_dni) references empleados(dni) ON UPDATE CASCADE ON DELETE CASCADE

);
-- Creamos la tabla historial salarial con fk de empleados
CREATE TABLE historial_salarial(
    empleado_dni int(8),
    salario INTEGER,
    fecha_comienzo date,
    fecha_fin DATE,
    constraint historial_salarial_fk foreign key (empleado_dni) references empleados(dni) ON UPDATE CASCADE ON DELETE CASCADE

);

-- Creamos la tabla trabajos
CREATE TABLE trabajos(
    trabajo_cod int(5),
    nombre_trab varchar(20) not null,
    salario_min decimal(2,1),
    salario_max decimal(2,1),
    constraint trabajo_pk primary key (trabajo_cod)
);

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
alter table trabajos modify salario_max decimal(2,1) not null; -- Salario maximo obligatorio de cada trabajo
alter table trabajos modify salario_min decimal(2,1) not null; -- Salario minimo obligatorio de cada trabajo

-- Ejercicio 2 restricciones sexo
alter table empleados add constraint sexo_ck CHECK (sexo='H' OR sexo='M'); -- añadimos restriccion al sexo de empleados para que tome 2 valores.

-- Ejercicio 3 restriccion departamentos y trabajos
alter table departamentos modify nombre_dpto varchar(30) not null unique; -- Restriccion nombre departamento unico
alter table trabajos modify nombre_trab varchar(20) not null unique; -- Restriccion nombre trabajo unico

-- Ejercicio 4 respetar orden cronologico fechas historiales
alter table historial_laboral add constraint f_inicio_ck CHECK (fecha_inicio<fecha_fin); -- restriccion fecha inicio menor que fecha fin

alter table historial_salarial add constraint f_inicio_ck CHECK (fecha_comienzo<fecha_fin); -- restriccion fecha inicio menor que fecha fin
-- Aplicar salario null cuando fecha fin sea null??