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
    - **DisciplinaID**: Identificador da disciplina ministrada na turma (INT, NOT NULL, FOREIGN KEY)
    - **ProfessorID**: Identificador do professor que ministra a turma (INT, NOT NULL, FOREIGN KEY)
    - **AnoLetivo**: Ano letivo da turma (INT, NOT NULL)

5. **Inscricoes**
    - **ID**: Identificador único da inscrição (INT, AUTO_INCREMENT, PRIMARY KEY)
    - **EstudanteID**: Identificador do estudante inscrito (INT, NOT NULL, FOREIGN KEY)
    - **TurmaID**: Identificador da turma em que o estudante está inscrito (INT, NOT NULL, FOREIGN KEY)
    - **NotaFinal**: Nota final do estudante na turma (DECIMAL(5,2), CHECK (NotaFinal BETWEEN 0 AND 100))

6. **NotasMedias**
    - **EstudanteID**: Identificador do estudante (INT, PRIMARY KEY, FOREIGN KEY)
    - **MediaNotas**: Média das notas do estudante (DECIMAL(5,2))

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

## Estrutura da Base de Dados

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
- **Professores e Turmas**: Cada turma pode ser ministrada por um ou mais professores, e a relação é estabelecida através de uma tabela de ligação TurmasProfessores.
- **Disciplinas e Turmas**: Cada turma pode estar associada a uma ou mais disciplinas, e a relação é estabelecida através de uma tabela de ligação TurmasDisciplinas.
- **Inscrições e Turmas**: Cada inscrição está vinculada a uma turma específica.

#### Funcionamento da Inscrição e Cálculo da Nota Média

- Quando um estudante é inscrito em uma turma, uma nova entrada é adicionada à tabela Inscrições com a nota final do estudante para aquela turma.
- A cada nova inscrição ou atualização de nota, a média das notas do estudante é recalculada e atualizada na tabela NotasMedias.
- Caso um estudante se inscreva em múltiplas turmas com notas diferentes, a média refletirá a combinação dessas notas.




Esse fluxo de dados garante que todas as informações relacionadas a estudantes, professores, disciplinas e turmas sejam inseridas e gerenciadas de forma organizada e sem duplicidade, facilitando o controle acadêmico da instituição.
