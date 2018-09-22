/*-----------------------------ELIMINA ESQUEMA----------------------------*/
drop schema Transportes;

/*-------------------------------CREA ESQUEMA-----------------------------*/
create schema if not exists Transportes;

/*----------------------------SELECCIONA ESQUEMA--------------------------*/
use Transportes;

/*-----------------------------CREACION DE TABLAS-------------------------*/
create table combi(
patente VARCHAR (8) primary key not null,
modelo VARCHAR (45) not null,
marca VARCHAR (45) not null,
km_service INT not null
);

create table salida (
id_salida INT primary key not null,
km_salida INT not null,
fecha DATETIME not null,
pasajes_vendidos INT not null,
km_llegada INT not null,
novedades VARCHAR(280),
salida_id_recorrido INT not null,
salida_combi_patente VARCHAR (8) not null,
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
domicilio_id_localidad INT
);

create table localidad (
id_localidad INT primary key not null,
nombre_localidad VARCHAR(45) not null,
localidad_id_provincia INT not null
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
odometro INT not null,
monto_service INT not null,
mantenimiento_id_taller INT not null,
mantenimiento_combi_patente VARCHAR (8) not null
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
combustible_combi_patente VARCHAR (8) not null,
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

alter table  localidad add foreign key (localidad_id_provincia) references provincia(id_provincia);

alter table  domicilio add foreign key (domicilio_id_localidad) references localidad(id_localidad);

alter table  estacion_de_servicio add foreign key (servicio_id_domicilio) references domicilio (id_domicilio);

alter table  pasajero add foreign key (pasajero_id_tarifa) references tarifa_plana(id_tarifa);
alter table  pasajero add foreign key (pasajero_id_recorrido_ind) references recorrido_individual(id_recorrido_ind);
alter table  pasajero add foreign key (pasajero_id_domicilio) references domicilio(id_domicilio);

alter table  recorrido_individual add foreign key (abordaje_id_parada) references parada(id_parada);

alter table  tarifa_plana add foreign key (preferencial_id_parada) references parada(id_parada);

/**************************¿ARREGLAR ESTO?******************************/
alter table  recorrido add foreign key (recorrido_paradas) references recorrido_parada(recorrido_id_recorrido);
alter table  recorrido_parada add foreign key (parada_id_parada) references parada(id_parada);

/*-------------------------------------DATOS------------------------------------------*/

insert into combi values 
("AFJ579","Kombi T2", "Volkswagen",100),
("OP654UHG","Expert Tepee","Peugeot", 300),
("KJ579GHI","Trafic","Peugeot", 200),
("LK467HYG","Trafic","Peugeot", 200);

insert into provincia values
(1,"Buenos Aires"),
(2,"Santa Fe"),
(3,"Corrientes");

insert into localidad values
(1,"Lanús",1),
(2,"Gerli",1),
(3,"Alberdi",2),
(4,"Colón",3),
(5,"Avellaneda",1),
(6,"Burzaco",1),
(7,"Constitución",1),
(8,"Correo Central",1),
(9,"Agronomía",1);

insert into domicilio values
(1,"Salta",1264,1),
(2,"Cangallo",954,2),
(3,"Monteagudo",125,4),
(4,"Beruti",1254,5),
(5,"La Carra",647,5),
(6,"Guemes",2456,5),
(7,"Manuel Quintana",786,6),
(8,"Oroño",465,3),
(9,"Juan B. Justo", 2300,1),
(10,"Pichincha",2164,2),
(11,"9 de Julio",945,1),
(12,"Ituzaingó",2067,1),
(13,"Helguera",1641,2),
(14,"Padilla",697,2),
(15,"Campichuelo",496,5), 
(16,"29 de Septiembre",3102,1), 
(17,"Almeira",2164,6),
(18,"Las Piedras",648,1);

insert into chofer values
(34668513,20346685138,"Dominguez","Juan",'2012-06-20',32157641,1),
(38164236,20381642361,"Niiya","Germán",'2010-04-30',32414894,2),
(36264876,20362648761,"Medina","Walter",'2016-12-06',24164876,5),
(37498726,20374987267,"Noy","Martin",'2011-04-24',22679546,6);

insert into taller values
(1,"TecnoCar",24234569721,13),
(2,"Enchulame La Combi",24674982631,11);

insert into estacion_de_servicio values
(1,"Shell",32214795641,9),
(2,"YPF",2349678762,14);

insert into mantenimiento values
(1,'2018-06-13',"No importante",133,2000,1,"AFJ579"),
(2,'2018-06-17',"",206,3100,1,"KJ579GHI"),
(3,'2018-06-24',"Sigue sin importar",346,3000,2,"LK467HYG"),
(4,'2018-06-28',"No importante",216,1005,2,"KJ579GHI"),
(5,'2018-07-02',"",3556,2100,1,"KJ579GHI"),
(6,'2018-07-07',"",6547,4620,2,"LK467HYG"),
(7,'2018-07-11',"",3244,1640,2,"KJ579GHI"),
(8,'2018-07-17',"No importa",4672,1260,1,"OP654UHG"),
(9,'2018-07-24',"",4675,1260,1,"AFJ579"),
(10,'2018-07-30',"No va a importar nunca",1235,3210,1,"KJ579GHI");

insert into combustible values
(1,'2018-06-02',999,9999,"OP654UHG",1,34668513),
(2,'2018-06-05',999,9999,"AFJ579",2,38164236),
(3,'2018-06-11',999,9999,"LK467HYG",1,37498726),
(4,'2018-06-17',999,9999,"KJ579GHI",2,36264876),
(5,'2018-06-30',999,9999,"AFJ579",2,38164236),
(6,'2018-07-01',999,9999,"LK467HYG",1,37498726),
(7,'2018-07-09',999,9999,"OP654UHG",1,36264876),
(8,'2018-07-14',999,9999,"KJ579GHI",2,38164236),
(9,'2018-07-20',999,9999,"AFJ579",2,34668513),
(10,'2018-07-27',999,9999,"KJ579GHI",1,37498726);


insert into salida values /*tira error por que parada todavia no esta completamente creada ni en orden*/
(1,999,'2018-06-03',6,999,"Ninguna",1,"KJ579GHI",38164236),
(2,999,'2018-06-08',1,999,"Ninguna",3,"OP654UHG",34668513),
(3,999,'2018-06-14',5,999,"Ninguna",2,"AFJ579",37498726),
(4,999,'2018-06-25',4,999,"Ninguna",1,"LK467HYG",34668513),
(5,999,'2018-06-30',6,999,"Ninguna",1,"OP654UHG",38164236),
(6,999,'2018-07-02',7,999,"Ninguna",2,"KJ579GHI",37498726),
(7,999,'2018-07-12',8,999,"Ninguna",2,"LK467HYG",36264876),
(8,999,'2018-07-15',4,999,"Ninguna",3,"AFJ579",34668513),
(9,999,'2018-07-20',5,999,"Ninguna",3,"KJ579GHI",38164236),
(10,999,'2018-07-24',2,999,"Ninguna",2,"OP654UHG",36264876);

insert into parada values
(1,"Av Yrigoyen","Quintana",1),
(2,"Av Eva Peron","Anatole France",1),
(3,"Bustamante","Padilla",2),
(4,"Larralde","Guemes",5),
(5,"Av Belgrano","Anatole France",5),
(6,"Av Belgrano","Acosta",5),
(7,"Humberto 1ro","Carlos Calvo",7),
(8,"Av San Martin","Condarco",9),
(9,"Leandro N. Alem","Av Corrientes",8),
(10,"Av Brasil","Gral Hornos",7);
/*Seguir agregando paradas y datos*/

/*------------------------------------CONSULTAS-------------------------------------*/