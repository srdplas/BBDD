/*  BOLETÍN 2: DATOS DE EMPLEADOS DE UNA EMPRESA */
/*  CREACIÓN DE LA BASE DE DATOS*/
CREATE DATABASE actualizacion;
USE actualizacion;

/* CREACIÓN DE TABLAS */

CREATE TABLE empleados(
	dni CHAR(8),
	nombre VARCHAR(10) NOT NULL,
	apellido1 VARCHAR(15) NOT NULL,
	apellido2 VARCHAR(15),
	direcc1 VARCHAR(25),
	direcc2 VARCHAR(20),
	ciudad VARCHAR(20),
	municipio VARCHAR(20),
	cod_postal VARCHAR(5),
	sexo CHAR(1),
	fecha_nacimiento DATE,
	CONSTRAINT empl_pk PRIMARY KEY(dni),
	CONSTRAINT sexo_chk CHECK (sexo IN ('H','M'))
);
-- Aumento el tamaño de municipio de VARCHAR(3) a 20
CREATE TABLE universidad(
	univ_cod INT(5),
	nombre_univ VARCHAR(25) NOT NULL,
	ciudad VARCHAR(20),
	municipio VARCHAR(20),
	cod_postal VARCHAR(5),
	CONSTRAINT uni_pk PRIMARY KEY(univ_cod)
);

CREATE TABLE trabajos(
	trab_cod INT(5),
	nombre_trab VARCHAR(20) NOT NULL UNIQUE,
	sal_min INT(5),
	sal_max INT(5),
	CONSTRAINT trab_pk PRIMARY KEY (trab_cod)
);


CREATE TABLE departamentos(
	dpto_cod INT(5),
	nombre_dpto VARCHAR(30) NOT NULL UNIQUE,
	jefe CHAR(8) ,
	presupuesto INTEGER NOT NULL,
	pres_actual INTEGER,
	CONSTRAINT trab_pk PRIMARY KEY (dpto_cod),
	CONSTRAINT dpto_emp_fk FOREIGN KEY (jefe) 
		REFERENCES empleados(dni) on update cascade on delete cascade
);

-- Aumento el tamaño de grado de VARCHAR(3) a 20
CREATE TABLE estudios(
	emp_dni CHAR(8),
	universidad INT(5),
	anno INT(4),
	grado VARCHAR(20),
	especialidad VARCHAR(20),
	CONSTRAINT estudios_pk PRIMARY KEY(emp_dni, especialidad),
	CONSTRAINT est_emp_fk 
		FOREIGN KEY(emp_dni) REFERENCES empleados(dni),
	CONSTRAINT est_uni_fk 
		FOREIGN KEY(universidad) REFERENCES universidad(univ_cod)
);

CREATE TABLE historial_laboral(
	emp_dni CHAR(8),
	trab_cod INT(5),
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE,
	dpto_cod INT(5),
	supervisor_dni CHAR(8),
	CONSTRAINT hist_laboral_pk PRIMARY KEY (emp_dni,fecha_inicio ),
	CONSTRAINT finff_chk CHECK (fecha_fin>fecha_inicio),
	CONSTRAINT hl_emp_fk 
		FOREIGN KEY(emp_dni) REFERENCES empleados(dni),
	CONSTRAINT hl_dpto_fk 
		FOREIGN KEY(dpto_cod) REFERENCES departamentos(dpto_cod),
	CONSTRAINT hl_sup_emp_fk 
		FOREIGN KEY(supervisor_dni) REFERENCES empleados(dni),
	CONSTRAINT hl_trab_fk 
		FOREIGN KEY(trab_cod) REFERENCES trabajos(trab_cod)
);

CREATE TABLE historial_salarial(
	emp_dni CHAR(8),
	salario INTEGER,
	fecha_comienzo DATE NOT NULL,
	fecha_fin DATE,
	CONSTRAINT hist_salarial_pk PRIMARY KEY (emp_dni, fecha_comienzo),
	CONSTRAINT finhs_chk CHECK (fecha_fin>fecha_comienzo),
	CONSTRAINT hs_emp_fk 
		FOREIGN KEY(emp_dni) REFERENCES empleados(dni)

);

/* OPERACIONES */
/* 1. Inserta 2 tuplas en cada tabla */
INSERT INTO empleados VALUES ('11111111', 'Juan', 'Arch','López', 'Puerta Negra, 4','Puerta Negra, 5', 'Sevilla', 'Sevilla',  '41001', 'H', '1980-01-01');
INSERT INTO empleados VALUES ('22222222', 'María', 'García','García', 'Puerta Blanca, 1','Puerta Blanca, 2', 'Sevilla', 'Sevilla',  '41001', 'M', '1981-02-02');

INSERT INTO universidad VALUES (11111, 'Universidad 1', 'Sevilla', 'Sevilla','41001');
INSERT INTO universidad VALUES (22222, 'Universidad 2', 'Cádiz', 'Cádiz','11001');

INSERT INTO trabajos VALUES (11111, 'Profesor', 34000, 39000);
INSERT INTO trabajos VALUES (22222, 'Conserje', 18000, 24000);

INSERT INTO departamentos VALUES (11111, 'Programación', '11111111', 10000, 5000);
INSERT INTO departamentos VALUES (22222, 'Redes', '22222222', 8000, 4000);

INSERT INTO estudios VALUES ('11111111', 11111, 2000, 'sup', 'Informática');
INSERT INTO estudios VALUES ('22222222', 22222, 2001, 'sup', 'Informática');

INSERT INTO historial_laboral VALUES ('11111111', 11111, '2002-09-01', '2005-08-31', 11111, '22222222');
INSERT INTO historial_laboral VALUES ('11111111', 11111, '2006-09-01', '2016-08-31', 11111, '22222222');

INSERT INTO historial_salarial VALUES ('11111111', 34000, '2002-09-01', '2005-08-31');
INSERT INTO historial_salarial VALUES ('11111111', 35000, '2006-09-01', '2016-08-31');

/* 2. Inserta las tuplas */
INSERT INTO empleados VALUES ('111222', 'Sergio', 'Palma','Entrena', '', '', '', '' , '', 'V', '');
INSERT INTO empleados VALUES ('222333', 'Lucia', 'Ortega','Plus', '', '', '', '' , '', '', '');

INSERT INTO historial_laboral VALUES ('111222', NULL , '1996-06-16', NULL, '', '222333');
/* 	Va a dar errores, para que funcione
	Insertar en historial_laboral funciona, pero se deberia comprobar que el supervisor es un empleado*/
INSERT INTO empleados VALUES ('111222', 'Sergio', 'Palma','Entrena', '', '', '', '' , '', 'H', '');
INSERT INTO empleados VALUES ('222333', 'Lucia', 'Ortega','Plus', '', '', '', '' , '', 'M', '');

/* Actualiza al empleado que mas dinero gana actualmente
y hazlo indefinido*/
update historial_salarial set fecha_fin=null 
where salario in (select max(salario) from historial_salarial);
