create schema if not exists Aerolinea;

drop schema aerolinea;

use Aerolinea;


create table vuelo(
	codigo varchar(6) primary key,
	matricula varchar(20) not null,
    cuil	varchar(45) not null,
    iata_origen varchar(3) not null,
    iata_destino varchar(3) not null,
    fecha_partida datetime not null,
    fecha_arribo datetime not null,
    distancia int not null
);

create table avion(
	matricula varchar(20) primary key,
    marca int not null,
    modelo varchar(45) not null,
    fecha date,
    foreign key (marca) references marca(codigo)
);


create table marca(
	codigo int primary key,
    nombre varchar(45) not null,
    pais varchar(45) not null
    
);


alter table vuelo add foreign key (matricula) references avion(matricula);

create table piloto(
	cuil varchar(45) primary key,
    apellido varchar(45) not null,
    nombre varchar(45) not null,
    dni int not null,
    fecha_ingreso date not null,
    codigo_domicilio int not null
);

create table domicilio(
	idDomicilio int primary key,
    calle varchar(45) not null,
    numero int not null,
    localidad varchar(45) not null,
    provincia varchar(45) not null
);

alter table piloto add foreign key (codigo_domicilio) references domicilio(idDomicilio);
alter table vuelo add foreign key (cuil) references piloto(cuil);

create table pasajero(
	dni int primary key,
    apellido varchar(45) not null,
    nombre varchar(45) not null,
    viajero_frecuente binary not null,
    idvuelo varchar(6) not null,
    codigo_domicilio int not null
);

create table domicilio_pasajero(
	idDomicilio int primary key,
    calle varchar(45) not null,
    numero int not null,
    localidad varchar(45) not null,
    provincia varchar(45) not null
);

alter table pasajero drop primary key;
alter table pasajero add primary key (dni,idvuelo);
alter table pasajero add foreign key (codigo_domicilio) references domicilio_pasajero(idDomicilio);
alter table pasajero add foreign key (idvuelo) references vuelo(codigo);


create table aeropuerto(
	IATA varchar(3) primary key,
    nombre varchar(45) not null,
    ciudad varchar(45) not null
    );

alter table vuelo add foreign key (iata_origen) references aeropuerto(IATA);
alter table vuelo add foreign key (iata_destino) references aeropuerto(IATA);

insert into marca values (1,"Cessna","Estados Unidos");
insert into marca values (2,"Beechcraft","Estados Unidos");
insert into marca values (3,"Fokker","Alemania");

insert into avion values ("LV-ABC",1,"Citation","2010-12-12");
insert into avion values ("LV-CDE",2,"Baron","2011-10-01");
insert into avion values ("LV-FGH",3,"F-27","2008-05-04");
insert into avion values ("LV-IJK",1,"Citation","2014-06-07");
insert into avion values ("LV-LMN",2,"King Air","2012-07-08");

insert into domicilio values (1,"San Martín",2235,"CABA","CABA");
insert into domicilio values (2,"Azara",1254,"Lomas de Zamora","Buenos Aires");
insert into domicilio values (3,"Sarmiento",500,"Lanus","Buenos Aires");
insert into domicilio values (4,"Rivadavia",2351,"CABA","CABA");
insert into domicilio values (5,"Martinto",663,"Lanus","Buenos Aires");
insert into domicilio values (6,"Bolaños",1256,"Lanus","Buenos Aires");
insert into domicilio values (7,"Loria",333,"Lomas de Zamora","Buenos Aires");

insert into piloto values ("20-12345678-8","Juarez","Federico Bernardo",12345678,	"1994-10-1",1);
insert into piloto values ("20-34567890-1","Lacoste","Franco",34567890,"2003-7-1",2);
insert into piloto values ("27-45678901-1","Laime","Mariana",45678901,"2001-4-1",3);
insert into piloto values ("20-56789123-3","Lopez","Germán Ignacio",56789123,"2013-5-1",4);
insert into piloto values ("20-67891234-4","Martinez","Giuliano",67891234,"2010-7-1",5);
insert into piloto values ("27-78912345-5","Medina","Adriana",78912345,"2015-8-1",6);
insert into piloto values ("20-90123456-6","Melgarejo","Jair Alberto",90123456,"2011-3-1",7);

insert into aeropuerto values ("BUE","Aeroparque Jorge Newbery","CABA");
insert into aeropuerto values ("MDQ","Astor Piazolla","Mar Del Plata");
insert into aeropuerto values ("BRC","Teniente Luis Candelaria","San Carlos de Bariloche");

