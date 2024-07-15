### Documentação do Projeto de Gestão Escolar

Este projeto é um sistema de gestão escolar que permite o controle de estudantes, professores, disciplinas, turmas e inscrições. O sistema foi desenvolvido utilizando MySQL para a criação e gestão do banco de dados.

---

## Estrutura do Projeto

O projeto está organizado em diferentes arquivos SQL, cada um responsável por uma parte específica do sistema:

1. **Criação de Tabelas** (`create_tables.sql`)
2. **Triggers** (`triggers.sql`)
3. **Inserção de Dados** (`inserts.sql`)
4. **Consultas SQL** (`queries.sql`)
5. **Stored Procedures** (`stored_procedures.sql`)
6. **Cursor** (`cursor.sql`)

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
        INSERT INTO NotasMedias (EstudanteID, MediaNotas)
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

1. **Instalação do MySQL**
    - Baixe e instale o MySQL a partir do site oficial.
    - Configure o MySQL com um usuário e senha.

2. **Criação do Banco de Dados**
    - Execute o arquivo `create_tables.sql` para criar o banco de dados e as tabelas necessárias.

3. **Configuração dos Triggers**
    - Execute o arquivo `triggers.sql` para criar os triggers.

4. **Inserção de Dados**
    - Execute o arquivo `inserts.sql` para inserir dados de exemplo nas tabelas.

5. **Execução das Stored Procedures**
    - Execute o arquivo `stored_procedures.sql` para criar as stored procedures.

6. **Execução do Cursor**
    - Execute o arquivo `cursor.sql` para criar a stored procedure que utiliza o cursor.

7. **Realização de Consultas**
    - Execute o arquivo `queries.sql` para realizar as consultas e verificar os dados.

8. **Utilização das Stored Procedures**
    - Utilize as stored procedures para registrar inscrições, atualizar dados de estudantes e calcular médias de notas conforme necessário.

---

### Arquivos SQL

1. [create_tables.sql](link_para_o_arquivo)
2. [triggers.sql](link_para_o_arquivo)
3. [inserts.sql](link_para_o_arquivo)
4. [queries.sql](link_para_o_arquivo)
5. [stored_procedures.sql](link_para_o_arquivo)
6. [cursor.sql](link_para_o_arquivo)

---

