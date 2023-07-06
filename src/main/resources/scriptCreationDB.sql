/*
	Script for create dbplazoleta
*/
DROP DATABASE IF EXISTS dbplazoleta;

<<<<<<< HEAD
CREATE DATABASE IF NOT EXISTS  cinepacho_dbmultiplexs;

USE cinepacho_dbmultiplexs;

SET FOREIGN_KEY_CHECKS=0
; 
/* Drop Tables */

DROP TABLE IF EXISTS invoices CASCADE
;

DROP TABLE IF EXISTS movie_theater CASCADE
;

DROP TABLE IF EXISTS movies CASCADE
;

DROP TABLE IF EXISTS multiplexs CASCADE
;

DROP TABLE IF EXISTS show_invoice CASCADE
;

DROP TABLE IF EXISTS snacks CASCADE
;

DROP TABLE IF EXISTS snake_invoice CASCADE
;

DROP TABLE IF EXISTS theaters CASCADE
;

/* Create Tables */

CREATE TABLE invoices
(
	id BIGINT NOT NULL AUTO_INCREMENT,
	id_client VARCHAR(50) NOT NULL COMMENT 'Identificador de la factura',
	rating_movie DOUBLE(3,2) NULL COMMENT 'Calificación de pelicula',
	date DATE NOT NULL,
	net_value INT NULL,
	state VARCHAR(50) NOT NULL,
	CONSTRAINT PK_FACTURA PRIMARY KEY (id ASC)
)
COMMENT = 'Tabla por la cual se guarda todas las operaciones hecha en un punto agil.'

;

CREATE TABLE movie_theater
(
	id BIGINT NOT NULL AUTO_INCREMENT,
	id_theater BIGINT NOT NULL COMMENT 'Nombre multiplex',
	id_movie BIGINT NOT NULL COMMENT 'Id de la pelicula involucrada.',
	day DATE NOT NULL COMMENT 'Id Sala',
	schedule TIME NOT NULL,
	chair_general VARCHAR(79) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
	chair_preferential VARCHAR(39) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
	CONSTRAINT PK_PELICULA_SALA PRIMARY KEY (id ASC)
)
COMMENT = 'Tabla que contiene las relación entre pelicula y una sala.'

;

CREATE TABLE movies
(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'Atributo que identifica la películas en Cine Pacho',
	title VARCHAR(80) NOT NULL COMMENT 'Columna que contiene los nombres de las peliculas',
	duration TIME NOT NULL,
	year_allowed INT NOT NULL,
	synopsis VARCHAR(500) NOT NULL COMMENT 'Columna que contiene la sinopsis de una película.',
	url VARCHAR(255) NOT NULL COMMENT 'Columna que contiene la url de la imagen representativa de la película.',
	CONSTRAINT PK_PELICULA PRIMARY KEY (id ASC)
)
COMMENT = 'Tabla que contiene las peliculas que maneja Cine Pacho'

;

CREATE TABLE multiplexs
(
	id BIGINT NOT NULL AUTO_INCREMENT,
	name VARCHAR(80) NOT NULL COMMENT 'Nombre del producto',
	num_sala INT NOT NULL,
	point_ticket INT NOT NULL DEFAULT 10,
	point_snack INT NOT NULL DEFAULT 5,
	CONSTRAINT PK_MULTIPLEX PRIMARY KEY (id ASC)
)
COMMENT = 'Tabla por la cual contiene los multiplex de Cine Pacho.'

;

CREATE TABLE show_invoice
(
	id BIGINT NOT NULL,
	id_show BIGINT NOT NULL,
	id_invoice BIGINT NOT NULL,
	quantity_chair_general VARCHAR(255) NOT NULL,
	quantity_chair_preferential VARCHAR(255) NOT NULL,
	value INT NOT NULL,
	state VARCHAR(50) NOT NULL,
	CONSTRAINT PK_show_invoice PRIMARY KEY (id ASC)
)

;

CREATE TABLE snacks
(
	id BIGINT NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL COMMENT 'Nombre unico del snack',
	price INT NOT NULL COMMENT 'Valor unitario del snack',
	url VARCHAR(255) NOT NULL COMMENT 'Url de la imagen que representa al snack',
	CONSTRAINT PK_SNACK PRIMARY KEY (id ASC)
)
COMMENT = 'Tabla que contiene los snacks a la venta de Cine Pacho'

;

CREATE TABLE snake_invoice
(
	id BIGINT NOT NULL AUTO_INCREMENT,
	id_snack BIGINT NOT NULL COMMENT 'Id del movimiento bancario',
	id_invoice BIGINT NOT NULL COMMENT 'Numero de cuenta',
	quantity INT NOT NULL COMMENT 'Tipo de cuenta bancaria',
	value INT NOT NULL COMMENT 'Movimiento realizado desde la cuenta',
	state VARCHAR(50) NOT NULL,
	CONSTRAINT PK_SNACK_FACTURA PRIMARY KEY (id ASC)
)
COMMENT = 'Tabla que contiene las compras de snacks en una factura'

