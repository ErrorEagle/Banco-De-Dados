-- Excluir Banco de Dados ErrorEagle
DROP DATABASE IF EXISTS ErrorEagle;

-- Criar Banco de Dados ErrorEagle
CREATE DATABASE IF NOT EXISTS ErrorEagle;
USE ErrorEagle;

-- Criação da tabela Endereco.
DROP TABLE IF EXISTS Endereco;

CREATE TABLE IF NOT EXISTS Endereco(
  idEndereco INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  cep CHAR(8) NOT NULL,
  bairro VARCHAR(60) NOT NULL,
  rua VARCHAR(60) NOT NULL,
  numero INT NOT NULL,
  estado CHAR(2) NOT NULL,
  cidade VARCHAR(80) NOT NULL
  );

-- Criação da tabela Empresa.
DROP TABLE IF EXISTS Empresa;

CREATE TABLE IF NOT EXISTS Empresa(
  idEmpresa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nomeResponsavel VARCHAR(60) NOT NULL,
  razaoSocial VARCHAR(80) NOT NULL,
  CNPJ CHAR(14) NOT NULL UNIQUE,
  telefone1 CHAR(11) NOT NULL,
  telefone2 CHAR(11),
  email VARCHAR(80) NOT NULL UNIQUE, CHECK(email LIKE '%@%.%'),
  fkEndereco INT NOT NULL,
  CONSTRAINT ctFk_Endereco FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
  );

-- Criação da tabela Funcionário.
DROP TABLE IF EXISTS Funcionario;

CREATE TABLE IF NOT EXISTS Funcionario (
  idFuncionario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(80) NOT NULL UNIQUE, CHECK(email LIKE '%@%.%'),
  senha VARCHAR(60) NOT NULL,
  telefone VARCHAR(11) NOT NULL,
  fkEmpresa INT NOT NULL,
  fkSupervisor INT,
  CONSTRAINT ctFk_EmpresaVinculado FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
  CONSTRAINT ctFk_Supervisor FOREIGN KEY (fkSupervisor) REFERENCES Funcionario (idFuncionario)
  );
  
DROP TABLE IF EXISTS Administrador;

CREATE TABLE IF NOT EXISTS Administrador(
idAdministrador INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(60) NOT NULL
);

-- Criação da tabela do Fale Conosco
 DROP TABLE IF EXISTS Fale_conosco;

 CREATE TABLE IF NOT EXISTS Fale_conosco(
   idFaleConosco INT PRIMARY KEY NOT NULL,
   Nome VARCHAR(45) NOT NULL,
   Sobrenome VARCHAR(45) NOT NULL,
   TelefoneContato CHAR(11) NOT NULL,
   email VARCHAR(80) NOT NULL UNIQUE, CHECK(email LIKE '%@%.%'),
   MensagemUsuario VARCHAR(600) NOT NULL
   );

-- Criação da tabela Totem
 DROP TABLE IF EXISTS Totem ;

 CREATE TABLE IF NOT EXISTS Totem(
   idTotem INT PRIMARY KEY NOT NULL,
   disponibilidade VARCHAR(45) NOT NULL,
   SisOperacional VARCHAR(45) NOT NULL,
   arquitetura INT,
   fabricante VARCHAR(45) NOT NULL,
   hostName VARCHAR(45) NOT NULL,
   fkEmpresa INT NOT NULL,
   CONSTRAINT ctFk_EmpresaTotem FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
   );

-- Criação da tabela medidas de Desempenho
DROP TABLE IF EXISTS relatoriosManutencao;

