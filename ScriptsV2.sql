create database bd_web_shop;

create user usu_ws_shop_utb with password 'usu_ws_shop_utb';

create schema e_web_shop;


create sequence e_web_shop.seq_id_persona start with 1;

create table e_web_shop.p_persona(
	id_persona					bigint			not null	default nextval('e_web_shop.seq_id_persona') unique,
	nombres						varchar(200)	null,
	apellido_paterno			varchar(200)	null,
	apellido_materno			varchar(200)	null,
	apellido_casada				varchar(200)	null,
	direccion					varchar(200)	null,
	coordenada_x				varchar(200)	null,
	coordenada_y				varchar(200)	null,
	cod_estado_civil			varchar(5)		null,
	cod_tipo_identificacion		varchar(5)		null,
	numero_identificacion		varchar(20)		null,
	numero_contacto				varchar(20)		null,
	fec_registro				timestamp 		not null	default CURRENT_TIMESTAMP,
	cod_estado					varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.p_persona add constraint pk_f_persona primary key(id_persona);

create sequence e_web_shop.seq_id_usuario start with 1;

create table e_web_shop.f_usuario(
	id_usuario		bigint 			not null 	default nextval('e_web_shop.seq_id_usuario') unique,
	email_usuario	varchar(50)		not null,
	password		varchar(120)	not null,
	username		varchar(20)		not null,
	fec_registro	timestamp 		not null	default CURRENT_TIMESTAMP,
	cod_estado		varchar(5)		not null	default 'ACT',
	id_persona		bigint			null
);

alter table e_web_shop.f_usuario add constraint pk_f_usuario primary key(id_usuario);
alter table e_web_shop.f_usuario add constraint fk_f_usuario_persona foreign key(id_persona) references e_web_shop.p_persona(id_persona);

create sequence e_web_shop.seq_id_rol start with 1;

create table e_web_shop.f_rol(
	id_rol			bigint			not null	default nextval('e_web_shop.seq_id_rol') unique,
	nombre_rol		varchar(100)	not null,
	fec_registro	timestamp 		not null	default CURRENT_TIMESTAMP,
	cod_estado		varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.f_rol add constraint pk_f_rol primary key(id_rol);

insert into e_web_shop.f_rol(nombre_rol) values('ROLE_USER');
insert into e_web_shop.f_rol(nombre_rol) values('ROLE_MODERATOR');
insert into e_web_shop.f_rol(nombre_rol) values('ROLE_ADMIN');

create table e_web_shop.f_r_usuario_rol(
	id_usuario		bigint,
	id_rol			bigint
);

alter table e_web_shop.f_r_usuario_rol add constraint fk_f_usuario_rol foreign key(id_usuario) references e_web_shop.f_usuario(id_usuario);
alter table e_web_shop.f_r_usuario_rol add constraint fk_f_rol_usuario foreign key(id_rol) references e_web_shop.f_rol(id_rol);

create sequence e_web_shop.seq_id_def_dominio start with 1;

create table e_web_shop.p_def_dominio(
	id_def_dominio			bigint			not null	default nextval('e_web_shop.seq_id_def_dominio') unique,
	nombre_dominio			varchar(255)	not null,
	descripcion_dominio		text			null,
	fec_registro			timestamp 		not null	default CURRENT_TIMESTAMP,
	cod_estado				varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.p_def_dominio add constraint pk_p_def_dominio primary key(id_def_dominio);

create sequence e_web_shop.seq_id_dominio_fijo start with 1;

create table e_web_shop.p_dominio_fijo(
	id_dominio_fijo			bigint			not null 	default nextval('e_web_shop.seq_id_dominio_fijo') unique,
	id_def_dominio			bigint			not null,
	nombre_dominio			varchar(255)	not null,
	auxiliar				varchar(255)	null,
	cod_dominio				varchar(10)		not null,
	descripcion_dominio		text			null,
	fec_registro			timestamp		not null	default current_timestamp,
	cod_estado				varchar(5)		not null	default	'ACT'
);

alter table e_web_shop.p_dominio_fijo add constraint pk_dominio_fijo primary key(id_dominio_fijo);
alter table e_web_shop.p_dominio_fijo add constraint fk_dominio_fijo_def_dominio foreign key(id_def_dominio) references e_web_shop.p_def_dominio(id_def_dominio);

create sequence e_web_shop.seq_id_proveedor start with 1;

create table e_web_shop.f_proveedor(
	id_proveedor			bigint			not null	default nextval('e_web_shop.seq_id_proveedor') unique,
	nombre_proveedor		varchar(250)	not null,
	cod_tipo_identificacion	varchar(5)		null,
	numero_identificacion	varchar(20)		null,
	numero_contacto			varchar(20)		not null,
	fec_registro			timestamp		not null	default current_timestamp,
	cod_estado				varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.f_proveedor add constraint pk_f_proveedor primary key(id_proveedor);

create sequence e_web_shop.seq_id_categoria start with 1;

create table e_web_shop.f_categoria(
	id_categoria		bigint			not null	default nextval('e_web_shop.seq_id_categoria') unique,
	nombre_categoria	varchar(250)	not null,
	descripcion			text			null,
	fec_registro		timestamp		not null	default current_timestamp,
	cod_estado			varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.f_categoria add constraint pk_f_categoria primary key(id_categoria);

create sequence e_web_shop.seq_id_producto start with 1;

create table e_web_shop.f_producto(
	id_producto				bigint			not null default nextval('e_web_shop.seq_id_producto') unique,
	nombre_producto			varchar(250)	not null,
	cantidad_stock			numeric(10, 0)	not null,
	precio_producto			numeric(10, 2)	not null,
	descripcion				text			null,
	costo_producto			numeric(10, 2)	not null,
	-- cod_unidad_medida		varchar(5)		null,
	imagen_referencial		varchar(250)	null,
	id_proveedor			bigint			not null,
	id_categoria			bigint			not null,
	fec_registro			timestamp		not null	default	current_timestamp,
	cod_estado				varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.f_producto add constraint pk_f_producto primary key(id_producto);
alter table e_web_shop.f_producto add constraint fk_producto_proveedor foreign key(id_proveedor) references e_web_shop.f_proveedor(id_proveedor);
alter table e_web_shop.f_producto add constraint fk_producto_categoria foreign key(id_categoria) references e_web_shop.f_categoria(id_categoria);

create sequence e_web_shop.seq_id_cliente start with 1;

create table e_web_shop.f_cliente(
	id_cliente		bigint		not null	default nextval('e_web_shop.seq_id_cliente') unique,
	id_persona		bigint		not null,
	fec_registro	timestamp	not null	default current_timestamp,
	cod_estado		varchar(5)	not null	default 'ACT'
);

alter table e_web_shop.f_cliente add constraint pk_f_cliente primary key(id_cliente);
alter table e_web_shop.f_cliente add constraint fk_cliente_persona foreign key(id_persona) references e_web_shop.p_persona(id_persona);

create sequence e_web_shop.seq_id_venta start with 1;

create table e_web_shop.f_venta(
	id_venta			bigint			not null	default nextval('e_web_shop.seq_id_venta') unique,
	num_comprobante		numeric(10, 0)	not null	unique,
	total				numeric(20, 2)	not null	default 0,
	cod_metodo_pago		varchar(5)		not null,
	cod_tipo_venta		varchar(5)		not null,
	id_cliente			bigint 			not null,
	id_usuario			bigint			not null,
	fec_registro		timestamp		not null	default current_timestamp,
	cod_estado			varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.f_venta add constraint pk_f_venta primary key(id_venta);
alter table e_web_shop.f_venta add constraint fk_venta_cliente foreign key(id_cliente) references e_web_shop.f_cliente(id_cliente);
alter table e_web_shop.f_venta add constraint fk_venta_usuario foreign key(id_usuario) references e_web_shop.f_usuario(id_usuario);

create sequence e_web_shop.seq_id_detalle_venta start with 1;

create table e_web_shop.f_detalle_venta(
	id_detalle_venta	bigint			not null 	default nextval('e_web_shop.seq_id_detalle_venta') unique,
	id_venta			bigint			not null,	
	id_producto			bigint			not null,
	cantidad			bigint			not null	default 0,
	precio_venta		numeric(10,2)	not null,
	fec_registro		timestamp		not null	default current_timestamp,
	cod_estado			varchar(5)		not null	default 'ACT'
);

alter table e_web_shop.f_detalle_venta add constraint pk_detalle_venta primary key(id_detalle_venta);
alter table e_web_shop.f_detalle_venta add constraint fk_venta_producto foreign key(id_venta) references e_web_shop.f_venta(id_venta);
alter table e_web_shop.f_detalle_venta add constraint fk_producto_venta foreign key(id_producto) references e_web_shop.f_producto(id_producto);

create sequence e_web_shop.seq_id_entrega start with 1;

create table e_web_shop.f_entrega(
	id_entrega		bigint		not null	default nextval('e_web_shop.seq_id_entrega') unique,
	id_venta		bigint		not null,
	id_usuario		bigint		not null,
	fec_registro	timestamp	not null	default current_timestamp,
	cod_estado		varchar(5)	not null	default 'ACT'
);

alter table e_web_shop.f_entrega add constraint pk_f_entrega primary key(id_entrega);
alter table e_web_shop.f_entrega add constraint fk_entrega_repartidor foreign key(id_usuario) references e_web_shop.f_usuario(id_usuario);
alter table e_web_shop.f_entrega add constraint fk_entrega_venta foreign key(id_venta) references e_web_shop.f_venta(id_venta);

GRANT ALL PRIVILEGES ON DATABASE bd_web_shop TO usu_ws_shop_utb;

GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA e_web_shop TO usu_ws_shop_utb;
GRANT USAGE ON SCHEMA e_web_shop TO usu_ws_shop_utb;

ALTER DEFAULT PRIVILEGES IN SCHEMA e_web_shop
GRANT SELECT, INSERT, UPDATE ON TABLES TO usu_ws_shop_utb;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_persona TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_usuario TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_rol TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_def_dominio TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_dominio_fijo TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_proveedor TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_categoria TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_producto TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_cliente TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_venta TO usu_ws_shop_utb;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE e_web_shop.seq_id_entrega TO usu_ws_shop_utb;

-- Inserción en la tabla p_persona
INSERT INTO e_web_shop.p_persona (nombres, apellido_paterno, apellido_materno, direccion, coordenada_x, coordenada_y, cod_estado_civil, cod_tipo_identificacion, numero_identificacion, numero_contacto) VALUES
('Carlos', 'Pérez', 'Gómez', 'Calle 123', '10.123', '-75.123', 'SOL', 'DNI', '12345678', '987654321'),
('Ana', 'López', 'Rodríguez', 'Av. Central', '10.234', '-75.234', 'CAS', 'DNI', '23456789', '987654322'),
('Luis', 'Martínez', 'Fernández', 'Calle 45', '10.345', '-75.345', 'DIV', 'DNI', '34567890', '987654323'),
('María', 'González', 'Hernández', 'Av. Sur', '10.456', '-75.456', 'SOL', 'DNI', '45678901', '987654324'),
('Jorge', 'Ramírez', 'Ruiz', 'Calle 67', '10.567', '-75.567', 'VIU', 'DNI', '56789012', '987654325'),
('Laura', 'Torres', 'Silva', 'Av. Norte', '10.678', '-75.678', 'CAS', 'DNI', '67890123', '987654326'),
('Pedro', 'Vega', 'Mendoza', 'Calle 89', '10.789', '-75.789', 'SOL', 'DNI', '78901234', '987654327'),
('Lucía', 'Ortiz', 'Castro', 'Av. Este', '10.890', '-75.890', 'DIV', 'DNI', '89012345', '987654328'),
('Raúl', 'Sánchez', 'Rojas', 'Calle Oeste', '10.901', '-75.901', 'CAS', 'DNI', '90123456', '987654329'),
('Elena', 'Díaz', 'Morales', 'Calle Central', '11.012', '-75.012', 'SOL', 'DNI', '01234567', '987654330');

-- Inserción en la tabla f_usuario (relacionada con p_persona)
INSERT INTO e_web_shop.f_usuario (email_usuario, password, username, id_persona) VALUES
('carlos.perez@example.com', 'pass123', 'cperez', 1),
('ana.lopez@example.com', 'pass123', 'alopez', 2),
('luis.martinez@example.com', 'pass123', 'lmartinez', 3),
('maria.gonzalez@example.com', 'pass123', 'mgonzalez', 4),
('jorge.ramirez@example.com', 'pass123', 'jramirez', 5),
('laura.torres@example.com', 'pass123', 'ltorres', 6),
('pedro.vega@example.com', 'pass123', 'pvega', 7),
('lucia.ortiz@example.com', 'pass123', 'lortiz', 8),
('raul.sanchez@example.com', 'pass123', 'rsanchez', 9),
('elena.diaz@example.com', 'pass123', 'ediaz', 10);

-- Inserción en la tabla f_proveedor
INSERT INTO e_web_shop.f_proveedor (nombre_proveedor, cod_tipo_identificacion, numero_identificacion, numero_contacto) VALUES
('Proveedor Uno', 'RUC', '12345678901', '999888777'),
('Proveedor Dos', 'RUC', '12345678902', '999888776'),
('Proveedor Tres', 'RUC', '12345678903', '999888775'),
('Proveedor Cuatro', 'RUC', '12345678904', '999888774'),
('Proveedor Cinco', 'RUC', '12345678905', '999888773'),
('Proveedor Seis', 'RUC', '12345678906', '999888772'),
('Proveedor Siete', 'RUC', '12345678907', '999888771'),
('Proveedor Ocho', 'RUC', '12345678908', '999888770'),
('Proveedor Nueve', 'RUC', '12345678909', '999888769'),
('Proveedor Diez', 'RUC', '12345678910', '999888768');

-- Inserción en la tabla f_categoria
INSERT INTO e_web_shop.f_categoria (nombre_categoria, descripcion) VALUES
('Camisetas', 'Ropa casual para hombres y mujeres'),
('Pantalones', 'Pantalones de vestir y jeans'),
('Zapatos', 'Calzado para toda ocasión'),
('Accesorios', 'Sombreros, bufandas y más'),
('Ropa Deportiva', 'Ropa para actividades deportivas'),
('Abrigos', 'Abrigos y chaquetas para el frío'),
('Vestidos', 'Vestidos para ocasiones casuales y formales'),
('Trajes', 'Trajes de negocios y formales'),
('Ropa Interior', 'Ropa interior para hombres y mujeres'),
('Bolsos', 'Bolsos y mochilas');

-- Inserción en la tabla f_producto (relacionada con f_proveedor y f_categoria)
INSERT INTO e_web_shop.f_producto (nombre_producto, cantidad_stock, precio_producto, descripcion, costo_producto, imagen_referencial, id_proveedor, id_categoria) VALUES
('Camiseta Básica Blanca', 100, 15.99, 'Camiseta de algodón blanca', 8.50, '/images/camiseta_blanca.jpg', 1, 1),
('Jeans Azul Clásico', 50, 39.99, 'Jeans ajustados de mezclilla', 20.00, '/images/jeans_azul.jpg', 2, 2),
('Zapatillas Deportivas', 30, 59.99, 'Zapatillas cómodas para correr', 35.00, '/images/zapatillas.jpg', 3, 3),
('Gorra Negra', 80, 12.99, 'Gorra negra con ajuste', 5.00, '/images/gorra.jpg', 4, 4),
('Sudadera Deportiva', 40, 29.99, 'Sudadera para actividades físicas', 15.00, '/images/sudadera.jpg', 5, 5),
('Chaqueta de Invierno', 20, 89.99, 'Chaqueta acolchada para el frío', 50.00, '/images/chaqueta.jpg', 6, 6),
('Vestido Floral', 25, 49.99, 'Vestido con estampado floral', 22.50, '/images/vestido.jpg', 7, 7),
('Traje de Oficina', 15, 199.99, 'Traje formal para negocios', 100.00, '/images/traje.jpg', 8, 8),
('Calcetines Algodón', 150, 5.99, 'Calcetines suaves y cómodos', 2.50, '/images/calcetines.jpg', 9, 9),
('Bolso de Cuero', 10, 149.99, 'Bolso elegante de cuero', 75.00, '/images/bolso.jpg', 10, 10);

-- Inserción en la tabla f_cliente (relacionada con p_persona)
INSERT INTO e_web_shop.f_cliente (id_persona) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Inserción en la tabla f_venta (relacionada con f_cliente y f_usuario)
INSERT INTO e_web_shop.f_venta (num_comprobante, total, cod_metodo_pago, cod_tipo_venta, id_cliente, id_usuario) VALUES
(10001, 159.99, 'TC', 'ONL', 1, 1),
(10002, 239.50, 'EF', 'TIE', 2, 2),
(10003, 75.99, 'TC', 'ONL', 3, 3),
(10004, 49.99, 'EF', 'TIE', 4, 4),
(10005, 120.00, 'TC', 'ONL', 5, 5),
(10006, 89.99, 'EF', 'TIE', 6, 6),
(10007, 300.00, 'TC', 'ONL', 7, 7),
(10008, 59.99, 'EF', 'TIE', 8, 8),
(10009, 220.50, 'TC', 'ONL', 9, 9),
(10010, 110.00, 'EF', 'TIE', 10, 10);

-- Inserción en la tabla f_detalle_venta (relacionada con f_venta y f_producto)
INSERT INTO e_web_shop.f_detalle_venta (id_venta, id_producto, cantidad, precio_venta) VALUES
(1, 1, 2, 15.99),
(1, 2, 1, 39.99),
(2, 3, 1, 59.99),
(2, 4, 3, 12.99),
(3, 5, 2, 29.99),
(4, 6, 1, 89.99),
(5, 7, 1, 49.99),
(6, 8, 1, 199.99),
(7, 9, 5, 5.99),
(8, 10, 1, 149.99);

-- Inserción en la tabla p_def_dominio
INSERT INTO e_web_shop.p_def_dominio (nombre_dominio, descripcion_dominio) VALUES
('Estado Civil', 'Lista de estados civiles disponibles'),
('Método de Pago', 'Tipos de métodos de pago disponibles'),
('Tipo de Identificación', 'Tipos de documentos de identidad'),
('Estado de Producto', 'Estado del producto en inventario'),
('Tipo de Venta', 'Canales o métodos de venta'),
('Estado de Entrega', 'Estados asociados al proceso de entrega'); -- Nuevo dominio agregado

-- Inserción en la tabla p_dominio_fijo (relacionado con p_def_dominio)
INSERT INTO e_web_shop.p_dominio_fijo (id_def_dominio, nombre_dominio, auxiliar, cod_dominio, descripcion_dominio) VALUES
-- Estado Civil
(1, 'Soltero', NULL, 'SOL', 'Persona no casada'),
(1, 'Casado', NULL, 'CAS', 'Persona casada'),
(1, 'Divorciado', NULL, 'DIV', 'Persona divorciada'),
(1, 'Viudo', NULL, 'VIU', 'Persona que perdió a su cónyuge'),
-- Método de Pago
(2, 'Tarjeta de Crédito', NULL, 'TC', 'Pago con tarjeta de crédito'),
(2, 'Efectivo', NULL, 'EF', 'Pago en efectivo'),
(2, 'Transferencia Bancaria', NULL, 'TB', 'Pago mediante transferencia bancaria'),
(2, 'Paypal', NULL, 'PP', 'Pago a través de Paypal'),
-- Tipo de Identificación
(3, 'Documento Nacional de Identidad', NULL, 'DNI', 'Documento oficial de identidad'),
(3, 'Pasaporte', NULL, 'PAS', 'Documento para viajar internacionalmente'),
(3, 'Licencia de Conducir', NULL, 'LIC', 'Licencia para conducir vehículos'),
(3, 'Carnet de Extranjería', NULL, 'EXT', 'Documento para extranjeros'),
-- Estado de Producto
(4, 'Disponible', NULL, 'DIS', 'Producto disponible en inventario'),
(4, 'Agotado', NULL, 'AGO', 'Producto sin existencias'),
(4, 'En Reposición', NULL, 'REP', 'Producto en proceso de reposición'),
(4, 'Descontinuado', NULL, 'DES', 'Producto fuera del catálogo'),
-- Tipo de Venta
(5, 'Online', NULL, 'ONL', 'Venta realizada a través de la tienda en línea'),
(5, 'En Tienda', NULL, 'TIE', 'Venta realizada físicamente en la tienda'),
(5, 'Por Teléfono', NULL, 'TEL', 'Venta gestionada por llamada telefónica'),
(5, 'Otros', NULL, 'OTR', 'Otros métodos de venta no especificados'),
-- Estado de Entrega (Nuevo dominio)
(6, 'Pendiente', NULL, 'PEN', 'Entrega aún no procesada'),
(6, 'En Proceso', NULL, 'PRO', 'Entrega en proceso de envío'),
(6, 'Completada', NULL, 'COM', 'Entrega finalizada exitosamente'),
(6, 'Cancelada', NULL, 'CAN', 'Entrega cancelada por algún motivo');