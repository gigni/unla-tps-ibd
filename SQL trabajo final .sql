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
fecha DATE not null,
pasajes_vendidos INT not null,
km_llegada INT not null,
novedades VARCHAR(280),
salida_id_recorrido INT not null,
salida_combi_patente VARCHAR (8) not null,
salida_chofer_dni INT not null,
salida_id_planilla INT not null
);

create table salida_pasajeros (
salida_id_salida INT not null,
pasajero_dni INT not null
);

create table recorrido (
id_recorrido INT primary key not null,
nombre_recorrido VARCHAR(45),
distancia_recorrer INT not null
);

create table parada (
id_parada INT primary key not null,
calle_x VARCHAR(45) not null,
calle_Y VARCHAR(45) not null,
parada_id_localidad INT not null
);

create table plan (
id_plan INT primary key not null,
abono_id_abono INT,
recorrido_individual_id_recorrido_individual INT
);

create table recorrido_paradas (
id_recorrido_paradas INT primary key not null,
recorrido_id_recorrido INT not null,
parada_id_parada INT not null
);

create table recorrido_individual (
id_recorrido_individual INT primary key,
monto_individual FLOAT not null,
valido BOOLEAN,
abordaje_id_recorrido_paradas INT not null
);

create table abono (
id_abono INT primary key,
monto_total FLOAT not null,
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
apellido VARCHAR(45) not null,
nombre VARCHAR(45) not null,
pasajero_id_domicilio INT not null,
plan_activo_id_plan INT 
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
alter table salida add foreign key (salida_id_planilla) references planilla_chofer(pchofer_id_salida);

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

alter table  pasajero add foreign key (pasajero_id_domicilio) references domicilio(id_domicilio);
alter table  pasajero add foreign key (plan_activo_id_plan) references plan(id_plan);

alter table  plan add foreign key (abono_id_abono) references abono(id_abono);
alter table  plan add foreign key (recorrido_individual_id_recorrido_individual) references recorrido_individual(id_recorrido_individual);

alter table  recorrido_individual add foreign key (abordaje_id_recorrido_paradas) references recorrido_paradas(id_recorrido_paradas);

alter table  abono add foreign key (preferencial_id_parada) references parada(id_parada);

alter table  recorrido_paradas add foreign key (recorrido_id_recorrido) references recorrido(id_recorrido);
alter table  recorrido_paradas add foreign key (parada_id_parada) references parada(id_parada);

alter table salida_pasajeros add foreign key (salida_id_salida) references salida(id_salida);
alter table salida_pasajeros add foreign key (pasajero_dni) references pasajero(dni);



/*------------------------------------DATOS-------------------------------------*/

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
(5,'2018-07-02',"",3556,2100,1,"OP654UHG"),
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

insert into recorrido values
(1,"Lanús-Constitución", 10),
(2,"Lanús-Correo Central",13),
(3,"Lanús-Agronomía",18);

insert into salida values
(1,999,'2018-06-03',6,999,"Ninguna",1,"KJ579GHI",38164236,1),
(2,999,'2018-06-08',1,999,"Ninguna",3,"OP654UHG",34668513,5),
(3,999,'2018-06-14',5,999,"Ninguna",2,"AFJ579",37498726,6),
(4,999,'2018-06-25',4,999,"Ninguna",1,"LK467HYG",34668513,7),
(5,999,'2018-06-30',6,999,"Ninguna",1,"OP654UHG",38164236,10),
(6,999,'2018-07-02',7,999,"Ninguna",2,"KJ579GHI",37498726,9),
(7,999,'2018-07-12',8,999,"Ninguna",2,"LK467HYG",36264876,8),
(8,999,'2018-07-15',4,999,"Ninguna",3,"AFJ579",34668513,4),
(9,999,'2018-07-20',5,999,"Ninguna",3,"KJ579GHI",38164236,2),
(10,999,'2018-07-24',2,999,"Ninguna",2,"OP654UHG",36264876,3);


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
(10,"Av Brasil","Gral Hornos",7),
(11,"Av Moreno","Av Alberdi", 10),
(12,"Av Acoyte","Av Velez",10),
(13,"Caxaraville","Reconquista",2),
(14,"Sitio de Montevideo","Córdoba",1),
(15,"Maipú","Colón",5),
(16,"Iguazú","Gral Roca",5),
(17,"Burela","Salta",2),
(18,"Arredondo","La Carra",2),
(19,"San Martin","Italia",5),
(20,"Cochabamba","Tacuarí",7),
(21,"9 de Julio","Viamonte",8);
/*(22,"Hipolito Yrigoyen","Entre Rios",5),
(23,"Juan de Garay","Bolivar",7),
(24,"Pringles","Damonte",1);*/

insert into recorrido_paradas values
(1,1,1),
(2,1,2),
(3,1,3),
(4,1,4),
(5,1,5),
(6,1,6),
(7,1,7),
(8,1,10),
(9,2,1),
(10,2,8),
(11,2,9),
(12,2,11),
(13,2,12),
(14,2,13),
(15,2,10),
(16,2,21),
(17,3,1),
(18,3,14),
(19,3,15),
(20,3,16),
(21,3,17),
(22,3,18),
(23,3,10),
(24,3,21);

insert into abono values
(1,200,'2018-05-21','2018-06-20',1),
(2,300,'2018-06-21','2018-07-20',13);

insert into recorrido_individual values
(1,15,false,1),
(2,15,false,1),
(3,15,false,10),
(4,16,false,14),
(5,16,true,12),
(6,16,true,11),
(7,16,true,5);

insert into plan values
(1, 1, null), -- ID plan, abono, viaje individual.
(2, 2, null),
(3, null, 1),
(4, null, 2),
(5, null, 3),
(6, null, 4),
(7, null, 5),
(8, null, 6),
(9, null, 7);

insert into pasajero values
(25456825,"Rodriguez","Pablo",3,1),
(34567882,"Barroso","Daniel",4,2),
(23417982,"Vila","Maria",7,3),
(35762199,"Rio","Carmen",8,4),
(40241967,"Duran","Luis",10,5),
(41216748,"Cortes","Ignacio",12,6),
(39413579,"Sánchez","Pilar",15,7),
(38541967,"Daniel","Martin",16,8),
(25216796,"Rubio","María",17,9),
(36449792,"Roncero","Alejandra",18,null);

insert into salida_pasajeros values
(1,23417982),
(1,35762199),
(1,40241967),
(2,41216748),
(3,39413579),
(3,38541967),
(4,25216796),
(4,36449792),
(5,34567882),
(6,25456825),
(6,39413579),
(6,25216796),
(7,35762199),
(7,38541967),
(8,39413579),
(8,36449792),
(9,41216748),
(9,23417982),
(9,38541967),
(10,36449792);

insert into planilla_chofer values
(1,300,20,3000,2500,500),
(2,300,25,3250,3100,150),
(3,300,27,3400,2900,500),
(4,300,17,2800,2700,100),
(5,300,22,3080,3080,0),
(6,300,30,3600,3400,200),
(7,300,19,2920,2700,220),
(8,300,20,3000,2900,100),
(9,300,22,3080,2900,180),
(10,300,25,3250,3000,250);



/*------------------------------------CONSULTAS-------------------------------------*/
select* from pasajero;
-- 2) Emitir listado de recorridos, con sus paradas.
select nombre_recorrido, calle_x, calle_y
from recorrido
inner join recorrido_paradas
on recorrido.id_recorrido=recorrido_paradas.recorrido_id_recorrido
inner join parada
on recorrido_paradas.parada_id_parada=parada.id_parada;

