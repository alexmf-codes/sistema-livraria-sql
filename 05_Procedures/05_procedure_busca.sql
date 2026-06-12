USE livraria;

-- Cenário: Criar uma rotina de banco de dados onde o usuário pesquisa livros fornecendo apenas o nome da editora.
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

DELIMITER ;

-- Para testar a procedure:
-- CALL sp_buscar_livros_editora('Rocco');