/*-----------------------------ELIMINA ESQUEMA----------------------------*/
drop schema if exists Transportes;

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
valor_pasaje FLOAT not null,
km_llegada INT not null,
novedades VARCHAR(280),
salida_id_recorrido INT not null,
salida_combi_patente VARCHAR (8) not null,
salida_chofer_dni INT not null
);

/*create table salida_pasajeros (
salida_id_salida INT not null,
pasajero_dni INT not null
);
*/

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

create table recorrido_paradas (
recorrido_id_recorrido INT not null,
parada_id_parada INT not null,
primary key (recorrido_id_recorrido, parada_id_parada)
);

create table tarifa_plana_recorridos_paradas (
tarifa_plana_id_tarifa_plana INT not null,
recorrido_preferencial INT not null,
parada_preferencial INT not null,
primary key (tarifa_plana_id_tarifa_plana, recorrido_preferencial, parada_preferencial)
);

create table recorrido_individual (
id_recorrido_individual INT primary key,
monto FLOAT not null,
fecha_desde DATE not null,
fecha_hasta DATE not null,
pasajero_dni INT not null,
recorrido_abordaje INT not null,
parada_abordaje INT not null
);

create table tarifa_plana (
id_tarifa_plana INT primary key,
monto FLOAT not null,
fecha_desde DATE not null,
fecha_hasta DATE not null,
pasajero_dni INT not null
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
monto_total FLOAT,
gasto_inesperado FLOAT 
);

