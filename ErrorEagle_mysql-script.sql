
DROP database IF exists error_eagle ;
CREATE DATABASE IF NOT EXISTS error_eagle;
USE error_eagle;
DROP TABLE IF EXISTS Endereco ;

CREATE TABLE IF NOT EXISTS Endereco (
    id INT NOT NULL AUTO_INCREMENT,
    cep CHAR(8) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);
-- -----------------------------------------------------
-- Table Empresa
-- -----------------------------------------------------
DROP TABLE IF EXISTS Empresa ;

CREATE TABLE IF NOT EXISTS Empresa (
    id INT NOT NULL AUTO_INCREMENT,
    responsavel VARCHAR(100) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    telefone CHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT chk_email_empresa CHECK (email LIKE '%@%.%'),
    statusEmpresa TINYINT NOT NULL,
    bandaLarga INT NOT NULL,
    fkEndereco INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_Empresa_Endereco1 FOREIGN KEY (fkEndereco)
        REFERENCES Endereco (id)
);
-- -----------------------------------------------------
-- Table Funcionario
-- -----------------------------------------------------
DROP TABLE IF EXISTS Funcionario ;
CREATE TABLE IF NOT EXISTS Funcionario (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL UNIQUE,
  CONSTRAINT chk_email_funcionario CHECK (email LIKE '%@%.%'),
  senha VARCHAR(100) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  telefone CHAR(11) NOT NULL,
  firstAcess TINYINT NOT NULL,
  statusFuncionario TINYINT NOT NULL,
  fkEmpresa INT NOT NULL,
  fkSupervisor INT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_Funcionario_Empresa1
    FOREIGN KEY (fkEmpresa)
    REFERENCES Empresa (id),
  CONSTRAINT fk_Funcionario_Funcionario1
    FOREIGN KEY (fkSupervisor)
    REFERENCES Funcionario (id)
    );
-- -----------------------------------------------------
-- Table FaleConosco
-- -----------------------------------------------------
DROP TABLE IF EXISTS FaleConosco ;

CREATE TABLE IF NOT EXISTS FaleConosco (
    id INT NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Sobrenome VARCHAR(45) NOT NULL,
    TelefoneContato CHAR(11) NOT NULL,
    email VARCHAR(80) NOT NULL,
    CONSTRAINT chk_email_contato CHECK (email LIKE '%@%.%'),
    MensagemUsuario VARCHAR(600) NOT NULL,
    PRIMARY KEY (id)
);
-- -----------------------------------------------------
-- Table Totem
-- -----------------------------------------------------
DROP TABLE IF EXISTS Totem ;

CREATE TABLE IF NOT EXISTS Totem (
  id INT NOT NULL AUTO_INCREMENT,
  hostName VARCHAR(100) NOT NULL UNIQUE,
  fkEmpresa INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_Totem_Empresa1
    FOREIGN KEY (fkEmpresa)
    REFERENCES Empresa (id)
    );
-- -----------------------------------------------------
-- Table RelatoriosManutencao
-- -----------------------------------------------------
DROP TABLE IF EXISTS RelatoriosManutencao ;

CREATE TABLE IF NOT EXISTS RelatoriosManutencao (
  id INT NOT NULL AUTO_INCREMENT,
  fkFuncionario INT NOT NULL,
  fkTotem INT NOT NULL,
  titulo VARCHAR(200) NOT NULL,
  descricaoIncidente VARCHAR(800) NOT NULL,
  descricaoManutencao VARCHAR(800) NOT NULL,
  dataManutencao DATETIME NOT NULL,
  dataRelatorio DATETIME NOT NULL,
  PRIMARY KEY (id, fkFuncionario, fkTotem),
  CONSTRAINT fk_Funcionario_has_Totem_Funcionario1
    FOREIGN KEY (fkFuncionario)
    REFERENCES Funcionario (id),
  CONSTRAINT fk_Funcionario_has_Totem_Totem1
    FOREIGN KEY (fkTotem)
    REFERENCES Totem (id)
);

