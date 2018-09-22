/*-----------------------------ELIMINA ESQUEMA----------------------------*/
/*drop schema Transportes;*/

/*-------------------------------CREA ESQUEMA-----------------------------*/
create schema if not exists Transportes;

/*----------------------------SELECCIONA ESQUEMA--------------------------*/
use Transportes;

/*-----------------------------CREACION DE TABLAS-------------------------*/
create table combi(
patente INT primary key not null,
modelo VARCHAR (45) not null,
marca VARCHAR (45) not null,
km_service INT not null
);

create table salida (
id_salida INT primary key not null,
km_salida INT not null,
fecha_salida DATETIME not null,
fecha_llegada DATETIME not null,
pasajes_vendidos INT not null,
km_llegada INT not null,
novedades VARCHAR(280),
salida_id_recorrido INT not null,
salida_combi_patente INT not null,
salida_chofer_dni INT not null
);

create table recorrido (
id_recorrido INT primary key not null,
nombre_recorrido VARCHAR(45),
distancia_recorrer INT not null,
recorrido_paradas INT
);

create table parada (
id_parada INT primary key not null,
calle_x VARCHAR(45) not null,
calle_Y VARCHAR(45) not null,
parada_id_localidad INT not null
);

/*Esta parte capaz hay que arreglarla*/
create table recorrido_parada (
recorrido_id_recorrido INT primary key not null,
parada_id_parada INT not null
);
/*******************************************/

create table recorrido_individual (
id_recorrido_ind INT primary key,
monto_individual FLOAT not null,
abordaje_id_parada INT not null
);

create table tarifa_plana (
id_tarifa INT primary key,
monto_mensual FLOAT not null,
fecha_desde DATE not null,
fecha_hasta DATE not null,
preferencial_id_parada INT
);

create table domicilio (
id_domicilio INT not null primary key,
calle VARCHAR(45),
num_calle INT,
domicilio_id_localidad INT,
domicilio_id_provincia INT
);

create table localidad (
id_localidad INT primary key not null,
nombre_localidad VARCHAR(45) not null
);

create table provincia (
id_provincia INT primary key not null,
nombre_provincia VARCHAR(45) not null
);

create table chofer (
dni INT primary key not null,
cuil LONG not null,
apellido VARCHAR (45) not null,
nombre VARCHAR (45) not null,
fecha_ingreso date not null,
n_licencia int not null,
chofer_id_domicilio INT not null
);

create table planilla_chofer (
pchofer_id_salida INT primary key not null,
caja_inicial FLOAT not null,
cantidad_boletos INT not null,
monto_total FLOAT not null,
caja_final FLOAT not null,
gasto_inesperado FLOAT not null 
);

create table pasajero (
dni INT primary key not null ,
apellido VARCHAR(45),
nombre VARCHAR(45),
pasajero_id_tarifa INT,
pasajero_id_recorrido_ind INT,
pasajero_id_domicilio INT not null
);

create table mantenimiento (
id_mantenimiento INT primary key not null,
fecha_mantenimiento DATE not null,
descripcion VARCHAR(45) not null,
odomentro INT not null,
monto_service INT not null,
mantenimiento_id_taller INT not null,
mantenimiento_combi_patente INT not null
);

create table taller (
id_taller INT primary key not null,
razon_social VARCHAR(45),
cuit LONG not null,
taller_id_domicilio INT not null
);

create table combustible (
id_carga INT primary key not null,
fecha_carga DATE not null,
litros_cargados FLOAT not null,
monto_carga FLOAT not null,
combustible_combi_patente INT not null,
combustible_id_estacion INT not null,
combustible_chofer_dni INT not null
);

create table estacion_de_servicio (
id_estacion INT primary key not null,
razon_social VARCHAR(45) not null,
cuit LONG not null,
servicio_id_domicilio INT not null
);
/****************************************/
/*agregar lista de pasajeros por parada*/
/***************************************/

/*----------------------------ASIGNACION DE FOREIGN KEYS------------------------------*/

alter table salida add foreign key (salida_combi_patente) references combi(patente);
alter table salida add foreign key (salida_chofer_dni) references chofer(dni);
alter table salida add foreign key (salida_id_recorrido) references recorrido(id_recorrido);

alter table chofer add foreign key (chofer_id_domicilio) references domicilio(id_domicilio);

alter table  combustible add foreign key (combustible_combi_patente) references combi(patente);
alter table  combustible add foreign key (combustible_id_estacion) references estacion_de_servicio(id_estacion);
alter table  combustible add foreign key (combustible_chofer_dni) references chofer(dni);

alter table  mantenimiento add foreign key (mantenimiento_id_taller) references taller(id_taller);
alter table  mantenimiento add foreign key (mantenimiento_combi_patente) references combi(patente);

alter table  taller add foreign key (taller_id_domicilio) references domicilio(id_domicilio);

alter table  domicilio add foreign key (domicilio_id_localidad) references localidad(id_localidad);
alter table  domicilio add foreign key (domicilio_id_provincia) references provincia(id_provincia);

alter table  estacion_de_servicio add foreign key (servicio_id_domicilio) references domicilio (id_domicilio);

alter table  pasajero add foreign key (pasajero_id_tarifa) references tarifa_plana(id_tarifa);
alter table  pasajero add foreign key (pasajero_id_recorrido_ind) references recorrido_individual(id_recorrido_ind);
alter table  pasajero add foreign key (pasajero_id_domicilio) references domicilio(id_domicilio);

alter table  recorrido_individual add foreign key (abordaje_id_parada) references parada(id_parada);

alter table  tarifa_plana add foreign key (preferencial_id_parada) references parada(id_parada);

/**************************¿ARREGLAR ESTO?******************************/
alter table  recorrido add foreign key (recorrido_paradas) references recorrido_parada(recorrido_id_recorrido);
alter table  recorrido_parada add foreign key (parada_id_parada) references parada(id_parada);

/*------------------------------------CONSULTAS-------------------------------------*/