USE livraria;

-- Cenário: Garantir a regra de negócio de que nenhum livro com zero ou menos páginas seja inserido no sistema.
DELIMITER $$

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

-- Para testar o bloqueio da trigger:
-- INSERT INTO livros (titulo, categoria, isbn, ano_publicacao, quantidade_paginas, editora, id_autor) 
-- VALUES ('Livro Teste', 'Teste', '1111111', 2023, 0, 'Editora X', 1);