create table pasajero (
dni INT primary key not null ,
apellido VARCHAR(45) not null,
nombre VARCHAR(45) not null,
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

alter table  pasajero add foreign key (pasajero_id_domicilio) references domicilio(id_domicilio);

alter table  tarifa_plana add foreign key (pasajero_dni) references pasajero(dni);

alter table  recorrido_paradas add foreign key (recorrido_id_recorrido) references recorrido(id_recorrido);
alter table  recorrido_paradas add foreign key (parada_id_parada) references parada(id_parada);

alter table  recorrido_individual add foreign key (pasajero_dni) references pasajero(dni);
alter table  recorrido_individual add foreign key (recorrido_abordaje) references recorrido_paradas(recorrido_id_recorrido);
alter table  recorrido_individual add foreign key (parada_abordaje) references recorrido_paradas(parada_id_parada);

alter table tarifa_plana_recorridos_paradas add foreign key (tarifa_plana_id_tarifa_plana) references tarifa_plana(id_tarifa_plana);
alter table tarifa_plana_recorridos_paradas add foreign key (recorrido_preferencial) references recorrido_paradas(recorrido_id_recorrido);
alter table tarifa_plana_recorridos_paradas add foreign key (parada_preferencial) references recorrido_paradas(parada_id_parada);

/*alter table salida_pasajeros add foreign key (salida_id_salida) references salida(id_salida);
alter table salida_pasajeros add foreign key (pasajero_dni) references pasajero(dni);
*/

alter table planilla_chofer add foreign key (pchofer_id_salida) references salida(id_salida);


/*------------------------------------DATOS-------------------------------------*/
insert into combi values 
-- Patente, modelo, marca, km_service
("AFJ579","Kombi T2", "Volkswagen",380),
("OP654UHG","Expert Tepee","Peugeot", 170),
("KJ579GHI","Trafic","Peugeot", 420),
("LK467HYG","Trafic","Peugeot", 40);

insert into provincia values
-- id_provincia, nombre_provincia
(1,"Buenos Aires"),
(2,"Santa Fe"),
(3,"Corrientes");

insert into localidad values
-- id_localidad, nombre_localidad, id_provincia
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
-- id_domicilio, calle, num_calle, id_localidad
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
-- dni, cuil, apellido, nombre, fecha_ingreso, n_licencia, id_domicilio
(34668513,20346685138,"Dominguez","Juan",'2012-06-20',32157641,1),
(38164236,20381642361,"Niiya","Germán",'2010-04-30',32414894,2),
(36264876,20362648761,"Medina","Walter",'2016-12-06',24164876,5),
(37498726,20374987267,"Noy","Martin",'2011-04-24',22679546,6);

insert into taller values
-- id_taller, razon_social, cuit, id_domicilio
(1,"TecnoCar",24234569721,13),
(2,"Enchulame La Combi",24674982631,11);

insert into estacion_de_servicio values
-- id_estacion, razon_social, cuit, id_domicilio
(1,"Shell",32214795641,9),
(2,"YPF",2349678762,14);

insert into mantenimiento values
-- id_mantenimiento, fecha_mantenimiento, descripcion, odometro, monto_service, id_taller, patente
(1,'2018-06-13',"No importante",270,2000,1,"AFJ579"),
(2,'2018-06-17',"",353,3100,1,"KJ579GHI"),
(3,'2018-06-24',"Sigue sin importar",4,3000,2,"LK467HYG"),
(4,'2018-06-28',"No importante",421,1005,2,"KJ579GHI"),
(5,'2018-07-02',"",46,2100,1,"OP654UHG"),
(6,'2018-07-07',"",43,4620,2,"LK467HYG"),
(7,'2018-07-11',"",417,1640,2,"KJ579GHI"),
(8,'2018-07-17',"No importa",58,1260,1,"OP654UHG"),
(9,'2018-07-24',"",392,1260,1,"AFJ579"),
(10,'2018-07-30',"No va a importar nunca",419,3210,1,"KJ579GHI");

insert into combustible values
-- id_carga, fecha_carga, litros_cargados, monto_carga, patente, id_estacion, chofer_dni
(1,'2018-06-02',32,1280,"OP654UHG",1,34668513),
(2,'2018-06-05',26,1040,"AFJ579",2,38164236),
(3,'2018-06-11',41,1640,"LK467HYG",1,37498726),
(4,'2018-06-17',42,1680,"KJ579GHI",2,36264876),
(5,'2018-06-30',20,820,"AFJ579",2,38164236),
(6,'2018-07-01',30,1230,"LK467HYG",1,37498726),
(7,'2018-07-09',45,1845,"OP654UHG",1,36264876),
(8,'2018-07-14',35,1435,"KJ579GHI",2,38164236),
(9,'2018-07-20',37,1517,"AFJ579",2,34668513),
(10,'2018-07-27',28,1148,"KJ579GHI",1,37498726);

insert into recorrido values
-- id_recorrido, nombre_recorrido, distancia_recorrer
(1,"Lanús-Constitución", 10),
(2,"Lanús-Correo Central",13),
(3,"Lanús-Agronomía",18);

insert into salida values
-- id_salida, km_salida, fecha, pasajes_vendidos,valor pasaje, km_llegada, novedades, id_recorrido, patente, chofer_dni
(1,463,'2018-06-03',6,45,472,"Ninguna",1,"KJ579GHI",38164236),
(2,134,'2018-06-08',1,45,152,"Ninguna",3,"OP654UHG",34668513),
(3,383,'2018-06-14',5,45,397,"Ninguna",2,"AFJ579",37498726),
(4,43,'2018-06-25',4,45,53,"Ninguna",1,"LK467HYG",34668513),
(5,161,'2018-06-30',6,45,170,"Ninguna",1,"OP654UHG",38164236),
(6,479,'2018-07-02',7,45,482,"Ninguna",2,"KJ579GHI",37498726),
(7,53,'2018-07-12',8,45,66,"Ninguna",2,"LK467HYG",36264876),
(8,389,'2018-07-15',4,45,407,"Ninguna",3,"AFJ579",34668513),
(9,482,'2018-07-20',5,45,500,"Ninguna",3,"KJ579GHI",38164236),
(10,170,'2018-07-24',2,45,183,"Ninguna",2,"OP654UHG",36264876);

insert into parada values
-- id_parada, calle_x, calle_y, id_localidad
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
-- id_recorrido, id_parada
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,10),
(2,1),
(2,8),
(2,9),
(2,11),
(2,12),
(2,13),
(2,10),
(2,21),
(3,1),
(3,14),
(3,15),
(3,16),
(3,17),
(3,18),
(3,10),
(3,21);

