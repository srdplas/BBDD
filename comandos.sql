

alter table alumnos modify sexo char(1);
alter table alumnos modify apellido2 varchar(20);
alter table alumnos ADD apellido2 varchar(20);
alter table alumnos DROP curso_alumnos_fk;
alter table curso add constraint fechas CHECK (fecha_inicio<fecha_fin);

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

INSERT INTO alumnos ();

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
  nombre_profesor varchar(20) UNIQUE,
  DNI varchar(9),
  direccion varchar(40),
  titulo varchar(30),
  gana decimal(6,2),
  constraint profesores_pk PRIMARY KEY (DNI)

);

-- Añadimos los apellidos y nobre lo editamos
update profesores set nombre_profesor
ALTER TABLE profesores RENAME COLUMN nombre_profesor to nombre;
alter table profesores modify nombre_profesor=nombre;
alter table profesores add apellido1 VARCHAR (30);
alter table profesores add apellido2 VARCHAR (30);
INSERT INTO alumnos  VALUES ('Yuri', 'Cabrero', 'Zayas', '29548797F', 'c/ tomares nº 29', '2000-09-17', 'H', 1);
update alumnos set sexo='H' WHERE codigo=1;
alter table profesores modify gana decimal(6,2);
-- INSERTAMOS VALORES Y BORRAMOS--
DELETE from profesores WHERE nombre='Fernando';
INSERT INTO profesores values ('Juan', '32432455', 'Puerta Negra, 4', 'Ing.Informatica', 7500, 'Arch', 'Lopez');
INSERT INTO profesores values ('Maria', '43215643', 'Juan Alfonso 32', 'Lda. Fil. Inglesa', 5400, 'Oliva', 'Rubio');
INSERT INTO curso values ('Inglés Básico', 1, 15, '2000-11-01', '2000-12-22', 120, '43215643');
INSERT INTO curso values ('Administración Linux', 2, NULL, '2000-12-20', NULL, 8, '32432455');
INSERT INTO alumnos values ('Lucas', 'Manilva', 'López', '123523', 'Alhamar 3', '1979-11-01', 'V', 1);
INSERT INTO alumnos values ('Jose', 'Perez', 'Caballar', '4896765', 'Jarcha 5', '1977-02-03', 'H',  1);
INSERT INTO alumnos values ('Manuel', 'Alcantara', 'Pedros', '3123689', 'Julian 2', NULL, NULL, 1);
update alumnos set curso=2 where curso=1;
INSERT INTO alumnos values ('Antonia', 'Lopez', 'Alcantara', '2567567', 'Maniquí 21', NULL, 'M', 1);
INSERT INTO alumnos values ('Sergio', 'Navas', 'Retal', '123523', null, NULL, 'p', null); -- va a dar error dni repetido sexo no es M O H y el codigo curso no puede ser nulo
/*INSERT INTO curso (`nombre_curso`, `cod_curso`, `maximo_alumnos`, `fecha_inicio`, `fecha_fin`, `num_horas`, `dni_profesor`) VALUES
	('Entorno', 1, 25, '2019-12-01', '2020-12-01', 400, '24576578D');*/