-- -----------------------------------------------------
-- Table Admin
-- -----------------------------------------------------
DROP TABLE IF EXISTS Admin ;
CREATE TABLE IF NOT EXISTS Admin (
  id INT NOT NULL auto_increment,
  email VARCHAR(80) NOT NULL UNIQUE,
  CONSTRAINT chk_email_admin CHECK (email LIKE '%@%.%'),
  senha VARCHAR(60) NOT NULL,
  PRIMARY KEY (id));
-- -----------------------------------------------------
-- Table Componente
-- -----------------------------------------------------
DROP TABLE IF EXISTS Componente ;

CREATE TABLE IF NOT EXISTS Componente (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);
-- -----------------------------------------------------
-- Table Configuracao
-- -----------------------------------------------------
DROP TABLE IF EXISTS Configuracao ;

CREATE TABLE IF NOT EXISTS Configuracao (
  fkTotem INT NOT NULL,
  fkComponente INT NOT NULL,
  capacidade DOUBLE NOT NULL,
  unidadeMedida VARCHAR(10) NOT NULL,
  PRIMARY KEY (fkTotem, fkComponente),
  CONSTRAINT fk_Totem_has_TipoComponente_Totem1
    FOREIGN KEY (fkTotem)
    REFERENCES Totem (id),
  CONSTRAINT fk_Totem_has_TipoComponente_TipoComponente1
    FOREIGN KEY (fkComponente)
    REFERENCES Componente (id)
    
    );



-- -----------------------------------------------------
-- Table Medida
-- -----------------------------------------------------
DROP TABLE IF EXISTS Medida ;

CREATE TABLE IF NOT EXISTS Medida (
  id INT NOT NULL AUTO_INCREMENT,
  percentual DOUBLE NOT NULL,
  dataHora DATETIME NOT NULL DEFAULT now(),
  fkTotem INT NOT NULL,
  fkComponente INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_Medidas_Configuracao1
    FOREIGN KEY (fkTotem , fkComponente)
    REFERENCES Configuracao (fkTotem , fkComponente)
    
    );

-- -----------------------------------------------------
-- Table TipoAlerta
-- -----------------------------------------------------
DROP TABLE IF EXISTS TipoAlerta ;

CREATE TABLE IF NOT EXISTS TipoAlerta (
    id INT NOT NULL AUTO_INCREMENT,
    Criticidade VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- ---------------------------------------------
-- Tabela situacaoTotem 
-- ---------------------------------------------

CREATE TABLE if not exists situacaoTotem (
  id INT NOT NULL AUTO_INCREMENT,
  mensagem VARCHAR(200) NOT NULL,
  media DOUBLE NOT NULL,
  datahora DATETIME NOT NULL,
  fkTotem INT NOT NULL,
  fkComponente INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_situacaoTotem_Configuracao1
    FOREIGN KEY (fkTotem , fkComponente)
    REFERENCES Configuracao (fkTotem , fkComponente)
);

-- -----------------------------------------------------
-- Table Limite
-- -----------------------------------------------------
DROP TABLE IF EXISTS Limite ;

CREATE TABLE IF NOT EXISTS Limite (
  fkComponente INT NOT NULL,
  fkTipoAlerta INT NOT NULL,
  maximo DOUBLE NOT NULL,
  minimo DOUBLE NOT NULL,
  PRIMARY KEY (fkComponente, fkTipoAlerta),
	CONSTRAINT fk_TipoComponente_has_tiposAlertas_TipoComponente1
    FOREIGN KEY (fkComponente)
    REFERENCES Componente (id),
	CONSTRAINT fk_TipoComponente_has_tiposAlertas_tiposAlertas1
    FOREIGN KEY (fkTipoAlerta)
    REFERENCES TipoAlerta (id)
    
    );


-- -----------------------------------------------------
-- Table MedidaRede
-- -----------------------------------------------------
DROP TABLE IF EXISTS MedidaRede ;

CREATE TABLE IF NOT EXISTS MedidaRede (
  id INT NOT NULL AUTO_INCREMENT,
  upload DOUBLE NOT NULL,
  donwload DOUBLE NOT NULL,
  fkTotem INT NOT NULL,
  fkComponente INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_MedidaRede_Configuracao1
    FOREIGN KEY (fkTotem , fkComponente)
    REFERENCES Configuracao (fkTotem , fkComponente)
    );
