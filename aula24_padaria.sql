CREATE DATABASE DB_TI55_F_02722_Elenir_padaria;
USE DB_TI55_F_02722_Elenir_padaria;
 
CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(50),
    preco DECIMAL(5,2)
);
 
CREATE TABLE Funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(50),
    cargo VARCHAR(30)
);
 
CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY,
    id_produto INT,
    quantidade INT,
    data DATE,
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);
 
INSERT INTO Produtos (id_produto, nome, preco) VALUES
(1, 'Pão francês', 0.50),
(2, 'Croissant', 2.50),
(3, 'Bolo de cenoura', 15.00),
(4, 'Sonho', 3.00);
 
INSERT INTO Funcionarios (id_funcionario, nome, cargo) VALUES
(1, 'Ana Paula', 'Padeiro'),
(2, 'Carlos Eduardo', 'Atendente'),
(3, 'Juliana Silva', 'Caixa'),
(4, 'Marcos Vinícius', 'Gerente');
 
INSERT INTO Vendas (id_venda, id_produto, quantidade, data) VALUES
(1, 1, 10, '2025-08-15'),
(2, 2, 5, '2025-08-15'),
(3, 3, 2, '2025-08-16'),
(4, 4, 7, '2025-08-16');


UPDATE Funcionarios SET nome = 'Juliana Silva Moreira' WHERE id_funcionario = 3;
SELECT nome FROM Funcionarios;
DELETE FROM Funcionarios WHERE id_funcionario = 3;


-- 🍪 Inserir pelo menos 4 registros na tabela de produtos
INSERT INTO Produtos (id_produto, nome, preco) VALUES
(5, 'panetone', 12.99),
(6, 'pudim', 30.00),
(7, 'pamonha', 7.00),
(8, 'pão doce', 0.75);

-- 🛠️ Atualizar pelo menos 1 desses registros
 UPDATE Produtos SET preco = 16 WHERE id_produto = 3;
 
-- 🗑️ Excluir 1 desses registros
 DELETE FROM Produtos WHERE id_produto = 5;
 
-- 🔎 Fazer a consulta dessa tabela
 SELECT * FROM Produtos;
 
 -- WHERE
-- 💰 Mostrar Produtos com preço acima de R$5,00
SELECT *
FROM Produtos
WHERE preco > 5.00;
 
-- 🎂 Mostrar Produtos com nome contendo “Bolo”
SELECT *
FROM Produtos
WHERE nome LIKE '%Bolo%';
 
-- 📉 Mostrar Produtos com estoque abaixo de 20 unidades
 ALTER TABLE Produtos ADD estoque INT DEFAULT 0;
UPDATE Produtos SET estoque = 15 WHERE id_produto = 1; -- Pão francês
UPDATE Produtos SET estoque = 25 WHERE id_produto = 2; -- Croissant
UPDATE Produtos SET estoque = 10 WHERE id_produto = 3; -- Bolo de cenoura
UPDATE Produtos SET estoque = 40 WHERE id_produto = 4; -- Sonho

SELECT *
FROM Produtos
WHERE estoque < 20;

-- 🔁 Mostrar Produtos entre R$3,00 e R$10,00
 SELECT *
FROM Produtos
WHERE preco BETWEEN 3.00 AND 10;

-- 🍞 Mostrar Produtos que começam com "Pão"
SELECT *
FROM Produtos
WHERE nome LIKE 'Pão%';
 
-- 🥐 Mostrar Produtos com nome "Croissant" e estoque maior que 30
SELECT *
FROM Produtos
WHERE nome LIKE 'Croissant%'
AND estoque > 30;



-- atividade pratica aula 18 - pratica 6
-- Pensando em um negócio de padaria, quais são os comandos para:
-- 🔍 Mostrar Nome dos produtos em MAIÚSCULAS
SELECT
  nome,
  UPPER(nome) AS nome
FROM
  Produtos;

-- 📝 Mostrar Nome dos produtos em minúsculas
SELECT
  nome,
  LOWER(nome) AS nome