;

CREATE TABLE theaters
(
	id BIGINT NOT NULL AUTO_INCREMENT,
	id_multiplex BIGINT NOT NULL,
	id_sala INT NOT NULL COMMENT 'Numero de sala.',
	CONSTRAINT PK_SALA PRIMARY KEY (id ASC)
)
COMMENT = 'Tabla que contiene las salas de un multiplex dado.'

;

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE invoices 
 ADD CONSTRAINT CK_STATE CHECK (state in ('EN PROCESO', 'CANCELADO', 'PAGADO'))
;

ALTER TABLE movie_theater 
 ADD INDEX IXFK_Movie_Theater_Movies (id_movie ASC)
;

ALTER TABLE movie_theater 
 ADD INDEX IXFK_Movie_Theater_Theaters (id_theater ASC)
;

ALTER TABLE movies 
 ADD CONSTRAINT CK_YEAR CHECK (year_allowed > 0)
;

ALTER TABLE multiplexs 
 ADD CONSTRAINT UNIQUE_NAME UNIQUE (name ASC)
;

ALTER TABLE multiplexs 
 ADD CONSTRAINT CK_NUM_SALA CHECK (num_sala  > 0)
;

ALTER TABLE multiplexs 
 ADD CONSTRAINT CK_TIKECT CHECK (point_ticket > 0)
;

ALTER TABLE multiplexs 
 ADD CONSTRAINT CK_SNACK CHECK (point_snack > 0)
;

ALTER TABLE multiplexs 
 ADD CONSTRAINT CK_NAME CHECK (name in ('TITAN','UNICENTRO','PLAZA CENTRAL','GRAN ESTACION','EMBAJADOR','LAS AMERICAS'))
;

ALTER TABLE show_invoice 
 ADD CONSTRAINT CK_VALUE_TICKET CHECK (value >= 0)
;

ALTER TABLE show_invoice 
 ADD CONSTRAINT CK_STATE_SHOW_INVOICE CHECK (state in ('EN PROCESO', 'CANCELADO', 'PAGADO'))
;

ALTER TABLE show_invoice 
 ADD INDEX IXFK_show_invoice_invoices (id_invoice ASC)
;

ALTER TABLE show_invoice 
 ADD INDEX IXFK_show_invoice_movie_theater (id_show ASC)
;

ALTER TABLE snacks 
 ADD CONSTRAINT CK_PRICE CHECK (price > 0)
;

ALTER TABLE snake_invoice 
 ADD CONSTRAINT CK_QUANTITY CHECK (quantity > 0)
;

ALTER TABLE snake_invoice 
 ADD CONSTRAINT CK_VALUE_SNACK CHECK (value > 0)
;

ALTER TABLE snake_invoice 
 ADD CONSTRAINT CK_STATE_SNAKE_INVOICE CHECK (state in ('EN PROCESO', 'CANCELADO', 'PAGADO'))
;

ALTER TABLE snake_invoice 
 ADD INDEX IXFK_snake_invoice_invoices (id_invoice ASC)
;

ALTER TABLE snake_invoice 
 ADD INDEX IXFK_snake_invoice_snacks (id_snack ASC)
;

ALTER TABLE theaters 
 ADD CONSTRAINT CK_SALA CHECK (id_sala > 0)
;

ALTER TABLE theaters 
 ADD INDEX IXFK_Theaters_Multiplexs (id_multiplex ASC)
;

/* Create Foreign Key Constraints */

ALTER TABLE show_invoice 
 ADD CONSTRAINT FK_show_invoice_invoices
	FOREIGN KEY (id_invoice) REFERENCES invoices (id) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE show_invoice 
 ADD CONSTRAINT FK_show_invoice_movie_theater
	FOREIGN KEY (id_show) REFERENCES movie_theater (id) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE snake_invoice 
 ADD CONSTRAINT FK_snake_invoice_invoices
	FOREIGN KEY (id_invoice) REFERENCES invoices (id) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE snake_invoice 
 ADD CONSTRAINT FK_snake_invoice_snacks
	FOREIGN KEY (id_snack) REFERENCES snacks (id) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE theaters 
 ADD CONSTRAINT FK_Theaters_Multiplexs
	FOREIGN KEY (id_multiplex) REFERENCES multiplexs (id) ON DELETE Restrict ON UPDATE Restrict
;

SET FOREIGN_KEY_CHECKS=1
; 
=======
CREATE DATABASE IF NOT EXISTS  dbplazoleta;
>>>>>>> 062c40bbcd9f2bff24e0a46d09492396cf6d8214
