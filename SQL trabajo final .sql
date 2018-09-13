create schema if not exists FlyBondi;

use FlyBondi;

create table chofer (
cuil int primary key,
apellido varchar (45),
nombre varchar (45),
fecha_ingreso date,
n_licencia int
);

create table combi(
patente int primary key,
modelo varchar (45),
marca varchar (45),
km_service int
);

create table salida (

)

create table recorrido (

);