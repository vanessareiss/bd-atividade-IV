
CREATE DATABASE biblioteca;
USE biblioteca;


CREATE TABLE livros (
    id_livro INT PRIMARY KEY,
    titulo VARCHAR(255),
    autor VARCHAR(255),
    quantidade_estoque INT
);


INSERT INTO livros (id_livro, titulo, autor, quantidade_estoque)
VALUES
    (1, 'Dom Casmurro', 'Machado de Assis', 5),
    (2, '1984', 'George Orwell', 10),
    (3, 'Cem Anos de Solidão', 'Gabriel Garcia Márquez', 7);


CREATE TABLE emprestimos (
    id_emprestimo INT PRIMARY KEY,
    id_livro INT,
    data_emprestimo DATETIME,
    data_devolucao DATETIME,
    FOREIGN KEY (id_livro) REFERENCES livros (id_livro)
);


DELIMITER //

CREATE TRIGGER after_insert_emprestimo
AFTER INSERT ON emprestimos
FOR EACH ROW
BEGIN
    UPDATE livros
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE id_livro = NEW.id_livro;
END;

//

DELIMITER ;