CREATE TABLE RelatoriosManutencao(
titulo VARCHAR(45) NOT NULL,
decricao VARCHAR(45) NOT NULL,
resposavel VARCHAR(45) NOT NULL,
fkFuncionario INT NOT NULL,
CONSTRAINT CTfk_Funcionario FOREIGN KEY (fkFuncionario) REFERENCES Funcionario(idFuncionario),
fkTotem INT NOT NULL,
CONSTRAINT CTfk_Totem FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem)
);

 
DROP TABLE IF EXISTS Cpus;
 CREATE TABLE Cpus (
 idCpu INT PRIMARY KEY NOT NULL,
 nome VARCHAR(45) NOT NULL,
 microArquitetura VARCHAR(45) NOT NULL,
 frequencia VARCHAR(45) NOT NULL,
 usoAtencao DOUBLE,
 usoUrgente DOUBLE,
 usoCritico DOUBLE,
 fkTotem INT NOT NULL,
 FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem)
 );
 
 select * from Cpus;
 
 DROP TABLE IF EXISTS AlertasCPU;
 CREATE TABLE AlertasCPU (
 criticidade VARCHAR(45) NOT NULL,
 usoCPU DOUBLE,
 tempoExecucao TIME,
 horaLeitura DATETIME,
 fkTotem INT NOT NULL,
 CONSTRAINT fk_Totem FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem),
 fkCpus INT NOT NULL,
 CONSTRAINT fk_Cpus FOREIGN KEY (fkCpus) REFERENCES Cpus(idCpu)
 );
 
 DROP TABLE IF EXISTS AlertasRam;
 
 CREATE TABLE Ram (
 idRam INT PRIMARY KEY NOT NULL,
 totalRam DOUBLE,
 usoAtencao DOUBLE,
 usoUrgente DOUBLE,
 usoCritico DOUBLE,
 fkTotem INT NOT NULL,
 FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem)
 );
 
 DROP TABLE IF EXISTS AlertasRam;
  CREATE TABLE AlertasRam (
 criticidade VARCHAR(45) NOT NULL,
 usoRam DOUBLE,
 tempoExecucao TIME,
 horaLeitura DATETIME,
 fkTotem INT NOT NULL,
 FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem),
 fkRam INT NOT NULL,
 CONSTRAINT CTfk_Ram FOREIGN KEY (fkRam) REFERENCES Ram(idRam)
 );
 
 CREATE TABLE Disco (
 idDisco INT PRIMARY KEY NOT NULL,
 modelo VARCHAR(45) NOT NULL,
 tipo VARCHAR(15) NOT NULL,
 totalDisco DOUBLE,
 usoAtencao DOUBLE,
 usoUrgente DOUBLE,
 usoCritico DOUBLE,
 fkTotem INT NOT NULL,
  FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem)
 );
 
 CREATE TABLE AlertasDisco(
 criticidade VARCHAR(45) NOT NULL,
 usoDisco DOUBLE,
 tempoExecucao TIME,
 horaLeitura DATETIME,
  fkTotem INT NOT NULL,
  FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem),
  fkDisco INT NOT NULL,
 CONSTRAINT CTfk_Disco FOREIGN KEY (fkDisco) REFERENCES Disco(idDisco)
 );
 
 CREATE TABLE Rede(
 idRede INT PRIMARY KEY NOT NULL,
 hostNome VARCHAR(45) NOT NULL,
 dominio VARCHAR(45) NOT NULL,
 servidoresDns DOUBLE,
 downloadIdeal DOUBLE,
 downloadUrgente DOUBLE,
 downloadCritico DOUBLE,
 uploadIdeal DOUBLE,
 uploadUrgente DOUBLE,
 uploadCritico DOUBLE,
   fkTotem INT NOT NULL,
 FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem)
 );
 
 CREATE TABLE AlertasRede(
 criticidade VARCHAR(45),
 taxaDownload DOUBLE,
 taxaUpload DOUBLE,
 horaLeitura DATETIME,
 fkTotem INT NOT NULL,
 FOREIGN KEY (fkTotem) REFERENCES Totem(idTotem),
 fkRede INT NOT NULL,
 CONSTRAINT CTfk_Rede FOREIGN KEY (fkRede) REFERENCES Rede(idRede)
 );
 






