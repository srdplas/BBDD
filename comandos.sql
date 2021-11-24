INSERT INTO alumnos
VALUES ();
CREATE TABLE ejercicio1(
    nombre_apellidos VARCHAR(30),
    codigo INT,
    direccion VARCHAR(35),
    f_nacimiento VARCHAR(8),
    sexo CHAR(1)
);

alter table alumnos modify sexo char(1);
alter table alumnos modify apellido2 varchar(20);
alter table alumnos ADD apellido2 varchar(20);
alter table alumnos DROP curso_alumnos_fk;
alter table curso add constraint fechas CHECK (fecha_inicio<fecha_fin);

CREATE TABLE alumnos (
    nombre varchar(20) ,
    apellido1 varchar(20),
    apllido2 varchar(20),
    DNI varchar(9) NOT NULL,
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
    cod_curso int(11) NOT NULL,
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
  DNI varchar(9) NOT NULL,
  direccion varchar(40),
  titulo varchar(30),
  gana decimal(4,2),
  constraint profesores_pk PRIMARY KEY (DNI)
);

INSERT INTO alumnos  VALUES ('Yuri', 'Cabrero', 'Zayas', '29548797F', 'c/ tomares nº 29', '2000-09-17', 'H', 1);
update alumnos set sexo='H' WHERE codigo=1;

INSERT INTO profesores (`nombre_profesor`, `DNI`, `direccion`, `titulo`, `gana`) VALUES
	('Fernando', '24576578D', 'c/Fernandez nº 14', 'Ingeniero Informatico', 8.50),


INSERT INTO curso (`nombre_curso`, `cod_curso`, `maximo_alumnos`, `fecha_inicio`, `fecha_fin`, `num_horas`, `dni_profesor`) VALUES
	('Entorno', 1, 25, '2019-12-01', '2020-12-01', 400, '24576578D');

nombre varchar(20) ,
    apellido1 varchar(20),
    apllido2 varchar(20),
    DNI varchar(9) NOT NULL,
    direccion varchar(40),
    fecha_nacimiento date,
    sexo char(1),
    curso int(11) NOT NULL,