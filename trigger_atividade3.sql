
CREATE DATABASE recursos_humanos;
USE recursos_humanos;


CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(255),
    cargo VARCHAR(255),
    salario DECIMAL(9,2),
    data_admissao DATE
);

DELIMITER //

CREATE TRIGGER before_insert_funcionario
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    IF NEW.data_admissao <= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A data de admissão deve ser maior que a data atual.';
    END IF;
END;

//

DELIMITER ;
