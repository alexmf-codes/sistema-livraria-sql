USE livraria;

-- Cenário: Criar uma "tabela virtual" para evitar que a equipe de Front-End faça JOINs complexos repetidamente.
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

-- Para testar a view:
-- SELECT * FROM vw_perfil_leitores WHERE estado = 'SP';