CREATE DATABASE sistema;
USE sistema;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY NOT NULL,
    nome VARCHAR(22),
    email VARCHAR(22),
    telefone VARCHAR(22)
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY NOT NULL,
    id_clientes INT,
    data_pedido DATE,
    valor_total DECIMAL(9,2),
    FOREIGN KEY (id_clientes) REFERENCES clientes (id_cliente)
);

INSERT INTO clientes (id_cliente, nome, email, telefone)
VALUES
    (1, 'Carla', 'carla@email.com', '(65)9857-9568'),
    (2, 'João', 'joao@email.com', '(85)9658-1235'),
    (3, 'Rafael', 'rafael@email.com', '(23)4587-6325'),
    (4, 'Daniel', 'daniel@email.com', '(74)6598-2314'),
    (5, 'André', 'andre@email.com', '(71)3265-4785');

INSERT INTO pedidos (id_pedido, id_clientes, data_pedido, valor_total)
VALUES
    (1, 1, '2023-01-01', 50.00),
    (2, 1, '2023-02-01', 75.00),
    (3, 3, '2023-02-01', 75.00),
    (4, 1, '2023-02-01', 75.00),
    (5, 2, '2023-03-01', 100.00);

CREATE VIEW relatorio_pedidos_cliente AS
SELECT c.nome AS nome_cliente, COUNT(p.id_pedido) AS num_pedidos, SUM(p.valor_total) AS valor_total_gasto
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_clientes
GROUP BY c.id_cliente;
SELECT * FROM relatorio_pedidos_cliente;
