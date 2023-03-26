
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
  CNPJ CHAR(13) NOT NULL UNIQUE,
  telefone1 CHAR(11) NOT NULL,
  telefone2 CHAR(11),
  email VARCHAR(80) NOT NULL UNIQUE, CHECK(email LIKE '%.%@%.%'),
  qtdTotem INT NOT NULL,
  Tokem CHAR(5) NOT NULL UNIQUE,
  fkEndereco INT NOT NULL,
  CONSTRAINT ctFk_Endereco FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
  );

-- Criação da tabela Funcionário.
DROP TABLE IF EXISTS Funcionario;

CREATE TABLE IF NOT EXISTS Funcionario (
  idFuncionario INT PRIMARY KEY NOT NULL,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(80) NOT NULL UNIQUE, CHECK(email LIKE '%.%@%.%'),
  senha VARCHAR(60) NOT NULL,
  telefone CHAR(11) NOT NULL,
  fkEmpresa INT NOT NULL,
  fkSupervisor INT NOT NULL,
  CONSTRAINT ctFk_EmpresaVinculado FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
  CONSTRAINT ctFk_Supervisor FOREIGN KEY (fkSupervisor) REFERENCES Funcionario (idFuncionario)
  );

-- Criação da tabela do Fale Conosco
DROP TABLE IF EXISTS Fale_conosco;

CREATE TABLE IF NOT EXISTS Fale_conosco(
  idFaleConosco INT PRIMARY KEY NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  Sobrenome VARCHAR(45) NOT NULL,
  TelefoneContato CHAR(11) NOT NULL,
  email VARCHAR(80) NOT NULL UNIQUE, CHECK(email LIKE '%.%@%.%'),
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
  usoCache VARCHAR(45) NOT NULL,
  processos INT NOT NULL,
  leituraRam DOUBLE NOT NULL,
  escritaRam DOUBLE NOT NULL,
  usoCpu DOUBLE NOT NULL,
  temperaturaCpu FLOAT NOT NULL,
  tempoAtividade TIME NOT NULL,
  usoDisco DOUBLE NOT NULL,
  leituraDisco VARCHAR(45) NOT NULL,
  escritaDisco VARCHAR(45) NOT NULL,
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