insert into pasajero values
-- dni, apellido, nombre, id_domicilio
(25456825,"Rodriguez","Pablo",3),
(34567882,"Barroso","Daniel",4),
(23417982,"Vila","Maria",7),
(35762199,"Rio","Carmen",8),
(40241967,"Duran","Luis",10),
(41216748,"Cortes","Ignacio",12),
(39413579,"Sánchez","Pilar",15),
(38541967,"Daniel","Martin",16),
(25216796,"Rubio","María",17),
(36449792,"Roncero","Alejandra",18);

insert into tarifa_plana values
-- id_tarifa_plana, monto, fecha_desde, fecha_hasta, pasajero_dni
(1,300,'2018-05-21','2018-06-20',38541967),
(2,300,'2018-06-21','2018-07-20',25216796);

insert into recorrido_individual values
-- id_recorrido_individual, monto, fecha_desde, fecha_hasta, pasajero_dni, recorrido_abordaje, parada_abordaje
(1,200,'2018-04-10','2018-05-10',25456825,2,9),
(2,200,'2018-05-15','2018-06-15',34567882,3,14),
(3,200,'2018-06-15','2018-07-15',23417982,1,1),
(4,200,'2018-05-20','2018-06-20',35762199,2,1),
(5,200,'2018-07-23','2018-08-23',40241967,3,1),
(6,200,'2018-08-14','2018-09-14',41216748,2,12),
(7,200,'2018-05-1','2018-06-1',39413579,1,3);

insert into planilla_chofer values
-- id_salida, caja_inicial, cantidad_boletos, monto_total, gasto_inesperado
(1,2871,6,4071,0),
(2,2774,1,3074,0),
(3,2905,5,3905,200),
(4,2837,4,3737,0),
(5,3257,5,4257,0),
(6,2713,5,3713,100),
(7,2819,7,4219,500),
(8,3461,4,4261,0),
(9,3013,5,4013,0),
(10,3367,2,3767,80);

insert into tarifa_plana_recorridos_paradas values
-- id_tarifa_plana, recorrido_preferencial, parada_preferencial
(1,1,4),
(1,2,8),
(1,3,16),
(2,1,1),
(2,2,1),
(2,3,14);


/*insert into salida_pasajeros values
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
*/


/*------------------------------------CONSULTAS-------------------------------------*/
-- 1) Emitir listados de clientes, con su correspondiente abono si lo tiene.

select apellido, nombre, id_recorrido_individual, id_tarifa_plana
from pasajero
left join recorrido_individual
on pasajero.dni=recorrido_individual.pasajero_dni
left join tarifa_plana
on pasajero.dni=tarifa_plana.pasajero_dni;

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

select salida.id_salida, parada.calle_x, parada.calle_y, pasajero.nombre
from salida 
inner join recorrido
on salida.salida_id_recorrido = recorrido.id_recorrido
inner join recorrido_paradas
on recorrido.id_recorrido=recorrido_paradas.recorrido_id_recorrido
inner join recorrido_individual
on recorrido_paradas.recorrido_id_recorrido=recorrido_individual.recorrido_abordaje
inner join pasajero
on recorrido_individual.pasajero_dni=pasajero.dni
inner join parada 
on recorrido_paradas.parada_id_parada=parada.id_parada
order by salida.id_salida;



-- 5) Consultar la recaudación bruta ya sea por recorrido o por destino (provincia de Buenos Aires o CABA)  
select	 month(s.fecha) mes, sum(pc.gasto_inesperado) from planilla_chofer pc
	inner join salida s on s.id_salida=pc.pchofer_id_salida
    group by mes;
    

