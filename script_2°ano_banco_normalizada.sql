---------------------------------- CRIAÇÃO DAS TABELAS --------------------------------------
 
-- Tabela 'Endereco'
CREATE TABLE Endereco
(
    id serial PRIMARY KEY,
    numero INT NOT NULL,
    rua VARCHAR(80) NOT NULL,
    bairro VARCHAR(80) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(30) NOT NULL,
    cep VARCHAR(20) NOT NULL
);
 
-- Tabela 'Escola'
CREATE TABLE Escola 
( 
    id serial PRIMARY KEY,  
    nome VARCHAR(20) NOT NULL,  
    email VARCHAR(50) NOT NULL CHECK (email LIKE '%@%'),  
    telefone VARCHAR(15) NOT NULL DEFAULT 'Não informado' CHECK (char_length(telefone) BETWEEN 7 AND 15),  
    id_endereco INT,
    FOREIGN KEY (id_endereco) REFERENCES Endereco (id)
);
 
-- Tabela 'Professor'
CREATE TABLE Professor 
( 
    id serial PRIMARY KEY,  
    nome VARCHAR(100) NOT NULL, 
    sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL CHECK (email LIKE '%@%'),
    senha VARCHAR(20) NOT NULL
);
 
-- Tabela 'Turma'
CREATE TABLE Turma 
( 
    id serial PRIMARY KEY,  
    nomenclatura VARCHAR(2) NOT NULL,
    serie INT NOT NULL,
    ano INT NOT NULL CHECK (ano >= 2024 AND ano <= 2100),
    id_escola INT,
    id_professor INT,
    FOREIGN KEY (id_escola) REFERENCES Escola (id),
    FOREIGN KEY (id_professor) REFERENCES Professor (id)
);
 
-- Tabela 'Aluno'
CREATE TABLE Aluno 
( 
    id serial PRIMARY KEY,  
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    email VARCHAR(200) NOT NULL CHECK (email LIKE '%@%'),
    senha VARCHAR(20) NOT NULL,
    xp INT NOT NULL DEFAULT 0 CHECK (xp >= 0), 
    id_turma INT,
    FOREIGN KEY (id_turma) REFERENCES Turma (id)
);
 
-- Tabela 'Responsavel'
CREATE TABLE Responsavel 
(
    id serial PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL CHECK (email LIKE '%@%'),
    senha VARCHAR(20) NOT NULL,
    id_aluno INT,
    FOREIGN KEY (id_aluno) REFERENCES Aluno (id)
);
 