-- 3) Emitir listados de historial de mantenimiento entre fechas, por móvil o taller.

select fecha_mantenimiento, patente
from combi
inner join mantenimiento
on combi.patente=mantenimiento.mantenimiento_combi_patente;

-- 4) Confeccionar las planillas de salida, con las paradas en las que deba detenerse el móvil, y los pasajeros a recoger en cada una de ellas.

-- 5) Consultar la recaudación bruta ya sea por recorrido o por destino (provincia de Buenos Aires o CABA)  
-- 6) Consultar los gastos por recorrido, por chofer o por chofer y entre fechas.
select s.fecha as fecha,sum(pc.gasto_inesperado) as monto, c.nombre as chofer, r.nombre_recorrido as recorrido
from salida s
inner join planilla_chofer pc on pc.pchofer_id_salida=s.salida_id_planilla
inner join chofer c on c.dni=s.salida_chofer_dni
inner join recorrido r on r.id_recorrido=s.salida_id_recorrido
group by chofer,recorrido;

-- 7) Emitir un listado mensual de los gastos realizados por todos los choferes. 
select c.nombre as chofer, sum(pc.gasto_inesperado) as total_gastado
from salida s
inner join chofer c on c.dni=s.salida_chofer_dni
inner join planilla_chofer pc on pc.pchofer_id_salida=s.salida_id_planilla
where fecha between '20180601' AND '20180731'
group by chofer;
-- 8) Emitir listados de consumo medio de combustible por km entre fechas (por recorrido, por móvil o por chofer), ordenado de mayor a menor. 
-- 9) Emitir listados de ganancia bruta por km, por recorrido 
-- 10) Emitir listado de cantidad de pasajeros transportados entre fechas por recorrido.
select r.nombre_recorrido as recorrido, sum(s.pasajes_vendidos) as totalxrecorrido
from salida s
inner join recorrido r on r.id_recorrido=s.salida_id_recorrido
where fecha between '20180601' AND '20180731'
group by recorrido;

-- 11)Emitir listado mensual de recaudación por recorrido o parada final. 
-- 12)Emitir listado de km recorridos entre fecha, para móvil o chofer.

select patente, (km_llegada-km_salida) as km_recorrido , fecha
from combi
inner join salida
on combi.patente=salida.salida_combi_patente;

 select*from recorrido_individual;
-- 13)Emitir listado de gastos de mantenimiento, por móvil.

select patente, sum(monto_service) as total_gasto_por_movil
from combi
inner join mantenimiento
on combi.patente=mantenimiento.mantenimiento_combi_patente
group by patente;

-- 14)Emitir listado de ganancia bruta por recorrido, calculada como el total de pasajes vendidos menos los gastos entre fechas. 
-- 15)Consultar la ganancia bruta de la empresa, calculada como el total de pasajes vendidos, más los abonos, menos el combustible y menos los gastos de mantenimiento. 