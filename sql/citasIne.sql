drop database citas_ine

create database citas_ine
go

use citas_ine
go

create table estados
(
	id_estado int,
	nombre varchar(50),
	Constraint pk_estados primary key (id_estado)
)

create table municipio(
id_estado int,
id_municipio int,
nombre	varchar(100)
Constraint pk_municipio primary key (id_municipio),
--constraint fk_idModulo foreign key (id_modulo)
--references Modulo (id_modulo), 
constraint fk_idEstado foreign key (id_estado)
references estados (id_estado)
)

create table modulo
(
	id_modulo int,
    id_municipio int,
	nombre	varchar(100),
	direccion	varchar(250),
	referencias	varchar(250),
	hora_inicio	time,
	hora_termino time,
	Constraint pk_modulo primary key (id_modulo),
	Constraint fk_idMunicipio foreign key (id_municipio)
	references municipio (id_municipio)
)

create table citas
(
	id_modulo int,
	folio int,
	fecha date,
	hora time,
	estado varchar(10),
	Constraint fk_modulo foreign key (id_modulo) references modulo (id_modulo)
)

create table tramite(
	id_tramite int,
	tipo varchar(100)
	constraint pk_tramite primary key (id_tramite)
)

create table paises(
	id_pais int,
	pais varchar(50),
	constraint pk_paises primary key (id_pais)
)


CREATE TABLE categoria
(
	id_categoria int,
	descripcion varchar(50)
	Constraint Pk_categoria primary key (id_categoria)
)


CREATE TABLE documento
(
	id_documento int,
	descripcion varchar(100),
	id_categoria int,
	Constraint Pk_documento primary key (id_documento),
	Constraint Fk_categoria foreign key (id_categoria) references categoria(id_categoria)
)

create table usuarios(
	id_usuario int,
	nombre varchar(100),
	aPaterno varchar(150),
	aMaterno varchar(150),
	lada int,
	telefono varchar(20),
	tipo_telefono varchar(20),
	correo_e  varchar(50),
	observacion varchar(250),
	residencia varchar(50),
	constraint pk_usuario primary key (id_usuario)
)

create table detalle_cita(
	folio int,
	id_usuario int,
	id_tramite int,
	id_documento1 int,
	id_documento2 int,
	id_documento3 int,
	constraint fk_detalle_cita_1 foreign key (id_usuario)
	references usuarios (id_usuario),
	constraint fk_detalle_cita_2 foreign key (id_tramite)
	references tramite (id_tramite),
	constraint fk_detalle_cita_3 foreign key (id_documento1)
	references documento (id_documento),
	constraint fk_detalle_cita_4 foreign key (id_documento2)
	references documento (id_documento),
	constraint fk_detalle_cita_5 foreign key (id_documento3)
	references documento (id_documento),
)

/*drop table detalle_cita
drop table citas
drop table modulo
drop table municipio
drop table estados
drop table categoria
drop table documento
drop table tramite
drop table paises
drop table usuarios*/

/*select * from detalle_cita
select * from citas
select * from modulo
select * from municipio
select * from estados
select * from categoria
select * from documento
select * from tramite
select * from paises
select * from usuario
*/