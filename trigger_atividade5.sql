
CREATE DATABASE gerenciamento_escola;
USE gerenciamento_escola;


CREATE TABLE alunos (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(255),
    data_nascimento DATE,
    serie INT
);


INSERT INTO alunos (id_aluno, nome, data_nascimento, serie)
VALUES
    (1, 'João', '2010-05-15', 5),
    (2, 'Maria', '2009-02-20', 6),
    (3, 'Pedro', '2011-08-10', 4);

CREATE TABLE matriculas (
    id_matricula INT PRIMARY KEY,
    id_aluno INT,
    data_matricula DATE,
    status VARCHAR(50),
    FOREIGN KEY (id_aluno) REFERENCES alunos (id_aluno)
);


DELIMITER //

CREATE TRIGGER before_insert_matricula
BEFORE INSERT ON matriculas
FOR EACH ROW
BEGIN
    DECLARE idade_aluno INT;
    SELECT TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) INTO idade_aluno
    FROM alunos
    WHERE id_aluno = NEW.id_aluno;
    IF idade_aluno < NEW.serie + 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aluno não atende aos requisitos de idade para a série.';
    END IF;
END;

//

DELIMITER ;
