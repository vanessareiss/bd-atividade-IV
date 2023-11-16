CREATE DATABASE sistema;
USE sistema;


CREATE TABLE clientes (
    id_clientes INT PRIMARY KEY NOT NULL,
    nome VARCHAR(50),
    endereco VARCHAR(255),
    cidade VARCHAR(255)	
);

CREATE TABLE pagamentos (
    id_pagamentos INT PRIMARY KEY NOT NULL,
    data_pagamento date,
    valor_pagamento DECIMAL(9,2),
    id_clientes INT,
    FOREIGN KEY (id_clientes) REFERENCES clientes (id_clientes)
);

INSERT INTO clientes (id_clientes, nome, endereco, cidade)
VALUES
    (1, 'joão', 'Rua A, 123', 'Cidade A'),
    (2, 'Guilher', 'Rua B, 456', 'Cidade B'),
    (3, 'Rafael', 'Rua C, 789', 'Cidade C'),
    (4, 'Jéssica', 'Rua D, 101', 'Cidade D'),
    (5, 'Marlon', 'Rua E, 112', 'Cidade E');

INSERT INTO pagamentos (id_pagamentos, data_pagamento, valor_pagamento, id_clientes)
VALUES
    (1, '2023-01-01', 100.00, 1),
    (2, '2023-02-01', 150.00, 2),
    (3, '2023-03-01', 200.00, 3),
    (4, '2023-04-01', 120.00, 4),
    (5, '2023-05-01', 180.00, 5);

CREATE VIEW relatorio_pagamentos_cidade AS
SELECT c.cidade AS nome_cidade, COALESCE(SUM(p.valor_pagamento), 0) AS valor_total_pagamentos
FROM clientes c
LEFT JOIN pagamentos p ON c.id_cliente = p.id_clientes
GROUP BY c.cidade;
SELECT * FROM relatorio_pagamentos_cidade;