-- 6) Consultar los gastos por recorrido, por chofer o por chofer y entre fechas.
select (pc.gasto_inesperado+sum(co.monto_carga)) as gasto_total, r.nombre_recorrido as recorrido
	from  salida s
    inner join combustible co on co.combustible_combi_patente=s.salida_combi_patente
    inner join planilla_chofer pc on pc.pchofer_id_salida=s.id_salida
    inner join recorrido r on r.id_recorrido=s.salida_id_recorrido
    inner join chofer c on c.dni=s.salida_chofer_dni
    group by recorrido;
    
-- 7) Emitir un listado mensual de los gastos realizados por todos los choferes.
 
select month(co.fecha_carga)  mes, sum(co.monto_carga) gasto_mensual
	from  salida s
    inner join combustible co on co.combustible_combi_patente=s.salida_combi_patente
    inner join planilla_chofer pc on pc.pchofer_id_salida=s.id_salida
    inner join recorrido r on r.id_recorrido=s.salida_id_recorrido
    inner join chofer c on c.dni=s.salida_chofer_dni
    where month(co.fecha_carga)=month(s.fecha)
	group by mes;
    
-- 8) Emitir listados de consumo medio de combustible por km entre fechas (por recorrido, por móvil o por chofer), ordenado de mayor a menor. 
select s.fecha,c.dni,c.nombre,c.apellido, avg(co.litros_cargados) as consumoMedio from combustible co
	inner join chofer c on c.dni=co.combustible_chofer_dni
    inner join salida s on s.salida_chofer_dni=co.combustible_chofer_dni
	where
     s.fecha between 20180601 and 20180731
    group by c.nombre
    order by consumoMedio desc;
-- 9) Emitir listados de ganancia bruta por km, por recorrido 



-- 10) Emitir listado de cantidad de pasajeros transportados entre fechas por recorrido. 
select r.nombre_recorrido as recorrido , count(p.dni) pasajeros from salida s
	inner join recorrido r on r.id_recorrido=s.salida_id_recorrido
    inner join recorrido_paradas rp on rp.recorrido_id_recorrido=r.id_recorrido
    inner join recorrido_individual ri on ri.recorrido_abordaje=rp.recorrido_id_recorrido
    inner join pasajero p on p.dni=ri.pasajero_dni
    where
    s.fecha between 20180601 and 20180731
    group by recorrido;
    
    
-- 11)Emitir listado mensual de recaudación por recorrido o parada final. 

select s.fecha as mes, SUM(ri.monto)as recaudacion
	from salida s
	inner join recorrido r on r.id_recorrido=s.salida_id_recorrido
    inner join recorrido_paradas rp on rp.recorrido_id_recorrido=r.id_recorrido
    inner join recorrido_individual ri on ri.recorrido_abordaje=rp.recorrido_id_recorrido;

-- 12)Emitir listado de km recorridos entre fecha, para móvil o chofer.

select patente, (km_llegada-km_salida) as km_recorrido , fecha
from salida s
inner join combi c
on c.patente=s.salida_combi_patente;

-- 13)Emitir listado de gastos de mantenimiento, por móvil.

select patente, sum(monto_service) as total_gasto_por_movil
from combi
inner join mantenimiento
on combi.patente=mantenimiento.mantenimiento_combi_patente
group by patente;


-- 14)Emitir listado de ganancia bruta por recorrido, calculada como el total de pasajes vendidos menos los gastos entre fechas.
select r.nombre_recorrido as recorrido, s.pasajes_vendidos,((s.pasajes_vendidos*s.valor_pasaje)+(count(tp.id_tarifa_plana)*monto)+(count(ri.id_recorrido_individual)*monto))-(pc.gasto_inesperado-co.monto_carga) as ganancia
from salida s
inner join recorrido r on r.id_recorrido=s.salida_id_recorrido
inner join recorrido_paradas rp on rp.recorrido_id_recorrido= r.id_recorrido
inner join tarifa_plana_recorrido_paradas z on z;

-- 15)Consultar la ganancia bruta de la empresa, calculada como el total de pasajes vendidos, más los abonos, menos el combustible y menos los gastos de mantenimiento. 
