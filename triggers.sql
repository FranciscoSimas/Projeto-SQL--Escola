DELIMITER //

CREATE TRIGGER AtualizaMediaNota
AFTER INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE Media DECIMAL(5,2);
    SELECT AVG(NotaFinal) INTO Media
    FROM Inscricoes
    WHERE EstudanteID = NEW.EstudanteID;
    
    INSERT INTO NotasMedias (EstudanteID, MediaNotas) 
    VALUES (NEW.EstudanteID, Media)
    ON DUPLICATE KEY UPDATE MediaNotas = Media;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER ImpedeInscricaoDuplicada
BEFORE INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Inscricoes WHERE EstudanteID = NEW.EstudanteID AND TurmaID = NEW.TurmaID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estudante já inscrito nesta turma';
    END IF;
END;
//

DELIMITER ;










-- Trigger para impedir duplicidade na tabela TurmasProfessores
DELIMITER //
CREATE TRIGGER ImpedeDuplicidadeTurmasProfessores
BEFORE INSERT ON TurmasProfessores
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM TurmasProfessores 
        WHERE TurmaID = NEW.TurmaID AND ProfessorID = NEW.ProfessorID
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Professor já atribuído a esta turma';
    END IF;
END;
//
DELIMITER ;

-- Trigger para impedir duplicidade na tabela TurmasDisciplinas
DELIMITER //
CREATE TRIGGER ImpedeDuplicidadeTurmasDisciplinas
BEFORE INSERT ON TurmasDisciplinas
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM TurmasDisciplinas 
        WHERE TurmaID = NEW.TurmaID AND DisciplinaID = NEW.DisciplinaID
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Disciplina já atribuída a esta turma';
    END IF;
END;
//
DELIMITER ;
