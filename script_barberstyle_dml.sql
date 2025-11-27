-- ==========================================================
-- 1. INSERÇÃO DE DADOS (INSERT)
-- ==========================================================

-- Inserindo Clientes
INSERT INTO CLIENTE (Nome_Completo, Telefone, Email, Data_Nascimento) VALUES 
('Fabio Alves', '(11) 99999-1234', 'fabio.dev@email.com', '1990-05-15'),
('Carlos Silva', '(11) 98888-5678', 'carlos.silva@email.com', '1985-10-20'),
('Ana Paula', '(11) 97777-4321', 'ana.paula@email.com', '1995-02-28');

-- Inserindo Barbeiros
INSERT INTO BARBEIRO (Nome, Especialidade, Percentual_Comissao) VALUES 
('João Tesoura', 'Corte Clássico', 40.00),
('Marcos Navalha', 'Barba e Pigmentação', 45.00);

-- Inserindo Serviços
INSERT INTO SERVICO (Descricao, Valor_Atual, Tempo_Estimado) VALUES 
('Corte Social', 40.00, 30),
('Barba Modelada', 35.00, 20),
('Sobrancelha', 15.00, 10),
('Corte + Barba', 70.00, 50);

-- Inserindo Produtos
INSERT INTO PRODUTO (Nome_Produto, Valor_Venda, Qtd_Estoque) VALUES 
('Pomada Modeladora', 25.00, 50),
('Gel Fixador', 15.00, 30),
('Óleo para Barba', 30.00, 20);

-- Inserindo Agendamentos
INSERT INTO AGENDAMENTO (Data_Hora, Status, ID_Cliente, ID_Barbeiro) VALUES 
('2024-11-28 10:00:00', 'Agendado', 1, 1), -- Fabio com João
('2024-11-28 11:00:00', 'Concluído', 2, 2); -- Carlos com Marcos

-- Inserindo Itens do Agendamento (Quais serviços foram feitos)
INSERT INTO ITEM_AGENDAMENTO (ID_Agendamento, ID_Servico, Valor_Praticado) VALUES 
(1, 4, 70.00), -- Fabio fará Corte + Barba
(2, 2, 35.00); -- Carlos fez Barba

-- ==========================================================
-- 2. CONSULTAS (SELECT)
-- ==========================================================

-- A. Consulta Simples com Ordenação
-- Listar todos os serviços ordenados do mais caro para o mais barato
SELECT * FROM SERVICO 
ORDER BY Valor_Atual DESC;

-- B. Consulta com JOIN (Relacionamento entre tabelas)
-- Ver quais clientes têm agendamento, data e com qual barbeiro
SELECT 
    c.Nome_Completo AS Cliente, 
    a.Data_Hora, 
    a.Status, 
    b.Nome AS Barbeiro
FROM AGENDAMENTO a
INNER JOIN CLIENTE c ON a.ID_Cliente = c.ID_Cliente
INNER JOIN BARBEIRO b ON a.ID_Barbeiro = b.ID_Barbeiro;

-- C. Consulta com Filtro e Agregação
-- Listar produtos com estoque abaixo de 40 unidades
SELECT Nome_Produto, Qtd_Estoque 
FROM PRODUTO 
WHERE Qtd_Estoque < 40;

-- ==========================================================
-- 3. ATUALIZAÇÃO DE DADOS (UPDATE)
-- ==========================================================

-- 1. Atualizar o telefone de um cliente específico
UPDATE CLIENTE 
SET Telefone = '(11) 90000-0000' 
WHERE ID_Cliente = 1;

-- 2. Reajustar o preço do "Corte Social" (Aumento de 10%)
UPDATE SERVICO 
SET Valor_Atual = Valor_Atual * 1.10 
WHERE Descricao = 'Corte Social';

-- 3. Atualizar o status de um agendamento para 'Cancelado'
UPDATE AGENDAMENTO 
SET Status = 'Cancelado' 
WHERE ID_Agendamento = 1;

-- ==========================================================
-- 4. EXCLUSÃO DE DADOS (DELETE)
-- ==========================================================

-- 1. Deletar um item de agendamento específico (Removendo um serviço do pacote)
DELETE FROM ITEM_AGENDAMENTO 
WHERE ID_Agendamento = 1 AND ID_Servico = 4;

-- 2. Deletar um produto que não será mais vendido (ex: Gel)
DELETE FROM PRODUTO 
WHERE Nome_Produto = 'Gel Fixador';

-- 3. Deletar agendamentos antigos e cancelados (Limpeza de base)
DELETE FROM AGENDAMENTO 
WHERE Status = 'Cancelado' AND Data_Hora < '2024-01-01';