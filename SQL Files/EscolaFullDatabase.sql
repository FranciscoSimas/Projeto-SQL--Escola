CREATE DATABASE  IF NOT EXISTS `Escola3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `Escola3`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 3.220.238.84    Database: Escola3
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Disciplinas`
--

DROP TABLE IF EXISTS `Disciplinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Disciplinas` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Departamento` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Disciplinas`
--

LOCK TABLES `Disciplinas` WRITE;
/*!40000 ALTER TABLE `Disciplinas` DISABLE KEYS */;
INSERT INTO `Disciplinas` VALUES (1,'Álgebra','Matemática'),(2,'Cálculo','Matemática'),(3,'Geometria','Matemática'),(4,'Estatística','Matemática'),(5,'História Antiga','História'),(6,'História Medieval','História'),(7,'História Moderna','História'),(8,'História Contemporânea','História'),(9,'Física Clássica','Física'),(10,'Física Moderna','Física'),(11,'Mecânica','Física'),(12,'Termodinâmica','Física'),(13,'Química Geral','Química'),(14,'Química Orgânica','Química'),(15,'Química Inorgânica','Química'),(16,'Bioquímica','Química');
/*!40000 ALTER TABLE `Disciplinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estudantes`
--

DROP TABLE IF EXISTS `Estudantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Estudantes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `DataNascimento` date NOT NULL,
  `Ano` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estudantes`
--

LOCK TABLES `Estudantes` WRITE;
/*!40000 ALTER TABLE `Estudantes` DISABLE KEYS */;
INSERT INTO `Estudantes` VALUES (1,'João Pedro Silva','2005-03-15',10),(2,'Maria Souza','2004-07-22',10),(3,'Carlos Mendes','2006-01-10',8),(4,'Ana Pereira','2005-12-30',9),(5,'Paulo Costa','2004-05-25',10),(6,'Laura Oliveira','2006-02-17',8),(7,'Mariana Rocha','2005-06-13',9),(8,'Ricardo Almeida','2004-11-28',10),(9,'Fernanda Dias','2006-07-21',8),(10,'Guilherme Lima','2005-08-14',9),(11,'Estudante 11','2006-01-01',8),(12,'Estudante 12','2005-01-02',9),(13,'Estudante 13','2004-01-03',10),(14,'Estudante 14','2006-01-04',8),(15,'Estudante 15','2005-01-05',9),(16,'Estudante 16','2004-01-06',10),(17,'Estudante 17','2006-01-07',8),(18,'Estudante 18','2005-01-08',9),(19,'Estudante 19','2004-01-09',10),(20,'Estudante 20','2006-01-10',8),(21,'Estudante 21','2005-01-11',9),(22,'Estudante 22','2004-01-12',10),(23,'Estudante 23','2006-01-13',8),(24,'Estudante 24','2005-01-14',9),(25,'Estudante 25','2004-01-15',10),(26,'Estudante 26','2006-01-16',8),(27,'Estudante 27','2005-01-17',9),(28,'Estudante 28','2004-01-18',10),(29,'Estudante 29','2006-01-19',8),(30,'Estudante 30','2005-01-20',9),(31,'Estudante 31','2004-01-21',10),(32,'Estudante 32','2006-01-22',8),(33,'Estudante 33','2005-01-23',9),(34,'Estudante 34','2004-01-24',10),(35,'Estudante 35','2006-01-25',8),(36,'Estudante 36','2005-01-26',9),(37,'Estudante 37','2004-01-27',10),(38,'Estudante 38','2006-01-28',8),(39,'Estudante 39','2005-01-29',9),(40,'Estudante 40','2004-01-30',10);
/*!40000 ALTER TABLE `Estudantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inscricoes`
--

DROP TABLE IF EXISTS `Inscricoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inscricoes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EstudanteID` int NOT NULL,
  `TurmaID` int NOT NULL,
  `NotaFinal` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `EstudanteID` (`EstudanteID`),
  KEY `TurmaID` (`TurmaID`),
  CONSTRAINT `Inscricoes_ibfk_1` FOREIGN KEY (`EstudanteID`) REFERENCES `Estudantes` (`ID`),
  CONSTRAINT `Inscricoes_ibfk_2` FOREIGN KEY (`TurmaID`) REFERENCES `Turmas` (`ID`),
  CONSTRAINT `Inscricoes_chk_1` CHECK ((`NotaFinal` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inscricoes`
--

LOCK TABLES `Inscricoes` WRITE;
/*!40000 ALTER TABLE `Inscricoes` DISABLE KEYS */;
INSERT INTO `Inscricoes` VALUES (1,1,1,85),(2,2,1,78),(3,3,1,92),(4,4,1,74),(5,5,1,88),(6,6,1,91),(7,7,1,76),(8,8,1,80),(9,9,1,87),(10,10,1,82),(11,11,2,90),(12,12,2,84),(13,13,2,79),(14,14,2,85),(15,15,2,93),(16,16,2,77),(17,17,2,88),(18,18,2,81),(19,19,2,89),(20,20,2,92),(21,21,3,83),(22,22,3,90),(23,23,3,86),(24,24,3,78),(25,25,3,89),(26,26,3,91),(27,27,3,84),(28,28,3,92),(29,29,3,87),(30,30,3,81),(31,31,4,85),(32,32,4,78),(33,33,4,92),(34,34,4,74),(35,35,4,88),(36,36,4,91),(37,37,4,76),(38,38,4,80),(39,39,4,87),(40,40,4,82),(42,1,4,88);
/*!40000 ALTER TABLE `Inscricoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `ImpedeInscricaoDuplicada` BEFORE INSERT ON `Inscricoes` FOR EACH ROW BEGIN
    IF EXISTS (SELECT 1 FROM Inscricoes WHERE EstudanteID = NEW.EstudanteID AND TurmaID = NEW.TurmaID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estudante já inscrito nesta turma';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `AtualizaMediaNota` AFTER INSERT ON `Inscricoes` FOR EACH ROW BEGIN
    DECLARE Media DECIMAL(5,2);
    SELECT AVG(NotaFinal) INTO Media
    FROM Inscricoes
    WHERE EstudanteID = NEW.EstudanteID;
    
    INSERT INTO NotasMedias (EstudanteID, MediaNotas) 
    VALUES (NEW.EstudanteID, Media)
    ON DUPLICATE KEY UPDATE MediaNotas = Media;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `NotasMedias`
--

DROP TABLE IF EXISTS `NotasMedias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NotasMedias` (
  `EstudanteID` int NOT NULL,
  `MediaNotas` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`EstudanteID`),
  CONSTRAINT `NotasMedias_ibfk_1` FOREIGN KEY (`EstudanteID`) REFERENCES `Estudantes` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NotasMedias`
--

LOCK TABLES `NotasMedias` WRITE;
/*!40000 ALTER TABLE `NotasMedias` DISABLE KEYS */;
INSERT INTO `NotasMedias` VALUES (1,86.50),(2,78.00),(3,92.00),(4,74.00),(5,88.00),(6,91.00),(7,76.00),(8,80.00),(9,87.00),(10,82.00),(11,90.00),(12,84.00),(13,79.00),(14,85.00),(15,93.00),(16,77.00),(17,88.00),(18,81.00),(19,89.00),(20,92.00),(21,83.00),(22,90.00),(23,86.00),(24,78.00),(25,89.00),(26,91.00),(27,84.00),(28,92.00),(29,87.00),(30,81.00),(31,85.00),(32,78.00),(33,92.00),(34,74.00),(35,88.00),(36,91.00),(37,76.00),(38,80.00),(39,87.00),(40,82.00);
/*!40000 ALTER TABLE `NotasMedias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Professores`
--

DROP TABLE IF EXISTS `Professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Professores` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Departamento` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Professores`
--

LOCK TABLES `Professores` WRITE;
/*!40000 ALTER TABLE `Professores` DISABLE KEYS */;
INSERT INTO `Professores` VALUES (1,'Carlos Santos','Matemática'),(2,'Ana Oliveira','História'),(3,'Beatriz Lima','Física'),(4,'Diogo Martins','Química'),(5,'Eduarda Silva','Biologia'),(6,'Fábio Ferreira','Português'),(7,'Gabriela Costa','Geografia'),(8,'Hugo Almeida','Inglês'),(9,'Isabela Rocha','Educação Física'),(10,'Jorge Dias','Artes');
/*!40000 ALTER TABLE `Professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Turmas`
--

DROP TABLE IF EXISTS `Turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Turmas` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `DisciplinaID` int NOT NULL,
  `ProfessorID` int NOT NULL,
  `AnoLetivo` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `DisciplinaID` (`DisciplinaID`),
  KEY `ProfessorID` (`ProfessorID`),
  CONSTRAINT `Turmas_ibfk_1` FOREIGN KEY (`DisciplinaID`) REFERENCES `Disciplinas` (`ID`),
  CONSTRAINT `Turmas_ibfk_2` FOREIGN KEY (`ProfessorID`) REFERENCES `Professores` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Turmas`
--

LOCK TABLES `Turmas` WRITE;
/*!40000 ALTER TABLE `Turmas` DISABLE KEYS */;
INSERT INTO `Turmas` VALUES (1,'Turma A',1,1,2024),(2,'Turma B',2,2,2024),(3,'Turma C',3,3,2024),(4,'Turma D',4,4,2024);
/*!40000 ALTER TABLE `Turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TurmasDisciplinas`
--

DROP TABLE IF EXISTS `TurmasDisciplinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TurmasDisciplinas` (
  `TurmaID` int NOT NULL,
  `DisciplinaID` int NOT NULL,
  PRIMARY KEY (`TurmaID`,`DisciplinaID`),
  KEY `DisciplinaID` (`DisciplinaID`),
  CONSTRAINT `TurmasDisciplinas_ibfk_1` FOREIGN KEY (`TurmaID`) REFERENCES `Turmas` (`ID`),
  CONSTRAINT `TurmasDisciplinas_ibfk_2` FOREIGN KEY (`DisciplinaID`) REFERENCES `Disciplinas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TurmasDisciplinas`
--

LOCK TABLES `TurmasDisciplinas` WRITE;
/*!40000 ALTER TABLE `TurmasDisciplinas` DISABLE KEYS */;
INSERT INTO `TurmasDisciplinas` VALUES (1,1),(2,2),(1,5),(3,5),(4,5),(2,6),(1,9),(4,9),(2,10),(4,10),(3,13),(3,14);
/*!40000 ALTER TABLE `TurmasDisciplinas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `ImpedeDuplicidadeTurmasDisciplinas` BEFORE INSERT ON `TurmasDisciplinas` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1 FROM TurmasDisciplinas 
        WHERE TurmaID = NEW.TurmaID AND DisciplinaID = NEW.DisciplinaID
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Disciplina já atribuída a esta turma';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `TurmasProfessores`
--

DROP TABLE IF EXISTS `TurmasProfessores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TurmasProfessores` (
  `TurmaID` int NOT NULL,
  `ProfessorID` int NOT NULL,
  PRIMARY KEY (`TurmaID`,`ProfessorID`),
  KEY `ProfessorID` (`ProfessorID`),
  CONSTRAINT `TurmasProfessores_ibfk_1` FOREIGN KEY (`TurmaID`) REFERENCES `Turmas` (`ID`),
  CONSTRAINT `TurmasProfessores_ibfk_2` FOREIGN KEY (`ProfessorID`) REFERENCES `Professores` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TurmasProfessores`
--

LOCK TABLES `TurmasProfessores` WRITE;
/*!40000 ALTER TABLE `TurmasProfessores` DISABLE KEYS */;
INSERT INTO `TurmasProfessores` VALUES (1,1),(3,1),(1,2),(2,3),(2,4),(1,5),(1,6),(4,6);
/*!40000 ALTER TABLE `TurmasProfessores` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `ImpedeDuplicidadeTurmasProfessores` BEFORE INSERT ON `TurmasProfessores` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1 FROM TurmasProfessores 
        WHERE TurmaID = NEW.TurmaID AND ProfessorID = NEW.ProfessorID
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Professor já atribuído a esta turma';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'Escola3'
--

--
-- Dumping routines for database 'Escola3'
--
/*!50003 DROP PROCEDURE IF EXISTS `AtualizaEstudante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `AtualizaEstudante`(
    IN p_ID INT,
    IN p_Nome VARCHAR(100),
    IN p_DataNascimento DATE,
    IN p_Ano INT
)
BEGIN
    UPDATE Estudantes
    SET Nome = p_Nome, DataNascimento = p_DataNascimento, Ano = p_Ano
    WHERE ID = p_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalculaMediaNotas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `CalculaMediaNotas`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistraInscricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `RegistraInscricao`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RelatorioNotas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `RelatorioNotas`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-16 11:18:55
