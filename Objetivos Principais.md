## Sistema de Gestão de Escola

### Objetivo
Desenvolver um sistema de gestão de uma escola que permita o controle de estudantes, professores, disciplinas, turmas e inscrições.

---

### Requisitos do Projeto

#### 1. Desenho da Base de Dados
- **Ferramenta Sugerida**: MySQL Workbench, Draw.io, etc.
- **Objetivo**: Criar o diagrama ER (Entidade-Relacionamento) que define as tabelas e seus relacionamentos.

#### 2. Criação da Base de Dados
- **Tabelas Necessárias**:
  - **Estudantes**
    - ID
    - Nome 
    - DataNascimento 
    - Ano 
  - **Professores**
    - ID 
    - Nome 
    - Departamento 
  - **Disciplinas**
    - ID 
    - Nome 
    - Departamento 
  - **Turmas**
    - ID 
    - Nome 
    - DisciplinaID 
    - ProfessorID 
    - AnoLetivo 
  - **Inscrições**
    - ID 
    - EstudanteID 
    - TurmaID 
    - NotaFinal 

#### 3. Inserção de Dados
- **Objetivo**: Inserir dados de exemplo para testar o sistema.

#### 4. Consultas SQL
- **Questões a Responder**:
  - Listar todos os estudantes inscritos em cada turma.
  - Listar as turmas ministradas por um determinado professor.
  - Listar os estudantes com notas acima de um determinado valor.
  - Listar as disciplinas de um determinado departamento.

#### 5. Triggers
- **Objetivo**: Criar triggers para:
  - Atualizar a média de notas do estudante após a inserção de uma nova inscrição.
  - Impedir a inscrição de um estudante numa turma se já estiver inscrito.

#### 6. Stored Procedures
- **Objetivo**: Criar stored procedures para:
  - Registrar uma nova inscrição.
  - Atualizar os dados de um estudante.
  - Calcular a média de notas de um estudante num determinado período.

#### 7. Cursores
- **Objetivo**: Utilizar cursores para:
  - Gerar um relatório que lista todos os estudantes e as suas notas finais em cada turma num determinado período.

#### 8. Documentação
- **Conteúdo**:
  - Descrição das tabelas e seus campos.
  - Explicação dos triggers, stored procedures e cursores criados.
  - Instruções para configurar e utilizar o sistema.

#### 9. Entregáveis
- Diagrama ER da base de dados.
- Scripts SQL para criação das tabelas.
- Scripts SQL para inserção de dados de exemplo.
- Consultas SQL.
- Triggers.
- Stored Procedures.
- Cursores.
- Documentação do projeto.

#### 10. Avaliação
- **Critérios**:
  - Correção e completude do diagrama ER.
  - Estrutura e normalização da base de dados.
  - Funcionalidade e correção das consultas SQL.
  - Implementação correta dos triggers, stored procedures e cursores.
  - Qualidade e clareza da documentação.

---
