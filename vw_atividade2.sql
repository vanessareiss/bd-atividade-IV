CREATE DATABASE sistema;
USE sistema;

create table produtos(
id_produto int primary key,
nome varchar(22),
preco_unitario decimal (9,2),
categoria varchar(22)
);

create table estoque(
id_estoque int primary key,
id_produtos int,
quantidade int,
foreign key (id_produtos) references produtos (id_produto)
);


INSERT INTO produtos (id_produto, nome, preco_unitario, categoria) VALUES 
    (2, 'Copo Térmico', 12.50, 'Utensílio'),
    (3, 'Caneca de Porcelana', 18.75, 'Utensílio'),
    (4, 'Garrafa de Água', 30.00, 'Produto'),
    (5, 'Chaleira Elétrica', 75.90, 'Eletrodoméstico'),
    (6, 'Cafeteira', 120.00, 'Eletrodoméstico');

INSERT INTO estoque (id_estoque, id_produtos, quantidade) VALUES
    (4, 2, 8),
    (5, 3, 20),
    (6, 4, 12),
    (7, 5, 4),
    (8, 6, 10);
    
CREATE VIEW estoque_critico AS
SELECT p.nome AS nome_produto, e.quantidade
FROM produtos p
JOIN estoque e ON p.id_produto = e.id_produtos
WHERE e.quantidade < 10;

SELECT * FROM estoque_critico;