/* ----------------------------------------- Selects usados nos models SQL Local --------------------------------------------- */


SELECT * FROM Empresa;
SELECT * FROM Funcionario;
SELECT * FROM Endereco;
SELECT * FROM Empresa;
DESC Empresa;
SELECT * FROM Endereco;
SELECT * FROM Totem;
SELECT * FROM RelatoriosManutencao;
SELECT * FROM Cpus;
SELECT * FROM AlertasCPU;
SELECT * FROM Ram;
SELECT * FROM AlertasRam;
SELECT * FROM Disco;
SELECT * FROM AlertasDisco;
SELECT * FROM Rede;
SELECT * FROM AlertasRede;





    
-- SELECTS TESTE

-- SELECT com INNER JOIN
SELECT *
FROM Empresa
INNER JOIN Endereco ON Empresa.fkEndereco = Endereco.idEndereco;

SELECT *
FROM Funcionario
INNER JOIN Empresa ON Funcionario.fkEmpresa = Empresa.idEmpresa;

SELECT *
FROM Totem
INNER JOIN Empresa ON Totem.fkEmpresa = Empresa.idEmpresa;

SELECT *
FROM medidasDesemp
INNER JOIN Totem ON medidasDesemp.fkTotem = Totem.idTotem;

SELECT *
FROM Log_Erro
INNER JOIN medidasDesemp ON Log_Erro.fkTotem = medidasDesemp.fkTotem AND Log_Erro.fkDesempenho = medidasDesemp.idDesempenho;

SELECT *
FROM relatoriosManutencao
INNER JOIN Funcionario ON relatoriosManutencao.fkFuncionario = Funcionario.idFuncionario
INNER JOIN Totem ON relatoriosManutencao.fkTotem = Totem.idTotem;

-- SELECT com LEFT JOIN
SELECT *
FROM Empresa
LEFT JOIN Endereco ON Empresa.fkEndereco = Endereco.idEndereco;

SELECT *
FROM Funcionario
LEFT JOIN Empresa ON Funcionario.fkEmpresa = Empresa.idEmpresa;

SELECT *
FROM Totem
LEFT JOIN Empresa ON Totem.fkEmpresa = Empresa.idEmpresa;

SELECT *
FROM medidasDesemp
LEFT JOIN Totem ON medidasDesemp.fkTotem = Totem.idTotem;

SELECT *
FROM Log_Erro
LEFT JOIN medidasDesemp ON Log_Erro.fkTotem = medidasDesemp.fkTotem AND Log_Erro.fkDesempenho = medidasDesemp.idDesempenho;

SELECT *
FROM relatoriosManutencao
LEFT JOIN Funcionario ON relatoriosManutencao.fkFuncionario = Funcionario.idFuncionario
LEFT JOIN Totem ON relatoriosManutencao.fkTotem = Totem.idTotem;

-- SELECT com RIGHT JOIN
SELECT *
FROM Endereco
RIGHT JOIN Empresa ON Empresa.fkEndereco = Endereco.idEndereco;

SELECT *
FROM Empresa
RIGHT JOIN Funcionario ON Funcionario.fkEmpresa = Empresa.idEmpresa;

SELECT *
FROM Empresa
RIGHT JOIN Totem ON Totem.fkEmpresa = Empresa.idEmpresa;

SELECT *
FROM Totem
RIGHT JOIN medidasDesemp ON medidasDesemp.fkTotem = Totem.idTotem;

SELECT *
FROM medidasDesemp
RIGHT JOIN Log_Erro ON Log_Erro.fkTotem = medidasDesemp.fkTotem AND Log_Erro.fkDesempenho = medidasDesemp.idDesempenho;

SELECT *
FROM Funcionario
RIGHT JOIN relatoriosManutencao ON relatoriosManutencao.fkFuncionario = Funcionario.idFuncionario
RIGHT JOIN Totem ON relatoriosManutencao.fkTotem = Totem.idTotem;



