
CREATE DATABASE sistema;
USE sistema;


CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY NOT NULL,
    nome VARCHAR(50),
    cargo VARCHAR(50),
    salario DECIMAL(9,2)
);


CREATE TABLE vendas (
    id_venda INT PRIMARY KEY NOT NULL,
    id_funcionario INT,
    data_venda DATE,
    valor_venda DECIMAL(9,2),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios (id_funcionario)
);


INSERT INTO funcionarios (id_funcionario, nome, cargo, salario)
VALUES
    (1, 'Vanessa', 'Vendedor', 3000.00),
    (2, 'Gabriel', 'Gerente', 5000.00),
    (3, 'Élias', 'Vendedor', 3200.00);


INSERT INTO vendas (id_venda, id_funcionario, data_venda, valor_venda)
VALUES
    (1, 1, '2023-01-05', 1500.00),
    (2, 1, '2023-01-10', 2000.00),
    (3, 2, '2023-02-15', 3000.00),
    (4, 3, '2023-02-20', 1800.00),
    (5, 1, '2023-03-01', 2500.00);


drop database sistema;
CREATE VIEW relatorio_vendas_funcionario AS
SELECT f.nome AS nome_funcionario, COUNT(v.id_venda) AS num_vendas, SUM(v.valor_vendas) AS valor_total_vendas
FROM funcionarios f
LEFT JOIN vendas v ON f.id_funcionario = v.id_funcionario
GROUP BY f.id_funcionario;

SELECT * FROM relatorio_vendas_funcionario;
