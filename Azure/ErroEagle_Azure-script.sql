

CREATE TABLE Endereco (
    id INT NOT NULL IDENTITY(1,1),
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

CREATE TABLE Empresa (
    id INT NOT NULL IDENTITY(1,1),
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

CREATE TABLE Funcionario (
  id INT NOT NULL IDENTITY(1,1),
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

CREATE TABLE FaleConosco (
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

CREATE TABLE Totem (
  id INT NOT NULL IDENTITY(1,1),
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

CREATE TABLE RelatoriosManutencao (
  fkFuncionario INT NOT NULL,
  fkTotem INT NOT NULL,
  Titulo VARCHAR(45) NOT NULL,
  Descricao VARCHAR(450) NOT NULL,
  PRIMARY KEY (fkFuncionario, fkTotem),
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

CREATE TABLE Admin (
  id INT NOT NULL IDENTITY(1,1),
  email VARCHAR(80) NOT NULL UNIQUE,
  CONSTRAINT chk_email_admin CHECK (email LIKE '%@%.%'),
  senha VARCHAR(60) NOT NULL,
  PRIMARY KEY (id));
-- -----------------------------------------------------
-- Table Componente
-- -----------------------------------------------------


CREATE TABLE Componente (
    id INT NOT NULL IDENTITY(1,1),
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);
-- -----------------------------------------------------
-- Table Configuracao
-- -----------------------------------------------------

CREATE TABLE Configuracao (
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

CREATE TABLE Medida (
  id INT NOT NULL IDENTITY(1,1),
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


CREATE TABLE TipoAlerta (
    id INT NOT NULL IDENTITY(1,1),
    Criticidade VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- -----------------------------------------------------
-- Table Limite
-- -----------------------------------------------------


CREATE TABLE Limite (
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

CREATE TABLE MedidaRede (
  id INT NOT NULL IDENTITY(1,1),
  upload DOUBLE NOT NULL,
  donwload DOUBLE NOT NULL,
  fkTotem INT NOT NULL,
  fkComponente INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_MedidaRede_Configuracao1
    FOREIGN KEY (fkTotem , fkComponente)
    REFERENCES Configuracao (fkTotem , fkComponente)
    );
