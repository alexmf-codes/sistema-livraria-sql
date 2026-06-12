-- ========================================================
-- SCRIPT ÚNICO DE INSTALAÇÃO - PROJETO LIVRARIA
-- ========================================================

DROP DATABASE IF EXISTS livraria;
CREATE DATABASE livraria;
USE livraria;

-- ========================================================
-- 1. CRIAÇÃO DAS TABELAS
-- ========================================================

CREATE TABLE autores(
    idautor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(30) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE livros(
    idlivro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    isbn VARCHAR(50) NOT NULL UNIQUE,
    ano_publicacao INT NOT NULL,
    quantidade_paginas INT NOT NULL,
    editora VARCHAR(50) NOT NULL,
    id_autor INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autores(idautor)
);

CREATE TABLE clientes(
    idcliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    sexo CHAR(1) NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    cpf CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE enderecos(
    idendereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR (70) NOT NULL,
    bairro VARCHAR (50) NOT NULL,
    cidade VARCHAR (40) NOT NULL,
    estado CHAR(2) NOT NULL,
    id_cliente INT NOT NULL UNIQUE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(idcliente)
);

CREATE TABLE telefones(
    idtelefone INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10) NOT NULL,
    tipo ENUM('cel','com','res') NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY(id_cliente) REFERENCES clientes(idcliente)
);

-- ========================================================
-- 2. INSERÇÃO DE DADOS (MOCK)
-- ========================================================

INSERT INTO autores (nome, nacionalidade, email) VALUES
('Machado de Assis', 'Brasileira', 'machado@academia.org'),
('J. K. Rowling', 'Britânica', 'jkrowling@email.com'),
('George Orwell', 'Britânica', 'orwell@email.com'),
('Clarice Lispector', 'Brasileira', 'clarice@email.com'),
('Käpt''n Blaubär', 'Alemã', 'blaubar@zeitgeist.de'),
('J. R. R. Tolkien', 'Britânica', 'tolkien@email.com'),
('Stephen King', 'Americana', 'king@email.com'),
('Antoine de Saint-Exupéry', 'Francesa', 'antoine@email.com');

INSERT INTO livros (titulo,categoria,isbn,ano_publicacao,quantidade_paginas,editora,id_autor) VALUES
('Dom Casmurro', 'Romance', '9788535910663', 1899, 256, 'Editora Globo', 1),
('Harry Potter e a Pedra Filosofal', 'Fantasia', '9788532511010', 1997, 264, 'Rocco', 2),
('1984', 'Ficção Científica', '9788535914845', 1949, 416, 'Companhia das Letras', 3),
('A Hora da Estrela', 'Romance', '9788532505675', 1977, 96, 'Rocco', 4),
('Das dickste Buch des Universum', 'Infantojuvenil', '978-3-934046-46-7', 2010, 50560, 'Zeitgeist Media', 5),
('O Senhor dos Anéis', 'Fantasia', '9788533613379', 1954, 1216, 'Martins Fontes', 6),
('O Iluminado', 'Terror', '9788556510361', 1977, 520, 'Suma', 7),
('O Pequeno Príncipe', 'Infantil', '9788595081512', 1943, 96, 'Agir', 8);

INSERT INTO clientes (nome,sexo,email,cpf) VALUES
('João Pedro Silva','M','joao@gmail.com','12345678901'),
('Maria Fernanda Souza','F','maria@gmail.com','23456789012'),
('Lucas Oliveira','M','lucas@gmail.com','34567890123'),
('Ana Carolina Lima','F','ana@gmail.com','45678901234'),
('Gabriel Costa','M','gabriel@gmail.com','56789012345'),
('Juliana Martins','F','juliana@gmail.com','67890123456'),
('Rafael Almeida','M','rafael@gmail.com','78901234567'),
('Camila Rocha','F','camila@gmail.com','89012345678');

INSERT INTO enderecos (rua,bairro,cidade,estado,id_cliente) VALUES
('Avenida Paulista','Bela Vista','São Paulo','SP',1),
('Rua XV de Novembro','Centro','Curitiba','PR',2),
('Avenida Afonso Pena','Centro','Belo Horizonte','MG',3),
('Rua da Praia','Centro Histórico','Porto Alegre','RS',4),
('Avenida Atlântica','Copacabana','Rio de Janeiro','RJ',5),
('Avenida Beira Mar','Meireles','Fortaleza','CE',6),
('Rua Chile','Centro Histórico','Salvador','BA',7),
('Avenida Djalma Batista','Chapada','Manaus','AM',8);

INSERT INTO telefones (numero,tipo,id_cliente) VALUES
('1198765432','cel',1),
('1134567890','res',1),
('4199998888','cel',2),
('3198888777','cel',3),
('3133221100','com',3),
('5197777666','cel',4),
('2196666555','cel',5),
('2133334444','res',5),
('8595555444','cel',6),
('7194444333','cel',7),
('9293333222','cel',8);

-- ========================================================
-- 3. CRIAÇÃO DE VIEWS, PROCEDURES E TRIGGERS
-- ========================================================

CREATE VIEW vw_perfil_leitores AS
SELECT 
    c.nome AS Leitor, 
    c.sexo, 
    c.email, 
    e.cidade, 
    e.estado
FROM clientes c
INNER JOIN enderecos e 
    ON c.idcliente = e.id_cliente;

DELIMITER $$

CREATE PROCEDURE sp_buscar_livros_editora(IN nome_editora VARCHAR(50))
BEGIN
    SELECT 
        titulo, 
        categoria, 
        ano_publicacao 
    FROM livros
    WHERE editora = nome_editora;
END $$

CREATE TRIGGER trg_valida_paginas_livro
BEFORE INSERT ON livros
FOR EACH ROW
BEGIN
    IF NEW.quantidade_paginas <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A quantidade de páginas deve ser maior que zero.';
    END IF;
END $$

DELIMITER ;
