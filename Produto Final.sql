-- 1. Componentes do grupo:
-- Giovanny Lino, Gabriel Mastropietro, Pedro Borges, Lucas Moreira, Felipe Julidori, Murilo Galo

-- 2. Criação do banco de dados e tabelas
CREATE DATABASE IF NOT EXISTS pizzaria;
USE pizzaria;

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(150)
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    borda VARCHAR(50) NOT NULL,
    tamanho VARCHAR(50) NOT NULL,
    sabor1 VARCHAR(50) NOT NULL,
    sabor2 VARCHAR(50),
    bebida VARCHAR(50),
    total DECIMAL(10, 2) NOT NULL,
    data_pedido DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    metodo VARCHAR(50) NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);

CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    descricao VARCHAR(200)
);

CREATE TABLE entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    endereco_entrega VARCHAR(150) NOT NULL,
    data_entrega DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(50) DEFAULT 'Pendente',
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);

-- 3. Inserção de no mínimo 5 registros em cada tabela
INSERT INTO clientes (nome, telefone, endereco) VALUES
('João Silva', '1111-1111', 'Rua A, 123'),
('Maria Souza', '2222-2222', 'Rua B, 456'),
('Carlos Lima', '3333-3333', 'Rua C, 789'),
('Ana Oliveira', '4444-4444', 'Rua D, 101'),
('Beatriz Santos', '5555-5555', 'Rua E, 202');

INSERT INTO pedidos (cliente_id, borda, tamanho, sabor1, sabor2, bebida, total) VALUES
(1, 'Catupiry', 'Grande', 'Calabresa', 'Frango', 'Coca-Cola', 45.00),
(2, 'Cheddar', 'Média', 'Mussarela', 'Portuguesa', 'Guaraná', 37.50),
(3, 'Sem Borda', 'Pequena', 'Calabresa', NULL, 'Água', 25.00),
(4, 'Catupiry', 'Grande', 'Frango', NULL, NULL, 40.00),
(5, 'Cheddar', 'Média', 'Mussarela', 'Calabresa', 'Suco', 35.00);

INSERT INTO funcionarios (nome, cargo, salario) VALUES
('Carlos Pereira', 'Atendente', 2500.00),
('Mariana Silva', 'Gerente', 3500.00),
('Júlio Costa', 'Entregador', 1800.00),
('Fernanda Lima', 'Pizzaiolo', 3000.00),
('Roberta Alves', 'Caixa', 2200.00);

INSERT INTO pagamento (pedido_id, metodo, valor_pago) VALUES
(1, 'Cartão de Crédito', 45.00),
(2, 'Dinheiro', 37.50),
(3, 'Pix', 25.00),
(4, 'Cartão de Débito', 40.00),
(5, 'Dinheiro', 35.00);

INSERT INTO produto (nome, preco, descricao) VALUES
('Pizza Calabresa', 30.00, 'Pizza com calabresa e cebola'),
('Pizza Frango com Catupiry', 32.00, 'Pizza com frango desfiado e catupiry'),
('Refrigerante 2L', 8.00, 'Refrigerante de 2 litros'),
('Suco Natural', 7.00, 'Suco de frutas naturais'),
('Sobremesa Brownie', 10.00, 'Brownie de chocolate com sorvete');

INSERT INTO entrega (pedido_id, endereco_entrega, status) VALUES
(1, 'Rua A, 123', 'Entregue'),
(2, 'Rua B, 456', 'Pendente'),
(3, 'Rua C, 789', 'Entregue'),
(4, 'Rua D, 101', 'A Caminho'),
(5, 'Rua E, 202', 'Pendente');

-- 4. Alteração de registro em cada tabela
UPDATE clientes SET telefone = '6666-6666' WHERE id = 5;
UPDATE pedidos SET bebida = 'Fanta' WHERE id = 3;
UPDATE funcionarios SET salario = 3200.00 WHERE id = 4;
UPDATE pagamento SET metodo = 'Pix' WHERE id = 3;
UPDATE produto SET nome = 'Pizza Marguerita' WHERE id = 1;
UPDATE entrega SET endereco_entrega = 'Rua F, 345' WHERE id = 5;

-- 5. Exclusão de registro em cada tabela
DELETE FROM clientes WHERE id = 5;
DELETE FROM pedidos WHERE id = 5;
DELETE FROM funcionarios WHERE id = 5;
DELETE FROM pagamento WHERE id = 5;
DELETE FROM produto WHERE id = 5;
DELETE FROM entrega WHERE id = 5;

-- 6. Alteração da estrutura de uma das tabelas (adicionando coluna 'data_pedido' na tabela 'pedidos')
-- Já incluída na criação da tabela pedidos acima.

-- 7. Conversão dos dados, se necessário
-- (Nenhuma conversão adicional necessária, pois o novo campo 'data_pedido' assume o valor padrão de data atual)

-- 8. Consultas envolvendo uma única tabela
SELECT * FROM clientes WHERE nome LIKE 'João%';
SELECT * FROM pedidos WHERE total > 30;
SELECT * FROM funcionarios WHERE cargo = 'Atendente';
SELECT nome FROM clientes WHERE telefone IS NOT NULL;
SELECT * FROM pedidos WHERE data_pedido = CURDATE();

-- 9. Consultas envolvendo múltiplas tabelas
SELECT clientes.nome, pedidos.total FROM clientes 
JOIN pedidos ON clientes.id = pedidos.cliente_id 
WHERE pedidos.total > 40;

SELECT funcionarios.nome, funcionarios.cargo, pedidos.total FROM funcionarios 
JOIN pedidos ON funcionarios.id = pedidos.id 
WHERE funcionarios.cargo = 'Pizzaiolo';

SELECT clientes.nome, pedidos.sabor1, pedidos.sabor2 FROM clientes 
JOIN pedidos ON clientes.id = pedidos.cliente_id 
WHERE pedidos.tamanho = 'Grande';

SELECT clientes.nome, pedidos.borda FROM clientes 
JOIN pedidos ON clientes.id = pedidos.cliente_id 
WHERE pedidos.borda = 'Cheddar';

SELECT funcionarios.nome, funcionarios.salario FROM funcionarios 
JOIN pedidos ON funcionarios.id = pedidos.id 
WHERE pedidos.bebida = 'Coca-Cola';

-- 10. Criação de uma função
DELIMITER //
CREATE FUNCTION calcular_media_salario()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE media DECIMAL(10,2);
    SELECT AVG(salario) INTO media FROM funcionarios;
    RETURN media;
END //
DELIMITER ;

-- 11. Criação e execução de uma procedure
DELIMITER //
CREATE PROCEDURE atualizar_salario_funcionario(
    IN funcionario_id INT, IN novo_salario DECIMAL(10, 2)
)
BEGIN
    UPDATE funcionarios SET salario = novo_salario WHERE id = funcionario_id;
END //
DELIMITER ;

-- Executando a procedure
CALL atualizar_salario_funcionario(3, 2000.00);

-- 12. Criação de um gatilho
DELIMITER //
CREATE TRIGGER before_pedido_delete
BEFORE DELETE ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO historico_pedidos (pedido_id, cliente_id, data_pedido, total) 
    VALUES (OLD.id, OLD.cliente_id, OLD.data_pedido, OLD.total);
END //
DELIMITER ;

-- 13. Deleção das tabelas e banco de dados
DROP TABLE IF EXISTS entrega;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS funcionarios;
DROP DATABASE IF EXISTS pizzaria;