FROM
  Produtos;
-- 🔢 Mostrar Quantidade de letras no nome do produto
 SELECT
  nome,
  LENGTH(nome) AS nome
FROM
  Produtos;
-- 🔤 Mostrar as Três primeiras letras do nome do produto
SELECT 
    LEFT(nome, 3) AS primeiras_letras
FROM 
    Produtos;

-- 💵 Mostrar Preço arredondado para o inteiro mais próximo
SELECT 
    ROUND(preco, 0) AS preco_arredondado
FROM 
    Produtos;

-- 📆 Exibir data atual junto com os produtos
SELECT 
    nome,
    NOW() AS data_atual
FROM 
    Produtos;
    
-- AULA 20 --- atividade 07
-- ➕ Adicionar coluna de validade do produto
ALTER TABLE Produtos
ADD COLUMN validade DATE;

-- ️ Aumentar o tamanho do nome do produto
ALTER TABLE Produtos
MODIFY COLUMN nome VARCHAR(100);

-- ❌ Remover a coluna de validade
ALTER TABLE Produtos
DROP COLUMN validade;

-- ➕ Adicionar uma coluna para categoria (ex: "Pães", "Bolos", etc.)
ALTER TABLE Produtos
ADD COLUMN categoria VARCHAR(50);

-- ✏️ Alterar o tipo da coluna Preco para aumentar precisão
ALTER TABLE Produtos
MODIFY COLUMN preco DECIMAL(10,2);

-- 🗑️ Excluir completamente a tabela Produtos
DROP TABLE Produtos;

-- Criar tabela de Fornecedores
CREATE TABLE Fornecedores (
    id_fornecedor INT PRIMARY KEY,
    nome VARCHAR(100)
);

-- Adicionar coluna de Fornecedor na tabela Produtos
ALTER TABLE Produtos
ADD COLUMN id_fornecedor INT,
ADD FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor);

-- Inserir fornecedores
INSERT INTO Fornecedores (id_fornecedor, nome) VALUES
(1, 'Padaria Central'),
(2, 'Doces & Cia'),
(3, 'Forno de Ouro');

-- Atualizar os produtos para associar fornecedores
UPDATE Produtos SET id_fornecedor = 1 WHERE id_produto IN (1,4); -- Pão francês e Sonho
UPDATE Produtos SET id_fornecedor = 2 WHERE id_produto IN (2,6); -- Croissant e Pudim
UPDATE Produtos SET id_fornecedor = 3 WHERE id_produto IN (3,7,8); -- Bolo de cenoura, Pamonha, Pão doce


SELECT P.nome AS Produto, F.nome AS Fornecedor
FROM Produtos P
INNER JOIN Fornecedores F ON P.id_fornecedor = F.id_fornecedor;

SELECT P.nome AS Produto, V.quantidade, V.data
FROM Vendas V
INNER JOIN Produtos P ON V.id_produto = P.id_produto;

SELECT P.nome AS Produto,
       (V.quantidade * P.preco) AS Valor_Total,
       F.nome AS Fornecedor
FROM Vendas V
INNER JOIN Produtos P ON V.id_produto = P.id_produto
INNER JOIN Fornecedores F ON P.id_fornecedor = F.id_fornecedor;


SELECT P.nome AS Produto, P.estoque, F.nome AS Fornecedor
FROM Produtos P
INNER JOIN Fornecedores F ON P.id_fornecedor = F.id_fornecedor
WHERE P.estoque < 30;

SELECT 
    P.nome AS Produto,
    IFNULL(SUM(V.quantidade), 0) AS Total_Vendido
FROM Produtos P
LEFT JOIN Vendas V ON P.id_produto = V.id_produto
GROUP BY P.nome;

SELECT 
    nome AS Produto,
    preco,
    CASE 
        WHEN preco < 5 THEN '🟢 Barato'
        WHEN preco BETWEEN 5 AND 15 THEN '🟡 Intermediário'
        ELSE '🔴 Caro'
    END AS Faixa_Preco
FROM Produtos;