insert into vuelo values ("TT1234","LV-ABC","20-12345678-8","BUE","BRC","2018-5-1 20:00:00","2018-5-1 23:45:00",1);
insert into vuelo values ("TT3456","LV-CDE","27-78912345-5","BUE","MDQ","2018-5-2 10:00:00","2018-5-2 12:00:00",2);	
insert into vuelo values ("TT1235","LV-ABC","20-12345678-8","BRC","BUE","2018-5-2 07:00:00","2018-5-2 10:50:00",1);
insert into vuelo values ("TT1256","LV-FGH","27-45678901-1","BUE","MDQ","2018-5-2 8:00:00","2018-5-2 10:05:00",3);
insert into vuelo values ("TT5632","LV-IJK","20-56789123-3","MDQ","BUE","2018-5-3 7:00:00","2018-5-3 9:15:00",4);
insert into vuelo values ("TT3333","LV-LMN","20-12345678-8","BUE","BRC","2018-5-3 7:00:00","2018-5-3 10:50:00",5);
insert into vuelo values ("TT1257","LV-FGH","27-45678901-1","BUE","MDQ","2018-5-4 8:00:00","2018-5-4 10:05:00",3);
insert into vuelo values ("TT3457","LV-CDE","27-78912345-5","MDQ","BUE","2018-5-4 10:00:00","2018-5-4 12:00:00",2);
insert into vuelo values ("TT5633","LV-IJK","20-56789123-3","BUE","MDQ","2018-5-5 7:00:00","2018-5-5 9:15:00",4);

insert into domicilio_pasajero values (1,"Ituzaingo",123,"Lanus","Buenos Aires");
insert into domicilio_pasajero values (2,"Roca",4561,"CABA","CABA");
insert into domicilio_pasajero values (3,"Campichuelo",6532,"Avellaneda","Buenos Aires");
insert into domicilio_pasajero values (4,"Meeks",562,"Lomas de Zamora","Buenos Aires");
insert into domicilio_pasajero values (5,"Mamberti",2356,"Lanus","Buenos Aires");
insert into domicilio_pasajero values (6,"Amenabar",2345,"CABA","CABA");
insert into domicilio_pasajero values (7,"Capello",1589,"Lomas de Zamora","Buenos Aires");
insert into domicilio_pasajero values (8,"Amenabar",356,"CABA","CABA");
insert into domicilio_pasajero values (9,"Meeks",1296,"Lomas de Zamora","Buenos Aires");
insert into domicilio_pasajero values (10,"San Martìn",3652,"Avellaneda","Buenos Aires");


insert into pasajero values (44444444,"Chimbo","Brisa","s","TT1234",4);
insert into pasajero values (55555555,"Chudoba","Camila","n","TT1234",5);
insert into pasajero values (66666666,"Cires","Carlos","s","TT1234",6);
insert into pasajero values (77777777,"Cusato","Carlos Sebastián","n","TT3456",7);
insert into pasajero values (88888888,"Dominguez","Christian","s","TT3456",8);
insert into pasajero values (99999999,"Escullini","Cristian","s","TT3456",9);
insert into pasajero values (44444444,"Chimbo","Brisa","s","TT1235",4);
insert into pasajero values (55555555,"Chudoba","Camila","n","TT1235",5);
insert into pasajero values (11111111,"Barragan","Alejo","s","TT1256",1);
insert into pasajero values (22222222,"Casas","Andrès Alfredo","s","TT1256",2);
insert into pasajero values (33333333,"Chaves","Barbara","n","TT1256",3);
insert into pasajero values (77777777,"Cusato","Carlos Sebastián","n","TT5632",7);
insert into pasajero values (88888888,"Dominguez","Christian","s","TT5632",8);
insert into pasajero values (99999999,"Escullini","Cristian","s","TT5632",9);
insert into pasajero values (77777777,"Cusato","Carlos Sebastián","n","TT3333",7);
insert into pasajero values (88888888,"Dominguez","Christian","s","TT3333",8);
insert into pasajero values (99999999,"Escullini","Cristian","s","TT3333",9);
insert into pasajero values (22222222,"Casas","Andrès Alfredo","s","TT1257",2);
insert into pasajero values (77777777,"Cusato","Carlos Sebastián","n","TT3457",7);
insert into pasajero values (88888888,"Dominguez","Christian","s","TT3457",8);
insert into pasajero values (99999999,"Escullini","Cristian","s","TT3457",9);
insert into pasajero values (77777777,"Cusato","Carlos Sebastián","n","TT5633",7);
insert into pasajero values (88888888,"Dominguez","Christian","s","TT5633",8);
insert into pasajero values (99999999,"Escullini","Cristian","s","TT5633",9);


