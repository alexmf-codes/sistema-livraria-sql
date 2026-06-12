# 📚 Banco de Dados: Sistema de Gerenciamento de Livraria

Bem-vindo ao repositório do projeto **Livraria**. Este projeto consiste na modelagem e implementação de um banco de dados relacional completo para gerenciar as operações de uma livraria fictícia. 

O objetivo principal deste repositório é demonstrar proficiência em **SQL (MySQL)** aplicados à resolução de problemas reais de negócios, estruturação de dados e boas práticas de banco de dados.

## 🛠️ Tecnologias Utilizadas
* **Banco de Dados:** MySQL
* **Conceitos Aplicados:** Modelagem Relacional (1:1, 1:N), Normalização de Dados, Joins, Views, Stored Procedures, Triggers e DDL/DML.

---

## 🏗️ Estrutura do Banco de Dados

O modelo foi construído garantindo a integridade referencial com restrições `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL` e `UNIQUE`.

* **`autores`**: Armazena os dados dos escritores.
* **`livros`**: Registra o catálogo de livros, mantendo um relacionamento (1:N) com a tabela de autores.
* **`clientes`**: Cadastro unificado de usuários.
* **`enderecos`**: Relacionamento restrito (1:1) com clientes para logística.
* **`telefones`**: Relacionamento (1:N) com clientes, utilizando validação `ENUM` para tipos de contato.

---

## ⚙️ Regras de Negócio Implementadas

Para além do armazenamento básico, o banco possui inteligência embutida para lidar com cenários cotidianos:

1. **Visões (`VIEWS`):**
   * `vw_perfil_leitores`: Uma tabela virtual que unifica dados de clientes e endereços, simplificando consultas frequentes da equipe de Front-End e análises de marketing.
2. **Rotinas (`STORED PROCEDURES`):**
   * `sp_buscar_livros_editora`: Automatiza a busca de títulos através do nome da editora, encapsulando a complexidade do SELECT.
3. **Gatilhos de Validação (`TRIGGERS`):**
   * `trg_valida_paginas_livro`: Regra de validação a nível de banco que impede (via `SIGNAL SQLSTATE`) a inserção de livros com 0 ou menos páginas.

---

## 🚀 Como Executar o Projeto

Para visualizar a estrutura e testar as funcionalidades, você não precisa executar os arquivos um por um. Preparei um **script unificado** de fácil execução.

1. Abra seu cliente MySQL.
2. Execute o script contido no arquivo principal de instalação (arquivo:instalacao)
