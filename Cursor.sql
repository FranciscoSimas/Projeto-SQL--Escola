DELIMITER //

CREATE PROCEDURE RelatorioNotas (
    IN p_AnoInicio INT,
    IN p_AnoFim INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE Estudante VARCHAR(100);
    DECLARE Turma VARCHAR(100);
    DECLARE NotaFinal INT;

    DECLARE cur CURSOR FOR
        SELECT E.Nome AS Estudante, T.Nome AS Turma, I.NotaFinal
        FROM Inscricoes I
        JOIN Estudantes E ON I.EstudanteID = E.ID
        JOIN Turmas T ON I.TurmaID = T.ID
        WHERE T.AnoLetivo BETWEEN p_AnoInicio AND p_AnoFim;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO Estudante, Turma, NotaFinal;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Aqui pode-se inserir a lógica para processar ou armazenar os dados lidos
        SELECT Estudante, Turma, NotaFinal;
    END LOOP;

    CLOSE cur;
END;
//

DELIMITER ;
