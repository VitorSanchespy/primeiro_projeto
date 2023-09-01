-- criar banco de dados para o cenário E-commerce
create schema if not exists ecommerce ;
use ecommerce;
drop database ecommerce;
-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
		Fname varchar(10),
		Minit char(3),
		Lname varchar(20),
		CPF char(11) not null,
		Address varchar(30),
        date_nasc date not null,
		constraint unique_cpf_client unique (CPF)
);

-- criar tabela pedido
create table pedido(
		idpedido int auto_increment primary key,
        idPClient int,
        Pstatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
        Pdescription varchar(255),
        pagamento bool default false,
        constraint fk_orders_client foreign key(idPClient) references clients(idClient)
);
-- criar tabela produto
create table product(
		idProduct int auto_increment primary key,
        idPClient int auto_increment ,
        idpedido int auto_increment,
        Pname varchar(15),
        classification_kids bool default false,
        category enum('Eletrôico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
        Pvalor float not null, 
        size varchar(10),
        constraint fk_client foreign key(idPClient) references clients(idClient),
        constraint fk_pedido foreign key(idpedido) references pedido(idpedido)
);


show tables;
desc pedido;
-- criar tabela estoque
create table estoque(
		idestoque int auto_increment primary key,
        id_Product_etoque int auto_increment,
        Location varchar(45),
        quantity int default 0,
        constraint id_Product_etoque foreign key(id_Product_etoque) references product(idProduct)
);
-- criar tabela fornecedor
create table fornecedor(
		idfornecedor int auto_increment primary key,
        id_fornecedor_produto int auto_increment,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ),
        constraint id_fornecedor_produto foreign key(id_fornecedor_produto) references product(idProduct)
);

-- terceiro vendendor
create table terceiro_vedendedor(
		idterceiro_vedendedor  int auto_increment primary key,
        id_terceiro_produto int auto_increment,
		razao_social varchar(45) not null,
        Tlocal varchar(45) not null,
		nome_fantasia varchar(45),
        constraint id_terceiro_produto foreign key(id_terceiro_produto) references product(idProduct)
);

show tables;
desc clients;
insert into clients (Fname, Minit, Lname, CPF, Address, date_nasc)
		values('Maria', 'M', 'Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores', '05-29-2000'),
			  ('Matheus', 'O', 'Pimentel', 987654321, 'rua alameda 289, Centro - Cidade das flores','02-29-2000') ,
              ('Ricardo', 'F', 'Silva', 45678913, 'avenida alameda vinha 1009, Centro - Cidade das flores','05-22-1980'),
              ('Julia', 'S', 'França', 789123456, 'rua lareijras 861, Centro - Cidade das flores','10-29-2000'),
              ('Roberta', 'G', 'Assis', 98745631, 'avenida koller 19, Centro - Cidade das flores','05-29-2004'),
              ('Isabela', 'M', 'Cruz', 654789123, 'rua alameda das flores 28, Centro - Cidade das flores','09-22-2007');
desc product;
select * from clients;
insert into product (Pname, classification_kids, category,  size) values
					('Fone de ouvido', false, 'Eletrônico',  null),
                    ('Barbie Elsa', true, 'Brinquedos',  null),
                    ('Body Carters', true, 'Vestimenta', null),
                    ('Microfone', false, 'Eletrônico',  null),
                    ('Sofá retrátil', false, 'Móveis',  '3x57x80'),
                    ('Farinha de arroz', false, 'Alimentos',  null),
                    ('Fire Stick Amazon', false, 'Eletrônico',  null);
                    
select * from clients;
select * from product;

delete from orders where idClient in (1,2,3,4);

desc fornecedor;
insert into fornecedor (SocialName, CNPJ, contact) values
			('Almeida e filhos', 123456789123456, '21985474'),
            ('Eletrônicos Silva', 85451964914357, '21985484'),
            ('Eletrônicos Valma', 93456789393469, '21975745');
select* from fornecedor;

desc estoque;
insert into estoque (Location, quantity) values
			('Rio de Janeiro', 1000),
            ('Rio de Janeiro', 500),
            ('São Paulo', 10),
            ('São Paulo', 100),
            ('São Paulo', 10),
            ('Brasília', 60);
select *from estoque;

desc terceiro_vedendedor;
insert into terceiro_vedendedor (razao_social, nome_fantasia, Tlocal) values
			('Tech eletronics', null,  'Rio de Janeiro'),
            ('Botique Durgas', null, 'Rio de Janeiro'),
            ('Kids world', null, 'São Paulo');

select * from terceiro_vedendedor;


select count(*) from clients;