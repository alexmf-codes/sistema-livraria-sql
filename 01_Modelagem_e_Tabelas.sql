-- Criação do banco de dados
CREATE DATABASE livraria;
USE livraria;

-- Tabela de Autores
CREATE TABLE autores(
    idautor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(30) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Tabela de Livros (Relacionamento 1:N com Autores)
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

-- Tabela de Clientes
CREATE TABLE clientes(
    idcliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    sexo CHAR(1) NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    cpf CHAR(11) NOT NULL UNIQUE
);

-- Tabela de Endereços (Relacionamento 1:1 com Clientes)
CREATE TABLE enderecos(
    idendereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR (70) NOT NULL,
    bairro VARCHAR (50) NOT NULL,
    cidade VARCHAR (40) NOT NULL,
    estado CHAR(2) NOT NULL,
    id_cliente INT NOT NULL UNIQUE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(idcliente)
);

-- Tabela de Telefones (Relacionamento 1:N com Clientes)
CREATE TABLE telefones(
    idtelefone INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10) NOT NULL,
    tipo ENUM('cel','com','res') NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY(id_cliente) REFERENCES clientes(idcliente)
);
