-- Listar todos os estudantes inscritos em cada turma
SELECT T.Nome AS Turma, E.Nome AS Estudante
FROM Inscricoes I
JOIN Estudantes E ON I.EstudanteID = E.ID
JOIN Turmas T ON I.TurmaID = T.ID;

-- Listar as turmas ministradas por um determinado professor
SELECT T.Nome AS Turma, P.Nome AS Professor
FROM Turmas T
JOIN Professores P ON T.ProfessorID = P.ID
WHERE P.Nome = 'Ana Oliveira';

-- Listar os estudantes com notas acima de um determinado valor
SELECT E.Nome AS Estudante, I.NotaFinal
FROM Inscricoes I
JOIN Estudantes E ON I.EstudanteID = E.ID
WHERE I.NotaFinal > 85;

-- Listar as disciplinas de um determinado departamento
SELECT D.Nome AS Disciplina, D.Departamento
FROM Disciplinas D
WHERE D.Departamento = 'Matemática';
