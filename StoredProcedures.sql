DELIMITER //

CREATE PROCEDURE RegistraInscricao (
    IN p_EstudanteID INT,
    IN p_TurmaID INT,
    IN p_NotaFinal DECIMAL(5,2)
)
BEGIN
    -- Declarar a variável Media
    DECLARE Media DECIMAL(5,2);

    -- Inserir a inscrição
    INSERT INTO Inscricoes (EstudanteID, TurmaID, NotaFinal)
    VALUES (p_EstudanteID, p_TurmaID, p_NotaFinal);

    -- Calcular a média de notas do estudante
    SELECT AVG(NotaFinal) INTO Media
    FROM Inscricoes
    WHERE EstudanteID = p_EstudanteID;

    -- Atualizar a tabela NotasMedias
    INSERT INTO NotasMedias (EstudanteID, MediaNotas)
    VALUES (p_EstudanteID, Media)
    ON DUPLICATE KEY UPDATE MediaNotas = Media;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE AtualizaEstudante (
    IN p_ID INT,
    IN p_Nome VARCHAR(100),
    IN p_DataNascimento DATE,
    IN p_Ano INT
)
BEGIN
    UPDATE Estudantes
    SET Nome = p_Nome, DataNascimento = p_DataNascimento, Ano = p_Ano
    WHERE ID = p_ID;
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE CalculaMediaNotas (
    IN p_EstudanteID INT,
    IN p_AnoInicio INT,
    IN p_AnoFim INT,
    OUT p_MediaNotas DECIMAL(5,2)
)
BEGIN
    SELECT AVG(NotaFinal) INTO p_MediaNotas
    FROM Inscricoes I
    JOIN Turmas T ON I.TurmaID = T.ID
    WHERE I.EstudanteID = p_EstudanteID
      AND T.AnoLetivo BETWEEN p_AnoInicio AND p_AnoFim;
END;
//

DELIMITER ;

