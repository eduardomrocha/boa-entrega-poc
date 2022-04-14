-- MySQL dump 10.13  Distrib 8.0.28, for macos12.2 (x86_64)
--
-- Host: 127.0.0.1    Database: sistemagestaoentregas
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `centro_distribuicao`
--

DROP TABLE IF EXISTS `centro_distribuicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centro_distribuicao` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `localizacao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_distribuicao`
--

LOCK TABLES `centro_distribuicao` WRITE;
/*!40000 ALTER TABLE `centro_distribuicao` DISABLE KEYS */;
INSERT INTO `centro_distribuicao` VALUES (1,'CD Foz','Foz do Iguaçu'),(2,'CD Casc','Cascavel'),(3,'CD Marin','Maringa'),(4,'CD Lond','Londrina'),(5,'CD CWB','Curitiba'),(6,'CD SP','São Paulo');
/*!40000 ALTER TABLE `centro_distribuicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `parceira` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'Boa Entrega',0),(2,'Empresa Teste 2',1),(3,'Empresa Teste',1);
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega` (
  `id` int NOT NULL,
  `id_centro_distribuicao_atual` int DEFAULT NULL,
  `destinatario` varchar(255) DEFAULT NULL,
  `destino` varchar(255) DEFAULT NULL,
  `id_rota` int DEFAULT NULL,
  `id_status_entrega` int DEFAULT NULL,
  `id_empresa` int DEFAULT NULL,
  `codigo_barras` bigint DEFAULT NULL,
  `data_entrega` datetime DEFAULT NULL,
  `valor_cobranca` decimal(10,0) DEFAULT NULL,
  `id_tipo_cobranca` int DEFAULT NULL,
  `cte` varchar(255) DEFAULT NULL,
  `id_status_cobranca` int DEFAULT NULL,
  `volume` decimal(10,0) DEFAULT NULL,
  `prazo_entrega` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_status_entrega` (`id_status_entrega`),
  KEY `id_empresa_parceira` (`id_empresa`),
  KEY `id_tipo_cobranca` (`id_tipo_cobranca`),
  KEY `id_status_cobranca` (`id_status_cobranca`),
  KEY `id_rota` (`id_rota`),
  KEY `id_centro_distribuicao_atual` (`id_centro_distribuicao_atual`),
  CONSTRAINT `entrega_ibfk_1` FOREIGN KEY (`id_status_entrega`) REFERENCES `status_entrega` (`id`),
  CONSTRAINT `entrega_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  CONSTRAINT `entrega_ibfk_3` FOREIGN KEY (`id_tipo_cobranca`) REFERENCES `tipo_cobranca` (`id`),
  CONSTRAINT `entrega_ibfk_4` FOREIGN KEY (`id_status_cobranca`) REFERENCES `status_cobranca` (`id`),
  CONSTRAINT `entrega_ibfk_5` FOREIGN KEY (`id_rota`) REFERENCES `rota` (`id`),
  CONSTRAINT `entrega_ibfk_6` FOREIGN KEY (`id_centro_distribuicao_atual`) REFERENCES `centro_distribuicao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega`
--

LOCK TABLES `entrega` WRITE;
/*!40000 ALTER TABLE `entrega` DISABLE KEYS */;
INSERT INTO `entrega` VALUES (1,6,'Cliente 1','São Paulo',1,2,2,812730941723,'2022-01-13 00:00:00',50,1,'https://sge.boaentrega.com.br/files/cte01.pdf',1,1,3),(2,5,'Cliente 2','São Paulo',2,2,2,192803749823,'2022-01-14 00:00:00',100,2,'https://sge.boaentrega.com.br/files/cte02.pdf',1,2,3),(3,1,'Cliente 3','Curitiba',3,1,2,29384103240,'2022-01-16 00:00:00',100,3,'https://sge.boaentrega.com.br/files/cte03.pdf',2,2,2),(4,4,'Cliente 4','Curitiba',4,2,3,9384739071493,'2022-01-14 00:00:00',50,3,'https://sge.boaentrega.com.br/files/cte04.pdf',2,1,3),(5,1,'Cliente 5 ','Curitiba',4,1,3,19823749801237,'2022-01-15 00:00:00',150,3,'https://sge.boaentrega.com.br/files/cte05.pdf',2,3,3);
/*!40000 ALTER TABLE `entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `no_rota`
--

DROP TABLE IF EXISTS `no_rota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `no_rota` (
  `id_centro_distribuicao` int DEFAULT NULL,
  `id_rota` int DEFAULT NULL,
  KEY `id_rota` (`id_rota`),
  KEY `id_centro_distribuicao` (`id_centro_distribuicao`),
  CONSTRAINT `no_rota_ibfk_1` FOREIGN KEY (`id_rota`) REFERENCES `rota` (`id`),
  CONSTRAINT `no_rota_ibfk_2` FOREIGN KEY (`id_centro_distribuicao`) REFERENCES `centro_distribuicao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `no_rota`
--

LOCK TABLES `no_rota` WRITE;
/*!40000 ALTER TABLE `no_rota` DISABLE KEYS */;
INSERT INTO `no_rota` VALUES (1,1),(2,1),(3,1),(4,1),(6,1),(1,2),(2,2),(5,2),(6,2),(1,3),(2,3),(5,3),(1,4),(2,4),(3,4),(4,4),(5,4);
/*!40000 ALTER TABLE `no_rota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissao`
--

DROP TABLE IF EXISTS `permissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissao`
--

LOCK TABLES `permissao` WRITE;
/*!40000 ALTER TABLE `permissao` DISABLE KEYS */;
INSERT INTO `permissao` VALUES (1,'fornecedores'),(2,'colaborador'),(3,'cliente');
/*!40000 ALTER TABLE `permissao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rota`
--

DROP TABLE IF EXISTS `rota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rota` (
  `id` int NOT NULL,
  `origem` varchar(255) DEFAULT NULL,
  `destino` varchar(255) DEFAULT NULL,
  `prazo_entrega` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rota`
--

LOCK TABLES `rota` WRITE;
/*!40000 ALTER TABLE `rota` DISABLE KEYS */;
INSERT INTO `rota` VALUES (1,'Foz do Iguaçu','São Paulo',3),(2,'Foz do Iguaçu','São Paulo',3),(3,'Foz do Iguaçu','Curitiba',2),(4,'Foz do Iguaçu','Curitiba',3);
/*!40000 ALTER TABLE `rota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_cobranca`
--

DROP TABLE IF EXISTS `status_cobranca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_cobranca` (
  `id` int NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_cobranca`
--

LOCK TABLES `status_cobranca` WRITE;
/*!40000 ALTER TABLE `status_cobranca` DISABLE KEYS */;
INSERT INTO `status_cobranca` VALUES (1,'Pago'),(2,'Pendente');
/*!40000 ALTER TABLE `status_cobranca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_entrega`
--

DROP TABLE IF EXISTS `status_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_entrega` (
  `id` int NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_entrega`
--

LOCK TABLES `status_entrega` WRITE;
/*!40000 ALTER TABLE `status_entrega` DISABLE KEYS */;
INSERT INTO `status_entrega` VALUES (1,'Postado'),(2,'Enviado'),(3,'Entregue');
/*!40000 ALTER TABLE `status_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_cobranca`
--

DROP TABLE IF EXISTS `tipo_cobranca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_cobranca` (
  `id` int NOT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_cobranca`
--

LOCK TABLES `tipo_cobranca` WRITE;
/*!40000 ALTER TABLE `tipo_cobranca` DISABLE KEYS */;
INSERT INTO `tipo_cobranca` VALUES (1,'Crédito'),(2,'Débito'),(3,'Boleto');
/*!40000 ALTER TABLE `tipo_cobranca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_veiculo`
--

DROP TABLE IF EXISTS `tipo_veiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_veiculo` (
  `id` int NOT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_veiculo`
--

LOCK TABLES `tipo_veiculo` WRITE;
/*!40000 ALTER TABLE `tipo_veiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_veiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `id_permissao` int DEFAULT NULL,
  `id_empresa` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_permissao` (`id_permissao`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_permissao`) REFERENCES `permissao` (`id`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Usuario 1','usuario1@mail.com',3,3),(2,'Usuario 2','usuario2@mail.com',3,2),(3,'Usuario 3','usuario3@mail.com',2,1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculo`
--

DROP TABLE IF EXISTS `veiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veiculo` (
  `id` int NOT NULL,
  `id_tipo_veiculo` int DEFAULT NULL,
  `volume_total` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_tipo_veiculo` (`id_tipo_veiculo`),
  CONSTRAINT `veiculo_ibfk_1` FOREIGN KEY (`id_tipo_veiculo`) REFERENCES `tipo_veiculo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculo`
--

LOCK TABLES `veiculo` WRITE;
/*!40000 ALTER TABLE `veiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `veiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viagem`
--

DROP TABLE IF EXISTS `viagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viagem` (
  `id` int NOT NULL,
  `id_origem` int DEFAULT NULL,
  `id_destino` int DEFAULT NULL,
  `id_veiculo` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_origem` (`id_origem`),
  KEY `id_destino` (`id_destino`),
  KEY `id_veiculo` (`id_veiculo`),
  CONSTRAINT `viagem_ibfk_1` FOREIGN KEY (`id_origem`) REFERENCES `centro_distribuicao` (`id`),
  CONSTRAINT `viagem_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `centro_distribuicao` (`id`),
  CONSTRAINT `viagem_ibfk_3` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viagem`
--

LOCK TABLES `viagem` WRITE;
/*!40000 ALTER TABLE `viagem` DISABLE KEYS */;
/*!40000 ALTER TABLE `viagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viagem_entrega`
--

DROP TABLE IF EXISTS `viagem_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viagem_entrega` (
  `id_entrega` int DEFAULT NULL,
  `id_viagem` int DEFAULT NULL,
  KEY `id_entrega` (`id_entrega`),
  KEY `id_viagem` (`id_viagem`),
  CONSTRAINT `viagem_entrega_ibfk_1` FOREIGN KEY (`id_entrega`) REFERENCES `entrega` (`id`),
  CONSTRAINT `viagem_entrega_ibfk_2` FOREIGN KEY (`id_viagem`) REFERENCES `viagem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viagem_entrega`
--

LOCK TABLES `viagem_entrega` WRITE;
/*!40000 ALTER TABLE `viagem_entrega` DISABLE KEYS */;
/*!40000 ALTER TABLE `viagem_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sistemagestaoentregas'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-14 16:16:12
