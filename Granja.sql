drop schema gallinero;
create schema if not exists gallinero;

use gallinero;

create table galpon (
id_galpon int primary key
);

create table genetica (
	id_gen int primary key not null,
    nombre_gen varchar(50)
    
    );
    
    create table planteles (
	id_plantel int primary key,	
	nombre_plantel varchar(50),
    edad_gallina int not null,
    fecha_entrada date not null,
    cantidad_gallinas int not null,
    gen_idgen int
	);
    
    
    create table cabaña (
		cuit int primary key,
        razon_social varchar(50)
        );
        
	create table domicilio (
		id_dom int primary key,
        provincia varchar (50),
        localidad varchar (50),
        calle varchar (50),
        numero int
        );
        
	create table clientes (
		cuit_cl int primary key,
        nombre varchar (50)
        );
        
	create table factura (
		id_factura int primary key,
        fecha date 
        );
		
	create table venta (
		codigo int primary key,
        precio_meddoc float,
        cant_huevos int
        );
        
	create table planilla_galpon (
		fecha date primary key,
        cant_huevos int,
        gallunas_muertas int,
        cant_kgrs float,
        tipoalimento varchar (50)
        );
        
		
	alter table genetica add column cabaña_cuit int;
    alter table cabaña add column domicilio_id int;
    alter table clientes add column cliente_dom int;
    alter table factura add column venta_cod int;
    alter table factura add column cliente_cuit int;
    alter table planteles add column genetica_id int;
    alter table galpon add column plantel_id int;
    alter table planilla_galpon add column galpon_id int;
    
	alter table genetica add foreign key (cabaña_cuit) references cabaña(cuit);
    alter table cabaña add foreign key (domicilio_id) references domicilio(id_dom);
    alter table clientes add foreign key (cliente_dom) references domicilio(id_dom);
    alter table factura add foreign key (venta_cod) references venta(codigo);
    alter table factura add foreign key (cliente_cuit) references clientes(cuit_cl);
    alter table planteles add foreign key (genetica_id) references genetica(id_gen);
    alter table galpon add foreign key (plantel_id) references planteles(id_plantel);
    alter table planilla_galpon add foreign key (galpon_id) references galpon(id_galpon);
    