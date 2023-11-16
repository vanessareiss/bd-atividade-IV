
CREATE DATABASE gerenciamento_estoque;
USE gerenciamento_estoque;


CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    quantidade_estoque INT
);


INSERT INTO produtos (id_produto, nome, quantidade_estoque)
VALUES
    (1, 'Smartphone', 20),
    (2, 'Notebook', 15),
    (3, 'Fone de Ouvido', 30);


CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    data_venda DATETIME
);


CREATE TABLE itens_venda (
    id_item_venda INT PRIMARY KEY,
    id_venda INT,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_venda) REFERENCES vendas (id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos (id_produto)
);


DELIMITER //

CREATE TRIGGER before_insert_item_venda
BEFORE INSERT ON itens_venda
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    SELECT quantidade_estoque INTO estoque_atual
    FROM produtos
    WHERE id_produto = NEW.id_produto;
    IF NEW.quantidade > estoque_atual THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Produto fora de estoque. Quantidade disponível: ', estoque_atual);
    END IF;
END;

//

DELIMITER ;
