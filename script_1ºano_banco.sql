-- Script do banco

-- responsavel corrigido
CREATE TABLE responsavel (
	id serial PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
	sobrenome VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL CHECK (email LIKE '%@%'),
	senha VARCHAR(20) NOT NULL,
	id_aluno INT,
	FOREIGN KEY (id_aluno) REFERENCES Aluno (id)
);

-- aluno corrigido
CREATE TABLE Aluno 
( 
	id serial PRIMARY KEY,  
	nome VARCHAR(20) NOT NULL,
	sobrenome varchar(20) not null,
	xp INT NOT NULL DEFAULT 0 CHECK (xp >= 0), 
	email VARCHAR(200) NOT NULL CHECK (email LIKE '%@%'),
	senha VARCHAR(20) NOT NULL,
	id_turma INT,
	FOREIGN KEY (id_turma) REFERENCES Turma (id)
); 

select * from turma
CREATE TABLE Turma 
( 
	id serial PRIMARY KEY,  
	serie INT NOT NULL,
	nomenclatura VARCHAR(2) NOT NULL,
	ano INT NOT NULL CHECK (ano >= 2024 AND ano <= 2100),
	id_escola INT,
	id_professor INT
	FOREIGN KEY (id_escola) REFERENCES Escola (id),
	FOREIGN KEY (id_professor) REFERENCES Professor (id)
); 

CREATE TABLE Professor 
( 
	id serial PRIMARY KEY,  
	nome VARCHAR(100) NOT NULL, 
	sobrenome VARCHAR(100) NOT NULL,
	email VARCHAR(200) NOT NULL CHECK (email LIKE '%@%'),
	senha VARCHAR(20) NOT NULL
); 

CREATE TABLE Escola 
( 
	id serial PRIMARY KEY,  
	nome VARCHAR(20) NOT NULL,  
	email VARCHAR(50) NOT NULL CHECK (email LIKE '%@%'),  
	telefone VARCHAR(15) NOT NULL DEFAULT 'Não informado' CHECK (char_length(telefone) = 15),  
	id_endereco INT,
	FOREIGN KEY (id_endereco) REFERENCES Endereco (id)
);

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

CREATE TABLE Tema
(
	id serial PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	id_professor INT,
	FOREIGN KEY (id_professor) REFERENCES Professor (id)
);

CREATE TABLE Conteudo 
(
	id serial PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
	texto TEXT NOT NULL,
	video varchar(200) NOT NULL,
	id_tema INT,
	FOREIGN KEY (id_tema) REFERENCES Tema (id)
);

CREATE TABLE Pratica
(
	id serial PRIMARY KEY,
	enunciado TEXT,
	foto TEXT,
	id_professor INT,
	FOREIGN KEY (id_professor) REFERENCES Professor (id)
);

CREATE TABLE Quiz
(
	id serial PRIMARY KEY,
	pergunta TEXT,
	resposta_certa VARCHAR(150),
	resposta_errada1 VARCHAR(150),
	resposta_errada2 VARCHAR(150),
	resposta_errada3 VARCHAR(150),
	id_tema INT,
	FOREIGN KEY (id_tema) REFERENCES Tema (id)
);

CREATE TABLE Admin (
	id serial PRIMARY KEY,
	nome VARCHAR (100),
	email VARCHAR (150),
	senha VARCHAR (20)
);
