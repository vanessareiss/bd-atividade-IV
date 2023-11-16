CREATE DATABASE sistema;
USE sistema;

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY NOT NULL,
    nome_categoria VARCHAR(50),
    descricao VARCHAR(255)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY NOT NULL,
    nome VARCHAR(50),
    preco_unitario DECIMAL(9,2),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

INSERT INTO categorias (id_categoria, nome_categoria, descricao)
VALUES
    (1, 'Eletrônicos', 'Produtos eletrônicos e tecnológicos'),
    (2, 'Roupas', 'Vestuário e acessórios'),
    (3, 'Alimentos', 'Produtos alimentícios');

INSERT INTO produtos (id_produto, nome, preco_unitario, id_categoria)
VALUES
    (1, 'Smartphone', 999.99, 1),
    (2, 'Camiseta', 19.99, 2),
    (3, 'Notebook', 1499.99, 1),
    (4, 'Calça Jeans', 39.99, 2),
    (5, 'Chocolate', 3.99, 3);

CREATE VIEW relatorio_produtos_categoria AS
SELECT c.nome_categoria AS nome_categoria, COUNT(p.id_produto) AS quantidade_produtos
FROM categorias c
LEFT JOIN produtos p ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria;

-- Consulta na view
SELECT * FROM relatorio_produtos_categoria;
