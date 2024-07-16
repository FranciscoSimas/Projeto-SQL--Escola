CREATE DATABASE Escola3;
USE Escola3;

-- Criação da tabela Estudantes
CREATE TABLE Estudantes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE NOT NULL,
    Ano INT NOT NULL
);

-- Criação da tabela Professores
CREATE TABLE Professores (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Departamento VARCHAR(100) NOT NULL
);

-- Criação da tabela Disciplinas
CREATE TABLE Disciplinas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Departamento VARCHAR(100) NOT NULL
);

-- Criação da tabela Turmas
CREATE TABLE Turmas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DisciplinaID INT NOT NULL,
    ProfessorID INT NOT NULL,
    AnoLetivo INT NOT NULL,
    FOREIGN KEY (DisciplinaID) REFERENCES Disciplinas(ID),
    FOREIGN KEY (ProfessorID) REFERENCES Professores(ID)
);

-- Criação da tabela Inscrições
CREATE TABLE Inscricoes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    EstudanteID INT NOT NULL,
    TurmaID INT NOT NULL,
    NotaFinal INT CHECK (NotaFinal BETWEEN 0 AND 100),
    FOREIGN KEY (EstudanteID) REFERENCES Estudantes(ID),
    FOREIGN KEY (TurmaID) REFERENCES Turmas(ID)
);

-- Criação da tabela NotasMedias
CREATE TABLE NotasMedias (
    EstudanteID INT PRIMARY KEY,
    MediaNotas DECIMAL(5,2),
    FOREIGN KEY (EstudanteID) REFERENCES Estudantes(ID)
);

CREATE TABLE TurmasProfessores (
    TurmaID INT,
    ProfessorID INT,
    PRIMARY KEY (TurmaID, ProfessorID),
    FOREIGN KEY (TurmaID) REFERENCES Turmas(ID),
    FOREIGN KEY (ProfessorID) REFERENCES Professores(ID)
);

CREATE TABLE TurmasDisciplinas (
    TurmaID INT,
    DisciplinaID INT,
    PRIMARY KEY (TurmaID, DisciplinaID),
    FOREIGN KEY (TurmaID) REFERENCES Turmas(ID),
    FOREIGN KEY (DisciplinaID) REFERENCES Disciplinas(ID)
);

