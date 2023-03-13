Create Database errorEagle;
use errorEagle;



create table Endereco (
idEndereco INT PRIMARY KEY auto_increment,
CEP char (8),
bairro varchar(45),
rua varchar(45),
numero char(15),
estado varchar(45),
cidade varchar(45)
);

create table Empresa(
idEmpresa INT primary key auto_increment,
nomeResponsavel varchar(45),
RazaoSocial varchar(45),
cnpj char(13) not null,
telefone1 char(11)not null,
telefone2 char (11)not null,
email varchar(45),
tokem varchar(45),
fkEndereco int,foreign key(fkEndereco)references endereco(idEndereco)
);

create table Funcionario (
idFuncionario int primary key auto_increment,
email varchar(45),
senha varchar(45),
fkEmpresa int , foreign key(fkEmpresa) references empresa(idEmpresa)
);

create table Totem(
idTotem int primary key auto_increment,
statusTotem varchar(45),
fkEmpresa int ,foreign key(fkEmpresa) references empresa(idEmpresa)
);

create table Medidas (
idMedidas int primary key auto_increment,
disco varchar(45),
memoria varchar(45),
cpu varchar(45),
internet varchar(45),
horarioLeitura datetime,
fkTotem int,foreign key(fkTotem) references totem(idTotem) 
);

create table FaleConosco(
idFaleConosco int primary key,
Nome varchar(45),
sobreNome varchar(45),
telefoneContato char(11),
email varchar(45),
mensagemUsuario varchar(45)
);

select *from Endereco;
select *from Empresa;
select *from Funcionario;
select *from Totem;
select *from Medidas;
select *from FaleConosco;




