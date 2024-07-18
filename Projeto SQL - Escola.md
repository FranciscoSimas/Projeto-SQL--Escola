## Documentação do Projeto de Gestão Escolar

### Estrutura do Projeto
O projeto está organizado em diferentes arquivos SQL, cada um responsável por uma parte específica do sistema:

1. **Criação de Tabelas** ([create_tables.sql](https://github.com/FranciscoSimas/Projeto-SQL--Escola/blob/main/SQL%20Files/create_tables.sql))
2. **Triggers** ([triggers.sql](https://github.com/FranciscoSimas/Projeto-SQL--Escola/blob/main/SQL%20Files/triggers.sql))
3. **Inserção de Dados** ([inserts.sql](https://github.com/FranciscoSimas/Projeto-SQL--Escola/blob/main/SQL%20Files/inserts.sql))
4. **Consultas SQL** ([queries.sql](https://github.com/FranciscoSimas/Projeto-SQL--Escola/blob/main/SQL%20Files/queries.sql))
5. **Stored Procedures** ([stored_procedures.sql](https://github.com/FranciscoSimas/Projeto-SQL--Escola/blob/main/SQL%20Files/stored_procedures.sql))
6. **Cursor** ([cursor.sql](https://github.com/FranciscoSimas/Projeto-SQL--Escola/blob/main/SQL%20Files/cursor.sql))

---

### Descrição das Tabelas

1. **Estudantes**
    - **ID**: Identificador único do estudante (INT, AUTO_INCREMENT, PRIMARY KEY)
    - **Nome**: Nome do estudante (VARCHAR(100), NOT NULL)
    - **DataNascimento**: Data de nascimento do estudante (DATE, NOT NULL)
    - **Ano**: Ano em que o estudante está matriculado (INT, NOT NULL)

2. **Professores**
    - **ID**: Identificador único do professor (INT, AUTO_INCREMENT, PRIMARY KEY)
    - **Nome**: Nome do professor (VARCHAR(100), NOT NULL)
    - **Departamento**: Departamento ao qual o professor pertence (VARCHAR(100), NOT NULL)

3. **Disciplinas**
    - **ID**: Identificador único da disciplina (INT, AUTO_INCREMENT, PRIMARY KEY)
    - **Nome**: Nome da disciplina (VARCHAR(100), NOT NULL)
    - **Departamento**: Departamento ao qual a disciplina pertence (VARCHAR(100), NOT NULL)

4. **Turmas**
    - **ID**: Identificador único da turma (INT, AUTO_INCREMENT, PRIMARY KEY)
    - **Nome**: Nome da turma (VARCHAR(100), NOT NULL)
    - **AnoLetivo**: Ano letivo da turma (INT, NOT NULL)

5. **Inscricoes**
    - **ID**: Identificador único da inscrição (INT, AUTO_INCREMENT, PRIMARY KEY)
    - **EstudanteID**: Identificador do estudante inscrito (INT, NOT NULL, FOREIGN KEY)
    - **TurmaID**: Identificador da turma em que o estudante está inscrito (INT, NOT NULL, FOREIGN KEY)
    - **NotaFinal**: Nota final do estudante na turma (DECIMAL(5,2), CHECK (NotaFinal BETWEEN 0 AND 100))

6. **NotasMedias**
    - **EstudanteID**: Identificador do estudante (INT, PRIMARY KEY, FOREIGN KEY)
    - **MediaNotas**: Média das notas do estudante (DECIMAL(5,2))

7. **TurmasProfessores**
    - **TurmaID**: Identificador da turma (INT, FOREIGN KEY)
    - **ProfessorID**: Identificador do professor (INT, FOREIGN KEY)
    - **PRIMARY KEY** (TurmaID, ProfessorID)

8. **TurmasDisciplinas**
    - **TurmaID**: Identificador da turma (INT, FOREIGN KEY)
    - **DisciplinaID**: Identificador da disciplina (INT, FOREIGN KEY)
    - **PRIMARY KEY** (TurmaID, DisciplinaID)

---

### Explicação dos Triggers

1. **Trigger AtualizaMediaNota**: Atualiza a média de notas de um estudante após a inserção de uma nova inscrição.
    ```sql
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
    ```

2. **Trigger ImpedeInscricaoDuplicada**: Impede que um estudante se inscreva duas vezes na mesma turma.
    ```sql
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
    ```

3. **Trigger ImpedeProfessorDuplicado**: Impede que um professor seja atribuído mais de uma vez à mesma turma.
    ```sql
    DELIMITER //
    CREATE TRIGGER ImpedeProfessorDuplicado
    BEFORE INSERT ON TurmasProfessores
    FOR EACH ROW
    BEGIN
        IF EXISTS (SELECT 1 FROM TurmasProfessores WHERE TurmaID = NEW.TurmaID AND ProfessorID = NEW.ProfessorID) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Professor já atribuído a esta turma';
        END IF;
    END;
    //
    DELIMITER ;
    ```

4. **Trigger ImpedeDisciplinaDuplicada**: Impede que uma disciplina seja atribuída mais de uma vez à mesma turma.
    ```sql
    DELIMITER //
    CREATE TRIGGER ImpedeDisciplinaDuplicada
    BEFORE INSERT ON TurmasDisciplinas
    FOR EACH ROW
    BEGIN
        IF EXISTS (SELECT 1 FROM TurmasDisciplinas WHERE TurmaID = NEW.TurmaID AND DisciplinaID = NEW.DisciplinaID) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Disciplina já atribuída a esta turma';
        END IF;
    END;
    //
    DELIMITER ;
    ```

---

### Explicação das Stored Procedures

1. **RegistraInscricao**: Registra uma nova inscrição e atualiza a média de notas do estudante.
    ```sql
    DELIMITER //
    CREATE PROCEDURE RegistraInscricao (
        IN p_EstudanteID INT,
        IN p_TurmaID INT,
        IN p_NotaFinal DECIMAL(5,2)
    )
    BEGIN
        DECLARE Media DECIMAL(5,2);
        INSERT INTO Inscricoes (EstudanteID, TurmaID, NotaFinal)
        VALUES (p_EstudanteID, p_TurmaID, p_NotaFinal);
        SELECT AVG(NotaFinal) INTO Media
        FROM Inscricoes
        WHERE EstudanteID = p_EstudanteID;
        INSERT INTO NotasMedias

 (EstudanteID, MediaNotas)
        VALUES (p_EstudanteID, Media)
        ON DUPLICATE KEY UPDATE MediaNotas = Media;
    END;
    //
    DELIMITER ;
    ```

2. **AtualizaEstudante**: Atualiza os dados de um estudante.
    ```sql
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
    ```

3. **CalculaMediaNotas**: Calcula a média de notas de um estudante em um determinado período.
    ```sql
    DELIMITER //
    CREATE PROCEDURE CalculaMediaNotas (
        IN p_EstudanteID INT,
        IN p_AnoInicio INT,
        IN p_AnoFim INT,
        OUT p_MediaNotas DECIMAL(5,2)
    )
    BEGIN
        SELECT AVG(NotaFinal) INTO p_MediaNotas
        FROM Inscricoes
        JOIN Turmas ON Inscricoes.TurmaID = Turmas.ID
        WHERE EstudanteID = p_EstudanteID AND Turmas.AnoLetivo BETWEEN p_AnoInicio AND p_AnoFim;
    END;
    //
    DELIMITER ;
    ```

---

### Explicação do Cursor

**RelatorioNotas**: Gera um relatório que lista todos os estudantes e suas notas finais em cada turma em um determinado período.
```sql
DELIMITER //
CREATE PROCEDURE RelatorioNotas (
    IN p_AnoInicio INT,
    IN p_AnoFim INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE Estudante VARCHAR(100);
    DECLARE Turma VARCHAR(100);
    DECLARE NotaFinal DECIMAL(5,2);
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
END //
DELIMITER ;
```

---


### Instruções para Configurar e Utilizar o Sistema

Este sistema de gestão escolar é projetado para gerenciar informações sobre estudantes, professores, disciplinas, turmas e inscrições. Abaixo, explicamos o funcionamento da base de dados e as relações entre as tabelas.


### Exemplo de Fluxo de Dados Atualizado

1. **Registrar um Estudante**: 
   - Inserir informações na tabela `Estudantes` com detalhes como nome, data de nascimento e ano escolar.

2. **Registrar Professores**: 
   - Inserir dados na tabela `Professores` com informações como nome e departamento a que pertencem.

3. **Registrar Disciplinas**: 
   - Inserir dados na tabela `Disciplinas` com informações como nome e departamento correspondente.

4. **Criar uma Turma**: 
   - Inserir dados na tabela `Turmas`, como nome da turma e ano letivo.

5. **Atribuir Professores a uma Turma**: 
   - Inserir registros na tabela `TurmasProfessores` para associar um ou mais professores à turma recém-criada.

6. **Associar Disciplinas a uma Turma**: 
   - Inserir registros na tabela `TurmasDisciplinas` para associar uma ou mais disciplinas à turma recém-criada.

7. **Inscrever um Estudante em uma Turma**: 
   - Adicionar uma nova inscrição na tabela `Inscricoes` com o ID do estudante, o ID da turma e a nota final do estudante na disciplina associada à turma.
   - O sistema automaticamente recalcula e atualiza a média das notas do estudante na tabela `NotasMedias`.

#### Relações entre as Tabelas

- **Estudantes e Inscrições**: Cada estudante pode se inscrever em várias turmas, e cada inscrição registra a nota final do estudante na turma correspondente.
- **Professores e Turmas**: Cada turma pode ser ministrada por um ou mais professores, e a relação é estabelecida através de uma tabela de ligação `TurmasProfessores`.
- **Disciplinas e Turmas**: Cada turma pode estar associada a uma ou mais disciplinas, e a relação é estabelecida através de uma tabela de ligação `TurmasDisciplinas`.
- **Inscrições e Turmas**: Cada inscrição está vinculada a uma turma específica.

#### Funcionamento da Inscrição e Cálculo da Nota Média

- Quando um estudante é inscrito em uma turma, uma nova entrada é adicionada à tabela `Inscricoes` com a nota final do estudante para aquela turma.
- A cada nova inscrição ou atualização de nota, a média das notas do estudante é recalculada e atualizada na tabela `NotasMedias`.
- Caso um estudante se inscreva em múltiplas turmas com notas diferentes, a média refletirá a combinação dessas notas.

Esse fluxo de dados garante que todas as informações relacionadas a estudantes, professores, disciplinas e turmas sejam inseridas e gerenciadas de forma organizada e sem duplicidade, facilitando o controle acadêmico da instituição.











---

## Testando o Sistema

### Testando Triggers

1. **Trigger AtualizaMediaNota**:
       **Explicação**: 
    - **Resultado Esperado**: A tabela `NotasMedias` deve mostrar a média para o estudante com ID 1.
    ```sql
    -- Inserir um estudante
    INSERT INTO Estudantes (Nome, DataNascimento, Ano) VALUES ('João Silva', '2005-04-10', 10);

    -- Inserir uma turma
    INSERT INTO Turmas (Nome, AnoLetivo) VALUES ('Turma A', 2023);

    -- Inserir uma inscrição (isso deve acionar o trigger)
    INSERT INTO Inscricoes (EstudanteID, TurmaID, NotaFinal) VALUES (1, 1, 85.5);

    -- Verificar se a média foi atualizada
    SELECT * FROM NotasMedias WHERE EstudanteID = 1;
    ```


3. **Trigger ImpedeInscricaoDuplicada**:
       **Explicação**: 
    - **Resultado Esperado**: Um erro deve ser gerado, indicando que o estudante já está inscrito nesta turma.
    ```sql
    -- Tentar inserir a mesma inscrição novamente (isso deve falhar)
    INSERT INTO Inscricoes (EstudanteID, TurmaID, NotaFinal) VALUES (1, 1, 90.0);
    ```


4. **Trigger ImpedeDuplicidadeTurmaProfessor**:
       **Explicação**: 
    - **Resultado Esperado**: Um erro deve ser gerado, impedindo a duplicidade de dados na tabela `TurmasProfessores`.
    ```sql
    -- Inserir um professor
    INSERT INTO Professores (Nome, Departamento) VALUES ('Maria Oliveira', 'Matemática');

    -- Associar o professor à turma
    INSERT INTO TurmasProfessores (TurmaID, ProfessorID) VALUES (1, 1);

    -- Tentar associar o mesmo professor à mesma turma novamente (isso deve falhar)
    INSERT INTO TurmasProfessores (TurmaID, ProfessorID) VALUES (1, 1);
    ```


5. **Trigger ImpedeDuplicidadeTurmaDisciplina**:
       **Explicação**: 
    - **Resultado Esperado**: Um erro deve ser gerado, impedindo a duplicidade de dados na tabela `TurmasDisciplinas`.
    ```sql
    -- Inserir uma disciplina
    INSERT INTO Disciplinas (Nome, Departamento) VALUES ('Matemática Avançada', 'Matemática');

    -- Associar a disciplina à turma
    INSERT INTO TurmasDisciplinas (TurmaID, DisciplinaID) VALUES (1, 1);

    -- Tentar associar a mesma disciplina à mesma turma novamente (isso deve falhar)
    INSERT INTO TurmasDisciplinas (TurmaID, DisciplinaID) VALUES (1, 1);
    ```


### Testando Stored Procedures

1. **RegistraInscricao**:
       **Explicação**: 
    - **Resultado Esperado**: A tabela `Inscricoes` deve mostrar a nova inscrição e a tabela `NotasMedias` deve refletir a média atualizada.
    ```sql
    -- Registrar uma nova inscrição e atualizar a média de notas do estudante
    CALL RegistraInscricao(1, 1, 92.0);

    -- Verificar se a inscrição foi adicionada e a média atualizada
    SELECT * FROM Inscricoes WHERE EstudanteID = 1;
    SELECT * FROM NotasMedias WHERE EstudanteID = 1;
    ```


3. **AtualizaEstudante**:
       **Explicação**: 
    - **Resultado Esperado**: A tabela `Estudantes` deve mostrar os dados atualizados para o estudante com ID 1.
    ```sql
    -- Atualizar os dados de um estudante
    CALL AtualizaEstudante(1, 'João Pedro Silva', '2005-04-10', 11);

    -- Verificar se os dados foram atualizados
    SELECT * FROM Estudantes WHERE ID = 1;
    ```


4. **CalculaMediaNotas**:
       **Explicação**: 
    - **Resultado Esperado**: O valor da média calculada deve ser retornado na variável `@media`.
    ```sql
    -- Calcular a média de notas de um estudante em um determinado período
    CALL CalculaMediaNotas(1, 2023, 2024, @media);
    SELECT @media;
    ```


### Testando Cursor

1. **RelatorioNotas**:
       **Explicação**: 
    - **Resultado Esperado**: O relatório deve listar todos os estudantes e suas notas finais em cada turma no período especificado.
    ```sql
    -- Gerar um relatório de notas
    CALL RelatorioNotas(2023, 2024);
    ```



