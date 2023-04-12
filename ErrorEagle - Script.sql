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
  telefone VARCHAR(15) NOT NULL,
  fkEmpresa INT NOT NULL,
  fkSupervisor INT,
  statusFuncionario tinyint,
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
   statusRede VARCHAR(45) NOT NULL,
   tipoConexao VARCHAR(45) NOT NULL,
   tipoDisco CHAR(3) NOT NULL,
   totalDisco INT NOT NULL,
   totalRam INT NOT NULL,
   enderecoIP VARCHAR(15) NOT NULL,
   fkEmpresa INT NOT NULL,
   CONSTRAINT ctFk_EmpresaTotem FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
   );

-- Criação da tabela medidas de Desempenho
DROP TABLE IF EXISTS medidasDesemp ;

 CREATE TABLE IF NOT EXISTS medidasDesemp (
   fkTotem INT NOT NULL,
   idDesempenho INT NOT NULL,
   usoRam DOUBLE NOT NULL,
   usoCache DOUBLE NOT NULL,
   taxaLeituraRam DOUBLE NOT NULL,
   taxaEscritaRam DOUBLE NOT NULL,
   usoCpu DOUBLE NOT NULL,
   temperaturaCpu FLOAT NOT NULL,
   tempoAtividade TIME NOT NULL,
   usoDisco DOUBLE NOT NULL,
   taxaLeituraDisco VARCHAR(45) NOT NULL,
   taxaEscritaDisco VARCHAR(45) NOT NULL,
   HoraLeitura DATETIME NOT NULL,
   taxaUpload DOUBLE NOT NULL,
   taxaDonwload DOUBLE NOT NULL,
   PRIMARY KEY (fkTotem, idDesempenho),
   CONSTRAINT ctFk_Totem FOREIGN KEY (fkTotem) REFERENCES Totem (idTotem)
   );

-- Criação da tabela Log_Erro
 DROP TABLE IF EXISTS Log_Erro ;

 CREATE TABLE IF NOT EXISTS Log_Erro(
  idLog_Erro INT NOT NULL,
  TipoErro VARCHAR(45) NOT NULL,
  Descricao VARCHAR(400) NOT NULL,
  fkTotem INT NOT NULL,
  fkDesempenho INT NOT NULL,
  PRIMARY KEY (idLog_Erro),
  CONSTRAINT ctFk_LogErro FOREIGN KEY (fkTotem, fkDesempenho) REFERENCES medidasDesemp (fkTotem, idDesempenho)
 );

-- Criação da tabela relatórios de manutenca
 DROP TABLE IF EXISTS relatoriosManutencao;

 CREATE TABLE IF NOT EXISTS relatoriosManutencao(
   fkFuncionario INT NOT NULL,
   fkTotem INT NOT NULL,
   Titulo VARCHAR(45) NOT NULL,
   Descricao VARCHAR(450) NOT NULL,
   responsavel VARCHAR(45) NOT NULL,
   PRIMARY KEY (`fkFuncionario`, `fkTotem`),
   CONSTRAINT ctFk_ResponsManuten FOREIGN KEY (fkFuncionario) REFERENCES Funcionario (idFuncionario),
   CONSTRAINT ctfk_TotemReparado FOREIGN KEY (fkTotem) REFERENCES Totem (idTotem)
  );





/* ----------------------------------------- Selects usados nos models SQL Local --------------------------------------------- */


SELECT * FROM Empresa;

SELECT * FROM Funcionario;
                
SELECT * FROM Endereco;
SELECT * FROM Empresa;
DESC Empresa;
SELECT * FROM Endereco;


    
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



