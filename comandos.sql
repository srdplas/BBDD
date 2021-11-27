
CREATE database Ejercicio1;

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
    CONSTRAINT curso_alumnos_fk FOREIGN KEY (curso) REFERENCES curso (cod_curso) ON UPDATE CASCADE ON DELETE CASCADE
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
    constraint fechas_ck CHECK (fecha_inicio<fecha_fin);
    CONSTRAINT dni_profesor_fk FOREIGN KEY (dni_profesor) REFERENCES profesores (DNI) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE profesores (
  nombre varchar(20) UNIQUE,
  apellido1 VARCHAR (30),
  apellido2 VARCHAR (30),
  DNI varchar(9),
  direccion varchar(40),
  titulo varchar(30),
  gana decimal(6,2) not null,
  
  constraint profesores_pk PRIMARY KEY (DNI)

);

-- INSERTAMOS VALORES Y BORRAMOS--

INSERT INTO profesores values ('Juan', 'Arch', 'Lopez', '32432455', 'Puerta Negra, 4', 'Ing.Informatica', 7500);
INSERT INTO profesores values ('Maria', 'Oliva', 'Rubio', '43215643', 'Juan Alfonso 32', 'Lda. Fil. Inglesa', 5400);
INSERT INTO curso values ('Inglés Básico', 1, 15, '2000-11-01', '2000-12-22', 120, '43215643');
INSERT INTO curso values ('Administración Linux', 2, NULL, '2000-12-20', NULL, 80, '32432455');
INSERT INTO alumnos values ('Lucas', 'Manilva', 'López', '123523', 'Alhamar 3', '1979-11-01', 'V', 1); -- V no puede ser restriccion a H O M
INSERT INTO alumnos values ('Jose', 'Perez', 'Caballar', '4896765', 'Jarcha 5', '1977-02-03', 'H',  1);
INSERT INTO alumnos values ('Manuel', 'Alcantara', 'Pedros', '3123689', 'Julian 2', NULL, NULL, 1);
INSERT INTO alumnos values ('Antonia', 'Lopez', 'Alcantara', '2567567', 'Maniquí 21', NULL, 'M', 1);
INSERT INTO alumnos values ('Sergio', 'Navas', 'Retal', '123523', null, NULL, 'p', null); -- va a dar error dni repetido sexo no es M O H y el codigo curso no puede ser nulo

-- Como no existe el campo de edad en la tabla de profesores, debemos añadirla.
ALTER TABLE profesores ADD column edad int (2);
ALTER TABLE profesores ADD constraint edad_ck CHECK (edad>=18 and edad<=65); -- Añadimos restricciones para que la edad este entre 18 y 65

-- AÑadimos restricciones para que minimo de alumnos de un curso sea 10
ALTER TABLE curso ADD constraint num_alumnos CHECK (maximo_alumnos>10); 
-- Cambiamos las horas de los cursos para luego aplicarle la restriccion ya que los valores minimos no son 100
update curso set num_horas=101;
-- EL Numero de horas minimo del curso es de 100
ALTER TABLE curso ADD CONSTRAINT curso_hora_ck CHECK (num_horas>100); 

-- Quitamos la restriccion

ALTER TABLE alumnos DROP CONSTRAINT sexo_ck;

-- Restriccion Not null gana a profesores
ALTER TABLE profesores modify gana decimal (6,2);

-- Añadimos la restriccion unique al curso matriculado;
Alter table alumnos  add constraint curso_unique_ck UNIQUE (DNI, curso);

-- Añadimos restriccion de Fecha Inicio No nulo;
Alter table curso modify fecha_inicio date not null;

-- Nuestra tabla cursos se llamaba curso, le cambiamos el nombre para que este como en el ejercicio
ALTER TABLE curso RENAME TO cursos;