select apellido,nombre,dni from pasajero;
select p.apellido,p.nombre,p.dni,d.numero,d.calle,d.localidad,d.provincia from pasajero p inner join domicilio_pasajero d on p.codigo_domicilio=d.idDomicilio;
select p.apellido,p.nombre,p.dni,d.numero,d.calle,d.localidad,d.provincia from pasajero p inner join domicilio_pasajero d on p.codigo_domicilio=d.idDomicilio where p.viajero_frecuente="s" group by p.nombre,p.apellido;
select m.nombre as marca,a.modelo,a.matricula,a.fecha as fecha_entrada_en_servicio,m.pais from avion a inner join marca m on a.marca=m.codigo;
select m.nombre as marca,a.modelo,a.matricula,a.fecha as fecha_entrada_en_servicio,m.pais from avion a inner join marca m on a.marca=m.codigo where m.pais="Alemania";
select v.codigo,m.nombre as marca,a.modelo,v.matricula,v.iata_origen,v.iata_destino,v.fecha_partida,v.fecha_arribo,v.cuil from vuelo v 
		inner join avion a on v.matricula=a.matricula 
		inner join marca m on a.marca=m.codigo;
select v.codigo,m.nombre as marca,a.modelo,v.matricula,v.iata_origen,v.iata_destino,v.fecha_partida,v.fecha_arribo,v.cuil from vuelo v 
		inner join avion a on v.matricula=a.matricula 
		inner join marca m on a.marca=m.codigo
        where v.iata_origen="BUE"
        order by v.fecha_partida;
select v.codigo,v.iata_origen,v.iata_destino,v.fecha_partida,v.fecha_arribo from vuelo v where v.iata_origen="BUE" and v.iata_destino="MDQ";
select v.codigo,p.apellido,p.nombre,p.dni from vuelo v left join pasajero p on v.pasaje1=p.dni or v.pasaje2=p.dni or v.pasaje3=p.dni;
select count(*) from vuelo where iata_origen="BUE" and iata_destino="BRC";
select count(*) from vuelo where iata_origen="MDQ";
select iata_origen,count(*) as cantidad_vuelos from vuelo group by iata_origen;
select d.localidad, count(*) as cantidad_pasajeros from domicilio_pasajero d inner join pasajero p on d.idDomicilio=p.codigo_domicilio group by d.localidad;
select v.fecha_partida as fecha,count(*) as cantidad_pasajeros from vuelo v inner join pasajero p on v.codigo=p.idvuelo group by date(v.fecha_partida); 
select d.localidad as fecha,count(*) as cantidad_pasajeros from vuelo v 
		inner join pasajero p on v.codigo=p.idvuelo 
        inner join domicilio_pasajero d on p.codigo_domicilio=d.idDomicilio
		group by d.localidad; 
select a.matricula, sec_to_time(sum(time_to_sec(time(v.fecha_arribo))-time_to_sec(time(v.fecha_partida)))) from avion a inner join vuelo v on a.matricula=v.matricula group by v.matricula;
select m.nombre as marca, sec_to_time(sum(time_to_sec(time(v.fecha_arribo))-time_to_sec(time(v.fecha_partida)))) from avion a inner join vuelo v on a.matricula=v.matricula inner join marca m on a.marca=m.codigo group by m.nombre;
select p.dni,p.nombre,p.apellido,d.calle,sec_to_time(sum(time_to_sec(time(v.fecha_arribo))-time_to_sec(time(v.fecha_partida)))) 
		from pasajero p left join domicilio_pasajero d on p.codigo_domicilio=d.idDomicilio
        inner join vuelo v on v.codigo=p.idvuelo
		where d.calle="Meeks" and d.localidad="Lomas de Zamora" and d.provincia="Buenos Aires" and d.numero>0 and d.numero<1000 
        group by p.dni; 

create table pasajero(
	dni int primary key,
    apellido varchar(45) not null,
    nombre varchar(45) not null,
    viajero_frecuente binary not null,
    idvuelo varchar(6) not null,
    codigo_domicilio int not null
);

create table domicilio_pasajero(
	idDomicilio int primary key,
    calle varchar(45) not null,
    numero int not null,
    localidad varchar(45) not null,
    provincia varchar(45) not null
);


create table vuelo(
	codigo varchar(6) primary key,
	matricula varchar(20) not null,
    cuil	varchar(45) not null,
    iata_origen varchar(3) not null,
    iata_destino varchar(3) not null,
    fecha_partida datetime not null,
    fecha_arribo datetime not null,
    distancia int not null
);


