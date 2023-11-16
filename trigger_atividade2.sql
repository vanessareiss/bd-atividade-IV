-- Criar o banco de dados
CREATE DATABASE financas_pessoais;
USE financas_pessoais;

-- Criar a tabela "contas"
CREATE TABLE contas (
    id_conta INT PRIMARY KEY,
    nome VARCHAR(255),
    saldo DECIMAL(9,2)
);

-- Inserir alguns dados na tabela "contas"
INSERT INTO contas (id_conta, nome, saldo)
VALUES
    (1, 'Conta Corrente', 5000.00),
    (2, 'Poupança', 10000.00),
    (3, 'Investimento', 15000.00);

-- Criar a tabela "transacoes"
CREATE TABLE transacoes (
    id_transacao INT PRIMARY KEY,
    id_conta INT,
    tipo VARCHAR(50),
    valor DECIMAL(9,2),
    FOREIGN KEY (id_conta) REFERENCES contas (id_conta)
);

-- Criar o trigger
DELIMITER //

CREATE TRIGGER after_insert_transacao
AFTER INSERT ON transacoes
FOR EACH ROW
BEGIN
    DECLARE valor_transacao DECIMAL(9,2);

    -- Obter o valor da nova transação
    SELECT valor INTO valor_transacao FROM transacoes WHERE id_transacao = NEW.id_transacao;

    -- Atualizar o saldo da conta correspondente
    UPDATE contas
    SET saldo = CASE
        WHEN NEW.tipo = 'entrada' THEN saldo + valor_transacao
        WHEN NEW.tipo = 'saida' THEN saldo - valor_transacao
        ELSE saldo
    END
    WHERE id_conta = NEW.id_conta;
END;

//

DELIMITER ;
