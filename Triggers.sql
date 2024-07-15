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
