-- MySQL dump 10.16  Distrib 10.2.15-MariaDB, for Win64 (AMD64)
--
-- Host: 192.168.10.200    Database: bioacesso_portaria
-- ------------------------------------------------------
-- Server version	10.2.15-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abertura_por_botoeira`
--

DROP TABLE IF EXISTS `abertura_por_botoeira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abertura_por_botoeira` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_dispositivo` int(10) unsigned DEFAULT NULL,
  `tipo_dispositivo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_usuario` int(10) unsigned DEFAULT NULL,
  `data_abertura` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abertura_por_botoeira`
--

LOCK TABLES `abertura_por_botoeira` WRITE;
/*!40000 ALTER TABLE `abertura_por_botoeira` DISABLE KEYS */;
INSERT INTO `abertura_por_botoeira` VALUES (1,1,'toten',1,'2019-12-09 18:00:08'),(2,1,'toten',1,'2019-12-09 18:00:51'),(3,1,'toten',1,'2019-12-09 18:10:12'),(4,1,'toten',1,'2019-12-13 16:27:47'),(5,1,'toten',1,'2019-12-13 16:28:30'),(6,1,'toten',1,'2019-12-13 16:30:17'),(7,1,'toten',1,'2019-12-13 16:30:25'),(8,1,'toten',1,'2019-12-13 16:31:12'),(9,1,'toten',1,'2020-03-27 01:40:24'),(10,1,'toten',1,'2020-03-27 01:40:30'),(11,1,'toten',1,'2020-03-27 17:40:44');
/*!40000 ALTER TABLE `abertura_por_botoeira` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia`
--

DROP TABLE IF EXISTS `academia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(11) NOT NULL,
  `acesso_academia` tinyint(1) NOT NULL DEFAULT 0,
  `validade_atestado` date DEFAULT NULL,
  `adesao` date DEFAULT NULL,
  `cancelamento` date DEFAULT NULL,
  `id_externo_cobranca` int(11) DEFAULT NULL,
  `id_pessoa_fatura` int(11) DEFAULT NULL,
  `createAt` datetime DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_ID_PESSOA` (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia`
--

LOCK TABLES `academia` WRITE;
/*!40000 ALTER TABLE `academia` DISABLE KEYS */;
INSERT INTO `academia` VALUES (1,216,1,NULL,'2020-09-11',NULL,51,163,'2020-09-11 15:50:57','2020-09-11 16:20:42'),(2,175,1,'2020-12-08','2020-11-09',NULL,14,131,'2020-11-09 15:47:30',NULL);
/*!40000 ALTER TABLE `academia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acesso_localidade`
--

DROP TABLE IF EXISTS `acesso_localidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acesso_localidade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(10) unsigned DEFAULT NULL,
  `id_localidade` int(10) unsigned NOT NULL,
  `id_validade_acesso` int(10) unsigned DEFAULT NULL,
  `acesso_autorizado` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acesso_localidade`
--

LOCK TABLES `acesso_localidade` WRITE;
/*!40000 ALTER TABLE `acesso_localidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `acesso_localidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acesso_login`
--

DROP TABLE IF EXISTS `acesso_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acesso_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `id_pessoa` int(11) NOT NULL,
  `ativo` enum('s','n') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acesso_login`
--

LOCK TABLES `acesso_login` WRITE;
/*!40000 ALTER TABLE `acesso_login` DISABLE KEYS */;
INSERT INTO `acesso_login` VALUES (1,'77a58fd1cdf280aa0f9e67a2686ed929711ae56c1d52247704f178bc6768b765',1,'s','2021-02-26 17:15:34','2021-02-26 17:15:34'),(2,'0c9a327d09978eeee650b0b62f421f1d64f98f431278cc38a1aee66c35a35e51',1,'s','2021-02-26 18:02:00',NULL),(3,'3288666d545fe133818cc8caaa40fdc2616b78617bee832181b3d14904f49872',1,'s','2021-02-26 18:02:00',NULL),(4,'bf59eb6ddddaaa550e16cfeccfdb10dbf1fb082e4482850888402b716d47052b',1,'s','2021-02-26 18:02:00',NULL),(5,'bd7a65903647e41ee2e3e56cde8f651d5813138c2196b5dcc91a148bb606a993',1,'s','2021-02-26 18:02:00',NULL),(6,'14b11246acf7c403410d3dc7c3791cb867875b486ff621d7028939ed593f62ca',1,'s','2021-02-26 19:02:00',NULL),(7,'4edb0ef3ea9bc783b608fceb2866cb47013895fca48fd76ad1d212f85416ba5f',1,'s','2021-02-26 19:02:00',NULL),(8,'d5c90da00e2dc1c888196940b88f07e2d0c64bdc8b71659b57f6baf88e761773',1,'s','2021-02-26 19:02:00',NULL),(9,'aa8b1761ad199a7e380d4f2b201c6b401bec3574fdbe202bc0be60c588130ae2',1,'s','2021-03-01 13:03:00',NULL),(10,'69cd6af8f679f0706363e2d3ad8f2c02e517d9ace07fd11800708e5cd5ea60df',1,'s','2021-03-01 13:03:00',NULL),(11,'03f16207f9cb7fe6ab14243e790c6b4b4a00883d354053b965751507ad79800e',1,'s','2021-03-01 13:03:00',NULL);
/*!40000 ALTER TABLE `acesso_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acesso_toten`
--

DROP TABLE IF EXISTS `acesso_toten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acesso_toten` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_credencial_acesso` int(10) unsigned DEFAULT NULL,
  `id_pessoa_acesso` int(10) unsigned DEFAULT NULL,
  `id_toten` int(10) unsigned DEFAULT NULL,
  `id_lpr` int(11) DEFAULT NULL,
  `autorizar_acesso` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_atendente` int(10) unsigned DEFAULT NULL,
  `data_hora_criacao` datetime DEFAULT NULL,
  `data_hora_validacao` datetime DEFAULT NULL,
  `requerer_validacao` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `panico_acionado` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tela_panico_visualizada` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_catraca` int(11) DEFAULT NULL,
  `sentido_catraca` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_2` (`id_toten`,`id_pessoa_acesso`),
  KEY `Index_3` (`data_hora_criacao`),
  KEY `panico_acionado` (`panico_acionado`,`tela_panico_visualizada`),
  KEY `id_lpr` (`id_lpr`),
  CONSTRAINT `acesso_toten_ibfk_1` FOREIGN KEY (`id_lpr`) REFERENCES `lpr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acesso_toten`
--

LOCK TABLES `acesso_toten` WRITE;
/*!40000 ALTER TABLE `acesso_toten` DISABLE KEYS */;
INSERT INTO `acesso_toten` VALUES (1,4,3,11,NULL,'n',1,'2021-02-08 19:24:12','2021-02-08 22:24:23','s','n',NULL,NULL,NULL),(2,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:25:00','s','n',NULL,NULL,NULL),(3,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:34','s','n',NULL,NULL,NULL),(4,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:42','s','n',NULL,NULL,NULL),(5,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:45','s','n',NULL,NULL,NULL),(6,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:48','s','n',NULL,NULL,NULL),(7,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:51','s','n',NULL,NULL,NULL),(8,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:54','s','n',NULL,NULL,NULL),(9,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:57','s','n',NULL,NULL,NULL),(10,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:26','s','n',NULL,NULL,NULL),(11,4,3,11,NULL,'n',1,'2021-02-08 19:24:13','2021-02-08 22:24:31','s','n',NULL,NULL,NULL),(12,4,NULL,11,NULL,NULL,0,'2021-02-09 09:52:33','2021-02-09 09:50:32','s','n',NULL,NULL,NULL),(13,4,NULL,11,NULL,NULL,0,'2021-02-09 09:52:33','2021-02-09 09:50:35','s','n',NULL,NULL,NULL),(14,4,NULL,11,NULL,NULL,0,'2021-02-09 09:52:33','2021-02-09 09:51:03','s','n',NULL,NULL,NULL),(15,4,139,11,NULL,'n',1,'2021-02-09 12:53:07','2021-02-09 12:54:34','s','n',NULL,NULL,NULL),(16,4,139,11,NULL,'n',1,'2021-02-09 09:53:34','2021-02-09 12:54:28','s','n',NULL,NULL,NULL),(17,4,139,11,NULL,'s',1,'2021-02-09 12:54:09','2021-02-09 12:54:20','s','n',NULL,NULL,NULL),(18,4,139,11,NULL,'s',1,'2021-02-09 12:58:40','2021-02-09 12:58:44','s','n',NULL,NULL,NULL),(19,4,139,11,NULL,'s',1,'2021-02-09 12:58:46','2021-02-09 12:58:50','s','n',NULL,NULL,NULL),(20,4,139,11,NULL,'s',1,'2021-02-09 12:59:02','2021-02-09 12:59:05','s','n',NULL,NULL,NULL),(21,4,139,11,NULL,'s',1,'2021-02-09 12:59:07','2021-02-09 12:59:13','s','n',NULL,NULL,NULL),(22,4,139,11,NULL,'n',1,'2021-02-09 13:01:08','2021-02-09 13:01:24','s','n',NULL,NULL,NULL),(23,4,139,11,NULL,'n',1,'2021-02-09 13:01:24','2021-02-09 13:01:26','s','n',NULL,NULL,NULL),(24,4,3,11,NULL,'s',1,'2021-02-09 13:02:01','2021-02-09 13:02:13','s','n',NULL,NULL,NULL),(25,4,3,11,NULL,'s',1,'2021-02-09 13:02:14','2021-02-09 13:02:24','s','n',NULL,NULL,NULL),(26,4,139,11,NULL,'s',1,'2021-02-09 13:02:27','2021-02-09 13:02:31','s','n',NULL,NULL,NULL),(27,4,139,11,NULL,'s',1,'2021-02-09 13:02:32','2021-02-09 13:02:35','s','n',NULL,NULL,NULL),(28,4,3,11,NULL,'s',0,'2021-02-09 13:03:43','2021-02-09 13:03:43','n','n',NULL,NULL,NULL),(29,4,3,11,NULL,'s',0,'2021-02-09 13:03:48','2021-02-09 13:03:48','n','n',NULL,NULL,NULL),(30,4,3,11,NULL,'s',0,'2021-02-09 13:03:54','2021-02-09 13:03:54','n','n',NULL,NULL,NULL),(31,4,3,11,NULL,'s',0,'2021-02-09 13:04:04','2021-02-09 13:04:04','n','n',NULL,NULL,NULL),(32,4,3,11,NULL,'s',0,'2021-02-09 13:04:09','2021-02-09 13:04:09','n','n',NULL,NULL,NULL),(33,4,3,11,NULL,'s',0,'2021-02-09 13:04:14','2021-02-09 13:04:14','n','n',NULL,NULL,NULL),(34,4,3,11,NULL,'s',0,'2021-02-09 13:04:21','2021-02-09 13:04:21','n','n',NULL,NULL,NULL),(35,4,139,11,NULL,'s',1,'2021-02-09 13:04:38','2021-02-09 13:04:43','s','n',NULL,NULL,NULL),(36,4,139,11,NULL,'s',1,'2021-02-09 13:04:45','2021-02-09 13:04:49','s','n',NULL,NULL,NULL),(37,4,139,11,NULL,'s',1,'2021-02-09 13:05:23','2021-02-09 13:05:30','s','n',NULL,NULL,NULL),(38,4,139,11,NULL,'s',1,'2021-02-09 13:05:37','2021-02-09 13:05:53','s','n',NULL,NULL,NULL),(39,4,139,11,NULL,'n',1,'2021-02-09 13:07:10','2021-02-09 13:07:24','s','n',NULL,NULL,NULL),(40,4,139,11,NULL,'n',1,'2021-02-09 13:09:41','2021-02-09 13:09:50','s','n',NULL,NULL,NULL),(41,4,139,11,NULL,'n',1,'2021-02-09 13:09:56','2021-02-09 13:09:59','s','n',NULL,NULL,NULL),(42,4,139,11,NULL,'n',1,'2021-02-09 13:10:40','2021-02-09 13:10:43','s','n',NULL,NULL,NULL),(43,4,3,11,NULL,'s',0,'2021-02-09 13:11:00','2021-02-09 13:11:00','n','n',NULL,NULL,NULL),(44,4,3,11,NULL,'s',0,'2021-02-09 13:11:07','2021-02-09 13:11:07','n','n',NULL,NULL,NULL),(45,4,3,11,NULL,'s',0,'2021-02-09 13:11:21','2021-02-09 13:11:21','n','n',NULL,NULL,NULL),(46,4,139,11,NULL,'n',1,'2021-02-09 13:11:34','2021-02-09 13:11:37','s','n',NULL,NULL,NULL),(47,4,139,11,NULL,'n',1,'2021-02-09 13:12:00','2021-02-09 13:12:11','s','n',NULL,NULL,NULL),(48,4,139,11,NULL,'n',1,'2021-02-09 13:12:11','2021-02-09 13:12:15','s','n',NULL,NULL,NULL),(49,4,139,11,NULL,'n',1,'2021-02-09 13:12:22','2021-02-09 13:12:26','s','n',NULL,NULL,NULL),(50,4,139,11,NULL,'n',1,'2021-02-09 13:12:27','2021-02-09 13:12:31','s','n',NULL,NULL,NULL),(51,4,139,11,NULL,'s',1,'2021-02-09 13:13:20','2021-02-09 13:13:25','s','n',NULL,NULL,NULL),(52,4,139,11,NULL,'s',1,'2021-02-09 13:13:27','2021-02-09 13:13:32','s','n',NULL,NULL,NULL),(53,4,139,11,NULL,'n',1,'2021-02-09 13:14:30','2021-02-09 13:14:38','s','n',NULL,NULL,NULL),(54,4,139,11,NULL,'n',1,'2021-02-09 13:14:43','2021-02-09 13:14:46','s','n',NULL,NULL,NULL),(55,4,139,11,NULL,NULL,NULL,'2021-02-09 13:15:11',NULL,'n','n',NULL,NULL,NULL),(56,4,139,11,NULL,NULL,NULL,'2021-02-09 13:15:22',NULL,'n','n',NULL,NULL,NULL),(57,4,139,11,NULL,NULL,NULL,'2021-02-09 13:15:32',NULL,'n','n',NULL,NULL,NULL),(58,4,139,11,NULL,NULL,NULL,'2021-02-09 13:16:03',NULL,'n','n',NULL,NULL,NULL),(59,4,139,11,NULL,NULL,NULL,'2021-02-09 13:16:12',NULL,'n','n',NULL,NULL,NULL),(60,4,139,11,NULL,'s',0,'2021-02-09 13:16:49','2021-02-09 13:16:49','n','n',NULL,NULL,NULL),(61,4,139,11,NULL,'s',0,'2021-02-09 13:16:55','2021-02-09 13:16:55','n','n',NULL,NULL,NULL),(62,4,139,11,NULL,'s',0,'2021-02-09 13:17:01','2021-02-09 13:17:01','n','n',NULL,NULL,NULL),(63,4,139,11,NULL,'s',0,'2021-02-09 13:17:07','2021-02-09 13:17:07','n','n',NULL,NULL,NULL),(64,4,139,11,NULL,'s',1,'2021-02-09 13:21:19','2021-02-09 13:21:23','s','n',NULL,NULL,NULL),(65,4,139,11,NULL,'s',1,'2021-02-09 13:21:25','2021-02-09 13:21:27','s','n',NULL,NULL,NULL),(66,4,139,11,NULL,'s',1,'2021-02-09 13:21:30','2021-02-09 13:21:32','s','n',NULL,NULL,NULL),(67,4,139,11,NULL,'s',1,'2021-02-09 13:21:35','2021-02-09 13:21:37','s','n',NULL,NULL,NULL),(68,4,139,11,NULL,'s',1,'2021-02-09 13:21:40','2021-02-09 13:21:44','s','n',NULL,NULL,NULL),(69,4,139,11,NULL,'s',1,'2021-02-09 13:22:07','2021-02-09 13:22:10','s','n',NULL,NULL,NULL),(70,4,139,11,NULL,'s',1,'2021-02-09 13:22:12','2021-02-09 13:22:14','s','n',NULL,NULL,NULL),(71,4,139,11,NULL,'s',1,'2021-02-09 13:22:49','2021-02-09 13:22:52','s','n',NULL,NULL,NULL),(72,4,139,11,NULL,'s',1,'2021-02-09 13:22:54','2021-02-09 13:22:58','s','n',NULL,NULL,NULL),(73,4,139,11,NULL,'s',1,'2021-02-09 13:26:35','2021-02-09 13:26:39','s','n',NULL,NULL,NULL),(74,4,139,11,NULL,'s',1,'2021-02-09 13:26:41','2021-02-09 13:26:43','s','n',NULL,NULL,NULL),(75,4,139,11,NULL,'s',1,'2021-02-09 13:26:50','2021-02-09 13:26:53','s','n',NULL,NULL,NULL),(76,4,139,11,NULL,'s',1,'2021-02-09 13:26:55','2021-02-09 13:26:58','s','n',NULL,NULL,NULL),(77,4,139,11,NULL,'s',1,'2021-02-09 13:27:01','2021-02-09 13:27:03','s','n',NULL,NULL,NULL),(78,4,139,11,NULL,'s',1,'2021-02-09 13:27:07','2021-02-09 13:27:09','s','n',NULL,NULL,NULL),(79,4,139,11,NULL,'s',1,'2021-02-09 13:27:19','2021-02-09 13:27:21','s','n',NULL,NULL,NULL),(80,4,139,11,NULL,'s',1,'2021-02-09 13:27:36','2021-02-09 13:27:39','s','n',NULL,NULL,NULL),(81,4,139,11,NULL,'s',1,'2021-02-09 13:27:41','2021-02-09 13:27:44','s','n',NULL,NULL,NULL),(82,4,139,11,NULL,'s',1,'2021-02-09 13:28:23','2021-02-09 13:28:26','s','n',NULL,NULL,NULL),(83,4,139,11,NULL,'s',1,'2021-02-09 13:28:28','2021-02-09 13:28:30','s','n',NULL,NULL,NULL),(84,4,139,11,NULL,'s',1,'2021-02-09 13:28:39','2021-02-09 13:28:41','s','n',NULL,NULL,NULL),(85,4,139,11,NULL,'s',1,'2021-02-09 13:28:45','2021-02-09 13:28:47','s','n',NULL,NULL,NULL),(86,4,139,11,NULL,'s',1,'2021-02-09 13:29:00','2021-02-09 13:29:03','s','n',NULL,NULL,NULL),(87,4,139,11,NULL,'s',1,'2021-02-09 13:29:05','2021-02-09 13:29:07','s','n',NULL,NULL,NULL),(88,4,139,11,NULL,'s',1,'2021-02-09 13:30:56','2021-02-09 13:30:59','s','n',NULL,NULL,NULL),(89,4,133,11,NULL,'s',0,'2021-02-09 13:31:11','2021-02-09 13:31:11','n','n',NULL,NULL,NULL),(90,4,133,11,NULL,'s',0,'2021-02-09 13:31:18','2021-02-09 13:31:18','n','n',NULL,NULL,NULL),(91,4,139,11,NULL,'s',1,'2021-02-09 13:31:20','2021-02-09 13:31:24','s','n',NULL,NULL,NULL),(92,4,133,11,NULL,'s',0,'2021-02-09 13:31:25','2021-02-09 13:31:25','n','n',NULL,NULL,NULL),(93,4,139,11,NULL,'s',1,'2021-02-09 13:31:26','2021-02-09 13:31:29','s','n',NULL,NULL,NULL);
/*!40000 ALTER TABLE `acesso_toten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acordo_parcelas_negociadas`
--

DROP TABLE IF EXISTS `acordo_parcelas_negociadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acordo_parcelas_negociadas` (
  `id_acordo` int(10) unsigned NOT NULL,
  `id_parcela_negociada` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `acordo_parcelas_negociadas_id_acordo_foreign` (`id_acordo`),
  KEY `acordo_parcelas_negociadas_id_parcela_negociada_foreign` (`id_parcela_negociada`),
  CONSTRAINT `acordo_parcelas_negociadas_id_acordo_foreign` FOREIGN KEY (`id_acordo`) REFERENCES `acordos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acordo_parcelas_negociadas_id_parcela_negociada_foreign` FOREIGN KEY (`id_parcela_negociada`) REFERENCES `parcela_boletos` (`id_parcela`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acordo_parcelas_negociadas`
--

LOCK TABLES `acordo_parcelas_negociadas` WRITE;
/*!40000 ALTER TABLE `acordo_parcelas_negociadas` DISABLE KEYS */;
/*!40000 ALTER TABLE `acordo_parcelas_negociadas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acordos`
--

DROP TABLE IF EXISTS `acordos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acordos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_conta_recebimento` int(10) unsigned NOT NULL,
  `id_associado` int(10) unsigned DEFAULT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `nome_parceiro` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `forma_pagamento` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `data_acordo` date NOT NULL,
  `data_agendamento` date NOT NULL,
  `valor_divida` decimal(15,2) NOT NULL,
  `valor_acordo` decimal(15,2) NOT NULL,
  `valor_entrada` decimal(15,2) DEFAULT 0.00,
  `data_recebimento_entrada` date DEFAULT NULL,
  `comprovante_entrada` bigint(20) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL COMMENT '0->cancelado,1->ativo,2->compensado',
  `cancelamento` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acordos_id_imovel_index` (`id_imovel`),
  KEY `acordos_id_associado_index` (`id_associado`),
  KEY `acordos_id_conta_recebimento_foreign` (`id_conta_recebimento`),
  CONSTRAINT `acordos_id_conta_recebimento_foreign` FOREIGN KEY (`id_conta_recebimento`) REFERENCES `conta_recebimentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acordos`
--

LOCK TABLES `acordos` WRITE;
/*!40000 ALTER TABLE `acordos` DISABLE KEYS */;
/*!40000 ALTER TABLE `acordos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acrescimo_pagar`
--

DROP TABLE IF EXISTS `acrescimo_pagar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acrescimo_pagar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_lancamento_agendar` int(10) unsigned NOT NULL,
  `id_conta` int(10) unsigned NOT NULL,
  `valor` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `incluir_soma` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acrescimo_pagar_id_lancamento_agendar_foreign` (`id_lancamento_agendar`),
  KEY `acrescimo_pagar_id_conta_foreign` (`id_conta`),
  CONSTRAINT `acrescimo_pagar_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`),
  CONSTRAINT `acrescimo_pagar_id_lancamento_agendar_foreign` FOREIGN KEY (`id_lancamento_agendar`) REFERENCES `lancamento_agendar` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acrescimo_pagar`
--

LOCK TABLES `acrescimo_pagar` WRITE;
/*!40000 ALTER TABLE `acrescimo_pagar` DISABLE KEYS */;
/*!40000 ALTER TABLE `acrescimo_pagar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertencia`
--

DROP TABLE IF EXISTS `advertencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advertencia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(10) unsigned NOT NULL,
  `tipo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `descricao` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `data_hora` datetime NOT NULL,
  `id_funcionario_condominio` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertencia`
--

LOCK TABLES `advertencia` WRITE;
/*!40000 ALTER TABLE `advertencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `advertencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_nascimento` date DEFAULT NULL,
  `data_ultima_vacina` date DEFAULT NULL,
  `nome` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `especie` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `raca` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pelagem` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `peso` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identificacao` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_pessoa_dono` int(11) NOT NULL DEFAULT 0,
  `obs` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_foto` blob DEFAULT NULL,
  `ultima_alteracao` datetime DEFAULT NULL,
  `porte` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_3` (`nome`),
  KEY `index_2` (`id_pessoa_dono`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (1,NULL,NULL,'Laika','Grande',NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,'2020-03-07 09:25:32',NULL),(2,'2020-01-01',NULL,'Leleu','Cachorro','akita','Branca','1','m',NULL,3,NULL,NULL,'2020-03-07 09:29:35',NULL),(3,'2020-01-01',NULL,'Lulu','Cachoro','Akita','Branca','1','m',NULL,3,NULL,NULL,'2020-03-07 09:30:22',NULL);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aprovadors`
--

DROP TABLE IF EXISTS `aprovadors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aprovadors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) NOT NULL,
  `tipo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aprovadors`
--

LOCK TABLES `aprovadors` WRITE;
/*!40000 ALTER TABLE `aprovadors` DISABLE KEYS */;
/*!40000 ALTER TABLE `aprovadors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `areas_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arquivo_retornos`
--

DROP TABLE IF EXISTS `arquivo_retornos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arquivo_retornos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome_arquivo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `caminho_arquivo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `layout` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data_leitura` date NOT NULL,
  `qtd_processado` int(11) NOT NULL DEFAULT 0,
  `qtd_recebida` int(11) NOT NULL DEFAULT 0,
  `qtd_rejeitada` int(11) NOT NULL DEFAULT 0,
  `outras_operacoes` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arquivo_retornos`
--

LOCK TABLES `arquivo_retornos` WRITE;
/*!40000 ALTER TABLE `arquivo_retornos` DISABLE KEYS */;
/*!40000 ALTER TABLE `arquivo_retornos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atividade_ocorrencia`
--

DROP TABLE IF EXISTS `atividade_ocorrencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atividade_ocorrencia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_ocorrencia` int(10) unsigned NOT NULL,
  `id_pessoa_funcionario` int(10) unsigned NOT NULL,
  `id_pessoa_responsavel` int(10) unsigned NOT NULL,
  `hora_conclusao` time DEFAULT NULL,
  `descricao` text COLLATE utf8_unicode_ci NOT NULL,
  `excluida` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `data_hora_exclusao` datetime DEFAULT NULL,
  `id_pessoa_exclusao` int(10) unsigned DEFAULT NULL,
  `data_hora_criacao` datetime NOT NULL,
  `data_conclusao` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atividade_ocorrencia`
--

LOCK TABLES `atividade_ocorrencia` WRITE;
/*!40000 ALTER TABLE `atividade_ocorrencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `atividade_ocorrencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baixas`
--

DROP TABLE IF EXISTS `baixas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baixas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parcela` int(10) unsigned NOT NULL,
  `valor_pago` decimal(15,2) NOT NULL,
  `valor_adicional` decimal(15,2) DEFAULT 0.00,
  `data_pagamento` date NOT NULL,
  `data_compensacao` date NOT NULL,
  `observacao` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `baixas_id_parcela_foreign` (`id_parcela`),
  CONSTRAINT `baixas_id_parcela_foreign` FOREIGN KEY (`id_parcela`) REFERENCES `recebimento_parcelas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baixas`
--

LOCK TABLES `baixas` WRITE;
/*!40000 ALTER TABLE `baixas` DISABLE KEYS */;
/*!40000 ALTER TABLE `baixas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bancos`
--

DROP TABLE IF EXISTS `bancos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bancos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `img` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bancos_codigo_unique` (`codigo`),
  UNIQUE KEY `bancos_descricao_unique` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bancos`
--

LOCK TABLES `bancos` WRITE;
/*!40000 ALTER TABLE `bancos` DISABLE KEYS */;
INSERT INTO `bancos` VALUES (1,'237','BANCO BRADESCO','https://banco.bradesco/html/classic/produtos-servicos/mais-produtos-servicos/segunda-via-boleto.shtm','img/bancos/bradesco.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(2,'341','BANCO ITAÚ S.A','https://www.itau.com.br/servicos/boletos/segunda-via/','img/bancos/itau.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(3,'001','BANCO DO BRASIL','https://www63.bb.com.br/portalbb/boleto/boletos/hc21e,802,3322,10343.bbx?_ga=2.25210302.2043215422.1511871573-1901821601.1511871573','img/bancos/bb.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(4,'033','BANCO SANTANDER','https://www.santander.com.br/br/resolva-on-line/boletos','img/bancos/santander.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(5,'104','CAIXA ECONÔMICA FEDERAL','https://bloquetoexpresso.caixa.gov.br/bloquetoexpresso/index.jsp','img/bancos/caixa.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(6,'399','BANCO HSBC','http://www.hsbc.com','img/bancos/hsbc.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(7,'748','SICREDI','https://si-web.sicredi.com.br/boletoweb/BoletoWeb.servicos.Index.task','img/bancos/sicredi.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(8,'041','BANCO BANRISUL','https://ww8.banrisul.com.br/brb/link/Brbw2Lhw_Bloqueto_Titulos_Internet.aspx?SegundaVia=1&secao_id=2539','img/bancos/banrisul.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(9,'756','SICOOB','http://www.sicoob.com.br/segunda-via-de-boleto/','img/bancos/sicoob.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(10,'004','BANCO BNB','https://www.bnb.gov.br/servicos/emissao-da-2-via-do-boleto','img/bancos/bnb.png',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17');
/*!40000 ALTER TABLE `bancos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boletos_lancamentos`
--

DROP TABLE IF EXISTS `boletos_lancamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletos_lancamentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parcela` int(10) unsigned DEFAULT NULL,
  `id_lancamento` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boletos_lancamentos_id_parcela_foreign` (`id_parcela`),
  KEY `boletos_lancamentos_id_lancamento_foreign` (`id_lancamento`),
  CONSTRAINT `boletos_lancamentos_id_lancamento_foreign` FOREIGN KEY (`id_lancamento`) REFERENCES `lancamentos` (`id`),
  CONSTRAINT `boletos_lancamentos_id_parcela_foreign` FOREIGN KEY (`id_parcela`) REFERENCES `recebimento_parcelas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletos_lancamentos`
--

LOCK TABLES `boletos_lancamentos` WRITE;
/*!40000 ALTER TABLE `boletos_lancamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletos_lancamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera`
--

DROP TABLE IF EXISTS `camera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camera` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_externa` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_portaria` int(10) unsigned DEFAULT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL,
  `acesso_externo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `totenid` int(10) unsigned DEFAULT NULL,
  `tipo` enum('app','doc','face','lpr') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'face',
  `url_camera` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `totenid` (`totenid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera`
--

LOCK TABLES `camera` WRITE;
/*!40000 ALTER TABLE `camera` DISABLE KEYS */;
INSERT INTO `camera` VALUES (5,'Camera Entrada','192.168.0.1',NULL,1,NULL,'n',1,'face',NULL),(8,'Camera Saida','192.168.0.2',NULL,1,NULL,'n',7,'face',NULL);
/*!40000 ALTER TABLE `camera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carta_cobrancas`
--

DROP TABLE IF EXISTS `carta_cobrancas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carta_cobrancas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `conteudo` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carta_cobrancas`
--

LOCK TABLES `carta_cobrancas` WRITE;
/*!40000 ALTER TABLE `carta_cobrancas` DISABLE KEYS */;
/*!40000 ALTER TABLE `carta_cobrancas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carteiras`
--

DROP TABLE IF EXISTS `carteiras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carteiras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_banco` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carteiras_id_banco_foreign` (`id_banco`),
  CONSTRAINT `carteiras_id_banco_foreign` FOREIGN KEY (`id_banco`) REFERENCES `bancos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carteiras`
--

LOCK TABLES `carteiras` WRITE;
/*!40000 ALTER TABLE `carteiras` DISABLE KEYS */;
INSERT INTO `carteiras` VALUES (1,'09',1,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(2,'21',1,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(3,'26',1,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(4,'109',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(5,'110',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(6,'111',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(7,'112',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(8,'115',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(9,'121',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(10,'180',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(11,'188',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(12,'180',2,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(13,'11',3,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(14,'12',3,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(15,'15',3,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(16,'17',3,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(17,'18',3,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(18,'31',3,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(19,'51',3,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(20,'101',4,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(21,'201',4,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(22,'RG',5,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(23,'CSB',6,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(24,'1',7,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(25,'2',7,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(26,'3',7,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(27,'1',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(28,'3',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(29,'4',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(30,'5',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(31,'6',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(32,'7',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(33,'8',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(34,'C',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(35,'D',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(36,'E',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(37,'F',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(38,'H',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(39,'I',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(40,'K',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(41,'M',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(42,'N',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(43,'R',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(44,'S',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(45,'X',8,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(46,'1',9,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(47,'3',9,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(48,'21',10,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(49,'31',10,'2021-02-09 23:01:18','2021-02-09 23:01:18'),(50,'41',10,'2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `carteiras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_usuario`
--

DROP TABLE IF EXISTS `categoria_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_usuario`
--

LOCK TABLES `categoria_usuario` WRITE;
/*!40000 ALTER TABLE `categoria_usuario` DISABLE KEYS */;
INSERT INTO `categoria_usuario` VALUES (15,'Gerente Segurança'),(16,'Administrador');
/*!40000 ALTER TABLE `categoria_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catraca`
--

DROP TABLE IF EXISTS `catraca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catraca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(16) DEFAULT NULL COMMENT 'uzerway, java, morpho',
  `descricao` varchar(32) NOT NULL,
  `id_portaria` int(11) DEFAULT NULL,
  `numero_serie` varchar(16) DEFAULT NULL,
  `sentido` varchar(8) DEFAULT NULL,
  `ip` varchar(40) DEFAULT NULL,
  `porta` int(10) unsigned DEFAULT NULL,
  `bit_giro_entrada` varchar(5) DEFAULT NULL,
  `bit_giro_saida` varchar(5) DEFAULT NULL,
  `teclado` varchar(1) DEFAULT NULL,
  `botoeira` varchar(1) DEFAULT NULL,
  `biometria` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catraca`
--

LOCK TABLES `catraca` WRITE;
/*!40000 ALTER TABLE `catraca` DISABLE KEYS */;
/*!40000 ALTER TABLE `catraca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centro_custos`
--

DROP TABLE IF EXISTS `centro_custos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centro_custos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `centro_custo_pai` int(11) DEFAULT NULL COMMENT 'Centro de custo pai',
  `ordem_codigo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Ordem/Código do centro de custo',
  `tipo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tipos aceitos: Sintético e analítico',
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Descrição do centro de custo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_custos`
--

LOCK TABLES `centro_custos` WRITE;
/*!40000 ALTER TABLE `centro_custos` DISABLE KEYS */;
INSERT INTO `centro_custos` VALUES (1,NULL,NULL,NULL,'Teste','2021-02-09 22:20:36','2021-02-09 22:20:33',NULL);
/*!40000 ALTER TABLE `centro_custos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cessao_uso`
--

DROP TABLE IF EXISTS `cessao_uso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cessao_uso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(10) DEFAULT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `titulo_cedido` varchar(2) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`id_imovel`),
  KEY `id_imovel` (`id_imovel`),
  CONSTRAINT `cessao_uso_ibfk_1` FOREIGN KEY (`id_imovel`) REFERENCES `imovel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cessao_uso`
--

LOCK TABLES `cessao_uso` WRITE;
/*!40000 ALTER TABLE `cessao_uso` DISABLE KEYS */;
/*!40000 ALTER TABLE `cessao_uso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cessao_uso_clube`
--

DROP TABLE IF EXISTS `cessao_uso_clube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cessao_uso_clube` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cessao_uso` int(11) NOT NULL,
  `id_clube` int(11) NOT NULL,
  `id_pessoa` int(10) unsigned NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `grau_parentesco` varchar(20) DEFAULT NULL,
  `perm_liberacao_convite` char(1) DEFAULT 'n',
  `pode_comprar_convite` char(1) DEFAULT 'n',
  `dependente_especial` char(1) DEFAULT 'n',
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cessao_uso` (`id_cessao_uso`),
  KEY `id_clube` (`id_clube`),
  KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `cessao_uso_clube_ibfk_1` FOREIGN KEY (`id_cessao_uso`) REFERENCES `cessao_uso` (`id`),
  CONSTRAINT `cessao_uso_clube_ibfk_2` FOREIGN KEY (`id_clube`) REFERENCES `clube` (`id`),
  CONSTRAINT `cessao_uso_clube_ibfk_3` FOREIGN KEY (`id_pessoa`) REFERENCES `clube` (`id_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cessao_uso_clube`
--

LOCK TABLES `cessao_uso_clube` WRITE;
/*!40000 ALTER TABLE `cessao_uso_clube` DISABLE KEYS */;
/*!40000 ALTER TABLE `cessao_uso_clube` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clube`
--

DROP TABLE IF EXISTS `clube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clube` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(10) unsigned NOT NULL,
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `clube_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clube`
--

LOCK TABLES `clube` WRITE;
/*!40000 ALTER TABLE `clube` DISABLE KEYS */;
/*!40000 ALTER TABLE `clube` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cnh`
--

DROP TABLE IF EXISTS `cnh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnh` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_venc` date DEFAULT NULL,
  `categoria` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL,
  `url_cnh` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cnh`
--

LOCK TABLES `cnh` WRITE;
/*!40000 ALTER TABLE `cnh` DISABLE KEYS */;
INSERT INTO `cnh` VALUES (1,'3213123','2030-01-01','ab','2020-12-28 09:57:10',NULL),(2,'123131231','2033-01-01','a','2020-07-06 15:07:57',NULL),(3,'1231313','2033-01-01','ab','2020-12-02 10:29:10',NULL),(4,'12313122332','2033-01-01','ab','2019-12-02 15:09:16',NULL),(5,'34t34','2026-06-06','a','2019-12-03 18:12:30',NULL),(6,'ggh','2020-06-06','d','2019-12-03 18:12:31',NULL),(7,'a','2201-05-05','a','2019-12-03 18:12:32',NULL),(8,'tyjh','2021-05-05','c','2019-12-03 18:15:08',NULL),(9,'5456654','2020-12-12','b','2020-12-07 09:27:11',NULL),(10,'ssad','2020-12-13','a','2019-12-04 09:52:05',NULL),(11,'12312313','2033-01-01','c','2019-12-04 10:20:02',NULL),(12,'6uy65u56','2020-06-06','a','2019-12-04 10:22:09',NULL),(13,'tyj','2050-01-01','c','2019-12-04 10:24:03',NULL),(14,'4675y','2020-08-09','b','2019-12-04 10:25:23',NULL),(15,'ss1d','2020-12-12','a','2019-12-04 10:32:42',NULL),(16,'sdsdds','2020-12-12','b','2019-12-04 10:32:43',NULL),(17,'345645','2050-05-05','b','2020-12-02 16:12:00',NULL),(18,'ss1d','2020-12-12','a','2019-12-04 10:32:59',NULL),(19,'sdsdds','2020-12-12','b','2019-12-04 10:33:00',NULL),(20,'2323','2020-12-12','b','2019-12-04 10:33:00',NULL),(21,'456456','2200-12-12','b','2019-12-04 10:53:24',NULL),(22,'sd1sd','2020-12-12','a','2019-12-04 10:53:25',NULL),(23,'s65d456sd','2020-12-12','b','2019-12-04 10:53:25',NULL),(24,'21254','2020-12-12','ab','2019-12-04 11:06:51',NULL),(25,'sd2121','2020-12-12','a','2019-12-04 11:06:52',NULL),(26,'s2d12','2020-12-12','b','2019-12-04 11:10:39',NULL),(27,'5s4d5','2020-12-12','a','2019-12-04 11:10:40',NULL),(28,'ad2asdaed2','2020-12-12','b','2019-12-04 16:01:43',NULL),(29,'s2d0s2','2020-12-12','c','2019-12-04 16:03:51',NULL),(30,'000','2020-12-12','c','2019-12-04 17:39:02',NULL),(31,'0000','2020-12-12','d','2019-12-04 17:39:03',NULL),(32,'l','2021-05-05','b','2019-12-06 09:49:02',NULL),(33,'j','2020-01-01','a','2019-12-06 09:49:03',NULL),(34,'asdasd','2020-11-11','b','2020-05-18 17:29:54',NULL),(35,'hjkkjhk25','2020-12-12','c','2019-12-12 15:24:41',NULL),(36,'hjkkjhk25','2020-12-12','c','2019-12-12 15:25:07',NULL),(37,'hjgjghu','2020-12-12','c','2019-12-12 15:25:07',NULL),(38,'dasd2eae2','2020-12-12','a','2019-12-12 15:25:07',NULL),(39,'hjkkjhk25','2020-12-12','c','2019-12-12 15:27:21',NULL),(40,'hjgjghu','2020-12-12','c','2019-12-12 15:27:22',NULL),(41,'dasd2eae2','2020-12-12','a','2019-12-12 15:27:22',NULL),(42,'123','2020-12-12','a','2019-12-12 15:27:22',NULL),(43,'e131231','2023-01-01','b','2019-12-13 14:14:26',NULL),(44,'123321','2033-12-20','c','2019-12-13 16:24:22',NULL),(45,'asdasd','2020-11-11','b','2019-12-13 18:00:08',NULL),(46,'5456456','2020-10-02','a','2019-12-13 18:00:39',NULL),(47,'asds321d','2020-11-11','d','2019-12-16 09:07:53',NULL),(48,'123123','2033-01-01','ab','2019-12-16 10:03:32',NULL),(49,'123123123','2033-01-01','e','2019-12-16 12:02:05',NULL),(50,'12313123','2033-01-01','ab','2019-12-16 12:03:15',NULL),(51,'22222','2020-12-22','a','2019-12-17 17:52:30',NULL),(52,'465446','2030-01-01','a','2019-12-19 13:00:11',NULL),(53,'6156166','1969-12-31','ab','2020-02-14 08:32:08',NULL),(54,'1234568','2022-01-01','a','2020-02-17 11:01:22',NULL),(55,'353535','2030-12-25','ab','2020-03-03 11:37:50',NULL),(56,'ad22d','2020-11-11','b','2020-02-28 11:07:16',NULL),(57,'d2s2','2020-12-12','b','2020-02-28 11:10:30',NULL),(58,'111','1969-12-31','ab','2020-06-16 16:26:00',NULL),(59,'1235464549','2020-12-02','ab','2020-02-28 16:34:52',NULL),(60,'554897863','2021-05-08','ab','2020-02-28 16:38:15',NULL),(61,'142485','2025-05-01','ab','2020-03-02 14:16:24',NULL),(62,'15425645','2021-05-01','ab','2020-03-17 10:50:27',NULL),(63,'5244566','2022-02-01','ab','2020-03-17 10:54:04',NULL),(64,'5225152','2022-01-01','b','2020-03-17 15:27:07',NULL),(65,'5256256','2021-01-01','ab','2020-04-30 11:53:55',NULL),(66,'656454','2020-12-12','a','2020-06-05 14:37:03',NULL),(67,'dsfgs','2021-10-10','a','2020-06-05 16:51:06',NULL),(68,'asdsd','2020-12-12','a','2020-06-09 15:38:06',NULL),(69,'dasdds','2020-10-20','a','2020-06-09 15:45:08','upload/img/pessoa/15917282965edfd8a8b0338.jpeg'),(70,'asdasd','2020-12-12','c','2020-06-09 15:54:24',NULL),(71,'1212131','2020-12-12','a','2020-06-09 16:01:02','upload/img/pessoa/15917289025edfdb06ccaf4.jpeg'),(72,'ret','2021-05-05','a','2020-06-09 16:42:11',NULL),(73,'1231245645','2022-01-01','ab','2020-06-16 14:49:46',NULL),(74,'543456','2023-04-07','b','2020-06-22 17:06:53',NULL),(75,'fdghdg','2021-05-05','b','2020-06-23 15:15:52',NULL),(76,'214.512.200-16','2022-02-02','ab','2020-11-30 17:29:34',NULL),(77,'191208','2025-04-05','ab','2020-07-08 16:50:20',NULL),(78,'asdasd','2020-12-12','a','2020-10-06 09:23:32',NULL),(79,'45645646456','2023-02-23','a','2020-09-21 14:56:02',NULL),(80,'525252565','2022-09-03','ab','2020-09-04 11:31:00',NULL),(81,'56uje56','2023-05-05','a','2020-07-23 11:11:15',NULL),(82,'876656','2023-06-05','ab','2020-07-23 12:33:01',NULL),(83,'21312313','2021-01-01','ab','2020-09-08 14:27:36',NULL),(84,'252222555','2022-01-01','ab','2020-11-26 15:46:01',NULL),(85,'321232','2021-12-12','a','2020-12-10 12:09:51',NULL);
/*!40000 ALTER TABLE `cnh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colunas`
--

DROP TABLE IF EXISTS `colunas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colunas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `colunas_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colunas`
--

LOCK TABLES `colunas` WRITE;
/*!40000 ALTER TABLE `colunas` DISABLE KEYS */;
/*!40000 ALTER TABLE `colunas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_convites`
--

DROP TABLE IF EXISTS `compras_convites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_convites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cessao_uso` int(11) NOT NULL,
  `id_responsavel` int(10) unsigned NOT NULL,
  `data_compra` datetime NOT NULL,
  `id_operador` int(11) NOT NULL,
  `cancelado` char(1) NOT NULL DEFAULT 'n',
  `data_cancelamento` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cessao_uso` (`id_cessao_uso`),
  KEY `id_responsavel` (`id_responsavel`),
  KEY `id_operador` (`id_operador`),
  CONSTRAINT `compras_convites_ibfk_1` FOREIGN KEY (`id_cessao_uso`) REFERENCES `cessao_uso` (`id`),
  CONSTRAINT `compras_convites_ibfk_2` FOREIGN KEY (`id_responsavel`) REFERENCES `pessoa` (`id`),
  CONSTRAINT `compras_convites_ibfk_3` FOREIGN KEY (`id_operador`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_convites`
--

LOCK TABLES `compras_convites` WRITE;
/*!40000 ALTER TABLE `compras_convites` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_convites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_convites_tipos`
--

DROP TABLE IF EXISTS `compras_convites_tipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_convites_tipos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_compra` int(11) NOT NULL,
  `id_tipo_convite` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor_convite` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_compra` (`id_compra`),
  KEY `id_tipo_convite` (`id_tipo_convite`),
  CONSTRAINT `compras_convites_tipos_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras_convites` (`id`),
  CONSTRAINT `compras_convites_tipos_ibfk_2` FOREIGN KEY (`id_tipo_convite`) REFERENCES `tipo_convites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_convites_tipos`
--

LOCK TABLES `compras_convites_tipos` WRITE;
/*!40000 ALTER TABLE `compras_convites_tipos` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_convites_tipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condominio`
--

DROP TABLE IF EXISTS `condominio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condominio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_cadastro` datetime DEFAULT NULL,
  `razao_social` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nome_fantasia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cnpj` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ie` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_atualizacao` datetime DEFAULT NULL,
  `tel1` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `endereco` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `complemento` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cidade` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bairro` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cep` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `area_total` double DEFAULT NULL,
  `latitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condominio`
--

LOCK TABLES `condominio` WRITE;
/*!40000 ALTER TABLE `condominio` DISABLE KEYS */;
INSERT INTO `condominio` VALUES (1,'2016-08-25 21:29:35','Res Uzer Tecnologia','Res Uzer Tecnologia','15.252.325/0001-39','isento','email@email.com.br','2021-02-26 15:33:35','0000000000','Rua do Condominio',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `condominio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condominio_configuracoes`
--

DROP TABLE IF EXISTS `condominio_configuracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condominio_configuracoes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `calculomessubsequente` tinyint(1) NOT NULL,
  `compensarabatimento` tinyint(1) NOT NULL,
  `diavencimento` int(11) NOT NULL,
  `diaapuracao` int(11) NOT NULL,
  `periododaapuracao` int(11) NOT NULL,
  `periodocompetencia` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Corrente ou Anterior',
  `tipodeapuracao` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Despesa Realizada ou Despesa Estimada',
  `escopoapuracao` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Realizado ou Realizado e Provisionado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condominio_configuracoes`
--

LOCK TABLES `condominio_configuracoes` WRITE;
/*!40000 ALTER TABLE `condominio_configuracoes` DISABLE KEYS */;
INSERT INTO `condominio_configuracoes` VALUES (1,1,1,20,20,31,'corrente','Despesa Estimada','Realizado','2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `condominio_configuracoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracao_carteiras`
--

DROP TABLE IF EXISTS `configuracao_carteiras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracao_carteiras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_conta_bancaria` int(10) unsigned NOT NULL,
  `id_carteira` int(10) unsigned NOT NULL,
  `id_layout_remessa` int(10) unsigned NOT NULL,
  `id_layout_retorno` int(10) unsigned NOT NULL,
  `agencia` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `conta_corrente` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_cedente` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primeiro_dado_config` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `segundo_dado_config` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instru_cobranca_um` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instru_cobranca_dois` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instru_cobranca_tres` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nosso_numero_inicio` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nosso_numero_fim` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_remessa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `configuracao_carteiras_id_carteira_foreign` (`id_carteira`),
  KEY `configuracao_carteiras_id_layout_remessa_foreign` (`id_layout_remessa`),
  KEY `configuracao_carteiras_id_layout_retorno_foreign` (`id_layout_retorno`),
  KEY `configuracao_carteiras_id_conta_bancaria_foreign` (`id_conta_bancaria`),
  CONSTRAINT `configuracao_carteiras_id_carteira_foreign` FOREIGN KEY (`id_carteira`) REFERENCES `carteiras` (`id`),
  CONSTRAINT `configuracao_carteiras_id_conta_bancaria_foreign` FOREIGN KEY (`id_conta_bancaria`) REFERENCES `conta_bancarias` (`id`),
  CONSTRAINT `configuracao_carteiras_id_layout_remessa_foreign` FOREIGN KEY (`id_layout_remessa`) REFERENCES `layout_remessas` (`id`),
  CONSTRAINT `configuracao_carteiras_id_layout_retorno_foreign` FOREIGN KEY (`id_layout_retorno`) REFERENCES `layout_retornos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracao_carteiras`
--

LOCK TABLES `configuracao_carteiras` WRITE;
/*!40000 ALTER TABLE `configuracao_carteiras` DISABLE KEYS */;
INSERT INTO `configuracao_carteiras` VALUES (1,1,1,1,1,'4319','28002-2','','','','','','','00001','99999','2021-02-09 23:01:19','2021-02-09 23:01:19',NULL);
/*!40000 ALTER TABLE `configuracao_carteiras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracao_sistema`
--

DROP TABLE IF EXISTS `configuracao_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracao_sistema` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `max_dias_validade_liberacao` int(10) unsigned NOT NULL,
  `max_qtd_adiv_permitidas` int(10) unsigned NOT NULL,
  `validade_adivertencia` int(10) unsigned NOT NULL,
  `idade_min_exig_doc` int(10) unsigned NOT NULL,
  `gerar_codigo_perm` varchar(1) COLLATE utf8_unicode_ci DEFAULT 's',
  `exigir_cracha_entrada` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exigir_cnh_entrada` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exigir_placa` tinyint(1) NOT NULL DEFAULT 0,
  `id_usuario` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_update` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filipeta_permanente` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cpf_filipeta` tinyint(1) DEFAULT 0,
  `placa_filipeta` tinyint(1) DEFAULT 0,
  `ver_registro_permanente` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 's',
  `horario_liberacao_inicial` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0600',
  `horario_liberacao_final` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '2200',
  `tempo_liberacoes` int(11) NOT NULL DEFAULT 3,
  `lista_ferramentas` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 's',
  `campo_tel` enum('t','p','v','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 't',
  `campo_nascimento` enum('t','p','v','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 't',
  `campo_cpf` enum('t','p','v','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 't',
  `campo_mae` enum('t','p','v','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 't',
  `campo_pai` enum('t','p','v','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 't',
  `campo_cnh` enum('t','p','v','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 't',
  `botoeira` int(11) NOT NULL DEFAULT 0,
  `permanente_academia` tinyint(4) DEFAULT 0,
  `possui_academia` tinyint(4) DEFAULT 0,
  `academia_atestado` tinyint(1) DEFAULT 0,
  `academia_financeiro` tinyint(1) DEFAULT 0,
  `camera_documento` tinyint(1) DEFAULT 0,
  `panico_instrucao1` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `panico_instrucao2` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `panico_instrucao3` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `lpr_entrada_saida` tinyint(1) NOT NULL DEFAULT 0,
  `saida_automatica_visitante` enum('t','p','v','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
  `voltar_tela_inicial` tinyint(1) NOT NULL DEFAULT 0,
  `controle_facial` tinyint(1) NOT NULL DEFAULT 0,
  `possui_rastreio` tinyint(1) NOT NULL DEFAULT 0,
  `permitir_entrada_alug_associado` tinyint(1) NOT NULL DEFAULT 1,
  `permitir_liberacao_alug_associado` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracao_sistema`
--

LOCK TABLES `configuracao_sistema` WRITE;
/*!40000 ALTER TABLE `configuracao_sistema` DISABLE KEYS */;
INSERT INTO `configuracao_sistema` VALUES (1,20,3,5,15,'n','s','s',0,'','','s',1,0,'s','0600','2200',60,'s','t','t','n','v','t','t',1,1,1,1,1,1,NULL,NULL,NULL,0,'n',0,1,1,1,1);
/*!40000 ALTER TABLE `configuracao_sistema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta_bancarias`
--

DROP TABLE IF EXISTS `conta_bancarias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conta_bancarias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idbanco` int(10) unsigned DEFAULT NULL,
  `tipo_banco` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Bancária ou caixa',
  `agencia` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `conta` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Conta corrente, poupança, conta investimento ou caixa',
  `descricao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `operacao` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `relatorio` tinyint(1) unsigned DEFAULT NULL,
  `saldo` decimal(20,2) NOT NULL DEFAULT 0.00,
  `data_saldo_inicial` date DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conta_bancarias_idbanco_foreign` (`idbanco`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta_bancarias`
--

LOCK TABLES `conta_bancarias` WRITE;
/*!40000 ALTER TABLE `conta_bancarias` DISABLE KEYS */;
INSERT INTO `conta_bancarias` VALUES (1,1,'bancária','4319','28002-2','CONTA CORRENTE',NULL,'0',1,0.00,NULL,NULL,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(2,2,'bancária','4308','415262','CONTA CORRENTE',NULL,'',0,0.00,'2021-02-26',NULL,'2021-02-26 22:19:10','2021-02-26 22:19:10'),(3,2,'bancária','4308','415262','CONTA CORRENTE',NULL,'',0,100.00,'2021-02-26',NULL,'2021-02-26 22:19:28','2021-02-26 22:19:28');
/*!40000 ALTER TABLE `conta_bancarias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta_recebimentos`
--

DROP TABLE IF EXISTS `conta_recebimentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conta_recebimentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_configuracao_carteira` int(10) unsigned NOT NULL,
  `id_layout_remessa` int(10) unsigned NOT NULL,
  `idimovel` int(10) unsigned DEFAULT NULL,
  `idassociado` int(10) unsigned DEFAULT NULL,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `descricao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_agendamento` date DEFAULT NULL,
  `numero_parcelas` tinyint(4) DEFAULT NULL,
  `numero_comprovante` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Taxa (TX), Avulso (AV), Antigo (AN) ou Acordo (AC)',
  `motivo_cancelamento` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancelamento` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `valor_total` decimal(15,2) NOT NULL,
  `valor_original` decimal(15,2) NOT NULL,
  `total_recebido` decimal(15,2) DEFAULT 0.00,
  `total_provisionado` decimal(15,2) DEFAULT 0.00,
  `saldo_receber` decimal(15,2) DEFAULT 0.00,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conta_recebimentos_id_configuracao_carteira_foreign` (`id_configuracao_carteira`),
  KEY `conta_recebimentos_id_layout_remessa_foreign` (`id_layout_remessa`),
  KEY `conta_recebimentos_idimovel_foreign` (`idimovel`),
  KEY `conta_recebimentos_idassociado_foreign` (`idassociado`),
  KEY `conta_recebimentos_id_empresa_foreign` (`id_empresa`),
  CONSTRAINT `conta_recebimentos_id_configuracao_carteira_foreign` FOREIGN KEY (`id_configuracao_carteira`) REFERENCES `configuracao_carteiras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conta_recebimentos_id_empresa_foreign` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  CONSTRAINT `conta_recebimentos_id_layout_remessa_foreign` FOREIGN KEY (`id_layout_remessa`) REFERENCES `layout_remessas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conta_recebimentos_idassociado_foreign` FOREIGN KEY (`idassociado`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conta_recebimentos_idimovel_foreign` FOREIGN KEY (`idimovel`) REFERENCES `imovel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta_recebimentos`
--

LOCK TABLES `conta_recebimentos` WRITE;
/*!40000 ALTER TABLE `conta_recebimentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `conta_recebimentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contas`
--

DROP TABLE IF EXISTS `contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fatura_der` tinyint(4) NOT NULL DEFAULT 1,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fluxo` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'DESPESA ou RECEITA',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conta_pai` int(11) DEFAULT NULL COMMENT 'Conta pai',
  `ordem_codigo` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'NULL' COMMENT 'Ordem/Código da conta',
  `id_plano_conta` int(10) unsigned DEFAULT NULL COMMENT 'ID de plano de contas',
  `categoria` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 => Taxa, 2 => Fundo, 3 => Outros, 4 => Custas, 5 => Multa, 6 => Juros, 7 => Descontos, 8 => Juridico, 9 => Correcoes, 10 => Abatimentos',
  PRIMARY KEY (`id`),
  KEY `contas_id_plano_conta_foreign` (`id_plano_conta`),
  CONSTRAINT `contas_id_plano_conta_foreign` FOREIGN KEY (`id_plano_conta`) REFERENCES `plano_contas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contas`
--

LOCK TABLES `contas` WRITE;
/*!40000 ALTER TABLE `contas` DISABLE KEYS */;
INSERT INTO `contas` VALUES (1,1,'Taxa Manutenção m2','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(2,1,'Fundo de Reserva','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(3,1,'Multa','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(4,1,'Juros','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(5,1,'Correção','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(6,1,'Custos Adicionais','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(7,1,'Descontos','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(8,1,'Abatimento','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1),(9,1,'Jurídico','RECEITA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `contas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contas_especiais`
--

DROP TABLE IF EXISTS `contas_especiais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contas_especiais` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_plano_conta` int(10) unsigned DEFAULT NULL COMMENT 'ID de plano de contas',
  `id_conta` int(10) unsigned DEFAULT NULL COMMENT 'ID de contas',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contas_especiais_id_plano_conta_foreign` (`id_plano_conta`),
  KEY `contas_especiais_id_conta_foreign` (`id_conta`),
  CONSTRAINT `contas_especiais_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`),
  CONSTRAINT `contas_especiais_id_plano_conta_foreign` FOREIGN KEY (`id_plano_conta`) REFERENCES `plano_contas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contas_especiais`
--

LOCK TABLES `contas_especiais` WRITE;
/*!40000 ALTER TABLE `contas_especiais` DISABLE KEYS */;
/*!40000 ALTER TABLE `contas_especiais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controle_login`
--

DROP TABLE IF EXISTS `controle_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controle_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `data_login` datetime DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_dispositivo` int(11) DEFAULT NULL,
  `data_logoff` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_USUARIO` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=500 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controle_login`
--

LOCK TABLES `controle_login` WRITE;
/*!40000 ALTER TABLE `controle_login` DISABLE KEYS */;
INSERT INTO `controle_login` VALUES (1,1,'2019-11-25 19:18:50','',0,NULL),(2,1,'2019-11-25 20:24:07','',0,NULL),(3,1,'2019-11-26 08:37:18','',0,NULL),(4,1,'2019-11-26 13:54:59','',0,NULL),(5,1,'2019-11-27 09:52:16','',0,NULL),(6,1,'2019-11-28 11:55:50','',0,NULL),(7,1,'2019-11-29 10:27:42','',0,NULL),(8,1,'2019-11-29 10:27:59','',0,NULL),(9,1,'2019-11-29 10:46:03','',0,NULL),(10,1,'2019-11-29 14:48:59','',0,NULL),(11,1,'2019-12-02 09:13:23','',0,NULL),(12,1,'2019-12-02 11:06:06','',0,NULL),(13,1,'2019-12-02 16:06:11','',0,NULL),(14,1,'2019-12-02 17:17:34','',0,NULL),(15,1,'2019-12-03 12:49:00','',0,NULL),(16,1,'2019-12-03 16:39:31','',0,NULL),(17,1,'2019-12-03 17:02:34','',0,NULL),(18,1,'2019-12-03 18:08:56','',0,NULL),(19,1,'2019-12-04 08:49:57','',0,NULL),(20,1,'2019-12-04 09:43:56','',0,NULL),(21,1,'2019-12-04 10:21:34','',0,NULL),(22,1,'2019-12-04 10:25:56','',0,NULL),(23,1,'2019-12-04 18:09:33','',0,NULL),(24,1,'2019-12-06 09:28:15','',0,NULL),(25,1,'2019-12-06 09:44:35','',0,NULL),(26,1,'2019-12-09 09:40:30','',0,NULL),(27,1,'2019-12-09 11:58:06','',0,NULL),(28,1,'2019-12-09 17:52:30','',0,NULL),(29,1,'2019-12-09 17:54:10','',0,NULL),(30,1,'2019-12-10 11:43:45','',0,NULL),(31,1,'2019-12-10 15:35:56','',0,NULL),(32,1,'2019-12-10 17:39:46','',0,NULL),(33,1,'2019-12-11 09:41:41','',0,NULL),(34,1,'2019-12-11 11:50:40','',0,NULL),(35,1,'2019-12-11 14:19:35','',0,NULL),(36,1,'2019-12-11 15:05:46','',0,NULL),(37,1,'2019-12-11 15:07:16','',0,NULL),(38,1,'2019-12-12 10:11:12','',0,NULL),(39,1,'2019-12-13 08:40:15','',0,NULL),(40,1,'2019-12-13 10:17:12','',0,NULL),(41,1,'2019-12-13 14:17:15','',0,NULL),(42,1,'2019-12-13 17:11:19','',0,NULL),(43,1,'2019-12-16 08:31:33','',0,NULL),(44,1,'2019-12-16 09:04:23','',0,NULL),(45,1,'2019-12-16 09:59:39','',0,NULL),(46,1,'2019-12-16 16:11:05','',0,NULL),(47,1,'2019-12-17 08:28:32','',0,NULL),(48,1,'2019-12-17 09:20:07','',0,NULL),(49,1,'2019-12-17 09:45:09','',0,NULL),(50,1,'2019-12-17 10:07:00','',0,NULL),(51,1,'2019-12-17 11:47:58','',0,NULL),(52,1,'2019-12-17 17:37:25','',0,NULL),(53,1,'2019-12-18 10:03:23','',0,NULL),(54,1,'2019-12-18 11:52:59','',0,NULL),(55,1,'2019-12-18 13:36:56','',0,NULL),(56,1,'2019-12-18 17:31:42','',0,NULL),(57,1,'2019-12-19 09:34:52','',0,NULL),(58,1,'2019-12-19 11:16:51','',0,NULL),(59,1,'2019-12-19 12:10:03','',0,NULL),(60,1,'2019-12-19 16:27:49','',0,NULL),(61,1,'2019-12-20 08:44:42','',0,NULL),(62,1,'2019-12-20 16:30:16','',0,NULL),(63,1,'2020-01-02 09:51:23','',0,NULL),(64,1,'2020-01-03 13:44:53','',0,NULL),(65,1,'2020-01-06 10:53:38','',0,NULL),(66,1,'2020-01-06 18:58:44','',0,NULL),(67,1,'2020-01-08 16:12:18','',0,NULL),(68,1,'2020-01-10 08:32:12','',0,NULL),(69,1,'2020-01-10 10:28:41','',0,NULL),(70,1,'2020-01-10 14:22:27','',0,NULL),(71,1,'2020-01-10 18:53:40','',0,NULL),(72,1,'2020-01-11 08:43:29','',0,NULL),(73,2,'2020-01-11 08:45:28','',0,NULL),(74,1,'2020-01-17 09:45:42','',0,NULL),(75,1,'2020-01-19 10:33:35','',0,NULL),(76,1,'2020-01-20 19:11:29','',0,NULL),(77,1,'2020-01-21 11:23:00','',0,NULL),(78,1,'2020-01-22 08:50:15','',0,NULL),(79,1,'2020-01-22 09:16:59','',0,NULL),(80,1,'2020-01-23 10:03:23','',0,NULL),(81,1,'2020-01-24 08:51:16','',0,NULL),(82,1,'2020-01-24 09:15:15','',0,NULL),(83,1,'2020-01-27 09:22:31','',0,NULL),(84,1,'2020-01-27 11:42:32','',0,NULL),(85,1,'2020-01-27 17:27:31','',0,NULL),(86,1,'2020-01-28 09:21:03','',0,NULL),(87,1,'2020-01-28 13:57:43','',0,NULL),(88,1,'2020-01-29 14:06:47','',0,NULL),(89,1,'2020-01-30 08:08:54','',0,NULL),(90,1,'2020-01-31 17:58:10','',0,NULL),(91,1,'2020-02-03 11:28:39','',0,NULL),(92,1,'2020-02-03 12:09:16','',0,NULL),(93,1,'2020-02-03 15:27:34','',0,NULL),(94,1,'2020-02-03 16:43:58','',0,NULL),(95,1,'2020-02-04 10:02:48','',0,NULL),(96,1,'2020-02-04 12:29:53','',0,NULL),(97,1,'2020-02-04 15:21:57','',0,NULL),(98,1,'2020-02-05 14:47:44','',0,NULL),(99,1,'2020-02-05 16:54:23','',0,NULL),(100,1,'2020-02-05 17:05:05','',0,NULL),(101,1,'2020-02-07 17:11:41','',0,NULL),(102,1,'2020-02-10 10:13:28','',0,NULL),(103,1,'2020-02-12 11:53:56','',0,NULL),(104,1,'2020-02-12 15:23:40','',0,NULL),(105,1,'2020-02-13 13:04:00','',0,NULL),(106,1,'2020-02-14 08:10:53','',0,NULL),(107,1,'2020-02-14 08:51:18','',0,NULL),(108,1,'2020-02-14 09:48:30','',0,NULL),(109,1,'2020-02-17 08:38:23','',0,NULL),(110,1,'2020-02-17 10:48:34','',0,NULL),(111,1,'2020-02-17 10:56:47','',0,NULL),(112,1,'2020-02-17 11:08:04','',0,NULL),(113,1,'2020-02-17 14:11:52','',0,NULL),(114,1,'2020-02-17 18:48:19','',0,NULL),(115,1,'2020-02-18 09:59:38','',0,NULL),(116,1,'2020-02-18 17:11:10','',0,NULL),(117,1,'2020-02-19 09:02:13','',0,NULL),(118,1,'2020-02-21 09:32:16','',0,NULL),(119,1,'2020-02-21 11:00:03','',0,NULL),(120,1,'2020-02-21 11:28:23','',0,NULL),(121,1,'2020-02-21 15:19:40','',0,NULL),(122,1,'2020-02-26 14:42:10','',0,NULL),(123,1,'2020-02-28 08:26:26','',0,NULL),(124,1,'2020-02-28 08:39:10','',0,NULL),(125,1,'2020-02-28 10:35:05','',0,NULL),(126,1,'2020-02-28 16:29:05','',0,NULL),(127,1,'2020-03-02 08:03:03','',0,NULL),(128,1,'2020-03-02 10:34:41','',0,NULL),(129,1,'2020-03-02 14:08:20','',0,NULL),(130,1,'2020-03-02 14:15:57','',0,NULL),(131,1,'2020-03-03 10:31:28','',0,NULL),(132,1,'2020-03-03 13:25:21','',0,NULL),(133,1,'2020-03-04 08:15:58','',0,NULL),(134,1,'2020-03-04 09:19:55','',0,NULL),(135,1,'2020-03-04 09:59:53','',0,NULL),(136,1,'2020-03-05 09:23:14','',0,NULL),(137,1,'2020-03-05 15:26:25','',0,NULL),(138,1,'2020-03-05 16:14:45','',0,NULL),(139,1,'2020-03-06 10:59:51','',0,NULL),(140,1,'2020-03-07 09:22:54','',0,NULL),(141,1,'2020-03-10 09:14:00','',0,NULL),(142,1,'2020-03-10 15:39:38','',0,NULL),(143,1,'2020-03-11 08:22:13','',0,NULL),(144,1,'2020-03-12 13:56:38','',0,NULL),(145,1,'2020-03-13 16:30:06','',0,NULL),(146,1,'2020-03-16 10:00:14','',0,NULL),(147,1,'2020-03-16 10:11:49','',0,NULL),(148,1,'2020-03-17 10:32:00','',0,NULL),(149,1,'2020-03-18 10:58:43','',0,NULL),(150,1,'2020-03-18 18:05:30','',0,NULL),(151,1,'2020-03-20 07:16:38','',0,NULL),(152,1,'2020-03-20 09:02:47','',0,NULL),(153,1,'2020-03-20 09:06:54','',0,NULL),(154,1,'2020-03-23 09:27:13','',0,NULL),(155,1,'2020-03-26 07:56:09','',0,NULL),(156,1,'2020-03-26 22:29:55','',0,NULL),(157,1,'2020-03-27 01:33:49','',0,NULL),(158,1,'2020-03-27 11:54:06','',0,NULL),(159,1,'2020-03-28 18:10:39','172.31.1.67',0,NULL),(160,1,'2020-03-30 07:55:18','',0,NULL),(161,1,'2020-03-31 09:02:34','',0,NULL),(162,1,'2020-04-01 14:17:52','',0,NULL),(163,1,'2020-04-02 10:06:07','',0,NULL),(164,1,'2020-04-03 08:55:26','',0,NULL),(165,1,'2020-04-03 13:53:58','',0,NULL),(166,1,'2020-04-03 15:34:59','',0,NULL),(167,1,'2020-04-06 11:32:59','',0,NULL),(168,1,'2020-04-06 12:44:54','',0,NULL),(169,1,'2020-04-07 16:01:52','',0,NULL),(170,1,'2020-04-07 18:03:04','',0,NULL),(171,1,'2020-04-07 18:03:40','',0,NULL),(172,1,'2020-04-08 09:58:03','',0,NULL),(173,1,'2020-04-08 17:26:25','',0,NULL),(174,1,'2020-04-09 15:17:15','',0,NULL),(175,1,'2020-04-09 15:26:59','',0,NULL),(176,1,'2020-04-09 16:50:24','',0,NULL),(177,1,'2020-04-13 13:47:24','',0,NULL),(178,1,'2020-04-13 14:59:24','',0,NULL),(179,1,'2020-04-15 17:41:35','',0,NULL),(180,1,'2020-04-16 08:54:41','',0,NULL),(181,1,'2020-04-16 09:21:05','',0,NULL),(182,1,'2020-04-16 14:33:58','',0,NULL),(183,1,'2020-04-16 15:42:23','',0,NULL),(184,1,'2020-04-16 15:42:32','',0,NULL),(185,1,'2020-04-17 08:22:11','',0,NULL),(186,1,'2020-04-17 14:11:50','',0,NULL),(187,1,'2020-04-17 15:21:29','',0,NULL),(188,1,'2020-04-17 16:15:27','',0,NULL),(189,1,'2020-04-18 14:11:41','',0,NULL),(190,1,'2020-04-19 14:39:39','',0,NULL),(191,1,'2020-04-19 15:51:02','',0,NULL),(192,1,'2020-04-20 09:18:01','',0,NULL),(193,1,'2020-04-20 10:12:18','',0,NULL),(194,1,'2020-04-20 10:40:24','',0,NULL),(195,1,'2020-04-21 09:12:44','',0,NULL),(196,1,'2020-04-24 13:55:19','',0,NULL),(197,1,'2020-04-27 15:49:21','',0,NULL),(198,1,'2020-04-27 17:22:27','',0,NULL),(199,1,'2020-04-28 08:49:34','',0,NULL),(200,1,'2020-04-28 08:59:21','',0,NULL),(201,1,'2020-04-28 09:56:07','',0,NULL),(202,1,'2020-04-28 09:58:29','',0,NULL),(203,1,'2020-04-29 08:14:56','',0,NULL),(204,1,'2020-04-29 09:32:36','',0,NULL),(205,1,'2020-04-29 11:21:12','',0,NULL),(206,1,'2020-04-29 17:25:25','',0,NULL),(207,1,'2020-04-30 08:47:04','',0,NULL),(208,1,'2020-04-30 10:15:56','',0,NULL),(209,1,'2020-05-11 15:12:08','',0,NULL),(210,1,'2020-05-11 18:39:11','',0,NULL),(211,1,'2020-05-12 09:35:40','',0,NULL),(212,1,'2020-05-12 15:50:20','',0,NULL),(213,1,'2020-05-12 15:59:55','',0,NULL),(214,1,'2020-05-12 19:08:46','',0,NULL),(215,1,'2020-05-12 19:48:06','',0,NULL),(216,1,'2020-05-12 19:49:36','',0,NULL),(217,1,'2020-05-13 17:29:50','',0,NULL),(218,1,'2020-05-15 19:22:28','',0,NULL),(219,1,'2020-05-15 19:23:01','',0,NULL),(220,1,'2020-05-18 12:50:32','',0,NULL),(221,1,'2020-05-21 20:21:58','',0,NULL),(222,1,'2020-05-21 20:22:11','',0,NULL),(223,1,'2020-05-22 11:46:46','',0,NULL),(224,1,'2020-05-22 15:01:27','',0,NULL),(225,1,'2020-05-25 16:46:10','',0,NULL),(226,1,'2020-05-26 11:47:12','',0,NULL),(227,1,'2020-05-28 12:22:48','',0,NULL),(228,1,'2020-05-29 12:35:39','',0,NULL),(229,1,'2020-06-03 20:16:38','',0,NULL),(230,1,'2020-06-04 13:21:52','',0,NULL),(231,1,'2020-06-05 13:47:16','',0,NULL),(232,1,'2020-06-05 17:19:26','',0,NULL),(233,1,'2020-06-05 19:37:16','',0,NULL),(234,1,'2020-06-05 19:40:14','',0,NULL),(235,1,'2020-06-05 18:56:56','',0,NULL),(236,1,'2020-06-08 10:05:26','',0,NULL),(237,1,'2020-06-08 13:23:51','',0,NULL),(238,1,'2020-06-08 13:27:03','',0,NULL),(239,1,'2020-06-08 15:20:15','',0,NULL),(240,1,'2020-06-08 15:23:02','',0,NULL),(241,1,'2020-06-08 15:34:03','',0,NULL),(242,1,'2020-06-09 09:25:36','',0,NULL),(243,1,'2020-06-09 11:18:42','',0,NULL),(244,1,'2020-06-09 15:21:57','',0,NULL),(245,1,'2020-06-09 17:22:33','',0,NULL),(246,1,'2020-06-10 08:38:36','',0,NULL),(247,1,'2020-06-10 11:43:56','',0,NULL),(248,1,'2020-06-10 12:25:37','',0,NULL),(249,1,'2020-06-15 10:46:07','',0,NULL),(250,1,'2020-06-16 09:00:08','',0,NULL),(251,1,'2020-06-16 14:10:59','',0,NULL),(252,1,'2020-06-16 14:19:33','',0,NULL),(253,1,'2020-06-17 11:38:50','',0,NULL),(254,1,'2020-06-17 16:46:29','',0,NULL),(255,1,'2020-06-18 08:53:27','',0,NULL),(256,1,'2020-06-18 17:43:39','',0,NULL),(257,1,'2020-06-19 09:05:20','',0,NULL),(258,1,'2020-06-19 10:44:17','',0,NULL),(259,1,'2020-06-19 15:30:47','',0,NULL),(260,1,'2020-06-19 17:51:33','',0,NULL),(261,1,'2020-06-19 17:52:25','',0,NULL),(262,1,'2020-06-22 09:43:53','',0,NULL),(263,1,'2020-06-22 09:46:12','',0,NULL),(264,1,'2020-06-22 09:53:18','',0,NULL),(265,1,'2020-06-22 16:57:07','',0,NULL),(266,1,'2020-06-23 15:15:02','',0,NULL),(267,1,'2020-06-24 09:27:38','',0,NULL),(268,1,'2020-06-24 09:54:36','',0,NULL),(269,1,'2020-06-24 10:19:01','',0,NULL),(270,1,'2020-06-24 10:45:31','',0,NULL),(271,1,'2020-06-24 10:52:26','',0,NULL),(272,1,'2020-06-25 11:58:27','',0,NULL),(273,1,'2020-06-26 09:19:19','',0,NULL),(274,1,'2020-06-26 17:05:48','',0,NULL),(275,1,'2020-06-26 17:14:08','',0,NULL),(276,1,'2020-06-26 17:47:02','',0,NULL),(277,1,'2020-06-29 08:31:29','',0,NULL),(278,1,'2020-06-29 11:40:16','',0,NULL),(279,1,'2020-06-29 16:05:42','',0,NULL),(280,1,'2020-06-30 15:19:15','',0,NULL),(281,1,'2020-06-30 16:10:23','',0,NULL),(282,1,'2020-06-30 18:44:08','',0,NULL),(283,1,'2020-07-01 08:26:30','',0,NULL),(284,1,'2020-07-01 09:14:28','',0,NULL),(285,1,'2020-07-01 10:38:02','',0,NULL),(286,1,'2020-07-01 15:03:23','',0,NULL),(287,1,'2020-07-01 16:09:44','',0,NULL),(288,1,'2020-07-01 16:15:15','',0,NULL),(289,1,'2020-07-01 16:43:23','',0,NULL),(290,1,'2020-07-06 09:45:53','',0,NULL),(291,1,'2020-07-06 14:22:33','',0,NULL),(292,1,'2020-07-06 14:24:33','',0,NULL),(293,1,'2020-07-06 14:54:26','',0,NULL),(294,1,'2020-07-06 17:17:59','',0,NULL),(295,1,'2020-07-07 08:39:18','',0,NULL),(296,1,'2020-07-07 09:49:14','',0,NULL),(297,1,'2020-07-07 09:51:28','',0,NULL),(298,3,'2020-07-07 09:55:00','',0,NULL),(299,1,'2020-07-07 09:56:16','',0,NULL),(300,1,'2020-07-07 16:56:38','',0,NULL),(301,1,'2020-07-08 08:59:32','',0,NULL),(302,1,'2020-07-08 12:12:37','',0,NULL),(303,1,'2020-07-08 14:17:20','',0,NULL),(304,1,'2020-07-09 11:20:46','',0,NULL),(305,1,'2020-07-09 17:46:47','',0,NULL),(306,1,'2020-07-09 18:05:44','',0,NULL),(307,1,'2020-07-09 21:58:55','',0,NULL),(308,1,'2020-07-10 11:23:07','',0,NULL),(309,1,'2020-07-10 17:03:26','',0,NULL),(310,1,'2020-07-10 17:05:28','',0,NULL),(311,1,'2020-07-10 17:30:43','',0,NULL),(312,1,'2020-07-13 14:16:11','',0,NULL),(313,1,'2020-07-14 13:52:17','',0,NULL),(314,1,'2020-07-14 14:59:50','',0,NULL),(315,1,'2020-07-14 15:53:38','',0,NULL),(316,1,'2020-07-14 17:10:11','',0,NULL),(317,1,'2020-07-15 10:20:14','',0,NULL),(318,1,'2020-07-15 12:21:40','',0,NULL),(319,1,'2020-07-15 12:25:45','',0,NULL),(320,1,'2020-07-17 10:39:24','',0,NULL),(321,1,'2020-07-17 11:34:36','',0,NULL),(322,1,'2020-07-20 10:57:59','',0,NULL),(323,1,'2020-07-20 11:47:17','',0,NULL),(324,1,'2020-07-21 15:16:10','',0,NULL),(325,1,'2020-07-21 15:30:33','',0,NULL),(326,1,'2020-07-21 16:16:28','',0,NULL),(327,1,'2020-07-22 08:48:16','',0,NULL),(328,1,'2020-07-22 09:21:24','',0,NULL),(329,1,'2020-07-22 16:40:59','',0,NULL),(330,1,'2020-07-22 17:04:25','',0,NULL),(331,1,'2020-07-23 11:05:28','',0,NULL),(332,1,'2020-07-23 11:58:46','',0,NULL),(333,1,'2020-07-23 15:53:56','',0,NULL),(334,1,'2020-07-23 17:05:09','',0,NULL),(335,1,'2020-07-24 14:27:45','',0,NULL),(336,1,'2020-07-27 11:26:41','',0,NULL),(337,1,'2020-07-28 16:54:50','',0,NULL),(338,1,'2020-07-29 08:40:08','',0,NULL),(339,1,'2020-07-29 09:50:14','',0,NULL),(340,1,'2020-07-29 11:33:48','',0,NULL),(341,1,'2020-07-30 09:00:34','',0,NULL),(342,1,'2020-07-30 17:01:30','',0,NULL),(343,1,'2020-07-31 09:49:34','',0,NULL),(344,1,'2020-07-31 10:12:18','',0,NULL),(345,1,'2020-08-03 16:47:11','',0,NULL),(346,1,'2020-08-06 18:11:27','',0,NULL),(347,1,'2020-08-19 11:17:04','',0,NULL),(348,1,'2020-08-20 01:30:21','',0,NULL),(349,1,'2020-08-21 10:35:30','',0,NULL),(350,1,'2020-08-21 12:39:37','',0,NULL),(351,1,'2020-08-21 15:20:54','',0,NULL),(352,1,'2020-08-21 15:21:57','192.168.232.2',0,NULL),(353,1,'2020-08-21 15:43:05','192.168.232.2',0,NULL),(354,1,'2020-08-21 15:59:04','192.168.232.2',0,NULL),(355,1,'2020-08-21 16:27:24','192.168.232.2',0,NULL),(356,1,'2020-08-21 16:52:42','',0,NULL),(357,1,'2020-08-21 17:28:45','',0,NULL),(358,1,'2020-08-21 18:14:46','',0,NULL),(359,1,'2020-08-22 18:38:19','',0,NULL),(360,1,'2020-08-24 09:10:52','10.0.2.15',0,NULL),(361,1,'2020-08-24 09:47:46','',0,NULL),(362,1,'2020-08-24 10:53:29','',0,NULL),(363,1,'2020-08-24 11:00:17','10.0.2.15',0,NULL),(364,1,'2020-08-24 15:09:51','',0,NULL),(365,1,'2020-08-25 09:10:29','',0,NULL),(366,1,'2020-08-26 10:40:51','',0,NULL),(367,1,'2020-08-27 09:41:06','',0,NULL),(368,1,'2020-08-27 16:36:53','',0,NULL),(369,1,'2020-08-27 18:23:44','',0,NULL),(370,1,'2020-08-28 08:58:17','',0,NULL),(371,1,'2020-08-28 09:20:40','',0,NULL),(372,1,'2020-08-28 15:45:09','',0,NULL),(373,1,'2020-09-01 10:18:43','',0,NULL),(374,1,'2020-09-03 09:51:48','',0,NULL),(375,1,'2020-09-04 09:46:30','',0,NULL),(376,1,'2020-09-08 14:05:31','',0,NULL),(377,1,'2020-09-09 17:24:41','',0,NULL),(378,1,'2020-09-10 16:35:18','',0,NULL),(379,1,'2020-09-11 14:42:33','',0,NULL),(380,1,'2020-09-11 14:45:26','',0,NULL),(381,1,'2020-09-11 14:48:09','',0,NULL),(382,1,'2020-09-11 15:16:16','',0,NULL),(383,1,'2020-09-16 18:01:51','',0,NULL),(384,1,'2020-09-17 17:44:27','',0,NULL),(385,1,'2020-09-21 14:11:15','',0,NULL),(386,1,'2020-09-23 09:22:05','',0,NULL),(387,1,'2020-09-24 17:38:06','',0,NULL),(388,1,'2020-09-25 10:25:15','',0,NULL),(389,1,'2020-09-29 15:32:58','',0,NULL),(390,1,'2020-10-01 11:13:44','',0,NULL),(391,1,'2020-10-02 11:16:05','',0,NULL),(392,1,'2020-10-02 16:05:01','',0,NULL),(393,1,'2020-10-05 10:07:41','',0,NULL),(394,1,'2020-10-06 09:19:28','',0,NULL),(395,1,'2020-10-15 14:13:35','',0,NULL),(396,1,'2020-10-16 09:08:28','',0,NULL),(397,1,'2020-10-20 15:48:09','',0,NULL),(398,1,'2020-10-22 17:44:58','',0,NULL),(399,1,'2020-10-23 14:00:15','',0,NULL),(400,1,'2020-10-29 12:09:16','',0,NULL),(401,1,'2020-10-29 16:10:42','',0,NULL),(402,1,'2020-11-04 13:17:19','',0,NULL),(403,1,'2020-11-04 19:10:32','',0,NULL),(404,1,'2020-11-05 13:08:24','',0,NULL),(405,1,'2020-11-06 12:56:21','',0,NULL),(406,1,'2020-11-06 16:01:09','',0,NULL),(407,1,'2020-11-06 16:06:37','',0,NULL),(408,1,'2020-11-06 17:09:22','',0,NULL),(409,1,'2020-11-06 17:21:21','',0,NULL),(410,1,'2020-11-06 17:57:18','',0,NULL),(411,1,'2020-11-10 18:40:21','',0,NULL),(412,1,'2020-11-11 13:16:57','',0,NULL),(413,1,'2020-11-18 14:47:35','',0,NULL),(414,1,'2020-11-19 16:18:47','',0,NULL),(415,1,'2020-11-23 13:11:28','',0,NULL),(416,1,'2020-11-23 16:49:56','',0,NULL),(417,1,'2020-11-24 18:35:28','',0,NULL),(418,1,'2020-11-26 11:50:23','',0,NULL),(419,1,'2020-11-27 11:13:00','',0,NULL),(420,1,'2020-11-27 11:22:17','',0,NULL),(421,1,'2020-11-27 11:29:19','',0,NULL),(422,1,'2020-11-30 12:55:48','',0,NULL),(423,1,'2020-11-30 12:57:00','',0,NULL),(424,1,'2020-11-30 12:57:33','',0,NULL),(425,1,'2020-11-30 13:01:35','',0,NULL),(426,1,'2020-11-30 16:35:41','',0,NULL),(427,1,'2020-11-30 17:21:07','',0,NULL),(428,1,'2020-11-30 17:38:22','',0,NULL),(429,1,'2020-11-30 17:20:24','',0,NULL),(430,1,'2020-11-30 17:21:02','',0,NULL),(431,1,'2020-11-30 17:21:33','',0,NULL),(432,1,'2020-11-30 18:29:36','',0,NULL),(433,1,'2020-11-30 17:30:48','',0,NULL),(434,1,'2020-12-01 16:45:51','',0,NULL),(435,4,'2020-12-01 16:47:56','',0,NULL),(436,4,'2020-12-01 17:20:30','192.168.1.200',0,NULL),(437,1,'2020-12-01 17:59:45','',0,NULL),(438,1,'2020-12-02 09:48:34','',0,NULL),(439,1,'2020-12-02 09:57:50','192.168.1.200',0,NULL),(440,1,'2020-12-02 09:59:32','192.168.1.200',0,NULL),(441,4,'2020-12-02 10:19:11','',0,NULL),(442,1,'2020-12-02 10:41:46','',0,NULL),(443,1,'2020-12-02 11:58:20','192.168.1.200',0,NULL),(444,1,'2020-12-02 12:00:32','192.168.1.200',0,NULL),(445,1,'2020-12-02 12:15:08','',0,NULL),(446,1,'2020-12-02 12:39:28','192.168.1.200',0,NULL),(447,1,'2020-12-02 15:15:26','192.168.1.200',0,NULL),(448,1,'2020-12-02 16:06:49','',0,NULL),(449,4,'2020-12-02 17:38:54','',0,NULL),(450,4,'2020-12-02 18:00:49','',0,NULL),(451,1,'2020-12-03 09:47:22','',0,NULL),(452,4,'2020-12-03 10:34:32','',0,NULL),(453,1,'2020-12-03 10:43:46','',0,NULL),(454,1,'2020-12-04 11:43:38','',0,NULL),(455,4,'2020-12-07 09:11:44','',0,NULL),(456,4,'2020-12-07 10:18:25','',0,NULL),(457,1,'2020-12-07 11:25:27','',0,NULL),(458,1,'2020-12-07 17:31:12','192.168.1.200',0,NULL),(459,4,'2020-12-08 10:00:30','',0,NULL),(460,4,'2020-12-08 10:25:29','',0,NULL),(461,4,'2020-12-08 12:16:53','',0,NULL),(462,4,'2020-12-09 07:40:12','',0,NULL),(463,1,'2020-12-10 10:43:05','',0,NULL),(464,1,'2020-12-10 10:46:44','',0,NULL),(465,1,'2020-12-11 10:19:38','',0,NULL),(466,1,'2020-12-11 12:36:43','',0,NULL),(467,4,'2020-12-11 15:58:47','',0,NULL),(468,1,'2020-12-12 19:14:05','',0,NULL),(469,1,'2020-12-14 10:06:22','',0,NULL),(470,1,'2020-12-14 12:02:13','',0,NULL),(471,1,'2020-12-15 10:25:22','',0,NULL),(472,1,'2020-12-16 11:18:03','',0,NULL),(473,1,'2020-12-17 13:58:41','',0,NULL),(474,4,'2020-12-18 15:26:46','',0,NULL),(475,1,'2020-12-21 11:18:07','',0,NULL),(476,1,'2020-12-22 12:21:19','',0,NULL),(477,1,'2020-12-23 18:58:20','',0,NULL),(478,1,'2020-12-28 09:55:50','',0,NULL),(479,1,'2020-12-28 13:13:08','',0,NULL),(480,1,'2021-01-05 15:52:56','',0,NULL),(481,1,'2021-01-12 11:53:09','',0,NULL),(482,1,'2021-01-14 15:54:04','',0,NULL),(483,1,'2021-01-15 12:35:05','',0,NULL),(484,1,'2021-02-04 15:18:54','',0,NULL),(485,1,'2021-02-05 13:22:25','',0,NULL),(486,1,'2021-02-08 21:32:18','',0,NULL),(487,1,'2021-02-08 22:52:31','',0,NULL),(488,1,'2021-02-09 12:53:43','',0,NULL),(489,1,'2021-02-16 17:45:17','',0,NULL),(490,1,'2021-02-17 12:19:58','',0,NULL),(491,1,'2021-02-24 16:07:56','',0,NULL),(492,1,'2021-02-25 12:43:06','',0,NULL),(493,1,'2021-02-25 12:52:12','',0,NULL),(494,1,'2021-02-25 16:00:17','',0,NULL),(495,1,'2021-02-26 15:14:40','',0,NULL),(496,1,'2021-02-26 15:32:45','',0,NULL),(497,1,'2021-02-26 16:36:14','',0,NULL),(498,1,'2021-03-01 10:18:03','',0,NULL),(499,1,'2021-03-01 15:50:54','',0,NULL);
/*!40000 ALTER TABLE `controle_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creditos`
--

DROP TABLE IF EXISTS `creditos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creditos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_imovel` int(11) DEFAULT NULL COMMENT 'ID do imóvel',
  `id_empresa` int(11) DEFAULT NULL COMMENT 'ID da empresa',
  `valor_credito` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Valor de crédito originário de cancelamento de recebimento de parcelas de boletos para uso em novos acordos e demais pagamentos.',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditos`
--

LOCK TABLES `creditos` WRITE;
/*!40000 ALTER TABLE `creditos` DISABLE KEYS */;
/*!40000 ALTER TABLE `creditos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dados_cheques`
--

DROP TABLE IF EXISTS `dados_cheques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dados_cheques` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `valor` decimal(20,2) NOT NULL,
  `data_emissao` date NOT NULL,
  `data_predatado` date NOT NULL,
  `data_vencimento` date NOT NULL,
  `codigo_banco` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `agencia` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `conta_bancaria` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `numero` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dados_cheques`
--

LOCK TABLES `dados_cheques` WRITE;
/*!40000 ALTER TABLE `dados_cheques` DISABLE KEYS */;
/*!40000 ALTER TABLE `dados_cheques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `departamentos_descricao_unique` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

LOCK TABLES `departamentos` WRITE;
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
INSERT INTO `departamentos` VALUES (1,'GERENCIA',NULL,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(2,'ADMINISTRATIVO',NULL,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(3,'FINANCEIRO',NULL,'2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `digital`
--

DROP TABLE IF EXISTS `digital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digital` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(10) unsigned NOT NULL,
  `formato_template` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ISO_FMR',
  `dedo_panico` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `digital` blob DEFAULT NULL,
  `data_hora` datetime DEFAULT NULL,
  `ativa` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_2` (`id_pessoa`,`ativa`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `digital`
--

LOCK TABLES `digital` WRITE;
/*!40000 ALTER TABLE `digital` DISABLE KEYS */;
INSERT INTO `digital` VALUES (1,8,'PKLITE','7','�U\0\0\0\0X��Pa4�=\0+��\0D���\0Sd��\0Vc�^\0X�d@�\0_:�\0eAAJ\0hVA�\0lg*�f\0|�d��\0��d��\0�O��\0�d��\0��O@�\0�dAW\0��d��\0�dA�\0�kd�:\0��d�L\0��dA�\0�_A\Z\0��dAX\0�od��\0�d��\0�d�V\0��d�w\0�/d��\0�_V��\0�d@�\0��d��\0�d�O\0�dA(\0��A�l\0��d�6\0�kAA\"�d�\n�d��[VA	�A�p�d@<2�*@�63d��8�d�~?�d��M?dA�T��`c�d@�m?d@J{K@��3H���?3�^�KH\0\0(�','2019-11-29 15:01:18','s'),(2,8,'PKLITE','2','��\0\0\0\0X��QZO@�\0�*A;\0/�d��\01dAx\0=f#��\0?�.\0?nd��\0D�dA\0Ej3�\0Jvd@�\0L:AL\0ObdA\0\0P�d�p\0ZH��\0]\nd�9\0gjd�\0t�dA)\0�nd@�\0�vd@�\0�d�J\0�bdA�\0�bO@�\0��V��\0��dAv\0��d@~\0��d�\0��d��\0�\ZdAc\0��d@r\0Үd��\0��dA�\0�^d@�\0�A��\0��d�~\0��d�X\0��VA|\0VdAn�d@��dAK�d��\Z6dA,\Z�d@�5�dA7�d��EFd�sJ�dA]S�d@�\\JVA<\\�dA\ng6]��iB3ALp�d��p�d��rJ#���Zd���VA��:���FA��^d���n*A\Z�\nV��d�.�d@��r:���bd@��rd�O��AAe�vA��fd����AA��nV�l�v�P��3At�z*���~d�����B��3AR��:@���V���rO\0\0\0\0\0','2019-11-29 15:01:18','s'),(3,8,'PKLITE','3','�	\0\0\0\0X��RSR@�\0���\0z]A\0&�O@�\02�d�\06vd�_\0;j*@�\0B\nd�n\0K�dA�\0N��\0P�d�9\0Vfd��\0W�d@W\0[\Z:�3\0jfd��\0kd��\0u�H�p\0uVd@�\0{zH�D\0|�d�\0}jd�U\0�&d@�\0��d�D\0�^d@�\0�dA�\0��*��\0�Vd��\0�\Zd�\0��d@�\0��d@�\0��dA�\0��dAp\0��d��\0��dA\0��d��\0��H@�\0�Vd@�\0�\Zd@�\0�d�s\0�*d��\0�Rd��\0��:���A�P2d�: >@b �d�?(�d��>F�jC�d�XG2V@�M�d��MN�G_�d@�g2d��t�d���:d���ZV�j�A@��\ZHA#�.O�D�&]@��\"H���#A|�j�1�A��&*A�:A��n3�d��s�@��*���*�;�A���\n��φA|�z:�S�A�\r�\ndAA�dAb�:���O�E�V�S�d\0\0\0�\0\0','2019-11-29 15:01:18','s'),(4,8,'PKLITE','4','��\0\0\0\0X��PP@��\0#A\0 �#��\0%�#��\0-�d��\0.d��\05�#@�\0C�d�b\0HAl\0Ic3�\'\0KgdAs\0N���\0`�d�\n\0b�dA0\0scd��\0xd�{\0��d�\0�gd��\0�[3A\0��d@�\0�d��\0��dA#\0��d@�\0��d�\0�Od�\ZGd�?�OA�B���DCd@�J�d�~L�*A@T�A4U�*��UC#AUZ?A@�\\Kd�he�HA4h?A`j�#A�jG@�t?d��zKd�v�+@���O@`�G#�Z��@��O:@��G@��_*AF�+]A�\'�f�\']���WA&�#OAL�d�-�]���wd���gAI�AA<�A���w@��w:�d�A�V����A\0\0\0�\0�','2019-11-29 15:01:18','s'),(5,8,'PKLITE','5','�a\0\0\0\0X��MX6A!\0�*�\0&�3@�\00\n#Al\00f3�m\09�O@�\0B:A\0EzdA�\0MbH��\0qZ:��\0s�d��\0v�:�L\0y�dA*\0{~dA�\0{bd��\0��O@�\0�\ZdA]\0�fd�4\0��dA]\0��d��\0��H��\0�\":A7\0��dA�\0�RdA\0��d@�\0�&H��\0��d��\0�d��\0�V��\0�Bd��\0�2A���d�K�d��)�d�i-�dA0�d��:BO��=�V��F.d@�Y23�g�@�m\ZA�Sw*#@�|:��|3A2�3���d���A�m�*��\nd�e����\ndA.�d���\nA@�͆]\0\0\0�','2019-11-29 15:01:18','s'),(6,156,'PKLITE','2','��\0\0\0\0X��QZO��\0	�d�\0\r�VAO\0!�OA\0&�d@�\0+\Zd�b\08j]�{\0<b#��\0C^#A	\0N�d��\0b�d�2\0j�d�j\0�&dA	\0��]@R\0�6@�\0�\"d��\0�.dAe\0��d�\0��:A�\0�N*�c\0��dA\0\0��]AS\0��d@L\0�:�c\0�&d@�\0�\"O@f\0îdA�\0�N@�\0�\"3@�\0ߪH�{\0��d�\0�d�6\0�d��\0�dAF\0��d��.d�1:d��.d�m\Z�d�Y�d@�.&d@T8\Z:�f=�O��>\"d�kJ�3��NO�PP3��Rd@�ZAA�`bd�he]��e\n#A!ed@�fd@�j\Zd��jrV��nA@�~\nd���A6�\ZH����:��d�b�A.�H�������d�<�#@�������3�*��d����#AX�z3@���d@��~3AT�z*�|�r]A<��3A^�~3A\'�@��^:\0\0\0�\0\0\0��@\0\n�\0\0\0\0oZ\rm�����������\r�����\03\0\0�� ������*6��/�	#��\'�\Z������\Z��\0��������������%��������%\0�%���������','2020-12-07 17:11:00','s'),(7,156,'PKLITE','3','�?\0\0\0\0X��OL[��\0\n�:��\0�#A\0�O@�\0\n:A$\0fA0\0$n*��\0+\":��\0,d@�\0.�:��\01�d@�\0=\"V�\0D�d��\0I\ZdA\0Jzd��\0T\nA��\0U�A@n\0a2*�1\0m�d�k\0r6#A�\0yZd@�\0{\"d��\0}.dA�\0�R:AN\0�^d�8\0��d��\0�V�v\0�VdA�\0��dA[\0��d�K\0�Zd�\0��d��\0�2d��\0�R@�\0�VA!\0��:�*\0�ZO�\0��:A&\0��HA�\0�NA\0�B*A\0ٶ*AI\0��d��\0�J@�\0�:A<\0��dAo\0�Nd�p�d��2d@�*d��\r��.�d�O �d��$&d@�(2]A�(RH�D0�d�JI�V@�a\"OA�gbV�ni^d�k*d@�l3@�m\ZO��u*�lufd��{\nd@�}AL�\n]�8�\Zd���d���jAA�\"d��\Zd���vH@��\nd�l�~3A#�d���d�<��d����O@��~*Aj������2��d����*@��V�\rƂOA,ӖVA\r����#���vH\0\0\0�\0\0\0N�@\0\n�\05\07\0\0Z\r��������\n����������	%\n�������\n\r��������!�����\0&��*������	\Z����3��%$����\n$������!�\0�\0�����','2020-12-07 17:11:00','s'),(8,156,'PKLITE','4','��\0\0\0\0X��NQJ�\0�O��\0�]��\0\"�:@�\02�:�\04sV�*\09�:A9\0?kH�^\0B�d�S\0D_d��\0Ed@�\0V�d@p\0X�*A�\0gWH�x\0w�dA \0y�dA/\0ycd��\0|d��\0�O@v\0��A��\0�+dA,\0�_:@�\0��]A>\0��d@�\0��d@�\0��d�p\0�Sd��\0�O�\0��d��\0��d@�\0�:�\\\0��d�K\0�G3��\0��dA�\0�SA\0�dA7\0��d@�\0�dA\0��d�O\0��dAC\0�dA�S���d�+�d@��d���dA�d���]�F�O�J.�:�O6�H@�;\'dAdA_d��G3�N\'d@�Qd��TdAeWs*�uak#��gd�,ld�ws:A$w�:�y:�|VA2~dA�d���dAQ�]@��#�9��HA%��*����H@���AA\Z�V\0\0\0�]:k@\0\n�\0(\05]�Z\r���������\n��!�����\0��\r������	�����+��������������������\r�����\0������	�\r�����3��������\Z��!�\0A�+\r���','2020-12-07 17:11:00','s'),(9,156,'PKLITE','5','��\0\0\0\0X��MUB@�\02�V�\08{d�\'\09sV�6\0?�V��\0@dA\0N�H�/\0WkH�\0Xsd�f\0Xc:A	\0_�d��\0bdAH\0d�d�\n\0m�d�!\0uod��\0�d��\0��]�\0�od��\0�V@�\0�#d@�\0��d�0\0��d��\0��d� \0��d�l\0��d��\0�+d��\0�\'O@�\0��d@�\0��V@�\0��H@�\0Ƿd��\0��A@�\0ַd��\0�CA��\0ܻd��\0޷d@�\0�3d@�\0��d@�\0�;:As\0��d�.\0��d��\0��d@��d@��d��;V���dA\'�d��/:�i�d@v�]�9%�dA])�d��,�dA3�A@�4�dAW7�d��?\'H@�CV�D/d@ym#HA,o#dA�d�%��AA�A�;�A@��d� ��d\0\0\0�\0��;@\0\n�\0$\0-\0��Z\r����*����	��!��\0\r��\r�����������������&�+��#!��������$\"\0�����#������,����.��\r�	��-������','2020-12-07 17:11:00','s'),(10,157,'PKLITE','2','��\0\0\0\0X��SgI�!\0�*A^\03q3@�\0<	d�0\0D�dA\0E�d��\0Id��\0W�d@�\0hd��\0k�d��\0rd��\0x�dA�\0ze*A6\0��d��\0��3@�\0�%d��\0�dA\0��d��\0��d@�\0�)d@�\0�dA\0��d�y\0��d@�\0��d��\0�d��\0�d��\0�d@�\0�%dAT\0�dA��H@�]@}	�d���d� �d��%O�l �d@�$�d��\'�d@�(�V��)1:@�1�H�T3�d��553��>9HA,B�dA8D�VA�D]*��E!d�|V)d@YX%]�aX�d��^�A��`!]Atb�OAk�V��m\rdA#n5d�Ev1d@��:���qd��)V�*�)dA��yd@���*�/�dAU�d@��\rd��\rd����3A3�dA�d�6�d@��]���]\0\0\0����e@\0\n�\0\0��Z\rr���\r��\0�������.�\0�����\n�	������,������\r����	���2� ������\"*6�%@�\n��-�����)����\0��2������\r','2020-12-07 17:11:45','s'),(11,157,'PKLITE','3','��\0\0\0\0X��R_F@�\0�:��\0�:A8\0�#��\0\"�#�A\0$�A�&\01�d�[\0>md@x\0I!3�?\0S�d��\0U\rdA\0W�dA�\0wedA{\0}�d@�\0�d��\0�aA\"\0��dA�\0��*A�\0�U#��\0�ad��\0�)d@�\0�dA8\0��d��\0�U]��\0�M�\0�d��\0�)d�\0�1d�v\0��HA&\0ed�k\0�3@�d��-d@�%�dA.�:A,5�d��A�3�jD�]��K)A(P9d��R�:AW�d��Y)d��h=��i%dA+o�d��v�d@�~d@��*�\"�1d����@n�*@��OAQ�-dAv����u#AS�%d������d@��\rVA&�d�	�d�]�!HAI�d�e�V@��#A\Z�dA=�\rd@��	d�<�OAV�3\0\0���S@\0\n�\0\0���Z\r�������������T\n������\r�������\"$�������!����\n���,���������\Z�\Z�(�.��+����������','2020-12-07 17:11:45','s'),(12,157,'PKLITE','4','��\0\0\0\0X��PXKA\0�A��\0|OA/\0�*@�\0�:@�\0%�A��\0@d@�\0T|d�C\0Wdd��\0dX3@�\0f�V�\0mpV�t\0v$d��\0{dA�\0}Xd�\0�pdA�\0�P*�\0��d@�\0��:��\0��H@�\0��:A�\0�P@�\0̨d@a\0װd��\0�0dA$\0��d@�\0��d@��d��<*@�8d@��d��<]��\Z�dA	�d@u�d�y 8H@]\'D*@�*�d�p18HAu4$A�[7�d@�E�#��F�d@�O�H@XU��rV�O�X�d@w`�d@�f�d@`p�]Ast�H@�w�V�qz�d@{�d�z|��3�0*�U�0d����#AZ��O@��0A�\n�,:@��Xd���xA!�O���\\OA�A����A@��@��*��:@��x��V���H���*@��#A\n��3\0\0\0��q@\0\n�\0\0,�Z\r�\r��\0���&����$��	�����\Z����&��������\'�����7��������\0�����4 ����\Z	�.�����#��2�����','2020-12-07 17:11:45','s'),(13,157,'PKLITE','5','��\0\0\0\0X��O]?A \0�:@�\0�@�\0�*@�\0)�A\0-�d�e\05�#�C\06ld@}\0Q�]�L\0]hd�6\0^pd�^\0y�d�\0��d@z\0��V��\0� d��\0�d��\0��]A\0��d�N\0��d@�\0ѴO@�\0۴O�t\0��d@�\0޴d�;\0��dAY\0��d@��d���d���dA	�]��$�d�f\'�d@�)�d��/�d�<�A�{>�d��@�d@�C�d��C�d�N���U�dA�V<@�Z\\V�e[8d�u[4A��e3��itH�;k0:��m�]@�p$d�{�W~ H���VA��3���#���:��ʌ*���d�#�*@�ݐ#@�߀A�-��	�*�Y�#�G��\0\0\0�n)@\0\n�\0\0%�Z\rr��#\0��\n���\"������!�\Z��*���\r������ �A�,\0���������0�����������	\n������\r��\Z�\"\n�����','2020-12-07 17:11:45','s'),(14,228,'PKLITE','2','��\0\0\0\0X��P^K��\0�3@�\0�3@�\0�*@x\0�#@�\0#&:A\"\05�d@�\0?\nd@�\0Bd@�\0HdA2\0Ojd@h\0P�d@�\0W�]��\0b]�k\0kf#��\0}�d��\0�\Zd@>\0��H�`\0�\Z:Ab\0��dAB\0��d�V\0��:@W\0��:��\0�\Zd@�\0��dA�\0�V*@�\0�d�G\0�^d�\0�vO@�\0�d@�\0ϊ]�J\0آd@�\0�\nV�o\0��dA\0��d�i\0��V��\0�&O@]\0��d�,\0��d���O@�\ZdA_\n�dAJ\r�d@@�d��!�d�!�V@�.�3@�3�3��;�HA=�dA4L�dAf�d�4j�dAm�d��p^]@Xu�]�*y�]�?��A���2]����dAS�Zd�f�fA@��*A@��O@��&V��O���\ZO@��]@z�*���O��O�3܆*A�*���*���*@��\n*\0\0\0�\0h�q@\0\n�\0\0#h�Z\r4���!\Z�?������\r���(\0��������\0����\n�\n���\n�\n������\r�������\n��\r1����\r������������\"�	)���','2020-12-08 10:06:27','s'),(15,228,'PKLITE','3','�\'\0\0\0\0X��RXWA(\0��\0�d�\0.zV@�\01�]A>\03�A@�\06�H��\07d��\08��M\0>jH�\0C�d@�\0Gd��\0I�V@�\0K\nV@�\0O\"d��\0Q�d�Y\0W�H��\0]d�r\0a�d�\0b~d�>\0c���\0g\ZdA�\0kZ��\0t�3��\0y�d@�\0y�d@�\0dA\0��H��\0�A�}\0�2d��\0��O@�\0�.dA6\0��d@�\0��dA\0��dA�\0�R3��\0��OA9\0�Nd��\0�&d��\0�.d�6\0��d��\0�O��\0�2d�,\0�Fd���:�~�d�oFH�`2]�m�H�m�d�Q�d��\"�]�d-2]AA3�V��3�AA4�dA?B�AA\"C�d�N_�dA�`Vd@�k�VAE{�dA}{ZdA�~Z3�@��d�X��d���2H@���V�R��]�Y��:�9�*dA\r�&]A,�*d�m�Z@��\"*�L��#��ĊH@�ɚ:�j�*�$�:@��\":���\ZA@��\ZdA�d�pۢ#���d���*���\nd\0\0\0�|�@\0\n�\0\02Z\r�\"��\0�������.�����\Z�*����\r�	������\r������\r.�������\0��������������!������	5\Z	�����.�','2020-12-08 10:06:27','s'),(16,228,'PKLITE','4','��\0\0\0\0X��QQM�\0.wA�\0.k*AV\0/�Ad\04���\07�3�D\08�]@�\09d@r\0J�A7\0Ugd�W\0a���\0bd@�\0d�d�e\0e[d@�\0j�d@�\0qd�7\0rcd�d\0s�O�n\0s+d��\0u�HAA\0w�3@�\0|d@�\0|H�F\0�_3@�\0��dA]\0��d��\0�dA�\0��VA,\0�Kd�k\0�/HA@\0��d�1\0��d�I\0��d��\0�+d�_\0��d�t\0�;VAC\0��dA;\0�Cd@�\0�dA$\0��d��\0��H��\0��A�S@��dA�\"�d@�%3d��%�d@x13dA6�dA?�dA2A�d�<P�O��VSd��ZS�q�d�w�dAN{�d�>��:�4��dAB��d�%��dA���#@���d����H���3d@��7VA ��:A7��d�k�#d��3A@��#AAa��3@y�#VA!�/V@��#:���\'*���#A`�WA\0\0\0�]�}@\0\n�\0&\05]�Z\r�����&��,����.�����	*�����������\n\0����������\'���\Z��\n���������	��*�����(��\"��\0����\0� ','2020-12-08 10:06:27','s'),(17,228,'PKLITE','5','��\0\0\0\0X��MW=��\0H��\0 �H��\0 �AA&\0)rd�\0@�dAN\0Db3A\r\0I~d@�\0R�d@�\0Vd��\0Z\"]��\0Z�d@�\0j�d�8\0qbd�s\0q^d��\0t&d��\0�\"O@�\0��:�(\0��dAK\0��dAs\0��dA&\0�fdA:\0�ZdAy\0�Rd��\0�ROA?\0��dAW\0�NdA\0��]A�\0���.\0��d�!\0�VAW\0��d�E+�d@�.�d@�;2d�R<�d@�K�dAtQ�dAPW�dAuj�d�aqNO@�w&V@�x&*��~�*@��*O���\"O���\"3A~�j��#A�\"#A.�A�$��3@��:@��*��d���dA�3�.�\nd���\n]���H@���:@���3\0\0\0�\0\0�@\0\n�\0!\0-\0\0FZ\r����\'���\Z�9��\'�\r�����\Z�>����\r������\"�������G��\0����������\Z����(�&�����\0�������.�\0��\n�����','2020-12-08 10:06:27','s'),(18,1,'PKLITE','2','��\0\0\0\0X��S`KA\'\0 �d��\0\'�3@�\0+�*@�\06�H��\08�*��\0=�3@�\0>]�B\0@od�s\0G�O��\0Od@�\0P�O�z\0Xk]��\0\\V��\0b_*�m\0t�d��\0}d��\0~�dA|\0��dAS\0��d��\0�#d��\0��d��\0�#d@�\0�d�^\0�cd�\0�dA\r\0ÏH@�\0�d��\0��d�h\0دd@�\0�HA+\0��dA�\0��d��\0�+dAO\0��d@�\0�d��\0��d��\0�d@v\0��dA\0��dAg�d@�+dA+\Z�d���dA1�dA55�dA9�dAYD�d�4d�d�_g�d�Jk�d��x�]�Yx�d�\n�3dA(��d@k��d���cd���gV�M�+dA�/]�W�dA9�\'d��\'d@��#d���wH�tЃ#�I�]@��3���#d��d�;�]A��s3@��d@��d���dA\r�d\0\0\0�\0��q@\0\n�\0\0\0�KZ\rN����$\r�3������	� ��-�\'������\r�����\0���\0�����������������\'�������%\0��	��%�������!���\n���!%���','2021-01-11 16:13:05','s'),(19,1,'PKLITE','3','�9\0\0\0\0X��SYZA\0�:�\02{O��\05���\05�O��\0=d@�\0D�3�h\0I�@�\0J�d@�\0Pd��\0Td��\0W�d@�\0X#d@T\0Y�#A�\0^[A\0a�d�`\0e�:��\0ed��\0j[]��\0od��\0y�V��\0z[@�\0��d@�\0��d@�\0�dA\0��:��\0�A@�\0�:��\0�+d�z\0�7d�5\0��dA\0��d�\0H@�\0ĳdA�\0��d@�\0�\'dA3\0�Od��\0�3��\0��H�0\0��d��\0�V��\0�3d��\0�7d�(\0G3��\n�dA`�d@m�V�]!/#AH(�d��)�d��:�d@g;/dA<�d�BC�dAJO�H�\"Q�dA6U�dA�iSd��x�dA��_HAB��d�4��d�y�WA�U��d@���V���/d@��3]A���H�O��VA���A<�/OA\0�#3�0�/dAe�W3A6�3��ӋV���#@�ۏH���c#�[�:�7�]@n�3���d���dAG��d�O�{3Am�k#�f��@��:���d��d\0\0\0�]��@\0\n�\0\0-]�Z\r�(���\Z��	\0���\r�/��������$���\Z\r�\n�����\n\n	�\n�#���\r0��\'������\0����������\0���!�$�����	7\"�����%� \r','2021-01-11 16:13:05','s'),(20,1,'PKLITE','4','��\0\0\0\0X��PPNA\0��0\0�@�\0 �@�\0\':�\0\'pA\0*xOAl\01�*�H\03�]A�\0I�@�\0J�AA<\0Nhd@�\0Xd�g\0[\\d@{\0]�3@�\0_�d@�\0d�V�8\0jdd��\0p�A��\0qV@v\0rV�`\0s�@�\0uA��\0{ d@�\0�d�^\0��d��\0��@�\0�d��\0�T�u\0��d@f\0�4VA/\0�X3�H\0��d�C\0��d��\0�(d�d\0��d@�\0�d�$\0��d��\0��V@�\0�V��\0��A��<H@��d��<d@��d��\Z�d���d��\"�d��\'�A@�\'<d@l083AU7�H�$<�dA6>�d��IT*�VLHO�CS�dA�`T��b�Aj�d�v�dAJ��:���X�=��]�.��dA]�PA�7��dAD��O@w�$O���0:A+�8]��ʨ���4#��� 3�s۔#@��$@�� @t��3@g \0\0\0\r�@\0\n�\0,\0?Z\r�����*(���$����/������������\Z����\0� ������\n��&������������3���\n\r����7�\0���\"��\r������\0�\Z�','2021-01-11 16:13:05','s'),(21,1,'PKLITE','5','��\0\0\0\0X��MVKA$\0oV�b\02_*��\07�dAP\0:cdA\0?d��\0M�*@�\0Od��\0U�d@z\0f�3�q\0h[d�3\0icV��\0n#dA�\0|�d��\0�OA\0��d��\0��dAF\0��dAq\0��d�$\0�cdA6\0�Wd��\0��d��\0��dA�\0�OV��\0��d@�\0�+H�@\0��d��\0��d�V\0�OdA\0г3@�\0�;H�+\0��O@�\0ڷ3��\0�7:A\0��d�[\0��d@�\0��V@�\0�Cd@�\0��d��\0��O���A�D&�d@�+�dAL7�d@�A3d@�F�AAoH�d�KS�O�L`�O@�j+O�Av3H��|+*@�~�O����AA[��3���:A0�A���#*���A@��A�1��H���]A�HA#��*����H��Ï:A\0�d���H��]�ׇ]A&�A���]���3�\'�H�E�{*��\03\0\0\0�]�q@\0\n�\0!\02]�Z\r����%���:��!�����%��\05� ��\n\n������\r,�������=����������������$�����������(�	��\0���\n��','2021-01-11 16:13:05','s'),(22,1,'PKLITE','7','�3\0\0\0\0X��XeY�|\0:!#�~\0=��a\0>��\0A�:A�\0J��\0O)d�Z\0T:A\n\0^!d��\0`!dA,\0edAW\0p]�\0y�dAV\0�d�{\0�)d�\0�!d�b\0��d��\0�}d��\0�%d��\0��d��\0��AA�\0�udA(\0�!d�1\0�d��\0�%d��\0��d@x\0�!d�X\0�d��\0�dAS\0�	HA_\0�HA�\0��]A�\0�u]��\0��dAd]Au�]�!d�=d�[d�x�d��#)d��&�d��,�d��1�d�\'2�V�h:�d��<�d� A%V@]B�OAWB�dA�C�d�I%d��J�d��Q�d�T!d�6TdAI[�d@j_)dA+c�d��g�d�vj�dA�n�d�Ps�VAhy�d�>�d�_�d�y��d����dA���d�+�)d@���dA?��A��ȹd�sɹd���9d@��Ad����AA�ֹ:�=�9H��ٽ#A��H���E#@��O���=A����dA��d���9d���9H��9:��53\0\0(����@\0\n�\0\0#��~Z���$�(������������0����\0���\0�	�����\n������D�����I�	���������\"��������\n������	\n����','2021-01-11 16:13:20','s');
/*!40000 ALTER TABLE `digital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispositivo`
--

DROP TABLE IF EXISTS `dispositivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispositivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mac` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descricao` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_portaria` int(11) NOT NULL,
  `ip` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispositivo`
--

LOCK TABLES `dispositivo` WRITE;
/*!40000 ALTER TABLE `dispositivo` DISABLE KEYS */;
INSERT INTO `dispositivo` VALUES (1,'xxxx','PC Portaria Principal',1,'192.168.40.21','2017-01-07 15:49:02'),(9,'iiiiii','PC Portaria Principal saÃ­da',3,'192.168.40.28','2017-01-07 18:59:46');
/*!40000 ALTER TABLE `dispositivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergencias`
--

DROP TABLE IF EXISTS `emergencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emergencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(11) NOT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `situacao` varchar(255) DEFAULT NULL,
  `data_hora_criacao` datetime NOT NULL DEFAULT current_timestamp(),
  `data_hora_atualizacao` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_pessoa` (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergencias`
--

LOCK TABLES `emergencias` WRITE;
/*!40000 ALTER TABLE `emergencias` DISABLE KEYS */;
INSERT INTO `emergencias` VALUES (1,45,1,'Incendio',NULL,'2019-12-12 16:38:32',NULL),(2,45,1,'Seguranca','visualizada','2019-12-13 10:16:20','2019-12-13 10:17:57'),(3,1,1,'Incendio','visualizada','2019-12-16 09:35:05','2019-12-16 09:35:09'),(4,45,1,'Seguranca',NULL,'2020-01-31 21:42:20',NULL),(5,4,1,'Seguranca','visualizada','2020-03-23 09:28:09','2020-03-23 09:28:23'),(6,4,1,'Seguranca','visualizada','2020-04-07 16:22:37','2020-04-07 16:22:48'),(7,45,1,'Seguranca',NULL,'2020-04-16 10:33:21',NULL),(8,4,9,'Medica',NULL,'2020-09-26 22:03:30',NULL),(9,175,1,'Medica',NULL,'2020-10-16 11:02:40',NULL),(10,4,1,'Medica','visualizada','2020-12-02 13:13:30','2020-12-02 13:18:43'),(11,4,1,'Medica','visualizada','2020-12-02 13:24:59','2020-12-02 13:25:10');
/*!40000 ALTER TABLE `emergencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_cadastro` datetime DEFAULT NULL,
  `razao_social` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nome_fantasia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cnpj` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ie` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contato` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'NULL',
  `obs` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_atualizacao` datetime DEFAULT NULL,
  `tel1` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel2` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `endereco` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cidade` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cep` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `complemento` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ramo_atividade` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bairro` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `endereco` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cidade` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uf` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cep` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `complemento` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bairro` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (2,'','','','','',''),(3,'','','','','',''),(4,'Rua 7a esq. 1008','Goiânia','GO','74335104',NULL,'São Francisco'),(5,'Rua C-0259','Goiânia','GO','74000000',NULL,'J N ESPERANCA'),(6,'Rua 7 de Setembro Qd. 139 Lt. 11','GOIANIA','GO','74000000',NULL,'J N ESPERANÇA'),(7,'Rua Periata','Goiânia','GO','74835500','Qd','Teste'),(8,'asda','ds','AC',NULL,NULL,'asd'),(11,'','','','','',''),(12,'','','','','',''),(14,'','','','','',''),(16,'','','','','',''),(17,'','','','','',''),(18,'','','','','',''),(19,'','','','','',''),(20,'rua das flores','Goiânia','GO','74411111','qd3 lt3','Jd. Goiás'),(21,'','','','','',''),(22,'','','','','',''),(24,'','','','','',''),(25,'Rua 7 de Setembro Qd. 139 Lt. 11','Goiânia','GO','74465420','Jardim Nova Esperança','J. N. Esperança'),(26,'Rua 7a esq. 1008','Goiânia','GO','74465420','000','J.N.E'),(27,'','','','','',''),(28,'Rua Sao Sebastiao Qd. 01 Lt. 07','Aparecida de Goiânia','GO','74965720',NULL,'Madre Germana 2'),(30,'','','','','',''),(31,'asddasd asd asd asd','asdddwd','AL','74000000','asda ds','d222dsad a'),(32,'asdasd','asd','AP',NULL,'dsad','ddd'),(33,'','','','','',''),(34,'65y356y','ergsregsr','PB',NULL,NULL,'rgs'),(35,'','','','','',''),(36,'sragf43','g34g4','PB',NULL,NULL,'aedrga4r'),(37,'Rua Sao Sebastiao Qd. 01 Lt. 07','Aparecida de Goiânia','GO','74965720',NULL,'OTO LUGAR');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrada`
--

DROP TABLE IF EXISTS `entrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrada` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_liberacao` int(11) DEFAULT NULL,
  `tipo_acesso` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cartao_visitante` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_pessoa` int(11) NOT NULL DEFAULT 0,
  `data_hora` datetime DEFAULT NULL,
  `id_usuario_atendente` int(10) unsigned DEFAULT NULL,
  `id_veiculo` int(10) unsigned DEFAULT NULL,
  `tipo_entrada` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_portaria` int(10) unsigned DEFAULT NULL,
  `id_acesso_toten` int(11) DEFAULT NULL,
  `id_imovel_acesso` int(10) unsigned DEFAULT NULL,
  `id_rastreador` int(11) DEFAULT NULL,
  `placa` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_4` (`cartao_visitante`),
  KEY `index_2` (`id_pessoa`),
  KEY `index_5` (`data_hora`),
  KEY `index_3` (`id_portaria`),
  KEY `IDX_ID_LIBERACAO` (`id_liberacao`)
) ENGINE=InnoDB AUTO_INCREMENT=1192 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrada`
--

LOCK TABLES `entrada` WRITE;
/*!40000 ALTER TABLE `entrada` DISABLE KEYS */;
INSERT INTO `entrada` VALUES (1,NULL,'t',NULL,5,'2019-11-29 12:17:00',NULL,NULL,NULL,1,3,NULL,NULL,NULL),(2,NULL,'t',NULL,5,'2019-11-29 12:17:22',NULL,NULL,NULL,1,4,NULL,NULL,NULL),(3,NULL,'p',NULL,5,'2019-11-29 12:18:26',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(4,NULL,'p',NULL,5,'2019-11-29 12:19:01',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(5,NULL,'t',NULL,5,'2019-11-29 12:28:22',NULL,NULL,NULL,1,9,NULL,NULL,NULL),(6,NULL,'t',NULL,5,'2019-11-29 12:28:26',NULL,NULL,NULL,1,10,NULL,NULL,NULL),(7,NULL,'t',NULL,5,'2019-11-29 12:28:30',NULL,NULL,NULL,1,11,NULL,NULL,NULL),(8,NULL,'t',NULL,8,'2019-11-29 15:10:35',NULL,NULL,NULL,1,17,NULL,NULL,NULL),(9,NULL,'t',NULL,8,'2019-11-29 15:11:38',NULL,NULL,NULL,1,19,NULL,NULL,NULL),(10,NULL,'t',NULL,8,'2019-11-29 15:11:43',NULL,NULL,NULL,1,20,NULL,NULL,NULL),(11,NULL,'t',NULL,8,'2019-11-29 15:13:47',NULL,NULL,NULL,1,25,NULL,NULL,NULL),(12,NULL,'t',NULL,8,'2019-11-29 15:15:57',NULL,NULL,NULL,1,30,NULL,NULL,NULL),(13,NULL,'t',NULL,8,'2019-11-29 15:16:21',NULL,NULL,NULL,1,32,NULL,NULL,NULL),(14,NULL,'t',NULL,8,'2019-11-29 15:16:28',NULL,NULL,NULL,1,33,NULL,NULL,NULL),(15,NULL,'t',NULL,8,'2019-11-29 15:16:40',NULL,NULL,NULL,1,34,NULL,NULL,NULL),(16,NULL,'t',NULL,8,'2019-11-29 15:16:50',NULL,NULL,NULL,1,35,NULL,NULL,NULL),(17,NULL,'t',NULL,8,'2019-11-29 15:21:34',NULL,NULL,NULL,1,37,NULL,NULL,NULL),(18,NULL,'p',NULL,8,'2019-11-29 15:35:12',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(19,NULL,'t',NULL,8,'2019-11-29 16:01:14',NULL,NULL,NULL,1,41,NULL,NULL,NULL),(20,NULL,'t',NULL,8,'2019-11-29 17:18:36',NULL,NULL,NULL,1,44,NULL,NULL,NULL),(21,NULL,'p',NULL,3,'2019-12-02 10:57:34',NULL,NULL,NULL,1,46,NULL,NULL,NULL),(22,NULL,'p',NULL,3,'2019-12-02 12:23:18',NULL,NULL,NULL,1,47,NULL,NULL,NULL),(23,NULL,'p',NULL,3,'2019-12-02 12:23:47',NULL,NULL,NULL,1,48,NULL,NULL,NULL),(24,NULL,'p',NULL,3,'2019-12-02 12:25:23',NULL,NULL,NULL,1,49,NULL,NULL,NULL),(25,NULL,'p',NULL,5,'2019-12-02 12:25:37',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(26,NULL,'p',NULL,5,'2019-12-02 14:12:12',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(27,1,'p','101',9,'2019-12-02 14:49:30',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(28,3,'p','102',10,'2019-12-02 14:56:29',1,4,'carro',0,NULL,NULL,NULL,NULL),(29,4,'p','104',11,'2019-12-02 15:09:40',1,5,'carro',0,NULL,NULL,NULL,NULL),(30,10,'p','1020',14,'2019-12-03 18:13:18',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(31,11,'p','1020',15,'2019-12-03 18:13:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(32,12,'p','1020',16,'2019-12-03 18:13:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(33,13,'p','2020',17,'2019-12-03 18:15:12',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(34,NULL,'p',NULL,5,'2019-12-04 08:50:23',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(35,14,'p','teste',18,'2019-12-04 09:46:05',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(36,15,'p','teste',20,'2019-12-04 09:52:09',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(37,16,'p','11',21,'2019-12-04 09:59:59',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(38,17,'p','12',21,'2019-12-04 10:20:06',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(39,18,'p','654',22,'2019-12-04 10:23:08',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(40,21,'p','texte',26,'2019-12-04 10:34:11',1,NULL,'pedestre',0,NULL,NULL,NULL,NULL),(41,22,'p','texte',27,'2019-12-04 10:34:12',1,NULL,'pedestre',0,NULL,NULL,NULL,NULL),(42,24,'p','texte',29,'2019-12-04 10:34:13',1,NULL,'pedestre',0,NULL,NULL,NULL,NULL),(43,27,'p','teste2',30,'2019-12-04 10:55:11',1,6,'carro',0,NULL,NULL,NULL,NULL),(44,28,'p','teste2',31,'2019-12-04 10:55:12',1,NULL,'carro',0,NULL,NULL,NULL,NULL),(45,29,'p','teste2',32,'2019-12-04 10:55:13',1,NULL,'carro',0,NULL,NULL,NULL,NULL),(46,33,'p','teste3',33,'2019-12-04 11:08:14',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(47,34,'p','teste3',34,'2019-12-04 11:08:15',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(48,35,'p','teste4',35,'2019-12-04 11:10:50',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(49,36,'p','teste4',36,'2019-12-04 11:10:51',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(50,44,'p','teste3',37,'2019-12-04 15:59:11',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(51,48,'p','tst',41,'2019-12-04 17:39:08',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(52,49,'p','tst',42,'2019-12-04 17:39:10',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(53,50,'p','66',43,'2019-12-06 09:49:17',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(54,51,'p','66',44,'2019-12-06 09:49:19',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(55,NULL,'t',NULL,3,'2019-12-09 18:03:33',NULL,NULL,NULL,1,57,NULL,NULL,NULL),(56,NULL,'t',NULL,3,'2019-12-09 18:08:19',NULL,NULL,NULL,1,61,NULL,NULL,NULL),(57,NULL,'p',NULL,6,'2019-12-10 17:32:37',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(58,NULL,'p',NULL,6,'2019-12-10 17:33:02',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(59,NULL,'p',NULL,5,'2019-12-10 17:36:01',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(60,NULL,'p',NULL,5,'2019-12-10 17:38:58',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(61,79,'p','teste',46,'2019-12-12 10:13:27',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(62,80,'p','teste',47,'2019-12-12 10:16:38',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(63,81,'p','teste',48,'2019-12-12 10:19:25',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(64,82,'p','teste',49,'2019-12-12 10:22:25',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(65,83,'p','teste',50,'2019-12-12 15:27:25',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(66,84,'p','teste',51,'2019-12-12 15:27:25',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(67,85,'p','teste',52,'2019-12-12 15:27:26',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(68,86,'p','teste',53,'2019-12-12 15:27:26',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(69,NULL,'p',NULL,6,'2019-12-13 08:58:45',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(70,NULL,'p',NULL,6,'2019-12-13 09:05:05',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(71,97,'p','teste',56,'2019-12-13 10:26:43',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(72,96,'p','teste',57,'2019-12-13 10:27:04',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(73,105,'p','teste',58,'2019-12-13 11:21:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(74,104,'p','teste2',59,'2019-12-13 11:21:33',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(75,107,'p','teste',59,'2019-12-13 11:24:00',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(76,108,'p','teste',59,'2019-12-13 11:26:46',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(77,118,'p','1234',60,'2019-12-13 14:09:45',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(78,119,'p','123',60,'2019-12-13 14:14:35',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(79,120,'p','122',60,'2019-12-13 14:34:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(80,125,'p','857223',10,'2019-12-13 16:23:49',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(81,126,'p','857223',10,'2019-12-13 16:31:42',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(82,128,'p','teste',62,'2019-12-13 17:12:38',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(83,129,'p','teste2',49,'2019-12-13 17:15:22',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(84,137,'p','teste',65,'2019-12-16 09:07:55',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(85,139,'p','123',67,'2019-12-16 12:02:10',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(86,140,'p','1233',68,'2019-12-16 12:03:25',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(87,141,'p','1222',69,'2019-12-16 12:04:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(88,142,'p','1234',70,'2019-12-16 12:05:32',1,8,'carro',0,NULL,NULL,NULL,NULL),(89,185,'p','teste',72,'2019-12-17 17:42:45',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(90,186,'p','teste',72,'2019-12-17 17:45:05',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(91,187,'p','teste',72,'2019-12-17 17:46:33',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(92,188,'p','teste',72,'2019-12-17 17:47:07',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(93,189,'p','teste',72,'2019-12-17 17:52:33',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(94,196,'p','832715',76,'2019-12-17 18:09:44',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(95,197,'p','832715',19,'2019-12-17 18:09:45',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(96,198,'p','832715',77,'2019-12-17 18:09:45',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(97,199,'p','832715',78,'2019-12-17 18:09:46',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(98,NULL,'p',NULL,6,'2019-12-17 18:17:27',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(99,200,'p','teste',79,'2019-12-17 18:54:48',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(100,201,'p','teste',19,'2019-12-17 18:54:50',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(101,202,'p','teste',80,'2019-12-17 18:54:50',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(102,205,'p','838456',81,'2019-12-18 10:05:42',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(103,265,'p','712680',82,'2019-12-18 17:33:58',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(104,288,'p','609521',83,'2019-12-19 11:38:48',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(105,291,'p','442173',85,'2019-12-19 12:11:49',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(106,289,'p','627108',86,'2019-12-19 12:12:12',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(107,293,'p','021916',88,'2019-12-19 12:22:34',1,9,'moto',0,NULL,NULL,NULL,NULL),(108,294,'p','021916',88,'2019-12-19 12:34:07',1,9,'carro',0,NULL,NULL,NULL,NULL),(109,295,'p','021916',88,'2019-12-19 12:37:33',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(110,296,'p','021916',88,'2019-12-19 12:38:37',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(111,297,'p','021916',88,'2019-12-19 13:00:23',1,9,'carro',0,NULL,NULL,NULL,NULL),(112,NULL,'p',NULL,4,'2020-01-27 11:43:00',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(113,NULL,'p',NULL,4,'2020-01-27 18:37:46',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(114,NULL,'p',NULL,12,'2020-01-30 11:42:30',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(115,373,'p','267388',92,'2020-01-30 14:58:27',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(116,374,'p','233',93,'2020-01-30 15:10:35',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(117,375,'p','388',92,'2020-01-30 15:18:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(118,NULL,'p',NULL,19,'2020-01-31 18:06:36',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(119,381,'p','44',94,'2020-02-03 12:15:45',1,12,'carro',0,NULL,NULL,NULL,NULL),(120,382,'p','88',93,'2020-02-03 14:54:30',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(121,383,'p','34',95,'2020-02-03 15:13:05',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(122,385,'p','50',96,'2020-02-03 16:18:44',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(123,384,'p','01',92,'2020-02-03 16:20:14',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(124,387,'p','02',96,'2020-02-03 17:02:34',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(125,386,'p','03',97,'2020-02-03 17:04:40',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(126,388,'p','011',98,'2020-02-03 17:13:20',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(127,390,'p','358363',99,'2020-02-04 10:03:52',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(128,391,'p','424100',100,'2020-02-04 10:05:51',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(129,392,'p','358363',99,'2020-02-04 10:15:40',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(130,393,'p','424100',100,'2020-02-04 10:17:54',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(131,394,'p','424100',100,'2020-02-04 10:19:52',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(132,395,'p','424100',100,'2020-02-04 10:21:53',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(133,396,'p','041857',101,'2020-02-04 10:30:23',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(134,397,'p','207663',102,'2020-02-04 10:31:57',1,13,'carro',0,NULL,NULL,NULL,NULL),(135,401,'p','477168',103,'2020-02-04 10:32:35',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(136,411,'p','137155',105,'2020-02-04 10:59:08',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(137,NULL,'p',NULL,2,'2020-02-04 11:58:52',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(138,NULL,'p',NULL,2,'2020-02-04 11:58:57',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(139,NULL,'p',NULL,2,'2020-02-04 11:59:08',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(140,NULL,'p',NULL,6,'2020-02-04 12:00:38',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(141,NULL,'p',NULL,2,'2020-02-04 12:05:21',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(142,NULL,'p',NULL,2,'2020-02-04 12:09:37',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(143,414,'p','637453',107,'2020-02-04 15:12:32',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(144,418,'p','137155',105,'2020-02-05 14:48:12',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(145,419,'p','137155',105,'2020-02-05 14:49:47',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(146,420,'p','137155',105,'2020-02-05 14:50:34',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(147,415,'p','207663',102,'2020-02-05 14:51:01',1,13,'carro',0,NULL,NULL,NULL,NULL),(148,421,'p','227836',106,'2020-02-05 14:52:03',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(149,432,'p','33',98,'2020-02-05 16:59:18',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(150,435,'p','034047',3,'2020-02-12 12:36:07',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(151,NULL,'p',NULL,109,'2020-02-14 08:24:47',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(152,NULL,'p',NULL,109,'2020-02-14 08:42:21',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(153,438,'p','011',110,'2020-02-17 09:24:13',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(154,439,'p','012',110,'2020-02-17 10:33:57',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(155,440,'p','153517',111,'2020-02-17 11:01:30',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(156,441,'p','153517',111,'2020-02-17 14:13:12',1,NULL,'outro',2,NULL,NULL,NULL,NULL),(157,449,'p','626853',8,'2020-02-17 14:49:38',1,NULL,'outro',2,NULL,NULL,NULL,NULL),(158,NULL,'p',NULL,4,'2020-02-17 15:01:39',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(159,452,'p','354471',13,'2020-02-19 09:16:36',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(160,453,'p','354471',13,'2020-02-19 09:23:23',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(161,454,'p','44',113,'2020-02-21 09:35:41',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(162,455,'p','028555',114,'2020-02-21 11:15:46',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(163,456,'p','0285556',114,'2020-02-21 11:18:45',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(164,457,'p','0285557',114,'2020-02-21 11:29:12',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(165,458,'p','028554',114,'2020-02-21 11:34:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(166,459,'p','0285559',114,'2020-02-21 11:47:53',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(167,NULL,'p',NULL,4,'2020-02-28 08:42:57',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(168,461,'p','13',115,'2020-02-28 08:50:50',1,41,'carro',0,NULL,NULL,NULL,NULL),(169,NULL,'p',NULL,12,'2020-02-28 09:08:32',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(170,464,'p','70',116,'2020-02-28 10:44:12',1,42,'carro',0,NULL,NULL,NULL,NULL),(171,469,'p','75',116,'2020-02-28 10:52:28',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(172,471,'p','693288',118,'2020-02-28 11:07:21',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(173,475,'p','526571',119,'2020-02-28 11:10:30',1,43,'carro',1,NULL,NULL,NULL,NULL),(174,476,'p','028555ff',114,'2020-02-28 11:18:02',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(175,478,'p','132364',121,'2020-02-28 11:46:16',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(176,479,'p','132364',121,'2020-02-28 11:47:21',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(177,477,'p','579605',122,'2020-02-28 11:48:12',1,44,'carro',1,NULL,NULL,NULL,NULL),(178,481,'p','21',123,'2020-02-28 12:02:52',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(179,483,'p','555127',124,'2020-02-28 16:34:52',1,45,'carro',1,NULL,NULL,NULL,NULL),(180,484,'p','327682',125,'2020-02-28 16:38:15',1,46,'carro',1,NULL,NULL,NULL,NULL),(181,487,'p','142485',126,'2020-03-02 14:11:58',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(182,488,'p','142485',126,'2020-03-02 14:13:08',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(183,489,'p','142485',126,'2020-03-02 14:16:26',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(184,491,'p','836450',128,'2020-03-03 10:50:25',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(185,492,'p','836450',128,'2020-03-03 10:53:31',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(186,493,'p','154183',129,'2020-03-03 10:56:54',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(187,494,'p','154183',129,'2020-03-03 10:58:39',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(188,495,'p','880897',130,'2020-03-03 11:01:49',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(189,498,'p','836450',128,'2020-03-03 14:02:43',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(190,507,'p','774416',134,'2020-03-03 14:47:39',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(191,549,'p','10',135,'2020-03-04 09:28:45',1,50,'carro',0,NULL,NULL,NULL,NULL),(192,NULL,'p',NULL,138,'2020-03-11 15:04:58',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(193,NULL,'p',NULL,139,'2020-03-12 14:03:03',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(194,580,'p','715147',140,'2020-03-16 10:45:44',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(195,580,'p','715147',140,'2020-03-16 10:46:31',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(196,580,'p','715147',140,'2020-03-16 10:59:01',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(197,581,'p','715147',140,'2020-03-16 11:00:38',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(198,581,'p','715147',140,'2020-03-16 11:02:18',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(199,NULL,'p',NULL,3,'2020-03-16 11:56:02',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(200,NULL,'p',NULL,19,'2020-03-16 11:56:58',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(201,NULL,'p',NULL,4,'2020-03-16 11:57:07',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(202,NULL,'p',NULL,66,'2020-03-16 11:57:20',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(203,NULL,'p',NULL,91,'2020-03-16 11:57:43',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(204,NULL,'p',NULL,138,'2020-03-16 11:58:59',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(205,NULL,'p',NULL,139,'2020-03-16 11:59:23',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(206,NULL,'p',NULL,54,'2020-03-16 12:01:42',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(207,NULL,'p',NULL,139,'2020-03-16 12:03:36',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(208,NULL,'p',NULL,3,'2020-03-16 12:03:52',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(209,NULL,'p',NULL,3,'2020-03-16 12:04:57',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(210,NULL,'p',NULL,19,'2020-03-16 12:06:21',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(211,582,'p','504793',141,'2020-03-16 12:19:48',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(212,583,'p','504793',141,'2020-03-16 12:22:02',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(213,584,'p','504793',141,'2020-03-16 12:23:16',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(214,585,'p','504793',141,'2020-03-16 12:24:19',1,52,'carro',1,NULL,NULL,NULL,NULL),(215,NULL,'p',NULL,143,'2020-03-16 17:19:32',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(216,587,'p','452658',144,'2020-03-17 10:35:34',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(217,588,'p','021588',145,'2020-03-17 10:40:27',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(218,589,'p','7845626',146,'2020-03-17 10:41:08',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(219,590,'p','451126',147,'2020-03-17 10:43:58',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(220,591,'p','421526',148,'2020-03-17 10:44:31',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(221,592,'p','892459',149,'2020-03-17 10:46:34',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(222,593,'p','1235486',149,'2020-03-17 10:47:41',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(223,594,'p','745284',150,'2020-03-17 10:48:52',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(224,595,'p','035425',151,'2020-03-17 10:50:27',1,53,'carro',0,NULL,NULL,NULL,NULL),(225,599,'p','12036502',152,'2020-03-17 10:53:15',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(226,598,'p','032015',153,'2020-03-17 10:54:04',1,54,'carro',0,NULL,NULL,NULL,NULL),(227,597,'p','0320241',154,'2020-03-17 10:54:30',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(228,596,'p','153517',111,'2020-03-17 10:54:55',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(229,NULL,'p',NULL,4,'2020-03-17 13:14:33',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(230,600,'p','010101',148,'2020-03-17 14:51:21',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(231,601,'p','020202',149,'2020-03-17 14:51:49',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(232,602,'p','030303',147,'2020-03-17 14:52:53',1,55,'carro',0,NULL,NULL,NULL,NULL),(233,602,'p','030303',147,'2020-03-17 14:53:35',1,55,'carro',0,NULL,NULL,NULL,NULL),(234,603,'p','252525',154,'2020-03-17 14:55:14',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(235,604,'p','050505',152,'2020-03-17 14:56:31',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(236,605,'p','030303',147,'2020-03-17 15:00:32',1,55,'carro',0,NULL,NULL,NULL,NULL),(237,606,'p','030303',147,'2020-03-17 15:21:57',1,55,'carro',0,NULL,NULL,NULL,NULL),(238,607,'p','030303',147,'2020-03-17 15:27:07',1,55,'carro',0,NULL,NULL,NULL,NULL),(239,609,'p','880897',130,'2020-03-18 11:00:52',1,56,'carro',0,NULL,NULL,NULL,NULL),(240,NULL,'t',NULL,3,'2020-03-27 00:22:57',NULL,NULL,NULL,1,254,NULL,NULL,NULL),(241,NULL,'t',NULL,3,'2020-03-27 00:23:01',NULL,NULL,NULL,1,254,NULL,NULL,NULL),(242,NULL,'t',NULL,3,'2020-03-27 00:23:04',NULL,NULL,NULL,1,254,NULL,NULL,NULL),(243,NULL,'t',NULL,3,'2020-03-27 00:23:08',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(244,NULL,'t',NULL,3,'2020-03-27 00:23:11',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(245,NULL,'t',NULL,3,'2020-03-27 00:23:16',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(246,NULL,'t',NULL,3,'2020-03-27 00:23:19',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(247,NULL,'t',NULL,3,'2020-03-27 00:23:22',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(248,NULL,'t',NULL,3,'2020-03-27 00:23:25',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(249,NULL,'t',NULL,3,'2020-03-27 00:23:29',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(250,NULL,'t',NULL,3,'2020-03-27 00:23:33',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(251,NULL,'t',NULL,3,'2020-03-27 00:23:36',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(252,NULL,'t',NULL,3,'2020-03-27 00:23:38',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(253,NULL,'t',NULL,3,'2020-03-27 00:29:53',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(254,NULL,'t',NULL,3,'2020-03-27 00:23:41',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(255,NULL,'t',NULL,3,'2020-03-27 00:23:48',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(256,NULL,'t',NULL,3,'2020-03-27 00:23:44',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(257,NULL,'t',NULL,3,'2020-03-27 00:23:52',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(258,NULL,'t',NULL,3,'2020-03-27 00:23:54',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(259,NULL,'t',NULL,3,'2020-03-27 00:23:58',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(260,NULL,'t',NULL,3,'2020-03-27 00:28:54',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(261,NULL,'t',NULL,3,'2020-03-27 00:24:01',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(262,NULL,'t',NULL,3,'2020-03-27 00:24:05',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(263,NULL,'t',NULL,3,'2020-03-27 00:24:09',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(264,NULL,'t',NULL,3,'2020-03-27 00:24:12',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(265,NULL,'t',NULL,3,'2020-03-27 00:24:16',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(266,NULL,'t',NULL,3,'2020-03-27 00:24:20',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(267,NULL,'t',NULL,3,'2020-03-27 00:24:23',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(268,NULL,'t',NULL,3,'2020-03-27 00:24:25',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(269,NULL,'t',NULL,3,'2020-03-27 00:24:28',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(270,NULL,'t',NULL,3,'2020-03-27 00:24:30',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(271,NULL,'t',NULL,3,'2020-03-27 00:24:33',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(272,NULL,'t',NULL,3,'2020-03-27 00:24:39',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(273,NULL,'t',NULL,3,'2020-03-27 00:24:36',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(274,NULL,'t',NULL,3,'2020-03-27 00:24:45',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(275,NULL,'t',NULL,3,'2020-03-27 00:24:48',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(276,NULL,'t',NULL,3,'2020-03-27 00:24:50',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(277,NULL,'t',NULL,3,'2020-03-27 00:24:55',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(278,NULL,'t',NULL,3,'2020-03-27 00:24:52',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(279,NULL,'t',NULL,3,'2020-03-27 00:25:00',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(280,NULL,'t',NULL,3,'2020-03-27 00:24:58',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(281,NULL,'t',NULL,3,'2020-03-27 00:25:10',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(282,NULL,'t',NULL,3,'2020-03-27 00:25:12',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(283,NULL,'t',NULL,3,'2020-03-27 00:25:15',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(284,NULL,'t',NULL,3,'2020-03-27 00:25:18',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(285,NULL,'t',NULL,3,'2020-03-27 00:25:20',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(286,NULL,'t',NULL,3,'2020-03-27 00:25:23',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(287,NULL,'t',NULL,3,'2020-03-27 00:25:26',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(288,NULL,'t',NULL,3,'2020-03-27 00:25:29',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(289,NULL,'t',NULL,3,'2020-03-27 00:25:33',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(290,NULL,'t',NULL,3,'2020-03-27 00:25:36',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(291,NULL,'t',NULL,3,'2020-03-27 00:25:41',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(292,NULL,'t',NULL,3,'2020-03-27 00:25:45',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(293,NULL,'t',NULL,3,'2020-03-27 00:25:49',NULL,NULL,NULL,1,255,NULL,NULL,NULL),(294,NULL,'t',NULL,3,'2020-03-27 00:06:13',NULL,NULL,NULL,1,257,NULL,NULL,NULL),(295,NULL,'t',NULL,3,'2020-03-27 00:06:50',NULL,NULL,NULL,1,259,NULL,NULL,NULL),(296,NULL,'t',NULL,3,'2020-03-27 00:07:56',NULL,NULL,NULL,1,261,NULL,NULL,NULL),(297,NULL,'t',NULL,3,'2020-03-27 00:15:37',NULL,NULL,NULL,1,264,NULL,NULL,NULL),(298,NULL,'t',NULL,3,'2020-03-27 00:15:50',NULL,NULL,NULL,1,265,NULL,NULL,NULL),(299,NULL,'t',NULL,3,'2020-03-27 00:17:16',NULL,NULL,NULL,1,266,NULL,NULL,NULL),(300,NULL,'t',NULL,3,'2020-03-27 00:27:53',NULL,NULL,NULL,1,268,NULL,NULL,NULL),(301,NULL,'t',NULL,3,'2020-03-27 00:29:33',NULL,NULL,NULL,1,269,NULL,NULL,NULL),(302,NULL,'t',NULL,3,'2020-03-27 00:46:18',NULL,NULL,NULL,1,274,NULL,NULL,NULL),(303,NULL,'t',NULL,3,'2020-03-27 00:47:54',NULL,NULL,NULL,1,276,NULL,NULL,NULL),(304,NULL,'t',NULL,3,'2020-03-27 00:50:22',NULL,NULL,NULL,1,278,NULL,NULL,NULL),(305,NULL,'t',NULL,3,'2020-03-27 00:50:37',NULL,NULL,NULL,1,279,NULL,NULL,NULL),(306,NULL,'t',NULL,3,'2020-03-27 00:50:47',NULL,NULL,NULL,1,280,NULL,NULL,NULL),(307,NULL,'t',NULL,3,'2020-03-27 00:52:34',NULL,NULL,NULL,1,281,NULL,NULL,NULL),(308,NULL,'t',NULL,3,'2020-03-27 00:52:46',NULL,NULL,NULL,1,282,NULL,NULL,NULL),(309,NULL,'t',NULL,3,'2020-03-27 00:54:27',NULL,NULL,NULL,1,283,NULL,NULL,NULL),(310,NULL,'t',NULL,3,'2020-03-27 00:54:51',NULL,NULL,NULL,1,284,NULL,NULL,NULL),(311,NULL,'t',NULL,3,'2020-03-27 00:55:17',NULL,NULL,NULL,1,285,NULL,NULL,NULL),(312,NULL,'t',NULL,3,'2020-03-27 00:55:30',NULL,NULL,NULL,1,286,NULL,NULL,NULL),(313,NULL,'t',NULL,3,'2020-03-27 00:55:37',NULL,NULL,NULL,1,287,NULL,NULL,NULL),(314,NULL,'t',NULL,3,'2020-03-27 00:55:44',NULL,NULL,NULL,1,288,NULL,NULL,NULL),(315,NULL,'t',NULL,3,'2020-03-27 00:55:58',NULL,NULL,NULL,1,289,NULL,NULL,NULL),(316,NULL,'t',NULL,3,'2020-03-27 01:01:18',NULL,NULL,NULL,1,290,NULL,NULL,NULL),(317,NULL,'t',NULL,3,'2020-03-27 01:01:31',NULL,NULL,NULL,1,291,NULL,NULL,NULL),(318,NULL,'t',NULL,3,'2020-03-27 01:01:49',NULL,NULL,NULL,1,292,NULL,NULL,NULL),(319,NULL,'t',NULL,3,'2020-03-27 01:02:01',NULL,NULL,NULL,1,293,NULL,NULL,NULL),(320,NULL,'t',NULL,3,'2020-03-27 01:02:15',NULL,NULL,NULL,1,294,NULL,NULL,NULL),(321,NULL,'t',NULL,3,'2020-03-27 01:06:41',NULL,NULL,NULL,1,295,NULL,NULL,NULL),(322,NULL,'t',NULL,3,'2020-03-27 01:06:53',NULL,NULL,NULL,1,296,NULL,NULL,NULL),(323,NULL,'t',NULL,3,'2020-03-27 01:07:01',NULL,NULL,NULL,1,297,NULL,NULL,NULL),(324,NULL,'t',NULL,3,'2020-03-27 01:07:09',NULL,NULL,NULL,1,298,NULL,NULL,NULL),(325,NULL,'t',NULL,3,'2020-03-27 01:07:17',NULL,NULL,NULL,1,299,NULL,NULL,NULL),(326,NULL,'t',NULL,3,'2020-03-27 01:07:24',NULL,NULL,NULL,1,300,NULL,NULL,NULL),(327,NULL,'t',NULL,3,'2020-03-27 01:10:59',NULL,NULL,NULL,1,301,NULL,NULL,NULL),(328,NULL,'t',NULL,3,'2020-03-27 01:23:40',NULL,NULL,NULL,1,302,NULL,NULL,NULL),(329,NULL,'t',NULL,3,'2020-03-27 01:29:18',NULL,NULL,NULL,1,304,NULL,NULL,NULL),(330,NULL,'t',NULL,3,'2020-03-27 01:31:28',NULL,NULL,NULL,1,305,NULL,NULL,NULL),(331,NULL,'t',NULL,3,'2020-03-27 01:32:05',NULL,NULL,NULL,1,306,NULL,NULL,NULL),(332,NULL,'t',NULL,3,'2020-03-27 01:32:42',NULL,NULL,NULL,1,307,NULL,NULL,NULL),(333,NULL,'t',NULL,3,'2020-03-27 01:34:02',NULL,NULL,NULL,1,308,NULL,NULL,NULL),(334,NULL,'t',NULL,3,'2020-03-27 01:34:11',NULL,NULL,NULL,1,309,NULL,NULL,NULL),(335,NULL,'t',NULL,3,'2020-03-27 01:38:34',NULL,NULL,NULL,1,311,NULL,NULL,NULL),(336,NULL,'t',NULL,3,'2020-03-27 01:39:29',NULL,NULL,NULL,1,313,NULL,NULL,NULL),(337,NULL,'t',NULL,3,'2020-03-27 01:39:51',NULL,NULL,NULL,1,314,NULL,NULL,NULL),(338,NULL,'t',NULL,3,'2020-03-27 01:40:18',NULL,NULL,NULL,1,315,NULL,NULL,NULL),(339,NULL,'t',NULL,3,'2020-03-27 01:47:04',NULL,NULL,NULL,1,330,NULL,NULL,NULL),(340,NULL,'t',NULL,3,'2020-03-27 01:47:14',NULL,NULL,NULL,1,331,NULL,NULL,NULL),(341,NULL,'t',NULL,3,'2020-03-27 01:47:51',NULL,NULL,NULL,1,332,NULL,NULL,NULL),(342,NULL,'t',NULL,3,'2020-03-27 01:48:17',NULL,NULL,NULL,1,333,NULL,NULL,NULL),(343,NULL,'t',NULL,3,'2020-03-27 01:48:48',NULL,NULL,NULL,1,334,NULL,NULL,NULL),(344,NULL,'t',NULL,3,'2020-03-27 01:49:45',NULL,NULL,NULL,1,335,NULL,NULL,NULL),(345,NULL,'t',NULL,3,'2020-03-27 01:51:50',NULL,NULL,NULL,1,336,NULL,NULL,NULL),(346,NULL,'t',NULL,3,'2020-03-27 02:07:45',NULL,NULL,NULL,1,344,NULL,NULL,NULL),(347,NULL,'t',NULL,3,'2020-03-27 02:09:22',NULL,NULL,NULL,1,345,NULL,NULL,NULL),(348,NULL,'t',NULL,3,'2020-03-27 17:48:24',NULL,NULL,NULL,1,356,NULL,NULL,NULL),(349,NULL,'p',NULL,3,'2020-03-27 17:57:00',NULL,NULL,NULL,1,358,NULL,NULL,NULL),(350,NULL,'p',NULL,3,'2020-03-27 17:59:42',NULL,NULL,NULL,1,359,NULL,NULL,NULL),(351,NULL,'p',NULL,3,'2020-03-27 18:00:13',NULL,NULL,NULL,1,360,NULL,NULL,NULL),(352,NULL,'p',NULL,3,'2020-03-27 18:01:50',NULL,NULL,NULL,1,361,NULL,NULL,NULL),(353,NULL,'p',NULL,3,'2020-03-27 18:03:26',NULL,NULL,NULL,1,362,NULL,NULL,NULL),(354,NULL,'t',NULL,3,'2020-03-27 18:17:36',NULL,NULL,NULL,1,1,NULL,NULL,NULL),(355,NULL,'t',NULL,3,'2020-03-27 18:21:51',NULL,NULL,NULL,1,3,NULL,NULL,NULL),(356,NULL,'t',NULL,3,'2020-03-27 18:45:40',NULL,NULL,NULL,1,5,NULL,NULL,NULL),(357,NULL,'t',NULL,3,'2020-03-27 18:48:16',NULL,NULL,NULL,1,1,NULL,NULL,NULL),(358,NULL,'t',NULL,3,'2020-03-30 01:57:18',NULL,NULL,NULL,1,37,NULL,NULL,NULL),(359,NULL,'t',NULL,3,'2020-03-30 02:00:06',NULL,NULL,NULL,1,40,NULL,NULL,NULL),(360,NULL,'t',NULL,1,'2020-03-30 02:10:58',NULL,NULL,NULL,1,42,NULL,NULL,NULL),(361,NULL,'t',NULL,3,'2020-03-30 02:15:32',NULL,NULL,NULL,1,45,NULL,NULL,NULL),(362,NULL,'t',NULL,1,'2020-03-30 02:31:33',NULL,NULL,NULL,1,51,NULL,NULL,NULL),(363,NULL,'t',NULL,3,'2020-03-30 02:43:20',NULL,NULL,NULL,1,52,NULL,NULL,NULL),(364,NULL,'t',NULL,1,'2020-03-30 02:49:14',NULL,NULL,NULL,1,55,NULL,NULL,NULL),(365,NULL,'t',NULL,1,'2020-03-30 02:57:50',NULL,NULL,NULL,1,59,NULL,NULL,NULL),(366,NULL,'t',NULL,3,'2020-03-30 03:08:23',NULL,NULL,NULL,1,63,NULL,NULL,NULL),(367,NULL,'t',NULL,1,'2020-03-30 03:13:54',NULL,NULL,NULL,1,66,NULL,NULL,NULL),(368,NULL,'t',NULL,1,'2020-03-30 13:50:28',NULL,NULL,NULL,1,73,NULL,NULL,NULL),(369,NULL,'t',NULL,1,'2020-03-30 13:55:07',NULL,NULL,NULL,1,78,NULL,NULL,NULL),(370,NULL,'t',NULL,1,'2020-03-30 13:58:15',NULL,NULL,NULL,1,82,NULL,NULL,NULL),(371,NULL,'t',NULL,3,'2020-03-30 14:00:04',NULL,NULL,NULL,1,84,NULL,NULL,NULL),(372,NULL,'t',NULL,4,'2020-03-30 14:55:05',NULL,NULL,NULL,1,1,NULL,NULL,NULL),(373,NULL,'t',NULL,4,'2020-03-30 14:59:28',NULL,NULL,NULL,1,4,NULL,NULL,NULL),(374,NULL,'t',NULL,4,'2020-03-30 15:00:57',NULL,NULL,NULL,1,6,NULL,NULL,NULL),(375,NULL,'t',NULL,3,'2020-03-30 15:03:12',NULL,NULL,NULL,1,8,NULL,NULL,NULL),(376,NULL,'t',NULL,4,'2020-03-30 15:03:48',NULL,NULL,NULL,1,9,NULL,NULL,NULL),(377,NULL,'t',NULL,3,'2020-03-30 15:06:06',NULL,NULL,NULL,1,12,NULL,NULL,NULL),(378,NULL,'t',NULL,4,'2020-03-30 15:09:09',NULL,NULL,NULL,1,17,NULL,NULL,NULL),(379,NULL,'t',NULL,4,'2020-03-30 15:10:02',NULL,NULL,NULL,1,19,NULL,NULL,NULL),(380,NULL,'t',NULL,4,'2020-03-30 15:10:39',NULL,NULL,NULL,1,21,NULL,NULL,NULL),(381,NULL,'t',NULL,4,'2020-03-30 15:14:51',NULL,NULL,NULL,1,26,NULL,NULL,NULL),(382,NULL,'t',NULL,4,'2020-03-30 15:16:26',NULL,NULL,NULL,1,31,NULL,NULL,NULL),(383,NULL,'t',NULL,4,'2020-03-30 15:17:34',NULL,NULL,NULL,1,33,NULL,NULL,NULL),(384,NULL,'t',NULL,4,'2020-03-30 15:18:16',NULL,NULL,NULL,1,35,NULL,NULL,NULL),(385,NULL,'t',NULL,3,'2020-03-30 15:19:15',NULL,NULL,NULL,1,36,NULL,NULL,NULL),(386,NULL,'t',NULL,3,'2020-03-30 15:22:41',NULL,NULL,NULL,1,41,NULL,NULL,NULL),(387,NULL,'t',NULL,4,'2020-03-30 15:24:26',NULL,NULL,NULL,1,43,NULL,NULL,NULL),(388,NULL,'t',NULL,3,'2020-03-30 17:21:19',NULL,NULL,NULL,1,48,NULL,NULL,NULL),(389,NULL,'t',NULL,3,'2020-03-30 19:59:29',NULL,NULL,NULL,1,49,NULL,NULL,NULL),(390,622,'p','10',95,'2020-04-02 11:02:18',1,NULL,'outro',2,NULL,NULL,NULL,NULL),(391,623,'p','11',96,'2020-04-02 11:10:02',1,NULL,'outro',2,NULL,NULL,NULL,NULL),(392,624,'p','13',116,'2020-04-02 13:45:38',1,NULL,'outro',2,NULL,NULL,NULL,NULL),(393,625,'p','14',110,'2020-04-02 13:47:27',1,NULL,'outro',2,NULL,NULL,NULL,NULL),(394,NULL,'t',NULL,3,'2020-04-06 14:54:41',NULL,NULL,NULL,1,150,NULL,NULL,NULL),(395,NULL,'t',NULL,3,'2020-04-06 15:02:03',NULL,NULL,NULL,1,157,NULL,NULL,NULL),(396,NULL,'t',NULL,3,'2020-04-06 15:05:27',NULL,NULL,NULL,1,159,NULL,NULL,NULL),(397,NULL,'t',NULL,3,'2020-04-09 14:36:46',NULL,NULL,NULL,1,264,NULL,NULL,NULL),(398,NULL,'t',NULL,3,'2020-04-09 16:42:50',NULL,NULL,NULL,1,267,NULL,NULL,NULL),(399,NULL,'t',NULL,3,'2020-04-09 16:43:28',NULL,NULL,NULL,1,268,NULL,NULL,NULL),(400,NULL,'t',NULL,3,'2020-04-09 16:53:17',NULL,NULL,NULL,1,269,NULL,NULL,NULL),(401,NULL,'t',NULL,3,'2020-04-09 16:53:45',NULL,NULL,NULL,1,270,NULL,NULL,NULL),(402,NULL,'t',NULL,3,'2020-04-09 17:00:34',NULL,NULL,NULL,1,271,NULL,NULL,NULL),(403,NULL,'p',NULL,157,'2020-04-15 18:10:43',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(404,NULL,'p',NULL,157,'2020-04-15 18:11:37',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(405,NULL,'p',NULL,157,'2020-04-15 18:12:47',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(406,NULL,'p',NULL,157,'2020-04-16 14:42:54',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(407,NULL,'t',NULL,3,'2020-04-17 14:23:34',NULL,NULL,NULL,1,330,NULL,NULL,NULL),(408,NULL,'t',NULL,3,'2020-04-17 14:28:36',NULL,NULL,NULL,1,333,NULL,NULL,NULL),(409,NULL,'t',NULL,3,'2020-04-17 14:36:02',NULL,NULL,NULL,1,339,NULL,NULL,NULL),(410,NULL,'t',NULL,3,'2020-04-17 14:40:56',NULL,NULL,NULL,1,1,NULL,NULL,NULL),(411,NULL,'t',NULL,3,'2020-04-17 14:42:33',NULL,NULL,NULL,1,3,NULL,NULL,NULL),(412,NULL,'t',NULL,3,'2020-04-17 14:43:41',NULL,NULL,NULL,1,6,NULL,NULL,NULL),(413,NULL,'t',NULL,3,'2020-04-17 14:57:48',NULL,NULL,NULL,1,1,NULL,NULL,NULL),(414,NULL,'t',NULL,3,'2020-04-17 14:59:46',NULL,NULL,NULL,1,4,NULL,NULL,NULL),(415,NULL,'t',NULL,3,'2020-04-17 15:07:14',NULL,NULL,NULL,1,1,NULL,NULL,NULL),(416,NULL,'t',NULL,3,'2020-04-17 15:55:51',NULL,NULL,NULL,1,1,NULL,NULL,NULL),(417,NULL,'t',NULL,3,'2020-04-17 15:56:46',NULL,NULL,NULL,1,4,NULL,NULL,NULL),(418,NULL,'t',NULL,3,'2020-04-17 15:59:11',NULL,NULL,NULL,1,7,NULL,NULL,NULL),(419,627,'p','558',158,'2020-04-17 16:16:10',1,65,'carro',0,NULL,NULL,NULL,NULL),(420,NULL,'t',NULL,4,'2020-04-17 16:17:23',NULL,NULL,NULL,1,10,NULL,NULL,NULL),(421,NULL,'t',NULL,4,'2020-04-17 16:51:01',NULL,NULL,NULL,1,20,NULL,NULL,NULL),(422,NULL,'t',NULL,4,'2020-04-17 18:49:01',NULL,NULL,NULL,1,70,NULL,NULL,NULL),(423,NULL,'t',NULL,4,'2020-04-17 18:49:52',NULL,NULL,NULL,1,73,NULL,NULL,NULL),(424,NULL,'t',NULL,4,'2020-04-17 18:51:50',NULL,NULL,NULL,1,78,NULL,NULL,NULL),(425,NULL,'t',NULL,4,'2020-04-17 18:53:34',NULL,NULL,NULL,1,81,NULL,NULL,NULL),(426,NULL,'t',NULL,4,'2020-04-17 18:54:50',NULL,NULL,NULL,1,83,NULL,NULL,NULL),(427,NULL,'t',NULL,4,'2020-04-17 19:03:31',NULL,NULL,NULL,1,88,NULL,NULL,NULL),(428,NULL,'t',NULL,4,'2020-04-17 19:05:17',NULL,NULL,NULL,1,90,NULL,NULL,NULL),(429,628,'p','12',159,'2020-04-20 10:49:07',1,NULL,'pedestre',1,NULL,NULL,NULL,NULL),(430,629,'p','142827',157,'2020-04-20 11:34:35',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(431,NULL,'p',NULL,157,'2020-04-20 11:35:28',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(432,NULL,'p',NULL,157,'2020-04-20 11:36:22',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(433,630,'p','142827',157,'2020-04-20 11:36:52',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(434,NULL,'p',NULL,157,'2020-04-20 11:40:07',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(435,NULL,'t',NULL,4,'2020-04-20 15:04:58',NULL,NULL,NULL,1,103,NULL,NULL,NULL),(436,NULL,'t',NULL,4,'2020-04-20 15:20:09',NULL,NULL,NULL,1,107,NULL,NULL,NULL),(437,NULL,'t',NULL,4,'2020-04-20 15:35:45',NULL,NULL,NULL,1,111,NULL,NULL,NULL),(438,NULL,'t',NULL,4,'2020-04-20 16:06:08',NULL,NULL,NULL,1,114,NULL,NULL,NULL),(439,NULL,'t',NULL,4,'2020-04-20 16:31:45',NULL,NULL,NULL,1,123,NULL,NULL,NULL),(440,NULL,'t',NULL,4,'2020-04-20 16:51:49',NULL,NULL,NULL,1,132,NULL,NULL,NULL),(441,NULL,'t',NULL,4,'2020-04-20 17:09:48',NULL,NULL,NULL,1,137,NULL,NULL,NULL),(442,NULL,'t',NULL,4,'2020-04-20 17:38:33',NULL,NULL,NULL,1,143,NULL,NULL,NULL),(443,NULL,'t',NULL,4,'2020-04-20 17:54:12',NULL,NULL,NULL,1,147,NULL,NULL,NULL),(444,NULL,'t',NULL,4,'2020-04-20 18:12:41',NULL,NULL,NULL,1,154,NULL,NULL,NULL),(445,NULL,'t',NULL,4,'2020-04-20 18:29:16',NULL,NULL,NULL,1,163,NULL,NULL,NULL),(446,NULL,'t',NULL,4,'2020-04-20 18:41:26',NULL,NULL,NULL,1,169,NULL,NULL,NULL),(447,NULL,'t',NULL,4,'2020-04-22 09:51:41',NULL,NULL,NULL,1,186,NULL,NULL,NULL),(448,NULL,'t',NULL,4,'2020-04-22 09:56:21',NULL,NULL,NULL,1,192,NULL,NULL,NULL),(449,NULL,'t',NULL,3,'2020-04-22 12:33:50',NULL,NULL,NULL,1,272,NULL,NULL,NULL),(450,NULL,'t',NULL,3,'2020-04-22 14:23:16',NULL,NULL,NULL,1,274,NULL,NULL,NULL),(451,NULL,'t',NULL,3,'2020-04-22 14:50:01',NULL,NULL,NULL,1,279,NULL,NULL,NULL),(452,NULL,'t',NULL,3,'2020-04-22 14:51:26',NULL,NULL,NULL,1,281,NULL,NULL,NULL),(453,NULL,'t',NULL,3,'2020-04-22 14:53:37',NULL,NULL,NULL,1,283,NULL,NULL,NULL),(454,633,'p','11',94,'2020-04-27 15:55:23',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(455,634,'p','12',95,'2020-04-27 16:01:50',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(456,635,'p','13',116,'2020-04-27 16:19:04',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(457,NULL,'p',NULL,139,'2020-04-27 16:51:01',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(458,NULL,'p',NULL,12,'2020-04-27 17:00:07',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(459,636,'p','15',113,'2020-04-27 17:13:14',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(460,NULL,'p',NULL,139,'2020-04-27 17:17:28',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(461,NULL,'p',NULL,138,'2020-04-27 17:23:38',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(462,637,'p','533550',160,'2020-04-27 17:23:57',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(463,638,'p','533550',160,'2020-04-27 17:24:31',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(464,639,'p','533550',160,'2020-04-27 17:25:46',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(465,NULL,'p',NULL,138,'2020-04-27 17:27:00',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(466,NULL,'p',NULL,138,'2020-04-27 17:41:58',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(467,NULL,'p',NULL,4,'2020-04-27 17:46:12',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(468,NULL,'p',NULL,12,'2020-04-27 17:49:31',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(469,NULL,'p',NULL,12,'2020-04-27 17:51:10',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(470,NULL,'p',NULL,54,'2020-04-27 17:51:39',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(471,NULL,'p',NULL,54,'2020-04-27 17:51:55',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(472,NULL,'p',NULL,139,'2020-04-27 17:53:17',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(473,NULL,'p',NULL,139,'2020-04-27 17:55:22',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(474,NULL,'p',NULL,138,'2020-04-27 17:55:57',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(475,NULL,'p',NULL,138,'2020-04-27 17:57:29',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(476,NULL,'p',NULL,138,'2020-04-27 17:57:40',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(477,644,'p','526571',119,'2020-04-28 08:55:07',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(478,641,'p','321252',161,'2020-04-28 08:55:27',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(479,642,'p','041857',101,'2020-04-28 08:56:42',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(480,645,'p','321252',161,'2020-04-28 08:57:10',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(481,647,'p','041857',101,'2020-04-28 08:58:15',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(482,646,'p','321252',161,'2020-04-28 08:58:30',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(483,649,'p','041857',101,'2020-04-28 09:00:13',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(484,648,'p','424100',100,'2020-04-28 09:00:39',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(485,650,'p','30',94,'2020-04-28 09:07:38',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(486,651,'p','041857',101,'2020-04-28 09:10:45',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(487,652,'p','041857',101,'2020-04-28 09:12:50',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(488,653,'p','041857',101,'2020-04-28 09:14:14',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(489,654,'p','041857',101,'2020-04-28 09:17:09',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(490,655,'p','041857',101,'2020-04-28 09:23:52',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(491,656,'p','041857',101,'2020-04-28 09:24:56',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(492,657,'p','041857',101,'2020-04-28 09:25:45',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(493,658,'p','041857',101,'2020-04-28 09:27:06',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(494,659,'p','041857',101,'2020-04-28 09:29:07',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(495,660,'p','041857',101,'2020-04-28 09:29:24',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(496,661,'p','041857',101,'2020-04-28 09:31:36',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(497,662,'p','041857',101,'2020-04-28 09:32:22',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(498,663,'p','041857',101,'2020-04-28 09:35:27',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(499,664,'p','041857',101,'2020-04-28 09:37:55',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(500,NULL,'p',NULL,4,'2020-04-28 09:38:53',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(501,NULL,'p',NULL,4,'2020-04-28 09:39:22',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(502,NULL,'p',NULL,138,'2020-04-28 09:44:03',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(503,666,'p','199468',162,'2020-04-28 10:25:27',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(504,667,'p','199468',162,'2020-04-28 10:29:25',1,106,'carro',1,NULL,NULL,NULL,NULL),(505,668,'p','199468',162,'2020-04-28 10:34:50',1,106,'carro',1,NULL,NULL,NULL,NULL),(506,669,'p','199468',162,'2020-04-28 11:11:54',1,106,'carro',1,NULL,NULL,NULL,NULL),(507,670,'p','199468',162,'2020-04-28 14:41:41',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(508,671,'p','199468',162,'2020-04-28 15:25:57',1,106,'carro',1,NULL,NULL,NULL,NULL),(509,672,'p','199468',162,'2020-04-28 15:31:07',1,106,'carro',1,NULL,NULL,NULL,NULL),(510,NULL,'p',NULL,3,'2020-04-28 15:31:59',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(511,NULL,'p',NULL,19,'2020-04-28 15:32:38',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(512,NULL,'p',NULL,4,'2020-04-28 15:33:08',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(513,673,'p','041857',101,'2020-04-28 15:52:23',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(514,674,'p','041857',101,'2020-04-28 15:54:50',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(515,675,'p','227836',106,'2020-04-28 15:57:19',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(516,676,'p','199468',162,'2020-04-28 15:57:53',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(517,NULL,'p',NULL,7,'2020-04-28 16:02:07',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(518,NULL,'p',NULL,45,'2020-04-28 16:02:43',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(519,NULL,'p',NULL,45,'2020-04-28 16:04:28',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(520,NULL,'p',NULL,12,'2020-04-28 16:05:23',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(521,NULL,'p',NULL,139,'2020-04-28 16:10:27',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(522,NULL,'p',NULL,6,'2020-04-28 16:11:03',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(523,NULL,'p',NULL,138,'2020-04-28 16:12:20',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(524,NULL,'p',NULL,138,'2020-04-28 16:23:47',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(525,677,'p','041857',101,'2020-04-29 08:28:17',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(526,678,'p','041857',101,'2020-04-29 08:28:34',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(527,679,'p','041857',101,'2020-04-29 08:29:56',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(528,680,'p','041857',101,'2020-04-29 08:30:11',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(529,681,'p','041857',101,'2020-04-29 08:30:50',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(530,682,'p','041857',101,'2020-04-29 08:31:04',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(531,683,'p','041857',101,'2020-04-29 08:43:08',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(532,684,'p','041857',101,'2020-04-29 08:49:00',1,107,'carro',1,NULL,NULL,NULL,NULL),(533,685,'p','041857',101,'2020-04-29 08:50:33',1,107,'carro',1,NULL,NULL,NULL,NULL),(534,NULL,'p',NULL,138,'2020-04-29 09:01:45',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(535,NULL,'p',NULL,138,'2020-04-29 09:02:33',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(536,NULL,'p',NULL,139,'2020-04-29 09:04:14',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(537,NULL,'p',NULL,7,'2020-04-29 09:06:37',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(538,NULL,'p',NULL,7,'2020-04-29 09:13:19',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(539,NULL,'p',NULL,138,'2020-04-29 09:15:10',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(540,NULL,'p',NULL,139,'2020-04-29 09:17:03',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(541,NULL,'p',NULL,138,'2020-04-29 09:18:50',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(542,NULL,'p',NULL,7,'2020-04-29 09:29:24',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(543,NULL,'p',NULL,138,'2020-04-29 09:29:43',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(544,NULL,'p',NULL,6,'2020-04-29 09:29:53',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(545,NULL,'p',NULL,7,'2020-04-29 09:32:54',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(546,NULL,'p',NULL,6,'2020-04-29 09:33:01',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(547,NULL,'p',NULL,138,'2020-04-29 09:33:08',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(548,686,'p','041857',101,'2020-04-29 09:36:03',1,107,'carro',1,NULL,NULL,NULL,NULL),(549,687,'p','041857',101,'2020-04-29 09:36:18',1,107,'carro',1,NULL,NULL,NULL,NULL),(550,688,'p','041857',101,'2020-04-29 09:36:31',1,107,'carro',1,NULL,NULL,NULL,NULL),(551,689,'p','041857',101,'2020-04-29 09:36:47',1,107,'carro',1,NULL,NULL,NULL,NULL),(552,690,'p','041857',101,'2020-04-29 09:39:55',1,107,'carro',1,NULL,NULL,NULL,NULL),(553,691,'p','041857',101,'2020-04-29 09:40:09',1,107,'carro',1,NULL,NULL,NULL,NULL),(554,692,'p','041857',101,'2020-04-29 09:40:21',1,107,'carro',1,NULL,NULL,NULL,NULL),(555,693,'p','041857',101,'2020-04-29 09:40:34',1,107,'carro',1,NULL,NULL,NULL,NULL),(556,694,'p','041857',101,'2020-04-29 09:42:05',1,107,'carro',1,NULL,NULL,NULL,NULL),(557,695,'p','041857',101,'2020-04-29 09:42:16',1,107,'carro',1,NULL,NULL,NULL,NULL),(558,696,'p','041857',101,'2020-04-29 09:42:28',1,107,'carro',1,NULL,NULL,NULL,NULL),(559,697,'p','041857',101,'2020-04-29 09:42:40',1,107,'carro',1,NULL,NULL,NULL,NULL),(560,698,'p','041857',101,'2020-04-29 09:44:37',1,107,'carro',1,NULL,NULL,NULL,NULL),(561,NULL,'p',NULL,163,'2020-04-29 17:25:20',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(562,NULL,'p',NULL,163,'2020-04-29 17:26:24',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(563,NULL,'p',NULL,138,'2020-04-29 17:26:39',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(564,701,'p','794800',98,'2020-04-29 18:24:13',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(565,699,'p','199468',162,'2020-04-29 18:24:37',1,106,'carro',1,NULL,NULL,NULL,NULL),(566,NULL,'p',NULL,4,'2020-04-29 18:25:28',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(567,700,'p','650548',113,'2020-04-29 18:25:38',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(568,702,'p','199468',162,'2020-04-29 19:22:51',1,106,'carro',1,NULL,NULL,NULL,NULL),(569,703,'p','199468',162,'2020-04-29 19:24:02',1,106,'carro',1,NULL,NULL,NULL,NULL),(570,704,'p','01',94,'2020-04-30 08:47:35',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(571,705,'p','199468',162,'2020-04-30 10:33:48',1,106,'carro',1,NULL,NULL,NULL,NULL),(572,NULL,'p',NULL,3,'2020-04-30 10:34:24',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(573,712,'p','aa',168,'2020-05-11 18:42:06',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(574,714,'p','527386',169,'2020-05-13 18:04:36',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(575,715,'p','527386',169,'2020-05-13 18:27:36',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(576,719,'p','999999',166,'2020-05-22 11:49:43',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(577,720,'p','999999',166,'2020-05-22 11:51:40',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(578,722,'p','999999',139,'2020-05-22 11:56:07',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(579,728,'p','277473',171,'2020-06-05 14:35:54',1,113,'carro',0,NULL,NULL,NULL,NULL),(580,729,'p','277473',171,'2020-06-05 14:36:28',1,113,'carro',0,NULL,NULL,NULL,NULL),(581,730,'p','277473',171,'2020-06-05 14:37:39',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(582,732,'p','624566',173,'2020-06-05 16:51:05',1,114,'carro',1,NULL,NULL,NULL,NULL),(583,731,'p','844716',172,'2020-06-05 16:51:38',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(584,733,'p','729167',174,'2020-06-05 16:52:59',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(585,734,'p','327267',176,'2020-06-08 10:44:52',1,NULL,'outro',2,NULL,NULL,NULL,NULL),(586,736,'p','133',177,'2020-06-08 15:39:50',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(587,NULL,'p',NULL,4,'2020-06-09 09:26:00',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(588,NULL,'p',NULL,19,'2020-06-09 15:28:05',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(589,737,'p','827842',178,'2020-06-09 15:38:06',1,119,'carro',1,NULL,NULL,NULL,NULL),(590,743,'p','634976',179,'2020-06-09 15:45:08',1,120,'carro',1,NULL,NULL,NULL,NULL),(591,742,'p','853746',180,'2020-06-09 15:54:24',1,121,'carro',1,NULL,NULL,NULL,NULL),(592,740,'p','748275',181,'2020-06-09 16:01:02',1,122,'carro',1,NULL,NULL,NULL,NULL),(593,NULL,'p',NULL,136,'2020-06-09 16:28:17',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(594,751,'p','122',187,'2020-06-09 16:29:06',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(595,766,'p','10',3,'2020-06-16 14:11:57',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(596,767,'p','11',190,'2020-06-16 14:14:00',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(597,NULL,'p',NULL,4,'2020-06-16 14:15:31',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(598,768,'p','12',110,'2020-06-16 14:19:19',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(599,770,'p','700941',191,'2020-06-16 14:23:22',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(600,771,'p','700941',191,'2020-06-16 14:25:07',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(601,772,'p','700941',191,'2020-06-16 14:34:51',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(602,773,'p','700941',191,'2020-06-16 14:44:37',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(603,769,'p','821480',94,'2020-06-16 14:45:54',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(604,774,'p','700941',191,'2020-06-16 14:46:52',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(605,775,'p','700941',191,'2020-06-16 14:49:51',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(606,NULL,'p',NULL,136,'2020-06-18 17:45:05',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(607,NULL,'p',NULL,12,'2020-06-26 17:16:40',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(608,799,'p','033532',110,'2020-06-26 17:19:24',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(609,NULL,'p',NULL,12,'2020-06-26 17:22:10',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(610,800,'p','033532',110,'2020-06-26 17:22:29',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(611,NULL,'p',NULL,12,'2020-06-26 17:26:02',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(612,801,'p','033532',110,'2020-06-26 17:31:15',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(613,802,'p','033532',110,'2020-06-26 17:38:10',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(614,803,'p','033532',110,'2020-06-26 17:41:40',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(615,804,'p','033532',110,'2020-06-26 17:42:22',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(616,805,'p','033532',110,'2020-06-26 17:56:38',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(617,NULL,'p',NULL,189,'2020-06-29 17:34:46',1,NULL,NULL,2,NULL,NULL,NULL,NULL),(618,810,'p','145262',195,'2020-06-29 18:09:03',1,126,'carro',2,NULL,NULL,NULL,NULL),(619,814,'p','143427',196,'2020-06-29 18:22:01',1,127,'carro',2,NULL,NULL,NULL,NULL),(620,820,'p','478410',189,'2020-06-30 17:25:15',1,129,'carro',1,NULL,NULL,NULL,NULL),(621,819,'p','996',197,'2020-06-30 17:26:42',1,130,'carro',1,NULL,NULL,NULL,NULL),(622,818,'p','997',198,'2020-06-30 17:32:16',1,131,'carro',1,NULL,NULL,NULL,NULL),(623,824,'p','85',199,'2020-06-30 17:44:01',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(624,828,'p','857223',10,'2020-07-01 10:40:32',1,4,'carro',1,NULL,NULL,NULL,NULL),(625,829,'p','857224',10,'2020-07-01 10:40:58',1,4,'carro',1,NULL,NULL,NULL,NULL),(626,830,'p','8572231',10,'2020-07-01 10:42:04',1,4,'moto',1,NULL,NULL,NULL,NULL),(627,NULL,'p',NULL,189,'2020-07-01 15:49:23',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(628,NULL,'p',NULL,167,'2020-07-01 15:51:10',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(629,835,'p','558',201,'2020-07-06 15:11:58',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(630,836,'p','11',191,'2020-07-06 17:23:06',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(631,838,'p','700941',191,'2020-07-06 17:53:59',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(632,839,'p','100',203,'2020-07-08 12:18:17',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(633,NULL,'p',NULL,12,'2020-07-08 14:08:47',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(634,NULL,'p',NULL,19,'2020-07-08 14:59:20',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(635,NULL,'p',NULL,189,'2020-07-08 15:35:43',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(636,NULL,'p',NULL,4,'2020-07-08 15:46:37',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(637,NULL,'p',NULL,19,'2020-07-08 16:00:36',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(638,NULL,'p',NULL,19,'2020-07-08 16:03:20',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(639,NULL,'p',NULL,138,'2020-07-08 16:24:36',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(640,NULL,'p',NULL,3,'2020-07-08 16:31:19',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(641,NULL,'p',NULL,138,'2020-07-08 16:35:09',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(642,NULL,'p',NULL,138,'2020-07-08 16:35:49',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(643,NULL,'p',NULL,3,'2020-07-08 16:36:05',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(644,840,'p','456789',205,'2020-07-08 16:44:24',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(645,841,'p','456789',205,'2020-07-08 16:50:25',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(646,NULL,'p',NULL,12,'2020-07-08 18:07:07',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(647,NULL,'p',NULL,12,'2020-07-08 18:08:51',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(648,NULL,'p',NULL,12,'2020-07-08 18:09:27',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(649,NULL,'p',NULL,12,'2020-07-08 18:10:40',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(650,NULL,'p',NULL,19,'2020-07-08 18:14:23',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(651,NULL,'p',NULL,19,'2020-07-08 18:15:09',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(652,NULL,'p',NULL,19,'2020-07-08 18:16:55',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(653,NULL,'p',NULL,19,'2020-07-08 18:17:35',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(654,NULL,'p',NULL,19,'2020-07-08 18:18:50',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(655,NULL,'p',NULL,19,'2020-07-08 18:21:17',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(656,NULL,'p',NULL,19,'2020-07-08 18:21:38',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(657,NULL,'p',NULL,12,'2020-07-08 18:22:22',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(658,NULL,'p',NULL,189,'2020-07-08 18:25:05',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(659,NULL,'p',NULL,138,'2020-07-08 18:26:21',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(660,NULL,'p',NULL,138,'2020-07-08 18:27:48',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(661,NULL,'p',NULL,12,'2020-07-08 18:40:13',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(662,842,'p','120',206,'2020-07-09 11:29:11',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(663,NULL,'p',NULL,19,'2020-07-10 11:45:56',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(664,NULL,'p',NULL,131,'2020-07-10 11:46:08',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(665,NULL,'p',NULL,143,'2020-07-10 11:46:16',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(666,NULL,'p',NULL,165,'2020-07-10 11:46:26',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(667,NULL,'p',NULL,167,'2020-07-10 11:46:57',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(668,NULL,'p',NULL,166,'2020-07-10 11:47:40',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(669,NULL,'p',NULL,167,'2020-07-10 13:20:40',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(670,NULL,'p',NULL,166,'2020-07-10 13:21:15',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(671,NULL,'p',NULL,165,'2020-07-10 13:25:41',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(672,844,'p','648111',207,'2020-07-10 13:30:09',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(673,845,'p','648111',207,'2020-07-10 13:32:30',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(674,846,'p','648111',207,'2020-07-10 13:35:39',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(675,847,'p','648111',207,'2020-07-10 13:36:46',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(676,NULL,'p',NULL,165,'2020-07-10 13:37:09',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(677,NULL,'p',NULL,167,'2020-07-10 13:42:13',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(678,NULL,'p',NULL,166,'2020-07-10 13:42:41',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(679,NULL,'p',NULL,143,'2020-07-10 13:44:44',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(680,NULL,'p',NULL,19,'2020-07-10 13:45:01',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(681,NULL,'p',NULL,19,'2020-07-10 13:46:02',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(682,NULL,'p',NULL,143,'2020-07-10 13:46:21',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(683,NULL,'p',NULL,19,'2020-07-10 14:01:19',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(684,NULL,'p',NULL,131,'2020-07-10 14:04:44',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(685,NULL,'p',NULL,131,'2020-07-10 14:06:13',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(686,NULL,'p',NULL,131,'2020-07-10 14:07:06',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(687,NULL,'p',NULL,131,'2020-07-10 14:09:06',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(688,NULL,'p',NULL,143,'2020-07-10 14:12:00',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(689,NULL,'p',NULL,167,'2020-07-10 14:13:17',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(690,NULL,'p',NULL,166,'2020-07-10 14:14:26',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(691,848,'p','648111',207,'2020-07-10 14:19:22',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(692,849,'p','648111',207,'2020-07-10 14:22:07',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(693,850,'p','648111',207,'2020-07-10 14:23:48',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(694,851,'p','648111',207,'2020-07-10 14:25:33',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(695,852,'p','648111',207,'2020-07-10 14:28:18',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(696,853,'p','648111',207,'2020-07-10 14:29:52',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(697,854,'p','648111',207,'2020-07-10 14:33:18',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(698,855,'p','648111',207,'2020-07-10 14:34:54',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(699,856,'p','648111',207,'2020-07-10 14:38:54',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(700,857,'p','648111',207,'2020-07-10 14:39:35',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(701,858,'p','648111',207,'2020-07-10 14:40:56',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(702,859,'p','648111',207,'2020-07-10 14:42:29',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(703,860,'p','648111',207,'2020-07-10 14:42:53',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(704,861,'p','648111',207,'2020-07-10 14:45:15',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(705,862,'p','648111',207,'2020-07-10 14:45:42',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(706,NULL,'p',NULL,131,'2020-07-10 14:49:19',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(707,NULL,'p',NULL,19,'2020-07-10 14:49:30',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(708,NULL,'p',NULL,19,'2020-07-10 14:50:11',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(709,NULL,'p',NULL,131,'2020-07-10 14:50:46',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(710,NULL,'p',NULL,143,'2020-07-10 14:51:23',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(711,NULL,'p',NULL,166,'2020-07-10 14:52:10',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(712,NULL,'p',NULL,167,'2020-07-10 14:52:46',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(713,863,'p','648111',207,'2020-07-10 14:53:50',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(714,864,'p','648111',207,'2020-07-10 14:54:30',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(715,865,'p','648111',207,'2020-07-10 14:55:52',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(716,866,'p','648111',207,'2020-07-10 14:56:14',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(717,867,'p','648111',207,'2020-07-10 14:58:00',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(718,868,'p','648111',207,'2020-07-10 14:58:15',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(719,869,'p','648111',207,'2020-07-10 14:58:55',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(720,870,'p','648111',207,'2020-07-10 14:59:11',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(721,871,'p','648111',207,'2020-07-10 15:01:17',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(722,872,'p','648111',207,'2020-07-10 15:01:44',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(723,873,'p','648111',207,'2020-07-10 15:02:50',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(724,874,'p','648111',207,'2020-07-10 15:05:44',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(725,NULL,'p',NULL,12,'2020-07-10 17:21:20',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(726,NULL,'p',NULL,12,'2020-07-10 17:58:48',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(727,876,'p','264141',208,'2020-07-14 14:18:51',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(728,878,'p','648111',207,'2020-07-14 15:57:05',1,135,'carro',1,NULL,NULL,NULL,NULL),(729,879,'p','648111',207,'2020-07-14 16:03:07',1,135,'carro',1,NULL,NULL,NULL,NULL),(730,880,'p','648111',207,'2020-07-14 16:13:12',1,135,'carro',1,NULL,NULL,NULL,NULL),(731,NULL,'p',NULL,3,'2020-07-14 16:49:31',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(732,NULL,'p',NULL,4,'2020-07-14 16:51:25',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(733,NULL,'p',NULL,19,'2020-07-14 16:52:54',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(734,NULL,'p',NULL,12,'2020-07-14 17:18:32',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(735,NULL,'p',NULL,136,'2020-07-14 17:29:03',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(736,881,'p','857117',209,'2020-07-23 11:11:15',1,136,'carro',1,NULL,NULL,NULL,NULL),(737,886,'p','880625',210,'2020-07-23 11:38:57',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(738,892,'p','aabb',211,'2020-07-23 12:33:01',1,137,'carro',1,NULL,NULL,NULL,NULL),(739,NULL,'p',NULL,12,'2020-07-23 16:29:25',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(740,894,'p','122',212,'2020-07-23 16:36:57',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(741,NULL,'p',NULL,136,'2020-07-23 16:57:54',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(742,NULL,'p',NULL,136,'2020-07-23 16:58:08',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(743,NULL,'p',NULL,136,'2020-07-23 17:01:47',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(744,NULL,'p',NULL,3,'2020-07-23 17:05:33',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(745,NULL,'p',NULL,3,'2020-07-23 17:07:17',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(746,NULL,'p',NULL,3,'2020-07-23 17:08:01',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(747,NULL,'p',NULL,136,'2020-07-23 17:22:11',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(748,896,'p','2222',206,'2020-07-27 12:26:46',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(749,897,'p','3333',206,'2020-07-27 16:10:15',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(750,898,'p','648111',207,'2020-07-28 17:35:39',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(751,NULL,'p',NULL,131,'2020-07-29 08:53:05',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(752,899,'p','648111',207,'2020-07-29 09:02:33',1,135,'carro',0,NULL,NULL,NULL,NULL),(753,900,'p','648111',207,'2020-07-29 09:04:42',1,135,'carro',0,NULL,NULL,NULL,NULL),(754,NULL,'p',NULL,165,'2020-07-29 09:29:28',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(755,NULL,'p',NULL,131,'2020-07-29 09:31:11',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(756,NULL,'p',NULL,143,'2020-07-29 09:33:32',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(757,NULL,'p',NULL,19,'2020-07-29 09:35:09',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(758,NULL,'p',NULL,143,'2020-07-29 09:35:21',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(759,NULL,'p',NULL,165,'2020-07-29 09:35:59',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(760,NULL,'p',NULL,143,'2020-07-29 09:37:04',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(761,NULL,'p',NULL,131,'2020-07-29 09:37:15',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(762,NULL,'p',NULL,167,'2020-07-29 09:38:45',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(763,NULL,'p',NULL,166,'2020-07-29 09:39:04',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(764,NULL,'p',NULL,143,'2020-07-29 09:42:16',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(765,901,'p','648111',207,'2020-07-29 09:43:19',1,135,'carro',0,NULL,NULL,NULL,NULL),(766,902,'p','648111',207,'2020-07-29 09:43:45',1,135,'carro',0,NULL,NULL,NULL,NULL),(767,903,'p','648111',207,'2020-07-29 09:45:38',1,135,'carro',0,NULL,NULL,NULL,NULL),(768,904,'p','648111',207,'2020-07-29 09:46:00',1,135,'carro',0,NULL,NULL,NULL,NULL),(769,905,'p','648111',207,'2020-07-29 09:48:47',1,135,'carro',0,NULL,NULL,NULL,NULL),(770,906,'p','648111',207,'2020-07-29 09:49:21',1,135,'carro',0,NULL,NULL,NULL,NULL),(771,907,'p','648111',207,'2020-07-29 09:51:01',1,135,'carro',0,NULL,NULL,NULL,NULL),(772,908,'p','648111',207,'2020-07-29 09:51:30',1,135,'carro',0,NULL,NULL,NULL,NULL),(773,NULL,'p',NULL,165,'2020-07-29 09:53:01',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(774,NULL,'p',NULL,131,'2020-07-29 09:53:51',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(775,NULL,'p',NULL,143,'2020-07-29 09:55:02',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(776,NULL,'p',NULL,166,'2020-07-29 09:55:59',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(777,NULL,'p',NULL,167,'2020-07-29 09:56:11',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(778,NULL,'p',NULL,167,'2020-07-29 09:56:58',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(779,NULL,'p',NULL,167,'2020-07-29 09:57:18',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(780,NULL,'p',NULL,167,'2020-07-29 09:57:31',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(781,NULL,'p',NULL,167,'2020-07-29 10:13:33',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(782,909,'p','648111',207,'2020-07-29 10:15:34',1,135,'carro',0,NULL,NULL,NULL,NULL),(783,910,'p','648111',207,'2020-07-29 10:16:18',1,135,'carro',0,NULL,NULL,NULL,NULL),(784,911,'p','648111',207,'2020-07-29 10:20:02',1,135,'carro',0,NULL,NULL,NULL,NULL),(785,912,'p','648111',207,'2020-07-29 10:21:56',1,135,'carro',0,NULL,NULL,NULL,NULL),(786,913,'p','648111',207,'2020-07-29 10:24:57',1,135,'carro',0,NULL,NULL,NULL,NULL),(787,914,'p','648111',207,'2020-07-29 10:27:06',1,135,'carro',0,NULL,NULL,NULL,NULL),(788,915,'p','648111',207,'2020-07-29 10:28:09',1,135,'carro',0,NULL,NULL,NULL,NULL),(789,NULL,'p',NULL,3,'2020-07-29 11:34:08',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(790,NULL,'p',NULL,3,'2020-07-29 11:34:55',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(791,916,'p','033532',110,'2020-07-29 11:36:08',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(792,NULL,'p',NULL,3,'2020-07-29 12:14:33',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(793,917,'p','648111',207,'2020-07-29 15:42:24',1,135,'carro',0,NULL,NULL,NULL,NULL),(794,918,'p','648111',207,'2020-07-29 15:43:51',1,135,'carro',0,NULL,NULL,NULL,NULL),(795,919,'p','648111',207,'2020-07-29 15:44:42',1,135,'carro',0,NULL,NULL,NULL,NULL),(796,920,'p','648111',207,'2020-07-29 15:45:40',1,135,'carro',0,NULL,NULL,NULL,NULL),(797,921,'p','648111',207,'2020-07-29 15:45:57',1,135,'carro',0,NULL,NULL,NULL,NULL),(798,924,'p','648111',207,'2020-07-29 15:47:48',1,135,'carro',0,NULL,NULL,NULL,NULL),(799,925,'p','648111',207,'2020-07-29 15:49:26',1,135,'carro',0,NULL,NULL,NULL,NULL),(800,NULL,'p',NULL,19,'2020-07-29 17:33:37',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(801,NULL,'p',NULL,131,'2020-07-29 17:34:21',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(802,NULL,'p',NULL,131,'2020-07-29 17:35:58',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(803,NULL,'p',NULL,143,'2020-07-29 17:36:44',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(804,NULL,'p',NULL,167,'2020-07-29 17:37:21',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(805,NULL,'p',NULL,166,'2020-07-29 17:37:27',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(806,926,'p','648111',207,'2020-07-29 17:38:19',1,135,'carro',0,NULL,NULL,NULL,NULL),(807,927,'p','648111',207,'2020-07-29 17:38:41',1,135,'carro',0,NULL,NULL,NULL,NULL),(808,928,'p','648111',207,'2020-07-29 17:40:35',1,135,'carro',0,NULL,NULL,NULL,NULL),(809,929,'p','648111',207,'2020-07-29 17:41:03',1,135,'carro',0,NULL,NULL,NULL,NULL),(810,930,'p','648111',207,'2020-07-29 17:41:58',1,135,'carro',0,NULL,NULL,NULL,NULL),(811,931,'p','648111',207,'2020-07-29 17:45:26',1,135,'carro',0,NULL,NULL,NULL,NULL),(812,932,'p','648111',207,'2020-07-29 17:46:35',1,135,'carro',0,NULL,NULL,NULL,NULL),(813,934,'p','648111',207,'2020-07-30 09:01:22',1,135,'carro',0,NULL,NULL,NULL,NULL),(814,935,'p','648111',207,'2020-07-30 09:02:28',1,135,'carro',0,NULL,NULL,NULL,NULL),(815,936,'p','648111',207,'2020-07-30 09:02:56',1,135,'carro',0,NULL,NULL,NULL,NULL),(816,937,'p','648111',207,'2020-07-30 09:03:38',1,135,'carro',0,NULL,NULL,NULL,NULL),(817,938,'p','648111',207,'2020-07-30 09:03:55',1,135,'carro',0,NULL,NULL,NULL,NULL),(818,939,'p','648111',207,'2020-07-30 09:04:30',1,135,'carro',0,NULL,NULL,NULL,NULL),(819,NULL,'p',NULL,19,'2020-07-30 09:05:59',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(820,NULL,'p',NULL,143,'2020-07-30 09:06:29',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(821,NULL,'p',NULL,165,'2020-07-30 09:06:41',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(822,NULL,'p',NULL,167,'2020-07-30 09:06:58',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(823,NULL,'p',NULL,166,'2020-07-30 09:07:16',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(824,940,'p','648111',207,'2020-07-30 09:07:56',1,135,'carro',0,NULL,NULL,NULL,NULL),(825,941,'p','648111',207,'2020-07-30 09:08:16',1,135,'carro',0,NULL,NULL,NULL,NULL),(826,942,'p','648111',207,'2020-07-30 09:09:52',1,135,'carro',0,NULL,NULL,NULL,NULL),(827,943,'p','3333',213,'2020-07-30 17:04:19',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(828,944,'p','2222',213,'2020-07-30 17:11:29',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(829,945,'p','1111',213,'2020-07-30 17:26:32',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(830,946,'p','1111',110,'2020-07-30 17:47:48',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(831,947,'p','101',214,'2020-07-31 09:52:38',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(832,949,'p','766871',214,'2020-07-31 10:15:49',1,138,'carro',0,NULL,NULL,NULL,NULL),(833,950,'p','648111',207,'2020-08-03 17:29:26',1,135,'carro',0,NULL,NULL,NULL,NULL),(834,951,'p','648111',207,'2020-08-03 17:31:22',1,135,'carro',0,NULL,NULL,NULL,NULL),(835,952,'p','648111',207,'2020-08-03 17:32:48',1,135,'carro',0,NULL,NULL,NULL,NULL),(836,953,'p','648111',207,'2020-08-03 17:36:46',1,135,'carro',0,NULL,NULL,NULL,NULL),(837,954,'p','648111',207,'2020-08-03 17:45:12',1,135,'carro',0,NULL,NULL,NULL,NULL),(838,955,'p','648111',207,'2020-08-03 17:46:35',1,135,'carro',0,NULL,NULL,NULL,NULL),(839,956,'p','648111',207,'2020-08-03 17:47:04',1,135,'carro',0,NULL,NULL,NULL,NULL),(840,957,'p','648111',207,'2020-08-03 17:47:34',1,135,'carro',0,NULL,NULL,NULL,NULL),(841,958,'p','648111',207,'2020-08-03 17:48:16',1,135,'carro',0,NULL,NULL,NULL,NULL),(842,NULL,'p',NULL,19,'2020-08-03 17:49:36',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(843,NULL,'p',NULL,131,'2020-08-03 17:50:28',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(844,NULL,'p',NULL,166,'2020-08-21 14:26:56',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(845,NULL,'p',NULL,19,'2020-08-21 15:04:04',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(846,NULL,'p',NULL,19,'2020-08-21 15:04:18',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(847,962,'p','033532',110,'2020-09-03 17:20:12',1,139,'carro',0,NULL,NULL,NULL,NULL),(848,NULL,'p',NULL,3,'2020-09-04 09:41:20',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(849,NULL,'p',NULL,3,'2020-09-04 09:42:38',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(850,962,'p','033532',110,'2020-09-04 09:44:01',1,139,'carro',0,NULL,NULL,NULL,NULL),(851,962,'p','033532',110,'2020-09-04 09:52:09',1,139,'carro',0,NULL,NULL,NULL,NULL),(852,962,'p','033532',110,'2020-09-04 10:36:08',1,139,'carro',1,NULL,NULL,NULL,NULL),(853,962,'p','033532',110,'2020-09-04 10:44:37',1,139,'carro',1,NULL,NULL,NULL,NULL),(854,962,'p','033532',110,'2020-09-04 10:46:00',1,139,'carro',1,NULL,NULL,NULL,NULL),(855,962,'p','033532',110,'2020-09-04 11:21:27',1,139,'carro',1,NULL,NULL,NULL,NULL),(856,962,'p','033532',110,'2020-09-04 11:31:00',1,139,'carro',1,NULL,NULL,NULL,NULL),(857,965,'p','100',214,'2020-09-08 14:27:36',1,138,'carro',1,NULL,NULL,NULL,NULL),(858,966,'p','101',203,'2020-09-08 14:33:58',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(859,967,'p','103',213,'2020-09-08 14:44:32',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(860,NULL,'p',NULL,138,'2020-09-08 15:08:03',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(861,968,'p','120',215,'2020-09-08 16:01:54',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(862,NULL,'p',NULL,138,'2020-09-17 17:46:15',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(863,971,'p','111',215,'2020-09-18 08:21:16',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(864,973,'p','264141',208,'2020-09-21 14:56:19',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(865,NULL,'p',NULL,19,'2020-09-25 10:31:18',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(866,NULL,'p',NULL,167,'2020-09-25 10:31:56',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(867,NULL,'p',NULL,165,'2020-09-25 10:33:26',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(868,NULL,'p',NULL,165,'2020-09-25 10:33:59',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(869,978,'p','264141',208,'2020-10-06 09:23:18',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(870,979,'p','648111',207,'2020-10-06 09:23:32',1,135,'carro',1,NULL,NULL,NULL,NULL),(871,986,'p','047924',217,'2020-10-15 14:16:31',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(872,985,'p','432452',218,'2020-10-15 14:17:43',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(873,997,'p','967466',219,'2020-10-16 17:21:22',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(874,996,'p','852288',220,'2020-10-16 17:22:07',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(875,995,'p','772225',221,'2020-10-16 17:22:56',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(876,994,'p','514060',222,'2020-10-16 17:23:30',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(877,993,'p','827233',223,'2020-10-16 17:24:03',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(878,1001,'p','939782',224,'2020-10-16 17:43:18',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(879,1022,'p','881916',225,'2020-10-20 15:50:08',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(880,1023,'p','881916',225,'2020-10-20 15:51:44',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(881,1024,'p','881916',225,'2020-10-20 15:52:48',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(882,NULL,'p',NULL,166,'2020-10-23 14:01:20',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(883,NULL,'p',NULL,166,'2020-10-23 14:25:28',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(884,NULL,'p',NULL,166,'2020-10-23 14:38:10',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(885,NULL,'t',NULL,3,'2020-11-06 13:09:10',NULL,NULL,NULL,1,312,NULL,NULL,NULL),(886,NULL,'t',NULL,25,'2020-11-06 13:10:11',NULL,NULL,NULL,1,313,NULL,NULL,NULL),(887,NULL,'t',NULL,25,'2020-11-06 13:11:42',NULL,NULL,NULL,1,314,NULL,NULL,NULL),(888,NULL,'t',NULL,25,'2020-11-06 13:11:56',NULL,NULL,NULL,1,315,NULL,NULL,NULL),(889,NULL,'t',NULL,25,'2020-11-06 13:16:20',NULL,NULL,NULL,1,316,NULL,NULL,NULL),(890,NULL,'t',NULL,25,'2020-11-06 13:34:12',NULL,NULL,NULL,1,317,NULL,NULL,NULL),(891,NULL,'t',NULL,25,'2020-11-06 15:15:04',NULL,NULL,NULL,1,318,NULL,NULL,NULL),(892,NULL,'t',NULL,25,'2020-11-06 15:15:13',NULL,NULL,NULL,1,319,NULL,NULL,NULL),(893,NULL,'t',NULL,25,'2020-11-06 15:15:17',NULL,NULL,NULL,1,320,NULL,NULL,NULL),(894,NULL,'t',NULL,25,'2020-11-06 15:15:26',NULL,NULL,NULL,1,321,NULL,NULL,NULL),(895,NULL,'t',NULL,25,'2020-11-06 15:15:39',NULL,NULL,NULL,1,322,NULL,NULL,NULL),(896,NULL,'t',NULL,25,'2020-11-06 15:15:48',NULL,NULL,NULL,1,323,NULL,NULL,NULL),(897,NULL,'t',NULL,25,'2020-11-06 15:18:06',NULL,NULL,NULL,1,324,NULL,NULL,NULL),(898,NULL,'t',NULL,25,'2020-11-06 15:18:21',NULL,NULL,NULL,1,325,NULL,NULL,NULL),(899,NULL,'t',NULL,25,'2020-11-06 15:19:35',NULL,NULL,NULL,1,326,NULL,NULL,NULL),(900,NULL,'t',NULL,25,'2020-11-06 15:20:42',NULL,NULL,NULL,1,327,NULL,NULL,NULL),(901,1211,'p','362982',115,'2020-11-26 15:46:01',1,41,'carro',1,NULL,NULL,NULL,NULL),(902,NULL,'p',NULL,156,'2020-12-01 17:20:50',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(903,1212,'p','474675',226,'2020-12-02 10:18:31',1,NULL,'outro',1,NULL,NULL,NULL,NULL),(904,NULL,'p',NULL,19,'2020-12-02 10:18:48',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(905,1213,'p','857223',10,'2020-12-02 10:29:10',4,4,'carro',0,NULL,NULL,NULL,NULL),(906,1214,'p','123123',18,'2020-12-02 10:32:00',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(907,1215,'p','123123',18,'2020-12-02 10:37:18',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(908,1216,'p','123123',18,'2020-12-02 10:38:47',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(909,NULL,'p',NULL,166,'2020-12-02 10:42:31',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(910,1217,'p','771023',227,'2020-12-02 10:43:24',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(911,1218,'p','771023',227,'2020-12-02 10:50:09',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(912,1219,'p','123321',28,'2020-12-02 10:58:03',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(913,1220,'p','123321',28,'2020-12-02 11:02:19',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(914,1221,'p','ttt',18,'2020-12-02 11:03:19',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(915,NULL,'p',NULL,166,'2020-12-02 11:09:02',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(916,1222,'p','123456',7,'2020-12-02 11:43:03',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(917,1223,'p','1111',28,'2020-12-02 11:43:44',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(918,1224,'p','22',28,'2020-12-02 11:45:24',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(919,1225,'p','2222',28,'2020-12-02 11:46:21',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(920,1225,'p','2222',28,'2020-12-02 11:53:30',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(921,NULL,'p',NULL,166,'2020-12-02 12:23:35',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(922,1225,'p','2222',28,'2020-12-02 12:25:08',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(923,1225,'p','2222',28,'2020-12-02 12:26:49',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(924,NULL,'p',NULL,19,'2020-12-02 12:29:00',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(925,1225,'p','2222',28,'2020-12-02 12:29:37',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(926,1225,'p','2222',28,'2020-12-02 12:31:31',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(927,NULL,'p',NULL,166,'2020-12-02 12:40:43',1,NULL,NULL,1,NULL,NULL,NULL,NULL),(928,1225,'p','2222',28,'2020-12-02 14:37:52',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(929,1226,'p','456',28,'2020-12-02 16:12:12',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(930,1226,'p','456',28,'2020-12-02 16:15:22',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(931,1226,'p','456',28,'2020-12-02 16:19:23',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(932,1227,'p','554',18,'2020-12-02 18:02:21',4,NULL,'outro',1,NULL,NULL,NULL,NULL),(933,1228,'p','123123',18,'2020-12-07 09:27:41',4,NULL,'outro',0,NULL,NULL,NULL,NULL),(934,NULL,'p',NULL,120,'2020-12-07 09:33:11',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(935,NULL,'p',NULL,192,'2020-12-07 09:33:27',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(936,NULL,'p',NULL,192,'2020-12-07 11:08:22',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(937,NULL,'p',NULL,157,'2020-12-07 15:18:06',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(938,NULL,'p',NULL,157,'2020-12-07 15:23:50',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(939,NULL,'p',NULL,157,'2020-12-07 15:25:39',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(940,NULL,'p',NULL,157,'2020-12-07 15:27:32',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(941,NULL,'p',NULL,157,'2020-12-07 15:28:05',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(942,NULL,'p',NULL,157,'2020-12-07 15:38:17',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(943,NULL,'p',NULL,157,'2020-12-07 15:39:02',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(944,NULL,'p',NULL,157,'2020-12-07 15:40:01',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(945,NULL,'p',NULL,167,'2020-12-07 16:07:47',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(946,NULL,'p',NULL,228,'2020-12-07 16:09:13',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(947,NULL,'p',NULL,157,'2020-12-07 17:15:16',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(948,NULL,'p',NULL,157,'2020-12-07 17:15:53',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(949,NULL,'p',NULL,156,'2020-12-07 17:43:19',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(950,NULL,'p',NULL,157,'2020-12-07 17:45:39',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(951,NULL,'p',NULL,157,'2020-12-07 17:49:20',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(952,NULL,'p',NULL,157,'2020-12-08 10:02:28',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(953,NULL,'p',NULL,157,'2020-12-08 10:26:11',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(954,NULL,'p',NULL,157,'2020-12-08 10:27:29',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(955,NULL,'p',NULL,157,'2020-12-08 10:38:59',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(956,NULL,'p',NULL,157,'2020-12-08 11:26:56',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(957,NULL,'p',NULL,157,'2020-12-08 11:28:22',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(958,NULL,'t',NULL,157,'2020-12-08 11:29:22',NULL,NULL,NULL,1,499,NULL,NULL,NULL),(959,NULL,'t',NULL,157,'2020-12-08 11:31:34',NULL,NULL,NULL,1,501,NULL,NULL,NULL),(960,NULL,'t',NULL,156,'2020-12-08 11:32:21',NULL,NULL,NULL,1,503,NULL,NULL,NULL),(961,NULL,'t',NULL,228,'2020-12-08 11:32:39',NULL,NULL,NULL,1,504,NULL,NULL,NULL),(962,NULL,'t',NULL,228,'2020-12-08 13:03:22',NULL,NULL,NULL,1,507,NULL,NULL,NULL),(963,NULL,'t',NULL,228,'2020-12-08 14:22:20',NULL,NULL,NULL,1,525,NULL,NULL,NULL),(964,NULL,'p',NULL,156,'2020-12-08 14:45:51',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(965,NULL,'t',NULL,156,'2020-12-08 15:08:01',NULL,NULL,NULL,1,538,NULL,NULL,NULL),(966,NULL,'t',NULL,156,'2020-12-08 15:10:03',NULL,NULL,NULL,1,539,NULL,NULL,NULL),(967,NULL,'t',NULL,167,'2020-12-08 16:23:43',NULL,NULL,NULL,1,569,NULL,NULL,NULL),(968,NULL,'t',NULL,156,'2020-12-08 16:24:06',NULL,NULL,NULL,1,570,NULL,NULL,NULL),(969,NULL,'t',NULL,228,'2020-12-08 16:24:19',NULL,NULL,NULL,1,571,NULL,NULL,NULL),(970,NULL,'t',NULL,167,'2020-12-08 16:28:08',NULL,NULL,NULL,1,576,NULL,NULL,NULL),(971,NULL,'t',NULL,167,'2020-12-08 16:28:58',NULL,NULL,NULL,1,577,NULL,NULL,NULL),(972,NULL,'t',NULL,228,'2020-12-08 16:29:08',NULL,NULL,NULL,1,578,NULL,NULL,NULL),(973,NULL,'t',NULL,167,'2020-12-08 16:29:15',NULL,NULL,NULL,1,579,NULL,NULL,NULL),(974,NULL,'t',NULL,167,'2020-12-08 16:35:22',NULL,NULL,NULL,1,592,NULL,NULL,NULL),(975,NULL,'t',NULL,167,'2020-12-08 16:40:04',NULL,NULL,NULL,1,599,NULL,NULL,NULL),(976,NULL,'t',NULL,156,'2020-12-08 16:40:20',NULL,NULL,NULL,1,600,NULL,NULL,NULL),(977,NULL,'t',NULL,228,'2020-12-08 16:40:40',NULL,NULL,NULL,1,601,NULL,NULL,NULL),(978,NULL,'t',NULL,157,'2020-12-08 16:40:56',NULL,NULL,NULL,1,602,NULL,NULL,NULL),(979,NULL,'t',NULL,157,'2020-12-08 16:41:12',NULL,NULL,NULL,1,603,NULL,NULL,NULL),(980,NULL,'t',NULL,228,'2020-12-08 16:41:32',NULL,NULL,NULL,1,604,NULL,NULL,NULL),(981,NULL,'t',NULL,157,'2020-12-08 16:41:44',NULL,NULL,NULL,1,605,NULL,NULL,NULL),(982,NULL,'t',NULL,157,'2020-12-08 17:51:07',NULL,NULL,NULL,1,632,NULL,NULL,NULL),(983,NULL,'t',NULL,157,'2020-12-08 17:51:30',NULL,NULL,NULL,1,633,NULL,NULL,NULL),(984,NULL,'t',NULL,228,'2020-12-08 17:51:40',NULL,NULL,NULL,1,634,NULL,NULL,NULL),(985,NULL,'t',NULL,167,'2020-12-08 17:51:56',NULL,NULL,NULL,1,635,NULL,NULL,NULL),(986,NULL,'t',NULL,167,'2020-12-08 17:52:49',NULL,NULL,NULL,1,636,NULL,NULL,NULL),(987,NULL,'t',NULL,156,'2020-12-08 17:52:57',NULL,NULL,NULL,1,637,NULL,NULL,NULL),(988,NULL,'t',NULL,156,'2020-12-08 17:53:33',NULL,NULL,NULL,1,639,NULL,NULL,NULL),(989,NULL,'t',NULL,156,'2020-12-09 07:39:22',NULL,NULL,NULL,1,642,NULL,NULL,NULL),(990,NULL,'t',NULL,167,'2020-12-09 07:41:09',NULL,NULL,NULL,1,643,NULL,NULL,NULL),(991,NULL,'t',NULL,228,'2020-12-09 07:41:16',NULL,NULL,NULL,1,644,NULL,NULL,NULL),(992,NULL,'t',NULL,157,'2020-12-09 07:41:19',NULL,NULL,NULL,1,645,NULL,NULL,NULL),(993,NULL,'t',NULL,156,'2020-12-09 07:58:49',NULL,NULL,NULL,1,646,NULL,NULL,NULL),(994,NULL,'t',NULL,157,'2020-12-09 09:13:54',NULL,NULL,NULL,1,653,NULL,NULL,NULL),(995,NULL,'t',NULL,157,'2020-12-09 09:15:04',NULL,NULL,NULL,1,656,NULL,NULL,NULL),(996,NULL,'t',NULL,228,'2020-12-09 09:23:49',NULL,NULL,NULL,1,659,NULL,NULL,NULL),(997,NULL,'t',NULL,228,'2020-12-09 09:24:30',NULL,NULL,NULL,1,660,NULL,NULL,NULL),(998,NULL,'t',NULL,228,'2020-12-09 09:26:07',NULL,NULL,NULL,1,662,NULL,NULL,NULL),(999,NULL,'t',NULL,157,'2020-12-09 09:26:23',NULL,NULL,NULL,1,663,NULL,NULL,NULL),(1000,NULL,'t',NULL,157,'2020-12-09 09:32:37',NULL,NULL,NULL,1,668,NULL,NULL,NULL),(1001,NULL,'p',NULL,157,'2020-12-09 09:33:36',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(1002,NULL,'p',NULL,157,'2020-12-09 09:35:45',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(1003,NULL,'p',NULL,157,'2020-12-09 09:38:26',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(1004,NULL,'p',NULL,157,'2020-12-09 09:39:41',4,NULL,NULL,0,NULL,NULL,NULL,NULL),(1005,NULL,'t',NULL,157,'2020-12-09 09:40:40',NULL,NULL,NULL,1,676,NULL,NULL,NULL),(1006,NULL,'t',NULL,157,'2020-12-09 09:41:29',NULL,NULL,NULL,1,678,NULL,NULL,NULL),(1007,NULL,'p',NULL,228,'2020-12-09 09:57:35',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(1008,NULL,'t',NULL,156,'2020-12-09 09:58:55',NULL,NULL,NULL,1,679,NULL,NULL,NULL),(1009,NULL,'t',NULL,228,'2020-12-09 09:59:09',NULL,NULL,NULL,1,680,NULL,NULL,NULL),(1010,NULL,'t',NULL,228,'2020-12-09 09:59:13',NULL,NULL,NULL,1,681,NULL,NULL,NULL),(1011,NULL,'t',NULL,228,'2020-12-09 10:00:17',NULL,NULL,NULL,1,683,NULL,NULL,NULL),(1012,NULL,'t',NULL,156,'2020-12-09 10:00:35',NULL,NULL,NULL,1,684,NULL,NULL,NULL),(1013,NULL,'p',NULL,156,'2020-12-09 10:01:20',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(1014,NULL,'p',NULL,228,'2020-12-09 10:01:55',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(1015,NULL,'p',NULL,157,'2020-12-09 10:02:33',4,NULL,NULL,1,NULL,NULL,NULL,NULL),(1016,NULL,'t',NULL,157,'2020-12-09 10:02:57',NULL,NULL,NULL,1,687,NULL,NULL,NULL),(1017,NULL,'t',NULL,156,'2020-12-11 16:32:21',NULL,NULL,NULL,1,699,NULL,NULL,NULL),(1018,NULL,'t',NULL,156,'2020-12-11 16:32:46',NULL,NULL,NULL,1,700,NULL,NULL,NULL),(1019,NULL,'t',NULL,156,'2020-12-11 16:33:36',NULL,NULL,NULL,1,701,NULL,NULL,NULL),(1020,NULL,'p','1234',189,'2021-01-14 15:55:43',1,NULL,NULL,0,NULL,NULL,NULL,NULL),(1021,1243,'p','7777',229,'2021-01-14 15:58:29',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(1022,1244,'p','666',229,'2021-01-14 16:03:59',1,NULL,'outro',0,NULL,NULL,NULL,NULL),(1023,NULL,'t',NULL,3,'2021-02-08 18:54:33',0,NULL,NULL,2,704,NULL,NULL,NULL),(1024,NULL,'t',NULL,3,'2021-02-08 18:54:33',0,NULL,NULL,2,1,NULL,NULL,NULL),(1025,NULL,'t',NULL,3,'2021-02-08 19:07:29',0,NULL,NULL,2,2,NULL,NULL,NULL),(1026,NULL,'t',NULL,3,'2021-02-08 19:07:34',0,NULL,NULL,2,3,NULL,NULL,NULL),(1027,NULL,'t',NULL,3,'2021-02-08 19:07:40',0,NULL,NULL,2,4,NULL,NULL,NULL),(1028,NULL,'t',NULL,3,'2021-02-08 19:07:45',0,NULL,NULL,2,5,NULL,NULL,NULL),(1029,NULL,'t',NULL,3,'2021-02-08 19:07:51',0,NULL,NULL,2,6,NULL,NULL,NULL),(1030,NULL,'t',NULL,3,'2021-02-08 19:08:45',0,NULL,NULL,2,7,NULL,NULL,NULL),(1031,NULL,'t',NULL,3,'2021-02-08 18:54:33',0,NULL,NULL,2,1,NULL,NULL,NULL),(1032,NULL,'t',NULL,3,'2021-02-08 19:07:29',0,NULL,NULL,2,2,NULL,NULL,NULL),(1033,NULL,'t',NULL,3,'2021-02-08 19:07:34',0,NULL,NULL,2,3,NULL,NULL,NULL),(1034,NULL,'t',NULL,3,'2021-02-08 19:07:40',0,NULL,NULL,2,4,NULL,NULL,NULL),(1035,NULL,'t',NULL,3,'2021-02-08 19:07:45',0,NULL,NULL,2,5,NULL,NULL,NULL),(1036,NULL,'t',NULL,3,'2021-02-08 19:07:51',0,NULL,NULL,2,6,NULL,NULL,NULL),(1037,NULL,'t',NULL,3,'2021-02-08 19:08:45',0,NULL,NULL,2,7,NULL,NULL,NULL),(1038,NULL,'t',NULL,3,'2021-02-08 19:11:22',0,NULL,NULL,2,8,NULL,NULL,NULL),(1039,NULL,'t',NULL,3,'2021-02-08 19:14:10',0,NULL,NULL,2,9,NULL,NULL,NULL),(1040,NULL,'t',NULL,3,'2021-02-08 19:15:04',0,NULL,NULL,2,10,NULL,NULL,NULL),(1041,NULL,'t',NULL,3,'2021-02-08 19:15:10',0,NULL,NULL,2,11,NULL,NULL,NULL),(1042,NULL,'t',NULL,3,'2021-02-08 18:54:33',0,NULL,NULL,2,1,NULL,NULL,NULL),(1043,NULL,'t',NULL,3,'2021-02-08 19:07:29',0,NULL,NULL,2,2,NULL,NULL,NULL),(1044,NULL,'t',NULL,3,'2021-02-08 19:07:34',0,NULL,NULL,2,3,NULL,NULL,NULL),(1045,NULL,'t',NULL,3,'2021-02-08 19:07:40',0,NULL,NULL,2,4,NULL,NULL,NULL),(1046,NULL,'t',NULL,3,'2021-02-08 19:07:45',0,NULL,NULL,2,5,NULL,NULL,NULL),(1047,NULL,'t',NULL,3,'2021-02-08 19:07:51',0,NULL,NULL,2,6,NULL,NULL,NULL),(1048,NULL,'t',NULL,3,'2021-02-08 19:08:45',0,NULL,NULL,2,7,NULL,NULL,NULL),(1049,NULL,'t',NULL,3,'2021-02-08 19:11:22',0,NULL,NULL,2,8,NULL,NULL,NULL),(1050,NULL,'t',NULL,3,'2021-02-08 19:14:10',0,NULL,NULL,2,9,NULL,NULL,NULL),(1051,NULL,'t',NULL,3,'2021-02-08 19:15:04',0,NULL,NULL,2,10,NULL,NULL,NULL),(1052,NULL,'t',NULL,3,'2021-02-08 19:15:10',0,NULL,NULL,2,11,NULL,NULL,NULL),(1053,NULL,'t',NULL,3,'2021-02-08 18:54:33',0,NULL,NULL,2,1,NULL,NULL,NULL),(1054,NULL,'t',NULL,3,'2021-02-08 19:07:29',0,NULL,NULL,2,2,NULL,NULL,NULL),(1055,NULL,'t',NULL,3,'2021-02-08 19:07:34',0,NULL,NULL,2,3,NULL,NULL,NULL),(1056,NULL,'t',NULL,3,'2021-02-08 19:07:40',0,NULL,NULL,2,4,NULL,NULL,NULL),(1057,NULL,'t',NULL,3,'2021-02-08 19:07:45',0,NULL,NULL,2,5,NULL,NULL,NULL),(1058,NULL,'t',NULL,3,'2021-02-08 19:07:51',0,NULL,NULL,2,6,NULL,NULL,NULL),(1059,NULL,'t',NULL,3,'2021-02-08 19:08:45',0,NULL,NULL,2,7,NULL,NULL,NULL),(1060,NULL,'t',NULL,3,'2021-02-08 19:11:22',0,NULL,NULL,2,8,NULL,NULL,NULL),(1061,NULL,'t',NULL,3,'2021-02-08 19:14:10',0,NULL,NULL,2,9,NULL,NULL,NULL),(1062,NULL,'t',NULL,3,'2021-02-08 19:15:04',0,NULL,NULL,2,10,NULL,NULL,NULL),(1063,NULL,'t',NULL,3,'2021-02-08 19:15:10',0,NULL,NULL,2,11,NULL,NULL,NULL),(1064,NULL,'t',NULL,3,'2021-02-08 18:54:33',0,NULL,NULL,2,1,NULL,NULL,NULL),(1065,NULL,'t',NULL,3,'2021-02-08 19:07:29',0,NULL,NULL,2,2,NULL,NULL,NULL),(1066,NULL,'t',NULL,3,'2021-02-08 19:07:34',0,NULL,NULL,2,3,NULL,NULL,NULL),(1067,NULL,'t',NULL,3,'2021-02-08 19:07:40',0,NULL,NULL,2,4,NULL,NULL,NULL),(1068,NULL,'t',NULL,3,'2021-02-08 19:07:45',0,NULL,NULL,2,5,NULL,NULL,NULL),(1069,NULL,'t',NULL,3,'2021-02-08 19:07:51',0,NULL,NULL,2,6,NULL,NULL,NULL),(1070,NULL,'t',NULL,3,'2021-02-08 19:08:45',0,NULL,NULL,2,7,NULL,NULL,NULL),(1071,NULL,'t',NULL,3,'2021-02-08 19:11:22',0,NULL,NULL,2,8,NULL,NULL,NULL),(1072,NULL,'t',NULL,3,'2021-02-08 19:14:10',0,NULL,NULL,2,9,NULL,NULL,NULL),(1073,NULL,'t',NULL,3,'2021-02-08 19:15:04',0,NULL,NULL,2,10,NULL,NULL,NULL),(1074,NULL,'t',NULL,3,'2021-02-08 19:15:10',0,NULL,NULL,2,11,NULL,NULL,NULL),(1075,NULL,'t',NULL,0,'2021-02-09 09:50:32',0,NULL,NULL,2,12,NULL,NULL,NULL),(1076,NULL,'t',NULL,0,'2021-02-09 09:50:35',0,NULL,NULL,2,13,NULL,NULL,NULL),(1077,NULL,'t',NULL,0,'2021-02-09 09:51:03',0,NULL,NULL,2,14,NULL,NULL,NULL),(1078,NULL,'t',NULL,139,'2021-02-09 09:53:03',0,NULL,NULL,2,16,NULL,NULL,NULL),(1079,NULL,'t',NULL,139,'2021-02-09 12:54:21',1,NULL,NULL,2,17,NULL,NULL,NULL),(1080,NULL,'t',NULL,139,'2021-02-09 12:54:21',NULL,NULL,NULL,2,17,NULL,NULL,NULL),(1081,NULL,'t',NULL,139,'2021-02-09 12:54:27',1,NULL,NULL,2,16,NULL,NULL,NULL),(1082,NULL,'t',NULL,139,'2021-02-09 12:54:33',1,NULL,NULL,2,15,NULL,NULL,NULL),(1083,NULL,'t',NULL,139,'2021-02-09 12:58:45',NULL,NULL,NULL,2,18,NULL,NULL,NULL),(1084,NULL,'t',NULL,139,'2021-02-09 12:58:45',1,NULL,NULL,2,18,NULL,NULL,NULL),(1085,NULL,'t',NULL,139,'2021-02-09 12:58:50',1,NULL,NULL,2,19,NULL,NULL,NULL),(1086,NULL,'t',NULL,139,'2021-02-09 12:58:50',NULL,NULL,NULL,2,19,NULL,NULL,NULL),(1087,NULL,'t',NULL,139,'2021-02-09 12:59:05',1,NULL,NULL,2,20,NULL,NULL,NULL),(1088,NULL,'t',NULL,139,'2021-02-09 12:59:05',NULL,NULL,NULL,2,20,NULL,NULL,NULL),(1089,NULL,'t',NULL,139,'2021-02-09 12:59:13',1,NULL,NULL,2,21,NULL,NULL,NULL),(1090,NULL,'t',NULL,139,'2021-02-09 12:59:13',NULL,NULL,NULL,2,21,NULL,NULL,NULL),(1091,NULL,'t',NULL,3,'2021-02-09 13:02:13',NULL,NULL,NULL,2,24,NULL,NULL,NULL),(1092,NULL,'t',NULL,156,'2021-02-09 13:02:14',NULL,NULL,NULL,2,24,NULL,NULL,NULL),(1093,NULL,'t',NULL,45,'2021-02-09 13:02:14',NULL,NULL,NULL,2,24,NULL,NULL,NULL),(1094,NULL,'t',NULL,3,'2021-02-09 13:02:25',NULL,NULL,NULL,2,25,NULL,NULL,NULL),(1095,NULL,'t',NULL,156,'2021-02-09 13:02:25',NULL,NULL,NULL,2,25,NULL,NULL,NULL),(1096,NULL,'t',NULL,91,'2021-02-09 13:02:25',NULL,NULL,NULL,2,25,NULL,NULL,NULL),(1097,NULL,'t',NULL,139,'2021-02-09 13:02:31',1,NULL,NULL,2,26,NULL,NULL,NULL),(1098,NULL,'t',NULL,139,'2021-02-09 13:02:31',NULL,NULL,NULL,2,26,NULL,NULL,NULL),(1099,NULL,'t',NULL,139,'2021-02-09 13:02:35',1,NULL,NULL,2,27,NULL,NULL,NULL),(1100,NULL,'t',NULL,139,'2021-02-09 13:02:35',NULL,NULL,NULL,2,27,NULL,NULL,NULL),(1101,NULL,'t',NULL,3,'2021-02-09 13:03:43',NULL,NULL,NULL,2,28,NULL,NULL,NULL),(1102,NULL,'t',NULL,3,'2021-02-09 13:03:48',NULL,NULL,NULL,2,29,NULL,NULL,NULL),(1103,NULL,'t',NULL,3,'2021-02-09 13:03:54',NULL,NULL,NULL,2,30,NULL,NULL,NULL),(1104,NULL,'t',NULL,3,'2021-02-09 13:04:05',NULL,NULL,NULL,2,31,NULL,NULL,NULL),(1105,NULL,'t',NULL,3,'2021-02-09 13:04:09',NULL,NULL,NULL,2,32,NULL,NULL,NULL),(1106,NULL,'t',NULL,3,'2021-02-09 13:04:14',NULL,NULL,NULL,2,33,NULL,NULL,NULL),(1107,NULL,'t',NULL,3,'2021-02-09 13:04:22',NULL,NULL,NULL,2,34,NULL,NULL,NULL),(1108,NULL,'t',NULL,139,'2021-02-09 13:04:44',1,NULL,NULL,2,35,NULL,NULL,NULL),(1109,NULL,'t',NULL,139,'2021-02-09 13:04:44',NULL,NULL,NULL,2,35,NULL,NULL,NULL),(1110,NULL,'t',NULL,139,'2021-02-09 13:04:49',1,NULL,NULL,2,36,NULL,NULL,NULL),(1111,NULL,'t',NULL,139,'2021-02-09 13:04:49',NULL,NULL,NULL,2,36,NULL,NULL,NULL),(1112,NULL,'t',NULL,139,'2021-02-09 13:05:30',1,NULL,NULL,2,37,NULL,NULL,NULL),(1113,NULL,'t',NULL,139,'2021-02-09 13:05:52',1,NULL,NULL,2,38,NULL,NULL,NULL),(1114,NULL,'t',NULL,139,'2021-02-09 13:05:53',1,NULL,NULL,2,38,NULL,NULL,NULL),(1115,NULL,'t',NULL,3,'2021-02-09 13:11:00',NULL,NULL,NULL,2,43,NULL,NULL,NULL),(1116,NULL,'t',NULL,3,'2021-02-09 13:11:07',NULL,NULL,NULL,2,44,NULL,NULL,NULL),(1117,NULL,'t',NULL,3,'2021-02-09 13:11:21',NULL,NULL,NULL,2,45,NULL,NULL,NULL),(1118,NULL,'t',NULL,139,'2021-02-09 13:12:10',1,NULL,NULL,2,47,NULL,NULL,NULL),(1119,NULL,'t',NULL,139,'2021-02-09 13:12:10',NULL,NULL,NULL,2,47,NULL,NULL,NULL),(1120,NULL,'t',NULL,139,'2021-02-09 13:12:14',1,NULL,NULL,2,48,NULL,NULL,NULL),(1121,NULL,'t',NULL,139,'2021-02-09 13:12:14',NULL,NULL,NULL,2,48,NULL,NULL,NULL),(1122,NULL,'t',NULL,139,'2021-02-09 13:12:25',1,NULL,NULL,2,49,NULL,NULL,NULL),(1123,NULL,'t',NULL,139,'2021-02-09 13:12:25',NULL,NULL,NULL,2,49,NULL,NULL,NULL),(1124,NULL,'t',NULL,139,'2021-02-09 13:12:31',1,NULL,NULL,2,50,NULL,NULL,NULL),(1125,NULL,'t',NULL,139,'2021-02-09 13:12:31',NULL,NULL,NULL,2,50,NULL,NULL,NULL),(1126,NULL,'t',NULL,139,'2021-02-09 13:13:26',NULL,NULL,NULL,2,51,NULL,NULL,NULL),(1127,NULL,'t',NULL,139,'2021-02-09 13:13:26',1,NULL,NULL,2,51,NULL,NULL,NULL),(1128,NULL,'t',NULL,139,'2021-02-09 13:13:33',1,NULL,NULL,2,52,NULL,NULL,NULL),(1129,NULL,'t',NULL,139,'2021-02-09 13:13:33',NULL,NULL,NULL,2,52,NULL,NULL,NULL),(1130,NULL,'t',NULL,139,'2021-02-09 13:16:49',NULL,NULL,NULL,2,60,NULL,NULL,NULL),(1131,NULL,'t',NULL,139,'2021-02-09 13:16:56',NULL,NULL,NULL,2,61,NULL,NULL,NULL),(1132,NULL,'t',NULL,139,'2021-02-09 13:17:02',NULL,NULL,NULL,2,62,NULL,NULL,NULL),(1133,NULL,'t',NULL,139,'2021-02-09 13:17:07',NULL,NULL,NULL,2,63,NULL,NULL,NULL),(1134,NULL,'t',NULL,139,'2021-02-09 13:21:24',1,NULL,NULL,2,64,NULL,NULL,NULL),(1135,NULL,'t',NULL,139,'2021-02-09 13:21:24',NULL,NULL,NULL,2,64,NULL,NULL,NULL),(1136,NULL,'t',NULL,139,'2021-02-09 13:21:28',1,NULL,NULL,2,65,NULL,NULL,NULL),(1137,NULL,'t',NULL,139,'2021-02-09 13:21:28',NULL,NULL,NULL,2,65,NULL,NULL,NULL),(1138,NULL,'t',NULL,139,'2021-02-09 13:21:32',NULL,NULL,NULL,2,66,NULL,NULL,NULL),(1139,NULL,'t',NULL,139,'2021-02-09 13:21:32',1,NULL,NULL,2,66,NULL,NULL,NULL),(1140,NULL,'t',NULL,139,'2021-02-09 13:21:38',NULL,NULL,NULL,2,67,NULL,NULL,NULL),(1141,NULL,'t',NULL,139,'2021-02-09 13:21:38',1,NULL,NULL,2,67,NULL,NULL,NULL),(1142,NULL,'t',NULL,139,'2021-02-09 13:21:43',1,NULL,NULL,2,68,NULL,NULL,NULL),(1143,NULL,'t',NULL,139,'2021-02-09 13:21:43',NULL,NULL,NULL,2,68,NULL,NULL,NULL),(1144,NULL,'t',NULL,139,'2021-02-09 13:21:44',1,NULL,NULL,2,68,NULL,NULL,NULL),(1145,NULL,'t',NULL,139,'2021-02-09 13:22:11',1,NULL,NULL,2,69,NULL,NULL,NULL),(1146,NULL,'t',NULL,139,'2021-02-09 13:22:11',NULL,NULL,NULL,2,69,NULL,NULL,NULL),(1147,NULL,'t',NULL,139,'2021-02-09 13:22:14',1,NULL,NULL,2,70,NULL,NULL,NULL),(1148,NULL,'t',NULL,139,'2021-02-09 13:22:14',NULL,NULL,NULL,2,70,NULL,NULL,NULL),(1149,NULL,'t',NULL,139,'2021-02-09 13:22:53',NULL,NULL,NULL,2,71,NULL,NULL,NULL),(1150,NULL,'t',NULL,139,'2021-02-09 13:22:53',1,NULL,NULL,2,71,NULL,NULL,NULL),(1151,NULL,'t',NULL,139,'2021-02-09 13:22:58',1,NULL,NULL,2,72,NULL,NULL,NULL),(1152,NULL,'t',NULL,139,'2021-02-09 13:22:58',NULL,NULL,NULL,2,72,NULL,NULL,NULL),(1153,NULL,'t',NULL,139,'2021-02-09 13:26:40',NULL,NULL,NULL,2,73,NULL,NULL,NULL),(1154,NULL,'t',NULL,139,'2021-02-09 13:26:40',1,NULL,NULL,2,73,NULL,NULL,NULL),(1155,NULL,'t',NULL,139,'2021-02-09 13:26:44',1,NULL,NULL,2,74,NULL,NULL,NULL),(1156,NULL,'t',NULL,139,'2021-02-09 13:26:44',NULL,NULL,NULL,2,74,NULL,NULL,NULL),(1157,NULL,'t',NULL,139,'2021-02-09 13:26:53',1,NULL,NULL,2,75,NULL,NULL,NULL),(1158,NULL,'t',NULL,139,'2021-02-09 13:26:53',NULL,NULL,NULL,2,75,NULL,NULL,NULL),(1159,NULL,'t',NULL,139,'2021-02-09 13:26:58',1,NULL,NULL,2,76,NULL,NULL,NULL),(1160,NULL,'t',NULL,139,'2021-02-09 13:26:58',NULL,NULL,NULL,2,76,NULL,NULL,NULL),(1161,NULL,'t',NULL,139,'2021-02-09 13:27:04',1,NULL,NULL,2,77,NULL,NULL,NULL),(1162,NULL,'t',NULL,139,'2021-02-09 13:27:04',NULL,NULL,NULL,2,77,NULL,NULL,NULL),(1163,NULL,'t',NULL,139,'2021-02-09 13:27:10',NULL,NULL,NULL,2,78,NULL,NULL,NULL),(1164,NULL,'t',NULL,139,'2021-02-09 13:27:10',1,NULL,NULL,2,78,NULL,NULL,NULL),(1165,NULL,'t',NULL,139,'2021-02-09 13:27:22',1,NULL,NULL,2,79,NULL,NULL,NULL),(1166,NULL,'t',NULL,139,'2021-02-09 13:27:22',NULL,NULL,NULL,2,79,NULL,NULL,NULL),(1167,NULL,'t',NULL,139,'2021-02-09 13:27:39',1,NULL,NULL,2,80,NULL,NULL,NULL),(1168,NULL,'t',NULL,139,'2021-02-09 13:27:39',NULL,NULL,NULL,2,80,NULL,NULL,NULL),(1169,NULL,'t',NULL,139,'2021-02-09 13:27:44',1,NULL,NULL,2,81,NULL,NULL,NULL),(1170,NULL,'t',NULL,139,'2021-02-09 13:27:44',NULL,NULL,NULL,2,81,NULL,NULL,NULL),(1171,NULL,'t',NULL,139,'2021-02-09 13:28:26',1,NULL,NULL,2,82,NULL,NULL,NULL),(1172,NULL,'t',NULL,139,'2021-02-09 13:28:26',NULL,NULL,NULL,2,82,NULL,NULL,NULL),(1173,NULL,'t',NULL,139,'2021-02-09 13:28:30',1,NULL,NULL,2,83,NULL,NULL,NULL),(1174,NULL,'t',NULL,139,'2021-02-09 13:28:30',NULL,NULL,NULL,2,83,NULL,NULL,NULL),(1175,NULL,'t',NULL,139,'2021-02-09 13:28:42',1,NULL,NULL,2,84,NULL,NULL,NULL),(1176,NULL,'t',NULL,139,'2021-02-09 13:28:42',NULL,NULL,NULL,2,84,NULL,NULL,NULL),(1177,NULL,'t',NULL,139,'2021-02-09 13:28:48',1,NULL,NULL,2,85,NULL,NULL,NULL),(1178,NULL,'t',NULL,139,'2021-02-09 13:28:48',NULL,NULL,NULL,2,85,NULL,NULL,NULL),(1179,NULL,'t',NULL,139,'2021-02-09 13:29:03',1,NULL,NULL,2,86,NULL,NULL,NULL),(1180,NULL,'t',NULL,139,'2021-02-09 13:29:03',NULL,NULL,NULL,2,86,NULL,NULL,NULL),(1181,NULL,'t',NULL,139,'2021-02-09 13:29:08',NULL,NULL,NULL,2,87,NULL,NULL,NULL),(1182,NULL,'t',NULL,139,'2021-02-09 13:29:08',1,NULL,NULL,2,87,NULL,NULL,NULL),(1183,NULL,'t',NULL,139,'2021-02-09 13:30:59',1,NULL,NULL,2,88,NULL,NULL,NULL),(1184,NULL,'t',NULL,139,'2021-02-09 13:30:59',NULL,NULL,NULL,2,88,NULL,NULL,NULL),(1185,NULL,'t',NULL,133,'2021-02-09 13:31:12',NULL,NULL,NULL,2,89,NULL,NULL,NULL),(1186,NULL,'t',NULL,133,'2021-02-09 13:31:18',NULL,NULL,NULL,2,90,NULL,NULL,NULL),(1187,NULL,'t',NULL,139,'2021-02-09 13:31:24',1,NULL,NULL,2,91,NULL,NULL,NULL),(1188,NULL,'t',NULL,139,'2021-02-09 13:31:24',NULL,NULL,NULL,2,91,NULL,NULL,NULL),(1189,NULL,'t',NULL,133,'2021-02-09 13:31:25',NULL,NULL,NULL,2,92,NULL,NULL,NULL),(1190,NULL,'t',NULL,139,'2021-02-09 13:31:30',1,NULL,NULL,2,93,NULL,NULL,NULL),(1191,NULL,'t',NULL,139,'2021-02-09 13:31:30',NULL,NULL,NULL,2,93,NULL,NULL,NULL);
/*!40000 ALTER TABLE `entrada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estimados`
--

DROP TABLE IF EXISTS `estimados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estimados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `valor` decimal(15,2) NOT NULL,
  `id_conta` int(10) unsigned NOT NULL,
  `fundo_reserva` tinyint(1) NOT NULL DEFAULT 1,
  `mes_competencia` int(11) NOT NULL,
  `ano_competencia` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `estimados_id_conta_foreign` (`id_conta`),
  CONSTRAINT `estimados_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estimados`
--

LOCK TABLES `estimados` WRITE;
/*!40000 ALTER TABLE `estimados` DISABLE KEYS */;
/*!40000 ALTER TABLE `estimados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque_movimentacao`
--

DROP TABLE IF EXISTS `estoque_movimentacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estoque_movimentacao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `operacao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `observacao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `numero_nota` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `valor_nota` decimal(15,2) DEFAULT 0.00,
  `valor_itens` decimal(15,2) DEFAULT 0.00,
  `id_fornecedor` int(10) unsigned DEFAULT NULL,
  `id_pedido` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `estoque_movimentacao_id_fornecedor_foreign` (`id_fornecedor`),
  KEY `estoque_movimentacao_id_pedido_foreign` (`id_pedido`),
  CONSTRAINT `estoque_movimentacao_id_fornecedor_foreign` FOREIGN KEY (`id_fornecedor`) REFERENCES `empresa` (`id`),
  CONSTRAINT `estoque_movimentacao_id_pedido_foreign` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque_movimentacao`
--

LOCK TABLES `estoque_movimentacao` WRITE;
/*!40000 ALTER TABLE `estoque_movimentacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `estoque_movimentacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque_movimentacao_produto`
--

DROP TABLE IF EXISTS `estoque_movimentacao_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estoque_movimentacao_produto` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `estoque_atual` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantidade` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `valor_unitario` decimal(15,2) DEFAULT 0.00,
  `id_estoque_movimentacao` int(10) unsigned NOT NULL,
  `id_produto` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `estoque_movimentacao_produto_id_estoque_movimentacao_foreign` (`id_estoque_movimentacao`),
  KEY `estoque_movimentacao_produto_id_produto_foreign` (`id_produto`),
  CONSTRAINT `estoque_movimentacao_produto_id_estoque_movimentacao_foreign` FOREIGN KEY (`id_estoque_movimentacao`) REFERENCES `estoque_movimentacao` (`id`),
  CONSTRAINT `estoque_movimentacao_produto_id_produto_foreign` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque_movimentacao_produto`
--

LOCK TABLES `estoque_movimentacao_produto` WRITE;
/*!40000 ALTER TABLE `estoque_movimentacao_produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `estoque_movimentacao_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feriados`
--

DROP TABLE IF EXISTS `feriados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feriados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `data` date NOT NULL,
  `anual` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `feriados_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feriados`
--

LOCK TABLES `feriados` WRITE;
/*!40000 ALTER TABLE `feriados` DISABLE KEYS */;
/*!40000 ALTER TABLE `feriados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ferramenta`
--

DROP TABLE IF EXISTS `ferramenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ferramenta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `saldo` int(10) unsigned NOT NULL,
  `id_pessoa` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_3` (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ferramenta`
--

LOCK TABLES `ferramenta` WRITE;
/*!40000 ALTER TABLE `ferramenta` DISABLE KEYS */;
INSERT INTO `ferramenta` VALUES (1,'Furadeira',0,NULL),(2,'martelo',0,NULL),(3,'mochila',0,NULL),(4,'asdasasd',1,NULL),(5,'asdadsd',3,NULL),(6,'asdad',2,NULL),(7,'xcvxcv',0,NULL),(8,'1asdasd',0,NULL),(9,'asdadasd',0,NULL),(10,'Furadeira',0,NULL),(11,'Maleta de ferramentas',1,NULL),(12,'tesoura',0,NULL),(13,'Shh',10,NULL),(14,'Xnnd',7,NULL),(15,'martelo',1,NULL),(16,'chave de fenda',2,229);
/*!40000 ALTER TABLE `ferramenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ferramenta_entrada`
--

DROP TABLE IF EXISTS `ferramenta_entrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ferramenta_entrada` (
  `id_ferramenta_entrada` int(11) NOT NULL AUTO_INCREMENT,
  `id_ferramenta` int(10) unsigned NOT NULL,
  `quantidade` int(10) unsigned NOT NULL,
  `id_entrada` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_ferramenta_entrada`),
  KEY `Index_2` (`id_entrada`),
  KEY `I_ID_FERRAMENTA` (`id_ferramenta`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ferramenta_entrada`
--

LOCK TABLES `ferramenta_entrada` WRITE;
/*!40000 ALTER TABLE `ferramenta_entrada` DISABLE KEYS */;
INSERT INTO `ferramenta_entrada` VALUES (1,1,10,193),(2,2,5,193),(3,3,1,193),(4,4,1,581),(5,5,3,581),(6,6,2,581),(7,7,2,844),(8,7,2,883),(9,8,2,883),(10,7,23,884),(11,9,2,884),(12,10,1,903),(13,11,1,903),(14,12,4,909),(15,13,6565,921),(16,14,98,921),(17,12,0,921),(18,13,5,927),(19,14,2,927),(20,15,2,1021);
/*!40000 ALTER TABLE `ferramenta_entrada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ferramenta_saida`
--

DROP TABLE IF EXISTS `ferramenta_saida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ferramenta_saida` (
  `id_ferramenta_saida` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_ferramenta` int(10) unsigned NOT NULL,
  `id_saida` int(10) unsigned NOT NULL,
  `quantidade` int(10) unsigned NOT NULL,
  `obs` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_ferramenta_saida`),
  KEY `I_ID_FERRAMENTA` (`id_ferramenta`),
  KEY `I_SAIDA` (`id_saida`),
  KEY `I_FERRAMENTA_SAIDA` (`id_ferramenta_saida`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ferramenta_saida`
--

LOCK TABLES `ferramenta_saida` WRITE;
/*!40000 ALTER TABLE `ferramenta_saida` DISABLE KEYS */;
INSERT INTO `ferramenta_saida` VALUES (1,1,151,10,NULL),(2,2,151,5,NULL),(3,3,151,1,NULL),(4,7,715,27,NULL),(5,8,715,2,NULL),(6,9,715,2,NULL),(7,12,729,4,NULL),(8,13,729,6560,NULL),(9,14,729,93,NULL),(10,10,730,1,NULL),(11,11,730,0,NULL);
/*!40000 ALTER TABLE `ferramenta_saida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financeiro_clube`
--

DROP TABLE IF EXISTS `financeiro_clube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `financeiro_clube` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_imovel` int(10) unsigned NOT NULL,
  `id_imovel_externo` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_id_imovel_externo` (`id_imovel_externo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financeiro_clube`
--

LOCK TABLES `financeiro_clube` WRITE;
/*!40000 ALTER TABLE `financeiro_clube` DISABLE KEYS */;
/*!40000 ALTER TABLE `financeiro_clube` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fluxo_caixa`
--

DROP TABLE IF EXISTS `fluxo_caixa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fluxo_caixa` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_conta_bancaria` int(10) unsigned NOT NULL,
  `id_parcela` int(10) unsigned DEFAULT NULL,
  `valor` decimal(15,2) NOT NULL,
  `data_vencimento` date DEFAULT NULL,
  `data_pagamento` date DEFAULT NULL,
  `descricao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referente` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tabela` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fluxo` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'DESPESA ou RECEITA',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fluxo_caixa_id_parcela_index` (`id_parcela`),
  KEY `fluxo_caixa_id_conta_bancaria_index` (`id_conta_bancaria`),
  KEY `fluxo_caixa_data_pagamento_index` (`data_pagamento`),
  KEY `fluxo_caixa_data_vencimento_index` (`data_vencimento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fluxo_caixa`
--

LOCK TABLES `fluxo_caixa` WRITE;
/*!40000 ALTER TABLE `fluxo_caixa` DISABLE KEYS */;
/*!40000 ALTER TABLE `fluxo_caixa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formulas`
--

DROP TABLE IF EXISTS `formulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formulas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `formula` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formulas`
--

LOCK TABLES `formulas` WRITE;
/*!40000 ALTER TABLE `formulas` DISABLE KEYS */;
INSERT INTO `formulas` VALUES (1,'DESPESA_TOTAL/AREA_TOTAL*AREA_IMOVEL','2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `formulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor_pedidos`
--

DROP TABLE IF EXISTS `fornecedor_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornecedor_pedidos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpedido` int(10) unsigned NOT NULL,
  `idfornecedor` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `valorTotal` double(18,2) DEFAULT NULL,
  `valorTotalCalculado` double(18,2) DEFAULT NULL,
  `acrescimo` double(18,2) DEFAULT NULL,
  `desconto` double(18,2) DEFAULT NULL,
  `observacao` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Não Aprovado',
  PRIMARY KEY (`id`),
  KEY `fornecedor_pedidos_idpedido_foreign` (`idpedido`),
  KEY `fornecedor_pedidos_idfornecedor_foreign` (`idfornecedor`),
  CONSTRAINT `fornecedor_pedidos_idfornecedor_foreign` FOREIGN KEY (`idfornecedor`) REFERENCES `empresa` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fornecedor_pedidos_idpedido_foreign` FOREIGN KEY (`idpedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor_pedidos`
--

LOCK TABLES `fornecedor_pedidos` WRITE;
/*!40000 ALTER TABLE `fornecedor_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedor_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_calculo`
--

DROP TABLE IF EXISTS `grupo_calculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_calculo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `percentualfundoreserva` decimal(15,2) NOT NULL,
  `id_conta_taxaassociativa` int(10) unsigned NOT NULL,
  `id_conta_fundoreserva` int(10) unsigned NOT NULL,
  `id_formula` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grupo_calculo_id_formula_foreign` (`id_formula`),
  KEY `grupo_calculo_id_conta_fundoreserva_foreign` (`id_conta_fundoreserva`),
  KEY `grupo_calculo_id_conta_taxaassociativa_foreign` (`id_conta_taxaassociativa`),
  CONSTRAINT `grupo_calculo_id_conta_fundoreserva_foreign` FOREIGN KEY (`id_conta_fundoreserva`) REFERENCES `contas` (`id`),
  CONSTRAINT `grupo_calculo_id_conta_taxaassociativa_foreign` FOREIGN KEY (`id_conta_taxaassociativa`) REFERENCES `contas` (`id`),
  CONSTRAINT `grupo_calculo_id_formula_foreign` FOREIGN KEY (`id_formula`) REFERENCES `formulas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_calculo`
--

LOCK TABLES `grupo_calculo` WRITE;
/*!40000 ALTER TABLE `grupo_calculo` DISABLE KEYS */;
INSERT INTO `grupo_calculo` VALUES (1,'Formula Padrão',10.00,1,2,1,'2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `grupo_calculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_calculo_imoveis`
--

DROP TABLE IF EXISTS `grupo_calculo_imoveis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_calculo_imoveis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_imovel` int(10) unsigned NOT NULL,
  `id_grupo_calculo` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grupo_calculo_imoveis_id_imovel_unique` (`id_imovel`),
  KEY `grupo_calculo_imoveis_id_grupo_calculo_foreign` (`id_grupo_calculo`),
  CONSTRAINT `grupo_calculo_imoveis_id_grupo_calculo_foreign` FOREIGN KEY (`id_grupo_calculo`) REFERENCES `grupo_calculo` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grupo_calculo_imoveis_id_imovel_foreign` FOREIGN KEY (`id_imovel`) REFERENCES `imovel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_calculo_imoveis`
--

LOCK TABLES `grupo_calculo_imoveis` WRITE;
/*!40000 ALTER TABLE `grupo_calculo_imoveis` DISABLE KEYS */;
INSERT INTO `grupo_calculo_imoveis` VALUES (1,1,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(2,2,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(3,5,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(4,4,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(5,6,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(6,13,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(7,8,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(8,14,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(9,10,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(10,11,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(11,12,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(12,9,1,'2021-02-09 23:01:19','2021-02-09 23:01:19'),(13,3,1,'2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `grupo_calculo_imoveis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_permanente`
--

DROP TABLE IF EXISTS `grupo_permanente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_permanente` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `inicio_codigo` int(10) unsigned NOT NULL,
  `final_codigo` int(10) unsigned NOT NULL,
  `usar_letra_codigo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `letra_codigo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_permanente`
--

LOCK TABLES `grupo_permanente` WRITE;
/*!40000 ALTER TABLE `grupo_permanente` DISABLE KEYS */;
INSERT INTO `grupo_permanente` VALUES (1,'G-I',100,300,'n','','Associado titular'),(3,'G-II',301,1600,'n','','Esposas, filhos, pais, irmaos'),(5,'G-III',1600,6999,'n','','Familiares e amigos'),(7,'G-IV',7000,9999,'n','','Prestadores de servico'),(9,'G-V',1,99,'n','','Funcionarios do condominio');
/*!40000 ALTER TABLE `grupo_permanente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_produtos`
--

DROP TABLE IF EXISTS `grupo_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_produtos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `depreciacao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grupo_produtos_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_produtos`
--

LOCK TABLES `grupo_produtos` WRITE;
/*!40000 ALTER TABLE `grupo_produtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagem_produtos`
--

DROP TABLE IF EXISTS `imagem_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagem_produtos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idprodutos` int(10) unsigned NOT NULL,
  `imagem` mediumblob NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `imagem_produtos_idprodutos_foreign` (`idprodutos`),
  CONSTRAINT `imagem_produtos_idprodutos_foreign` FOREIGN KEY (`idprodutos`) REFERENCES `produtos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagem_produtos`
--

LOCK TABLES `imagem_produtos` WRITE;
/*!40000 ALTER TABLE `imagem_produtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagem_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imovel`
--

DROP TABLE IF EXISTS `imovel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imovel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quadra` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lote` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logradouro` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `area_imovel` decimal(11,2) DEFAULT NULL,
  `obs` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_pessoa_proprietario` int(10) unsigned DEFAULT NULL,
  `cep` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idinquilino` int(10) unsigned DEFAULT NULL,
  `idlocalidade` int(10) unsigned DEFAULT NULL,
  `idsituacao_imovel` int(10) unsigned DEFAULT NULL,
  `alugado` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
  `area_construida` decimal(11,2) DEFAULT NULL,
  `area_ajardinada` decimal(11,2) DEFAULT NULL,
  `id_endereco_cobranca` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `softdeleted` tinyint(1) DEFAULT NULL,
  `base_calculo` decimal(11,2) DEFAULT NULL,
  `imovel_ficticio` tinyint(1) DEFAULT 0,
  `id_tipo_lote` int(11) DEFAULT NULL,
  `area_total_original` decimal(11,2) DEFAULT NULL,
  `area_construida_original` decimal(11,2) DEFAULT NULL,
  `area_permeavel` decimal(11,2) DEFAULT NULL,
  `possui_piscina` tinyint(1) DEFAULT NULL,
  `possui_edicula` tinyint(1) DEFAULT NULL,
  `area_edicula` decimal(11,2) DEFAULT NULL,
  `area_aprovaitamento` decimal(11,2) DEFAULT NULL,
  `frente` decimal(11,2) DEFAULT NULL,
  `frenteM` decimal(11,2) DEFAULT NULL,
  `fundo` decimal(11,2) DEFAULT NULL,
  `fundoM` decimal(11,2) DEFAULT NULL,
  `direita` decimal(11,2) DEFAULT NULL,
  `direitaM` decimal(11,2) DEFAULT NULL,
  `esquerda` decimal(11,2) DEFAULT NULL,
  `esquerdaM` decimal(11,2) DEFAULT NULL,
  `chanfro` decimal(11,2) DEFAULT NULL,
  `habitese_condominio` datetime DEFAULT NULL,
  `habitese_prefeitura` datetime DEFAULT NULL,
  `vistoria` datetime DEFAULT NULL,
  `entrada_rememb` datetime DEFAULT NULL,
  `aprovacao_condominio` datetime DEFAULT NULL,
  `aprovacao_prefeitura` datetime DEFAULT NULL,
  `envio_copia_ausa` datetime DEFAULT NULL,
  `retorno_ausa` datetime DEFAULT NULL,
  `indice_ocupacao` decimal(11,2) DEFAULT NULL,
  `id_externo` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_2` (`quadra`,`lote`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imovel`
--

LOCK TABLES `imovel` WRITE;
/*!40000 ALTER TABLE `imovel` DISABLE KEYS */;
INSERT INTO `imovel` VALUES (1,'00','00','RUA PRINCIPAL',123123.00,NULL,NULL,NULL,'35645645',NULL,1,1,'n',123.00,123.00,NULL,'2017-05-15 18:10:49','2019-11-25 21:53:54',0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'34',NULL,NULL),(2,'00','01','RUA DOS IPÊS',700.00,NULL,NULL,NULL,'74000000',NULL,1,1,'n',250.00,100.00,NULL,'2019-11-27 11:55:55','2019-11-27 11:55:55',0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL),(3,'23','93','RUA DA MATRIX',998.00,NULL,NULL,NULL,'74854211',NULL,1,1,'n',740.00,NULL,NULL,'2019-12-04 12:29:26','2019-12-04 12:29:26',0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'3',NULL,NULL),(4,'01','02','RUA DAS PRÍMULAS',1200.00,NULL,NULL,NULL,'75848484',NULL,1,9,'n',NULL,NULL,NULL,'2020-01-29 17:18:07','2020-01-29 17:18:07',1,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(5,'01','01','RUA DAS PRÍMULAS',840.00,NULL,NULL,NULL,'74544444',NULL,1,11,'n',840.00,NULL,NULL,'2020-01-29 17:18:56','2020-01-29 17:28:11',0,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'01','03','RUA DAS PRÍMULAS',1321.21,NULL,NULL,NULL,'74852122',NULL,1,1,'n',1300.00,NULL,NULL,'2020-01-29 17:24:55','2020-01-29 17:24:55',1,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'6',NULL,NULL),(8,'06','100','RUA SEM FIM',1000.00,NULL,NULL,NULL,'74454545',NULL,1,1,'n',800.00,NULL,NULL,'2020-02-14 10:30:18','2020-02-14 10:30:35',0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'21','21','RUA SANDRA ROSA',123.00,NULL,NULL,NULL,'74000000',NULL,1,1,'n',123.00,NULL,NULL,'2020-02-28 14:13:19','2020-02-28 14:13:19',0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'9',NULL,NULL),(10,'15','04','RUA DOS TESTES',1000.00,NULL,NULL,NULL,'74000000',NULL,1,1,'n',1000.00,NULL,NULL,'2020-04-15 20:44:07','2020-04-15 20:44:07',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10',NULL,NULL),(11,'16','05','RUA DO TESTE',1000.00,NULL,NULL,NULL,'74000001',NULL,1,1,'n',1000.00,NULL,NULL,'2020-04-15 20:57:30','2020-04-15 20:57:30',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11',NULL,NULL),(12,'17','06','RUA DE TESTES',1000.00,NULL,NULL,NULL,'74000002',NULL,1,1,'n',1000.00,NULL,NULL,'2020-04-15 20:58:01','2020-04-15 20:58:01',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',NULL,NULL),(13,'04','12','ALAMEDA VERDE',213.00,NULL,NULL,NULL,'74444444',NULL,1,1,'n',12.00,3123.00,NULL,'2020-04-29 18:05:35','2020-04-29 18:05:35',0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'51',NULL,NULL),(14,'13','13','RUA DO BRUNO',231321.00,NULL,NULL,NULL,'12345678',NULL,1,1,'n',21323.00,2323.00,NULL,'2020-07-10 14:28:27','2020-07-10 14:28:27',0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'14',NULL,NULL);
/*!40000 ALTER TABLE `imovel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imovel_agregado`
--

DROP TABLE IF EXISTS `imovel_agregado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imovel_agregado` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_imovel_principal` int(10) unsigned NOT NULL,
  `quadra` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lote` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logradouro` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `createdat` datetime NOT NULL,
  `updatedat` datetime NOT NULL,
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imovel_agregado`
--

LOCK TABLES `imovel_agregado` WRITE;
/*!40000 ALTER TABLE `imovel_agregado` DISABLE KEYS */;
INSERT INTO `imovel_agregado` VALUES (3,5,'01','02','RUA DAS PRÍMULAS',NULL,'2020-01-29 15:27:26','2020-01-29 15:28:11',0),(4,5,'01','03','RUA DAS PRÍMULAS',NULL,'2020-01-29 15:27:35','2020-01-29 15:28:11',0),(5,5,'01','93','RUA DA MATRIX',NULL,'2020-01-29 15:28:11','2020-01-29 15:28:11',0),(6,8,'06','93','RUA DA MATRIX',NULL,'2020-02-14 08:30:35','2020-02-14 08:30:35',0);
/*!40000 ALTER TABLE `imovel_agregado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imovel_entrada`
--

DROP TABLE IF EXISTS `imovel_entrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imovel_entrada` (
  `id_entrada` int(10) unsigned NOT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `id_autorizante` int(10) unsigned NOT NULL,
  KEY `id_entrada` (`id_entrada`,`id_imovel`,`id_autorizante`),
  KEY `I_ID_ENTRADA` (`id_entrada`),
  KEY `ID_IMOVEL` (`id_imovel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imovel_entrada`
--

LOCK TABLES `imovel_entrada` WRITE;
/*!40000 ALTER TABLE `imovel_entrada` DISABLE KEYS */;
INSERT INTO `imovel_entrada` VALUES (3,1,4),(4,2,2),(18,1,4),(25,1,4),(26,1,4),(34,1,4),(57,1,4),(58,1,4),(59,1,4),(60,2,2),(69,3,25),(70,1,4),(70,3,25),(98,1,4),(112,1,4),(113,1,4),(114,1,3),(118,1,19),(137,2,2),(138,2,2),(139,2,2),(140,2,2),(140,3,25),(141,2,2),(142,3,2),(151,3,109),(152,8,109),(158,1,4),(167,1,4),(169,1,3),(192,1,4),(193,1,4),(199,1,3),(200,3,19),(201,1,4),(202,1,66),(203,1,91),(204,1,4),(205,1,4),(206,1,19),(207,1,4),(208,1,3),(209,3,3),(210,3,19),(215,3,142),(229,1,4),(304,1,3),(305,1,3),(306,1,3),(307,1,3),(308,1,3),(309,1,3),(310,1,3),(311,1,3),(312,1,3),(313,1,3),(314,1,3),(315,1,3),(316,1,3),(317,1,3),(318,1,3),(319,1,3),(320,1,3),(321,1,3),(322,1,3),(323,1,3),(324,1,3),(325,1,3),(326,1,3),(327,1,3),(328,1,3),(329,1,3),(330,1,3),(331,1,3),(332,1,3),(333,1,3),(334,1,3),(336,1,3),(337,1,3),(338,1,3),(339,1,3),(340,1,3),(341,1,3),(342,1,3),(343,1,3),(389,1,3),(395,1,3),(398,1,3),(399,1,3),(400,1,3),(401,1,3),(402,1,3),(403,10,90),(403,11,155),(403,12,156),(404,11,155),(405,10,90),(406,10,90),(406,11,155),(406,12,156),(407,1,3),(431,11,155),(432,11,155),(434,11,155),(453,1,3),(457,1,4),(458,1,3),(460,1,4),(461,1,4),(465,1,4),(466,1,4),(467,1,4),(468,1,3),(469,1,3),(470,1,19),(471,1,19),(472,1,4),(473,1,4),(474,1,4),(475,1,4),(476,1,4),(500,1,4),(501,1,4),(502,1,4),(510,1,3),(511,3,19),(512,1,4),(517,3,25),(518,1,45),(519,1,45),(520,1,3),(521,1,4),(522,3,25),(523,1,4),(524,1,4),(524,3,19),(534,3,2),(535,1,4),(536,1,4),(537,3,25),(538,3,25),(539,1,4),(540,1,4),(541,1,4),(541,3,2),(542,3,25),(543,3,2),(544,3,25),(545,3,25),(546,3,25),(547,3,2),(561,13,163),(562,13,163),(563,1,4),(566,1,4),(572,1,3),(587,1,4),(588,1,19),(593,1,4),(597,1,4),(606,1,4),(607,1,3),(608,3,3),(609,1,3),(610,3,3),(611,1,3),(612,1,3),(613,1,3),(614,3,1),(615,1,3),(616,1,3),(617,1,4),(627,1,4),(628,13,164),(630,1,4),(631,1,4),(632,1,4),(633,1,3),(634,1,19),(635,1,4),(636,1,4),(637,1,19),(638,1,19),(639,1,4),(640,1,3),(641,1,4),(642,1,4),(643,1,3),(644,3,1),(645,3,1),(646,1,3),(647,1,3),(648,1,3),(649,1,3),(650,1,19),(651,1,19),(652,1,19),(653,1,19),(654,1,19),(655,1,19),(656,1,19),(657,1,3),(658,1,4),(659,1,4),(660,1,4),(661,1,3),(662,1,12),(663,14,19),(664,14,131),(665,14,19),(666,14,19),(667,14,19),(668,14,19),(669,14,19),(670,14,19),(671,14,19),(672,14,165),(673,14,165),(674,14,165),(675,14,165),(676,14,19),(677,14,19),(678,14,19),(679,14,19),(680,14,19),(681,14,19),(682,14,19),(683,14,19),(684,14,131),(685,14,131),(686,14,131),(687,14,131),(688,14,19),(689,14,19),(690,14,19),(691,14,19),(692,14,19),(693,14,143),(694,14,143),(695,14,131),(696,14,131),(697,14,131),(698,14,131),(699,14,19),(700,14,143),(701,14,143),(702,14,131),(703,14,131),(704,14,131),(705,14,131),(706,14,131),(707,14,19),(708,14,19),(709,14,131),(710,14,19),(711,14,19),(712,14,19),(713,14,19),(714,14,19),(715,14,143),(716,14,131),(717,14,143),(718,14,143),(719,14,131),(720,14,131),(721,14,19),(722,14,19),(723,14,143),(724,14,131),(725,1,3),(726,1,3),(731,1,3),(732,1,4),(733,14,19),(734,1,3),(735,1,4),(739,1,3),(741,1,4),(742,1,4),(743,1,4),(744,1,3),(745,1,3),(746,1,3),(747,1,4),(751,14,131),(754,14,19),(755,14,131),(756,14,19),(757,14,19),(758,14,19),(759,14,19),(760,14,19),(761,14,131),(762,14,19),(763,14,19),(764,14,19),(773,14,19),(774,14,131),(775,14,19),(776,14,19),(777,14,19),(778,14,19),(779,14,19),(780,14,19),(781,14,19),(789,1,3),(790,1,3),(792,1,3),(800,14,19),(801,14,131),(802,14,131),(803,14,19),(804,14,19),(805,14,19),(819,14,19),(820,14,19),(821,14,19),(822,14,19),(823,14,19),(842,14,19),(843,14,131),(844,14,19),(845,14,19),(846,14,19),(848,1,3),(849,1,3),(860,1,4),(862,1,4),(865,14,19),(866,14,19),(867,14,19),(868,14,19),(882,14,19),(883,14,19),(884,14,19),(885,3,25),(886,3,25),(887,3,25),(888,3,25),(889,3,25),(890,3,25),(891,3,25),(892,3,25),(893,3,25),(894,3,25),(895,3,25),(896,3,25),(897,3,25),(898,3,25),(899,3,25),(900,3,25),(902,9,156),(904,14,19),(909,13,164),(909,14,19),(915,13,164),(915,14,19),(921,13,164),(924,14,19),(927,13,164),(927,14,19),(934,9,120),(935,9,156),(936,9,156),(937,9,156),(938,9,156),(939,9,156),(940,9,156),(941,9,156),(942,9,156),(943,9,156),(944,9,156),(945,9,156),(946,9,156),(947,9,156),(948,9,156),(949,9,156),(950,9,156),(951,9,156),(952,9,156),(953,9,156),(954,9,156),(955,9,156),(956,9,156),(957,9,156),(957,10,90),(957,11,155),(958,9,156),(958,10,90),(958,11,155),(959,9,156),(959,10,90),(959,11,155),(960,9,156),(961,9,156),(962,9,156),(963,9,156),(964,9,156),(965,9,156),(966,9,156),(967,9,156),(967,14,19),(968,9,156),(969,9,156),(970,9,156),(970,14,19),(971,9,156),(971,14,19),(972,9,156),(973,9,156),(973,14,19),(974,9,156),(974,14,19),(975,9,156),(975,14,19),(976,9,156),(977,9,156),(978,9,156),(978,10,90),(978,11,155),(979,9,156),(979,10,90),(979,11,155),(980,9,156),(981,9,156),(981,10,90),(981,11,155),(982,9,156),(982,10,90),(982,11,155),(983,9,156),(983,10,90),(983,11,155),(984,9,156),(985,9,156),(985,14,19),(986,9,156),(986,14,19),(987,9,156),(988,9,156),(989,9,156),(990,9,156),(990,14,19),(991,9,156),(992,9,156),(992,10,90),(992,11,155),(993,9,156),(994,9,156),(994,10,90),(994,11,155),(995,9,156),(995,10,90),(995,11,155),(996,3,1),(996,9,156),(997,3,1),(997,9,156),(998,3,1),(998,9,156),(999,3,1),(999,9,156),(999,10,90),(999,11,155),(1000,3,1),(1000,9,156),(1000,10,90),(1000,11,155),(1001,3,1),(1002,3,1),(1003,3,1),(1004,3,1),(1005,3,1),(1005,9,156),(1005,10,90),(1005,11,155),(1006,3,1),(1006,9,156),(1006,10,90),(1006,11,155),(1007,9,156),(1008,9,156),(1009,3,1),(1009,9,156),(1010,3,1),(1010,9,156),(1011,3,1),(1011,9,156),(1012,9,156),(1013,9,156),(1014,3,1),(1014,9,156),(1015,9,156),(1016,3,1),(1016,9,156),(1016,10,90),(1016,11,155),(1017,9,156),(1018,9,156),(1019,9,156),(1020,1,4),(1079,3,2),(1080,3,2),(1081,3,2),(1082,3,2),(1083,3,2),(1084,3,2),(1085,3,2),(1086,3,2),(1087,3,2),(1088,3,2),(1089,3,2),(1090,3,2),(1091,1,3),(1092,1,3),(1093,1,3),(1094,1,3),(1095,1,3),(1096,1,3),(1097,3,2),(1098,3,2),(1099,3,2),(1100,3,2),(1101,1,3),(1102,1,3),(1103,1,3),(1104,1,3),(1105,1,3),(1106,1,3),(1107,1,3),(1108,3,2),(1109,3,2),(1110,3,2),(1111,3,2),(1112,3,2),(1113,3,2),(1114,3,2),(1115,1,3),(1116,1,3),(1117,1,3),(1118,3,2),(1119,3,2),(1120,3,2),(1121,3,2),(1122,3,2),(1123,3,2),(1124,3,2),(1125,3,2),(1126,3,2),(1127,3,2),(1128,3,2),(1129,3,2),(1130,3,2),(1131,3,2),(1132,3,2),(1133,3,2),(1134,3,2),(1135,3,2),(1136,3,2),(1137,3,2),(1138,3,2),(1139,3,2),(1140,3,2),(1141,3,2),(1142,3,2),(1143,3,2),(1144,3,2),(1145,3,2),(1146,3,2),(1147,3,2),(1148,3,2),(1149,3,2),(1150,3,2),(1151,3,2),(1152,3,2),(1153,3,2),(1154,3,2),(1155,3,2),(1156,3,2),(1157,3,2),(1158,3,2),(1159,3,2),(1160,3,2),(1161,3,2),(1162,3,2),(1163,3,2),(1164,3,2),(1165,3,2),(1166,3,2),(1167,3,2),(1168,3,2),(1169,3,2),(1170,3,2),(1171,3,2),(1172,3,2),(1173,3,2),(1174,3,2),(1175,3,2),(1176,3,2),(1177,3,2),(1178,3,2),(1179,3,2),(1180,3,2),(1181,3,2),(1182,3,2),(1183,3,2),(1184,3,2),(1185,5,131),(1186,5,131),(1187,3,2),(1188,3,2),(1189,5,131),(1190,3,2),(1191,3,2);
/*!40000 ALTER TABLE `imovel_entrada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imovel_liberacao`
--

DROP TABLE IF EXISTS `imovel_liberacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imovel_liberacao` (
  `id_liberacao` int(10) unsigned NOT NULL,
  `id_morador_autorizante` int(10) unsigned NOT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `id_atendente_create` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `id_pessoa_delete` int(10) unsigned DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `softdeleted` int(10) unsigned NOT NULL,
  KEY `Index_1` (`id_liberacao`),
  KEY `Index_2` (`id_morador_autorizante`),
  KEY `Index_3` (`id_imovel`),
  KEY `I_ID_IMOVEL` (`id_imovel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imovel_liberacao`
--

LOCK TABLES `imovel_liberacao` WRITE;
/*!40000 ALTER TABLE `imovel_liberacao` DISABLE KEYS */;
INSERT INTO `imovel_liberacao` VALUES (1,4,1,NULL,'2019-12-02 14:47:43',1,'2019-12-02 14:49:22',1),(1,4,1,1,'2019-12-02 14:49:11',1,'2019-12-02 14:49:22',1),(1,4,1,1,'2019-12-02 14:49:22',NULL,NULL,0),(2,4,1,NULL,'2019-12-02 14:53:10',NULL,NULL,0),(3,4,1,NULL,'2019-12-02 14:54:08',1,'2019-12-02 14:56:05',1),(3,4,1,1,'2019-12-02 14:56:05',NULL,NULL,0),(4,4,1,NULL,'2019-12-02 15:06:36',1,'2019-12-02 15:09:15',1),(4,4,1,1,'2019-12-02 15:09:15',NULL,NULL,0),(5,4,1,NULL,'2019-12-02 15:18:46',NULL,NULL,0),(6,1,1,NULL,'2019-12-02 17:06:15',NULL,NULL,0),(7,4,1,NULL,'2019-12-03 17:36:23',NULL,NULL,0),(8,4,1,NULL,'2019-12-03 17:36:55',NULL,NULL,0),(9,4,1,NULL,'2019-12-03 17:37:13',NULL,NULL,0),(10,1,1,1,'2019-12-03 18:12:29',NULL,NULL,0),(11,1,1,1,'2019-12-03 18:12:31',NULL,NULL,0),(12,1,1,1,'2019-12-03 18:12:32',NULL,NULL,0),(13,1,1,1,'2019-12-03 18:15:07',NULL,NULL,0),(14,1,1,1,'2019-12-04 09:46:00',NULL,NULL,0),(15,19,1,NULL,'2019-12-04 09:51:30',1,'2019-12-04 09:52:05',1),(15,19,1,1,'2019-12-04 09:52:05',NULL,NULL,0),(16,4,1,NULL,'2019-12-04 09:57:49',1,'2019-12-04 09:59:52',1),(16,4,1,1,'2019-12-04 09:59:52',NULL,NULL,0),(17,4,1,NULL,'2019-12-04 10:18:18',1,'2019-12-04 10:20:02',1),(17,4,1,1,'2019-12-04 10:19:51',1,'2019-12-04 10:20:02',1),(17,4,1,1,'2019-12-04 10:20:02',NULL,NULL,0),(18,1,1,1,'2019-12-04 10:22:09',NULL,NULL,0),(19,3,1,1,'2019-12-04 10:24:03',1,'2019-12-04 18:09:53',1),(20,2,2,1,'2019-12-04 10:25:23',1,'2019-12-04 10:26:40',1),(21,19,1,1,'2019-12-04 10:32:42',1,'2019-12-04 10:32:59',1),(22,19,1,1,'2019-12-04 10:32:43',1,'2019-12-04 10:33:00',1),(23,25,3,1,'2019-12-04 10:32:52',1,'2019-12-04 10:34:19',1),(21,19,1,1,'2019-12-04 10:32:59',NULL,NULL,0),(22,19,1,1,'2019-12-04 10:33:00',NULL,NULL,0),(24,19,1,1,'2019-12-04 10:33:00',NULL,NULL,0),(23,25,3,1,'2019-12-04 10:33:35',1,'2019-12-04 10:34:19',1),(23,25,3,1,'2019-12-04 10:34:03',1,'2019-12-04 10:34:19',1),(25,25,3,1,'2019-12-04 10:34:39',NULL,NULL,0),(26,19,1,1,'2019-12-04 10:44:56',1,'2019-12-04 10:51:08',1),(26,19,1,1,'2019-12-04 10:50:08',1,'2019-12-04 10:51:08',1),(26,19,1,1,'2019-12-04 10:50:08',1,'2019-12-04 10:51:08',1),(26,19,1,1,'2019-12-04 10:50:41',1,'2019-12-04 10:51:08',1),(27,3,1,1,'2019-12-04 10:53:24',NULL,NULL,0),(28,3,1,1,'2019-12-04 10:53:24',NULL,NULL,0),(29,3,1,1,'2019-12-04 10:53:25',NULL,NULL,0),(30,4,1,NULL,'2019-12-04 10:54:23',NULL,NULL,0),(31,4,1,NULL,'2019-12-04 10:54:53',NULL,NULL,0),(32,4,1,NULL,'2019-12-04 11:06:35',NULL,NULL,0),(33,19,1,1,'2019-12-04 11:06:51',NULL,NULL,0),(34,19,1,1,'2019-12-04 11:06:52',NULL,NULL,0),(35,19,1,1,'2019-12-04 11:10:39',NULL,NULL,0),(36,19,1,1,'2019-12-04 11:10:40',NULL,NULL,0),(37,4,1,NULL,'2019-12-04 11:22:35',NULL,NULL,0),(38,4,1,NULL,'2019-12-04 11:22:59',NULL,NULL,0),(39,4,1,NULL,'2019-12-04 11:25:35',NULL,NULL,0),(40,4,1,NULL,'2019-12-04 11:26:02',NULL,NULL,0),(41,4,1,NULL,'2019-12-04 11:49:55',NULL,NULL,0),(42,4,1,NULL,'2019-12-04 13:52:38',NULL,NULL,0),(43,4,1,NULL,'2019-12-04 15:29:07',1,'2019-12-04 18:09:56',1),(44,19,1,1,'2019-12-04 15:59:07',NULL,NULL,0),(45,19,1,1,'2019-12-04 16:01:43',1,'2019-12-04 18:09:49',1),(46,19,1,1,'2019-12-04 16:03:45',1,'2019-12-04 18:09:58',1),(47,19,1,1,'2019-12-04 16:03:51',1,'2019-12-04 18:09:48',1),(48,19,1,1,'2019-12-04 17:39:01',NULL,NULL,0),(49,19,1,1,'2019-12-04 17:39:03',NULL,NULL,0),(50,25,3,1,'2019-12-06 09:49:01',NULL,NULL,0),(51,25,3,1,'2019-12-06 09:49:02',NULL,NULL,0),(52,4,1,NULL,'2019-12-09 16:28:39',NULL,NULL,0),(53,4,1,NULL,'2019-12-10 10:43:50',NULL,NULL,0),(54,4,1,NULL,'2019-12-10 10:44:14',NULL,NULL,0),(55,4,1,NULL,'2019-12-10 10:47:33',NULL,NULL,0),(56,4,1,NULL,'2019-12-10 10:47:33',NULL,NULL,0),(57,1,1,NULL,'2019-12-10 15:39:42',NULL,NULL,0),(58,1,1,NULL,'2019-12-10 16:21:56',NULL,NULL,0),(59,1,1,NULL,'2019-12-10 16:23:08',NULL,NULL,0),(60,1,1,NULL,'2019-12-10 16:28:17',NULL,NULL,0),(61,1,1,NULL,'2019-12-10 16:29:17',NULL,NULL,0),(62,1,1,NULL,'2019-12-10 17:24:46',NULL,NULL,0),(63,1,1,NULL,'2019-12-10 17:25:39',NULL,NULL,0),(64,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(65,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(66,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(67,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(68,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(69,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(70,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(71,4,1,NULL,'2019-12-10 17:51:32',NULL,NULL,0),(72,4,1,NULL,'2019-12-11 12:03:47',NULL,NULL,0),(73,4,1,NULL,'2019-12-11 12:03:47',NULL,NULL,0),(74,4,1,NULL,'2019-12-11 12:03:47',NULL,NULL,0),(75,1,1,1,'2019-12-11 15:25:47',NULL,NULL,0),(76,1,1,1,'2019-12-11 15:26:07',NULL,NULL,0),(77,1,1,1,'2019-12-11 15:26:07',NULL,NULL,0),(78,19,1,NULL,'2019-12-12 10:10:23',NULL,NULL,0),(79,19,1,NULL,'2019-12-12 10:11:37',1,'2019-12-12 10:13:23',1),(79,19,1,1,'2019-12-12 10:13:23',NULL,NULL,0),(80,19,1,NULL,'2019-12-12 10:15:38',1,'2019-12-12 10:16:35',1),(80,19,1,1,'2019-12-12 10:16:35',NULL,NULL,0),(81,1,1,1,'2019-12-12 10:19:22',NULL,NULL,0),(82,1,1,1,'2019-12-12 10:22:23',NULL,NULL,0),(83,1,1,1,'2019-12-12 14:47:40',1,'2019-12-13 11:19:21',1),(83,13,2,1,'2019-12-12 14:47:40',1,'2019-12-12 15:27:21',1),(83,13,2,1,'2019-12-12 14:48:03',1,'2019-12-12 15:27:21',1),(83,1,1,1,'2019-12-12 14:48:03',1,'2019-12-13 11:19:21',1),(83,13,2,1,'2019-12-12 15:24:41',1,'2019-12-12 15:27:21',1),(83,1,1,1,'2019-12-12 15:24:41',1,'2019-12-13 11:19:21',1),(83,13,2,1,'2019-12-12 15:25:06',1,'2019-12-12 15:27:21',1),(83,1,1,1,'2019-12-12 15:25:06',1,'2019-12-13 11:19:21',1),(84,1,1,1,'2019-12-12 15:25:07',1,'2019-12-13 11:19:21',1),(84,13,2,1,'2019-12-12 15:25:07',1,'2019-12-12 15:27:21',1),(85,1,1,1,'2019-12-12 15:25:07',1,'2019-12-13 11:19:21',1),(85,13,2,1,'2019-12-12 15:25:07',1,'2019-12-12 15:27:22',1),(83,13,2,1,'2019-12-12 15:25:20',1,'2019-12-12 15:27:21',1),(83,1,1,1,'2019-12-12 15:25:20',1,'2019-12-13 11:19:21',1),(84,13,2,1,'2019-12-12 15:25:20',1,'2019-12-12 15:27:21',1),(84,1,1,1,'2019-12-12 15:25:20',1,'2019-12-13 11:19:21',1),(85,13,2,1,'2019-12-12 15:25:21',1,'2019-12-12 15:27:22',1),(85,1,1,1,'2019-12-12 15:25:21',1,'2019-12-13 11:19:21',1),(86,1,1,1,'2019-12-12 15:25:21',1,'2019-12-13 11:19:21',1),(86,13,2,1,'2019-12-12 15:25:21',1,'2019-12-12 15:27:22',1),(83,13,2,1,'2019-12-12 15:27:21',NULL,NULL,0),(83,1,1,1,'2019-12-12 15:27:21',1,'2019-12-13 11:19:21',1),(84,13,2,1,'2019-12-12 15:27:21',NULL,NULL,0),(84,1,1,1,'2019-12-12 15:27:21',1,'2019-12-13 11:19:21',1),(85,13,2,1,'2019-12-12 15:27:22',NULL,NULL,0),(85,1,1,1,'2019-12-12 15:27:22',1,'2019-12-13 11:19:21',1),(86,13,2,1,'2019-12-12 15:27:22',NULL,NULL,0),(86,1,1,1,'2019-12-12 15:27:22',1,'2019-12-13 11:19:21',1),(87,19,1,NULL,'2019-12-12 16:05:12',1,'2019-12-13 11:19:17',1),(88,19,1,NULL,'2019-12-12 16:13:03',1,'2019-12-13 11:19:15',1),(89,19,1,NULL,'2019-12-12 16:23:30',NULL,NULL,0),(90,19,1,NULL,'2019-12-12 16:23:30',NULL,NULL,0),(91,19,1,NULL,'2019-12-12 16:23:30',NULL,NULL,0),(92,19,1,NULL,'2019-12-12 17:35:07',NULL,NULL,0),(93,1,1,NULL,'2019-12-13 08:50:43',1,'2019-12-13 11:19:10',1),(94,19,1,NULL,'2019-12-13 10:15:25',NULL,NULL,0),(95,19,1,NULL,'2019-12-13 10:21:37',NULL,NULL,0),(96,19,1,NULL,'2019-12-13 10:24:21',1,'2019-12-13 10:27:00',1),(97,19,1,NULL,'2019-12-13 10:25:11',1,'2019-12-13 10:26:40',1),(97,19,1,1,'2019-12-13 10:25:25',1,'2019-12-13 10:26:40',1),(97,19,1,1,'2019-12-13 10:25:37',1,'2019-12-13 10:26:40',1),(97,19,1,1,'2019-12-13 10:25:53',1,'2019-12-13 10:26:40',1),(97,19,1,1,'2019-12-13 10:26:40',NULL,NULL,0),(96,19,1,1,'2019-12-13 10:27:00',NULL,NULL,0),(98,19,1,NULL,'2019-12-13 10:27:53',NULL,NULL,0),(99,19,1,NULL,'2019-12-13 10:28:47',NULL,NULL,0),(100,19,1,NULL,'2019-12-13 10:28:52',NULL,NULL,0),(101,19,1,NULL,'2019-12-13 10:29:22',1,'2019-12-13 11:19:12',1),(102,19,1,NULL,'2019-12-13 10:29:31',1,'2019-12-13 11:19:13',1),(103,19,1,NULL,'2019-12-13 10:34:54',1,'2019-12-13 11:19:08',1),(104,19,1,NULL,'2019-12-13 11:20:24',1,'2019-12-13 11:21:29',1),(105,19,1,NULL,'2019-12-13 11:20:56',1,'2019-12-13 11:21:15',1),(105,19,1,1,'2019-12-13 11:21:15',NULL,NULL,0),(104,19,1,1,'2019-12-13 11:21:24',1,'2019-12-13 11:21:29',1),(104,19,1,1,'2019-12-13 11:21:29',NULL,NULL,0),(106,19,1,NULL,'2019-12-13 11:22:31',NULL,NULL,0),(107,19,1,1,'2019-12-13 11:23:53',NULL,NULL,0),(108,19,1,1,'2019-12-13 11:26:41',NULL,NULL,0),(109,19,1,NULL,'2019-12-13 11:27:06',1,'2019-12-13 14:13:31',1),(110,19,1,NULL,'2019-12-13 11:34:12',1,'2019-12-13 14:13:23',1),(111,19,1,NULL,'2019-12-13 11:34:12',1,'2019-12-13 14:13:27',1),(112,19,1,NULL,'2019-12-13 11:34:12',1,'2019-12-13 14:13:39',1),(113,19,1,NULL,'2019-12-13 11:34:12',1,'2019-12-13 14:14:45',1),(114,19,1,NULL,'2019-12-13 11:34:12',1,'2019-12-13 14:14:54',1),(115,19,1,NULL,'2019-12-13 11:34:53',1,'2019-12-13 14:14:51',1),(116,19,1,NULL,'2019-12-13 11:36:56',1,'2019-12-13 14:14:40',1),(117,19,1,NULL,'2019-12-13 11:38:06',1,'2019-12-13 14:14:47',1),(118,4,1,NULL,'2019-12-13 14:07:37',1,'2019-12-13 14:09:38',1),(118,4,1,1,'2019-12-13 14:09:38',NULL,NULL,0),(119,4,1,NULL,'2019-12-13 14:11:03',1,'2019-12-13 14:14:26',1),(119,4,1,1,'2019-12-13 14:14:10',1,'2019-12-13 14:14:26',1),(119,4,1,1,'2019-12-13 14:14:16',1,'2019-12-13 14:14:26',1),(119,4,1,1,'2019-12-13 14:14:26',NULL,NULL,0),(120,4,1,NULL,'2019-12-13 14:16:51',1,'2019-12-13 14:34:13',1),(120,4,1,1,'2019-12-13 14:33:27',1,'2019-12-13 14:34:13',1),(120,4,1,1,'2019-12-13 14:33:34',1,'2019-12-13 14:34:13',1),(120,4,1,1,'2019-12-13 14:33:51',1,'2019-12-13 14:34:13',1),(120,4,1,1,'2019-12-13 14:34:13',NULL,NULL,0),(121,4,1,NULL,'2019-12-13 15:47:33',NULL,NULL,0),(122,4,1,NULL,'2019-12-13 16:10:42',NULL,NULL,0),(123,4,1,NULL,'2019-12-13 16:12:57',NULL,NULL,0),(124,4,1,NULL,'2019-12-13 16:17:03',1,'2019-12-13 16:24:22',1),(124,4,1,1,'2019-12-13 16:17:52',1,'2019-12-13 16:24:22',1),(125,3,1,1,'2019-12-13 16:19:38',NULL,NULL,0),(124,4,1,1,'2019-12-13 16:19:44',1,'2019-12-13 16:24:22',1),(124,4,1,1,'2019-12-13 16:20:40',1,'2019-12-13 16:24:22',1),(124,4,1,1,'2019-12-13 16:23:16',1,'2019-12-13 16:24:22',1),(124,4,1,1,'2019-12-13 16:24:22',NULL,NULL,0),(126,3,1,1,'2019-12-13 16:28:54',NULL,NULL,0),(127,4,1,NULL,'2019-12-13 16:28:50',NULL,NULL,0),(128,1,1,1,'2019-12-13 17:12:35',NULL,NULL,0),(129,1,1,1,'2019-12-13 17:14:55',1,'2019-12-13 17:15:20',1),(129,1,1,1,'2019-12-13 17:15:20',NULL,NULL,0),(130,19,1,NULL,'2019-12-13 17:31:02',1,'2019-12-13 17:32:59',1),(130,19,1,1,'2019-12-13 17:32:41',1,'2019-12-13 17:32:59',1),(130,19,1,1,'2019-12-13 17:32:53',1,'2019-12-13 17:32:59',1),(130,19,1,1,'2019-12-13 17:32:59',NULL,NULL,0),(131,1,1,1,'2019-12-13 17:33:14',1,'2019-12-13 17:33:17',1),(131,1,1,1,'2019-12-13 17:33:17',NULL,NULL,0),(132,1,1,1,'2019-12-13 17:34:38',NULL,NULL,0),(133,1,1,1,'2019-12-13 18:00:07',NULL,NULL,0),(134,1,1,1,'2019-12-13 18:00:39',NULL,NULL,0),(135,1,1,NULL,'2019-12-16 08:31:20',NULL,NULL,0),(136,1,1,NULL,'2019-12-16 09:04:10',NULL,NULL,0),(137,1,1,1,'2019-12-16 09:07:52',NULL,NULL,0),(138,4,1,NULL,'2019-12-16 11:49:32',NULL,NULL,0),(139,4,1,NULL,'2019-12-16 11:49:32',1,'2019-12-16 12:02:03',1),(140,4,1,NULL,'2019-12-16 11:53:08',1,'2019-12-16 12:03:15',1),(141,4,1,NULL,'2019-12-16 11:54:05',1,'2019-12-16 12:04:12',1),(142,4,1,NULL,'2019-12-16 11:57:40',1,'2019-12-16 12:05:23',1),(139,4,1,1,'2019-12-16 12:02:03',NULL,NULL,0),(140,4,1,1,'2019-12-16 12:03:15',NULL,NULL,0),(141,4,1,1,'2019-12-16 12:04:12',NULL,NULL,0),(142,4,1,1,'2019-12-16 12:05:23',NULL,NULL,0),(143,4,1,NULL,'2019-12-16 12:06:18',NULL,NULL,0),(144,4,1,NULL,'2019-12-16 12:06:18',1,'2019-12-16 12:07:43',1),(145,4,1,NULL,'2019-12-16 12:12:31',NULL,NULL,0),(146,4,1,NULL,'2019-12-16 12:16:24',NULL,NULL,0),(147,4,1,NULL,'2019-12-16 13:54:18',NULL,NULL,0),(148,4,1,NULL,'2019-12-16 14:04:07',NULL,NULL,0),(149,4,1,NULL,'2019-12-16 14:27:47',NULL,NULL,0),(150,19,1,NULL,'2019-12-16 16:09:56',NULL,NULL,0),(151,19,1,NULL,'2019-12-16 16:10:05',NULL,NULL,0),(152,19,1,NULL,'2019-12-16 16:10:11',NULL,NULL,0),(153,19,1,NULL,'2019-12-16 16:10:19',NULL,NULL,0),(154,19,1,NULL,'2019-12-16 16:10:37',NULL,NULL,0),(155,19,1,NULL,'2019-12-16 16:10:37',NULL,NULL,0),(156,19,1,NULL,'2019-12-17 08:32:06',NULL,NULL,0),(157,19,1,NULL,'2019-12-17 08:32:06',NULL,NULL,0),(158,19,1,NULL,'2019-12-17 08:32:06',NULL,NULL,0),(159,4,1,NULL,'2019-12-17 09:39:19',NULL,NULL,0),(160,4,1,NULL,'2019-12-17 10:06:20',NULL,NULL,0),(161,4,1,NULL,'2019-12-17 10:13:29',NULL,NULL,0),(162,4,1,NULL,'2019-12-17 10:13:29',NULL,NULL,0),(163,4,1,NULL,'2019-12-17 10:13:29',NULL,NULL,0),(164,1,1,NULL,'2019-12-17 10:30:35',NULL,NULL,0),(165,1,1,NULL,'2019-12-17 10:30:35',NULL,NULL,0),(166,4,1,NULL,'2019-12-17 12:00:40',NULL,NULL,0),(167,4,1,NULL,'2019-12-17 12:00:40',1,'2019-12-17 12:06:21',1),(168,4,1,NULL,'2019-12-17 12:00:40',NULL,NULL,0),(167,4,1,1,'2019-12-17 12:05:53',1,'2019-12-17 12:06:21',1),(167,4,1,1,'2019-12-17 12:06:21',NULL,NULL,0),(169,4,1,NULL,'2019-12-17 12:10:40',NULL,NULL,0),(170,4,1,NULL,'2019-12-17 12:10:40',NULL,NULL,0),(171,4,1,NULL,'2019-12-17 12:10:40',NULL,NULL,0),(172,4,1,NULL,'2019-12-17 12:25:21',NULL,NULL,0),(173,4,1,NULL,'2019-12-17 12:25:21',NULL,NULL,0),(174,4,1,NULL,'2019-12-17 12:25:21',NULL,NULL,0),(175,4,1,NULL,'2019-12-17 12:33:04',NULL,NULL,0),(176,4,1,NULL,'2019-12-17 12:33:04',NULL,NULL,0),(177,4,1,NULL,'2019-12-17 12:33:04',NULL,NULL,0),(178,4,1,NULL,'2019-12-17 13:40:39',NULL,NULL,0),(179,4,1,NULL,'2019-12-17 14:33:06',NULL,NULL,0),(180,4,1,NULL,'2019-12-17 14:33:06',NULL,NULL,0),(181,4,1,NULL,'2019-12-17 14:33:06',NULL,NULL,0),(182,4,1,NULL,'2019-12-17 14:41:54',NULL,NULL,0),(183,4,1,NULL,'2019-12-17 16:39:10',NULL,NULL,0),(184,4,1,NULL,'2019-12-17 16:40:10',NULL,NULL,0),(185,19,1,1,'2019-12-17 17:42:40',NULL,NULL,0),(186,19,1,1,'2019-12-17 17:44:58',NULL,NULL,0),(187,19,1,1,'2019-12-17 17:46:23',NULL,NULL,0),(188,19,1,1,'2019-12-17 17:46:56',NULL,NULL,0),(189,1,1,NULL,'2019-12-17 17:51:51',1,'2019-12-17 17:52:30',1),(189,1,1,1,'2019-12-17 17:52:30',NULL,NULL,0),(190,1,1,NULL,'2019-12-17 17:53:16',NULL,NULL,0),(191,1,1,NULL,'2019-12-17 17:54:28',NULL,NULL,0),(192,1,1,NULL,'2019-12-17 17:54:45',1,'2019-12-17 17:55:02',1),(192,1,1,1,'2019-12-17 17:55:02',NULL,NULL,0),(193,19,1,1,'2019-12-17 17:58:24',1,'2019-12-17 17:59:33',1),(193,19,1,1,'2019-12-17 17:58:30',1,'2019-12-17 17:59:33',1),(194,19,1,1,'2019-12-17 17:58:30',1,'2019-12-17 17:59:33',1),(195,19,1,1,'2019-12-17 17:58:30',1,'2019-12-17 17:59:33',1),(193,19,1,1,'2019-12-17 17:59:33',NULL,NULL,0),(195,19,1,1,'2019-12-17 17:59:33',NULL,NULL,0),(194,19,1,1,'2019-12-17 17:59:33',NULL,NULL,0),(196,19,1,1,'2019-12-17 18:09:40',NULL,NULL,0),(197,19,1,1,'2019-12-17 18:09:40',NULL,NULL,0),(198,19,1,1,'2019-12-17 18:09:40',NULL,NULL,0),(199,19,1,1,'2019-12-17 18:09:41',NULL,NULL,0),(200,19,1,1,'2019-12-17 18:54:43',NULL,NULL,0),(201,19,1,1,'2019-12-17 18:54:43',NULL,NULL,0),(202,19,1,1,'2019-12-17 18:54:44',NULL,NULL,0),(203,1,1,NULL,'2019-12-18 10:02:36',NULL,NULL,0),(204,1,1,NULL,'2019-12-18 10:02:43',NULL,NULL,0),(205,1,1,NULL,'2019-12-18 10:03:05',1,'2019-12-18 10:05:39',1),(206,1,1,NULL,'2019-12-18 10:03:05',NULL,NULL,0),(205,1,1,1,'2019-12-18 10:05:39',NULL,NULL,0),(207,1,1,NULL,'2019-12-18 10:12:26',NULL,NULL,0),(208,1,1,NULL,'2019-12-18 10:13:08',NULL,NULL,0),(209,1,1,NULL,'2019-12-18 10:13:23',NULL,NULL,0),(210,1,1,NULL,'2019-12-18 10:17:11',NULL,NULL,0),(211,1,1,NULL,'2019-12-18 10:17:23',NULL,NULL,0),(212,4,1,NULL,'2019-12-18 11:28:50',NULL,NULL,0),(213,4,1,NULL,'2019-12-18 11:43:31',NULL,NULL,0),(214,4,1,NULL,'2019-12-18 11:44:23',NULL,NULL,0),(215,4,1,NULL,'2019-12-18 11:44:23',NULL,NULL,0),(216,4,1,NULL,'2019-12-18 11:45:37',NULL,NULL,0),(217,4,1,NULL,'2019-12-18 11:46:08',NULL,NULL,0),(218,4,1,NULL,'2019-12-18 11:52:02',NULL,NULL,0),(219,4,1,NULL,'2019-12-18 11:52:32',NULL,NULL,0),(220,4,1,NULL,'2019-12-18 11:52:32',NULL,NULL,0),(221,4,1,NULL,'2019-12-18 11:54:15',NULL,NULL,0),(222,4,1,NULL,'2019-12-18 11:54:15',NULL,NULL,0),(223,4,1,NULL,'2019-12-18 12:03:27',NULL,NULL,0),(224,4,1,NULL,'2019-12-18 13:11:57',NULL,NULL,0),(225,1,1,NULL,'2019-12-18 13:37:31',NULL,NULL,0),(226,1,1,NULL,'2019-12-18 13:39:24',NULL,NULL,0),(227,1,1,NULL,'2019-12-18 13:39:40',NULL,NULL,0),(228,4,1,NULL,'2019-12-18 13:48:45',NULL,NULL,0),(229,4,1,NULL,'2019-12-18 13:49:48',NULL,NULL,0),(230,4,1,NULL,'2019-12-18 14:09:35',NULL,NULL,0),(231,4,1,NULL,'2019-12-18 14:10:08',NULL,NULL,0),(232,1,1,NULL,'2019-12-18 14:14:02',NULL,NULL,0),(233,1,1,NULL,'2019-12-18 14:14:10',NULL,NULL,0),(234,1,1,NULL,'2019-12-18 14:14:20',NULL,NULL,0),(235,1,1,NULL,'2019-12-18 14:14:28',NULL,NULL,0),(236,4,1,NULL,'2019-12-18 14:14:41',NULL,NULL,0),(237,1,1,NULL,'2019-12-18 14:14:48',NULL,NULL,0),(238,1,1,NULL,'2019-12-18 14:15:00',NULL,NULL,0),(239,1,1,NULL,'2019-12-18 14:15:13',NULL,NULL,0),(240,1,1,NULL,'2019-12-18 14:16:00',NULL,NULL,0),(241,4,1,NULL,'2019-12-18 14:22:24',NULL,NULL,0),(242,4,1,NULL,'2019-12-18 14:22:24',NULL,NULL,0),(243,4,1,NULL,'2019-12-18 14:24:13',NULL,NULL,0),(244,4,1,NULL,'2019-12-18 15:21:31',NULL,NULL,0),(245,4,1,NULL,'2019-12-18 15:30:31',NULL,NULL,0),(246,4,1,NULL,'2019-12-18 15:34:48',NULL,NULL,0),(247,4,1,NULL,'2019-12-18 16:27:07',NULL,NULL,0),(248,4,1,NULL,'2019-12-18 16:28:02',NULL,NULL,0),(249,4,1,NULL,'2019-12-18 16:28:58',NULL,NULL,0),(250,4,1,NULL,'2019-12-18 16:30:42',NULL,NULL,0),(251,4,1,NULL,'2019-12-18 16:30:42',NULL,NULL,0),(252,4,1,NULL,'2019-12-18 16:31:23',NULL,NULL,0),(253,4,1,NULL,'2019-12-18 16:32:20',NULL,NULL,0),(254,4,1,NULL,'2019-12-18 16:38:13',NULL,NULL,0),(255,4,1,NULL,'2019-12-18 16:39:01',NULL,NULL,0),(256,4,1,NULL,'2019-12-18 16:40:54',NULL,NULL,0),(257,4,1,NULL,'2019-12-18 16:41:23',NULL,NULL,0),(258,4,1,NULL,'2019-12-18 16:41:47',NULL,NULL,0),(259,4,1,NULL,'2019-12-18 16:56:25',NULL,NULL,0),(260,4,1,NULL,'2019-12-18 17:00:35',NULL,NULL,0),(261,4,1,NULL,'2019-12-18 17:01:15',NULL,NULL,0),(262,4,1,NULL,'2019-12-18 17:03:12',NULL,NULL,0),(263,4,1,NULL,'2019-12-18 17:03:51',NULL,NULL,0),(264,4,1,NULL,'2019-12-18 17:09:34',NULL,NULL,0),(265,1,1,NULL,'2019-12-18 17:32:27',1,'2019-12-18 17:33:55',1),(266,1,1,NULL,'2019-12-18 17:33:34',NULL,NULL,0),(265,1,1,1,'2019-12-18 17:33:55',NULL,NULL,0),(267,1,1,NULL,'2019-12-18 17:36:39',NULL,NULL,0),(268,4,1,NULL,'2019-12-18 17:52:31',NULL,NULL,0),(269,4,1,NULL,'2019-12-18 17:53:47',NULL,NULL,0),(270,18,1,NULL,'2019-12-19 09:36:14',NULL,NULL,0),(271,18,1,NULL,'2019-12-19 09:41:56',NULL,NULL,0),(272,18,1,NULL,'2019-12-19 09:43:18',NULL,NULL,0),(273,18,1,NULL,'2019-12-19 09:43:18',NULL,NULL,0),(274,4,1,NULL,'2019-12-19 09:49:18',NULL,NULL,0),(275,4,1,NULL,'2019-12-19 09:49:18',NULL,NULL,0),(276,4,1,NULL,'2019-12-19 09:53:37',NULL,NULL,0),(277,4,1,NULL,'2019-12-19 09:56:36',NULL,NULL,0),(278,4,1,NULL,'2019-12-19 09:57:08',NULL,NULL,0),(279,4,1,NULL,'2019-12-19 09:57:44',NULL,NULL,0),(280,4,1,NULL,'2019-12-19 11:05:29',1,'2019-12-19 12:10:06',1),(281,4,1,NULL,'2019-12-19 11:05:49',1,'2019-12-19 12:10:04',1),(282,1,1,NULL,'2019-12-19 11:16:10',NULL,NULL,0),(283,1,1,NULL,'2019-12-19 11:16:33',NULL,NULL,0),(284,1,1,NULL,'2019-12-19 11:18:00',NULL,NULL,0),(285,1,1,1,'2019-12-19 11:21:37',1,'2019-12-19 12:10:03',1),(286,1,1,1,'2019-12-19 11:22:09',1,'2019-12-19 12:10:01',1),(287,1,1,NULL,'2019-12-19 11:32:31',1,'2019-12-19 11:41:35',1),(288,1,1,NULL,'2019-12-19 11:32:41',1,'2019-12-19 12:09:42',1),(288,1,1,1,'2019-12-19 11:38:44',1,'2019-12-19 12:09:42',1),(287,1,1,1,'2019-12-19 11:40:01',1,'2019-12-19 11:41:35',1),(287,1,1,1,'2019-12-19 11:41:35',NULL,NULL,0),(289,1,1,NULL,'2019-12-19 12:10:23',1,'2019-12-19 12:12:10',1),(290,1,1,NULL,'2019-12-19 12:11:04',NULL,NULL,0),(291,1,1,NULL,'2019-12-19 12:11:21',1,'2019-12-19 12:11:47',1),(291,1,1,1,'2019-12-19 12:11:47',NULL,NULL,0),(289,1,1,1,'2019-12-19 12:12:10',NULL,NULL,0),(292,1,1,NULL,'2019-12-19 12:12:55',1,'2019-12-19 12:16:00',1),(292,1,1,1,'2019-12-19 12:16:00',NULL,NULL,0),(293,1,1,1,'2019-12-19 12:20:11',1,'2019-12-19 12:22:13',1),(293,1,1,1,'2019-12-19 12:22:13',NULL,NULL,0),(294,1,1,1,'2019-12-19 12:33:21',NULL,NULL,0),(295,1,1,1,'2019-12-19 12:36:08',1,'2019-12-19 12:37:16',1),(295,1,1,1,'2019-12-19 12:37:16',NULL,NULL,0),(296,1,1,1,'2019-12-19 12:38:07',1,'2019-12-19 12:38:27',1),(296,1,1,1,'2019-12-19 12:38:27',NULL,NULL,0),(297,1,1,1,'2019-12-19 13:00:11',NULL,NULL,0),(298,4,1,NULL,'2019-12-19 13:46:14',NULL,NULL,0),(299,4,1,NULL,'2019-12-19 13:46:14',NULL,NULL,0),(300,4,1,NULL,'2019-12-19 13:55:37',NULL,NULL,0),(301,4,1,NULL,'2019-12-19 13:55:37',NULL,NULL,0),(302,4,1,NULL,'2019-12-19 13:56:13',NULL,NULL,0),(303,4,1,NULL,'2019-12-19 14:01:05',NULL,NULL,0),(304,4,1,NULL,'2019-12-19 14:09:16',NULL,NULL,0),(305,4,1,NULL,'2019-12-19 14:12:07',NULL,NULL,0),(306,4,1,NULL,'2019-12-19 14:12:07',NULL,NULL,0),(307,4,1,NULL,'2019-12-19 14:15:05',NULL,NULL,0),(308,4,1,NULL,'2019-12-19 14:41:05',NULL,NULL,0),(309,4,1,NULL,'2019-12-19 14:50:14',NULL,NULL,0),(310,4,1,NULL,'2019-12-19 14:51:09',NULL,NULL,0),(311,4,1,NULL,'2019-12-19 15:41:07',NULL,NULL,0),(312,4,1,NULL,'2019-12-19 16:21:56',NULL,NULL,0),(313,4,1,NULL,'2019-12-19 16:31:29',NULL,NULL,0),(314,4,1,NULL,'2019-12-19 16:31:29',NULL,NULL,0),(315,4,1,NULL,'2019-12-20 09:35:10',NULL,NULL,0),(316,4,1,NULL,'2019-12-20 09:46:22',1,'2019-12-20 09:52:38',1),(317,4,1,NULL,'2019-12-20 09:46:22',NULL,NULL,0),(316,4,1,1,'2019-12-20 09:52:38',NULL,NULL,0),(318,4,1,NULL,'2019-12-20 09:55:33',NULL,NULL,0),(319,4,1,NULL,'2019-12-20 09:55:33',NULL,NULL,0),(320,4,1,NULL,'2019-12-20 14:45:37',NULL,NULL,0),(321,4,1,NULL,'2019-12-20 14:45:37',NULL,NULL,0),(322,4,1,NULL,'2019-12-20 14:50:00',NULL,NULL,0),(323,4,1,NULL,'2019-12-20 14:50:00',NULL,NULL,0),(324,4,1,NULL,'2019-12-20 14:53:09',NULL,NULL,0),(325,4,1,NULL,'2019-12-20 14:54:35',NULL,NULL,0),(326,4,1,NULL,'2019-12-20 15:57:18',NULL,NULL,0),(327,4,1,NULL,'2019-12-20 15:57:18',NULL,NULL,0),(328,1,1,NULL,'2019-12-20 17:18:36',NULL,NULL,0),(329,1,1,NULL,'2019-12-20 17:19:12',NULL,NULL,0),(330,1,1,NULL,'2019-12-20 17:19:41',NULL,NULL,0),(331,1,1,NULL,'2019-12-20 17:20:42',NULL,NULL,0),(332,4,1,NULL,'2020-01-02 16:36:12',NULL,NULL,0),(334,4,1,NULL,'2020-01-06 17:32:57',NULL,NULL,0),(333,4,1,NULL,'2020-01-06 17:32:57',NULL,NULL,0),(335,4,1,NULL,'2020-01-06 17:38:49',NULL,NULL,0),(336,4,1,NULL,'2020-01-10 11:42:33',NULL,NULL,0),(337,4,1,NULL,'2020-01-10 12:08:22',NULL,NULL,0),(338,4,1,NULL,'2020-01-10 12:09:45',NULL,NULL,0),(339,4,1,NULL,'2020-01-10 12:19:33',NULL,NULL,0),(340,4,1,NULL,'2020-01-10 12:21:19',NULL,NULL,0),(341,4,1,NULL,'2020-01-10 14:28:00',NULL,NULL,0),(342,25,3,1,'2020-01-22 08:50:46',NULL,NULL,0),(343,4,1,NULL,'2020-01-22 18:01:43',NULL,NULL,0),(344,4,1,NULL,'2020-01-22 18:01:54',NULL,NULL,0),(345,4,1,NULL,'2020-01-22 18:03:01',NULL,NULL,0),(346,4,1,NULL,'2020-01-23 09:45:45',NULL,NULL,0),(347,4,1,NULL,'2020-01-23 09:45:52',NULL,NULL,0),(348,4,1,NULL,'2020-01-23 09:53:18',NULL,NULL,0),(349,4,1,NULL,'2020-01-23 10:57:17',NULL,NULL,0),(350,4,1,NULL,'2020-01-23 10:57:28',NULL,NULL,0),(351,4,1,NULL,'2020-01-23 11:23:54',NULL,NULL,0),(352,4,1,NULL,'2020-01-23 11:24:02',NULL,NULL,0),(353,4,1,NULL,'2020-01-23 11:28:21',NULL,NULL,0),(354,4,1,NULL,'2020-01-23 11:28:27',NULL,NULL,0),(355,4,1,NULL,'2020-01-23 11:28:34',NULL,NULL,0),(356,4,1,NULL,'2020-01-23 15:29:25',NULL,NULL,0),(357,4,1,NULL,'2020-01-23 15:29:32',NULL,NULL,0),(358,4,1,NULL,'2020-01-23 15:29:40',NULL,NULL,0),(359,4,1,NULL,'2020-01-24 08:46:21',NULL,NULL,0),(360,4,1,NULL,'2020-01-24 08:46:26',NULL,NULL,0),(361,4,1,NULL,'2020-01-24 08:46:36',NULL,NULL,0),(362,4,1,NULL,'2020-01-28 16:28:40',NULL,NULL,0),(363,4,1,NULL,'2020-01-28 16:33:25',NULL,NULL,0),(364,4,1,NULL,'2020-01-28 16:36:08',NULL,NULL,0),(365,4,1,NULL,'2020-01-28 17:05:02',NULL,NULL,0),(366,4,1,NULL,'2020-01-28 17:05:38',NULL,NULL,0),(367,4,1,NULL,'2020-01-28 17:21:58',NULL,NULL,0),(368,4,1,NULL,'2020-01-29 14:34:40',NULL,NULL,0),(369,4,1,NULL,'2020-01-29 14:34:51',NULL,NULL,0),(370,4,1,NULL,'2020-01-29 14:34:58',NULL,NULL,0),(371,4,1,NULL,'2020-01-29 14:35:06',NULL,NULL,0),(372,4,1,NULL,'2020-01-30 10:43:20',1,'2020-01-30 15:43:31',1),(373,4,1,NULL,'2020-01-30 14:56:53',1,'2020-01-30 14:58:18',1),(373,4,1,1,'2020-01-30 14:58:18',NULL,NULL,0),(374,4,1,1,'2020-01-30 15:10:22',NULL,NULL,0),(375,4,1,NULL,'2020-01-30 15:16:49',1,'2020-01-30 15:18:08',1),(375,4,1,1,'2020-01-30 15:18:08',NULL,NULL,0),(376,4,1,NULL,'2020-01-31 17:21:12',NULL,NULL,0),(377,45,1,NULL,'2020-01-31 21:41:23',NULL,NULL,0),(378,45,1,NULL,'2020-01-31 21:41:57',NULL,NULL,0),(379,4,1,NULL,'2020-02-03 08:51:46',NULL,NULL,0),(380,4,1,NULL,'2020-02-03 08:52:38',NULL,NULL,0),(381,4,1,NULL,'2020-02-03 12:13:48',1,'2020-02-03 12:15:05',1),(381,4,1,1,'2020-02-03 12:15:05',NULL,NULL,0),(382,4,1,NULL,'2020-02-03 14:51:03',1,'2020-02-03 14:54:22',1),(382,4,1,1,'2020-02-03 14:54:22',NULL,NULL,0),(383,4,1,NULL,'2020-02-03 15:10:30',1,'2020-02-03 15:12:58',1),(384,4,1,NULL,'2020-02-03 15:10:30',1,'2020-02-03 16:20:08',1),(385,4,1,NULL,'2020-02-03 15:10:30',1,'2020-02-03 16:18:38',1),(383,4,1,1,'2020-02-03 15:12:58',NULL,NULL,0),(385,4,1,1,'2020-02-03 16:18:38',NULL,NULL,0),(384,4,1,1,'2020-02-03 16:20:08',NULL,NULL,0),(386,4,1,NULL,'2020-02-03 16:59:06',1,'2020-02-03 17:04:34',1),(387,4,1,NULL,'2020-02-03 16:59:06',1,'2020-02-03 17:02:27',1),(387,4,1,1,'2020-02-03 17:02:27',NULL,NULL,0),(386,4,1,1,'2020-02-03 17:04:34',NULL,NULL,0),(388,4,1,1,'2020-02-03 17:13:13',NULL,NULL,0),(389,19,1,NULL,'2020-02-04 09:58:31',NULL,NULL,0),(390,19,1,NULL,'2020-02-04 10:03:22',1,'2020-02-04 10:03:48',1),(390,19,1,1,'2020-02-04 10:03:48',NULL,NULL,0),(391,19,1,1,'2020-02-04 10:05:46',NULL,NULL,0),(392,19,1,NULL,'2020-02-04 10:14:29',1,'2020-02-04 10:15:27',1),(392,19,1,1,'2020-02-04 10:15:27',NULL,NULL,0),(393,19,1,1,'2020-02-04 10:17:52',NULL,NULL,0),(394,19,1,NULL,'2020-02-04 10:18:16',1,'2020-02-04 10:19:49',1),(394,19,1,1,'2020-02-04 10:19:49',NULL,NULL,0),(395,19,1,1,'2020-02-04 10:21:51',NULL,NULL,0),(396,19,1,NULL,'2020-02-04 10:27:02',1,'2020-02-04 10:30:21',1),(397,19,1,NULL,'2020-02-04 10:27:47',1,'2020-02-04 10:31:53',1),(398,19,1,NULL,'2020-02-04 10:28:04',NULL,NULL,0),(399,19,1,NULL,'2020-02-04 10:28:16',NULL,NULL,0),(400,19,1,NULL,'2020-02-04 10:28:36',NULL,NULL,0),(401,19,1,NULL,'2020-02-04 10:29:42',1,'2020-02-04 10:32:33',1),(396,19,1,1,'2020-02-04 10:30:21',NULL,NULL,0),(397,19,1,1,'2020-02-04 10:31:53',NULL,NULL,0),(401,19,1,1,'2020-02-04 10:32:33',NULL,NULL,0),(402,19,1,NULL,'2020-02-04 10:51:02',NULL,NULL,0),(403,19,1,NULL,'2020-02-04 10:51:45',NULL,NULL,0),(404,19,1,NULL,'2020-02-04 10:52:02',NULL,NULL,0),(405,19,1,NULL,'2020-02-04 10:52:32',NULL,NULL,0),(406,19,1,NULL,'2020-02-04 10:52:42',NULL,NULL,0),(407,19,1,NULL,'2020-02-04 10:52:49',NULL,NULL,0),(408,19,1,NULL,'2020-02-04 10:53:05',NULL,NULL,0),(409,19,1,NULL,'2020-02-04 10:53:48',1,'2020-02-04 10:54:21',1),(409,19,1,1,'2020-02-04 10:54:21',NULL,NULL,0),(410,19,1,NULL,'2020-02-04 10:57:15',1,'2020-02-17 10:02:57',1),(411,19,1,NULL,'2020-02-04 10:58:38',1,'2020-02-04 10:59:06',1),(411,19,1,1,'2020-02-04 10:59:06',NULL,NULL,0),(412,106,3,NULL,'2020-02-04 15:09:59',NULL,NULL,0),(413,106,3,NULL,'2020-02-04 15:10:18',1,'2020-03-02 14:08:50',1),(413,106,3,1,'2020-02-04 15:11:11',1,'2020-03-02 14:08:50',1),(414,106,3,NULL,'2020-02-04 15:12:03',1,'2020-03-02 14:08:52',1),(414,106,3,1,'2020-02-04 15:12:29',1,'2020-03-02 14:08:52',1),(415,19,3,NULL,'2020-02-05 09:42:37',1,'2020-02-05 14:50:50',1),(416,4,1,NULL,'2020-02-05 12:30:14',NULL,NULL,0),(417,4,1,NULL,'2020-02-05 14:29:58',NULL,NULL,0),(418,19,3,NULL,'2020-02-05 14:47:29',1,'2020-02-05 14:48:08',1),(418,19,3,1,'2020-02-05 14:48:08',NULL,NULL,0),(419,19,3,NULL,'2020-02-05 14:49:34',1,'2020-02-05 14:49:44',1),(419,19,3,1,'2020-02-05 14:49:44',NULL,NULL,0),(420,19,3,NULL,'2020-02-05 14:50:20',1,'2020-02-05 14:50:31',1),(420,19,3,1,'2020-02-05 14:50:31',NULL,NULL,0),(415,19,3,1,'2020-02-05 14:50:50',NULL,NULL,0),(421,19,3,1,'2020-02-05 14:52:01',NULL,NULL,0),(422,4,1,NULL,'2020-02-05 14:52:49',NULL,NULL,0),(423,4,1,NULL,'2020-02-05 15:14:45',NULL,NULL,0),(424,4,1,NULL,'2020-02-05 15:24:58',NULL,NULL,0),(425,4,1,NULL,'2020-02-05 15:28:54',NULL,NULL,0),(426,4,1,NULL,'2020-02-05 15:35:20',NULL,NULL,0),(427,4,1,NULL,'2020-02-05 15:35:56',NULL,NULL,0),(428,4,1,NULL,'2020-02-05 15:44:06',NULL,NULL,0),(429,4,1,NULL,'2020-02-05 15:56:38',NULL,NULL,0),(430,4,1,NULL,'2020-02-05 16:01:16',NULL,NULL,0),(431,4,1,NULL,'2020-02-05 16:02:51',NULL,NULL,0),(432,4,1,NULL,'2020-02-05 16:56:56',1,'2020-02-05 16:59:07',1),(432,4,1,1,'2020-02-05 16:59:07',NULL,NULL,0),(433,4,1,NULL,'2020-02-05 16:59:43',NULL,NULL,0),(434,4,1,NULL,'2020-02-05 17:02:29',NULL,NULL,0),(435,1,3,1,'2020-02-12 12:36:01',NULL,NULL,0),(435,108,1,1,'2020-02-12 12:36:01',NULL,NULL,0),(436,4,1,NULL,'2020-02-12 15:39:07',NULL,NULL,0),(437,4,1,NULL,'2020-02-13 11:12:42',NULL,NULL,0),(438,4,1,NULL,'2020-02-17 09:22:47',1,'2020-02-17 09:24:05',1),(438,4,1,1,'2020-02-17 09:24:05',NULL,NULL,0),(439,4,1,1,'2020-02-17 10:33:47',NULL,NULL,0),(440,3,1,NULL,'2020-02-17 10:57:27',1,'2020-02-17 11:01:21',1),(440,3,1,1,'2020-02-17 11:01:21',NULL,NULL,0),(441,3,1,NULL,'2020-02-17 11:06:01',1,'2020-02-17 14:13:08',1),(442,3,1,NULL,'2020-02-17 11:07:57',NULL,NULL,0),(443,3,1,NULL,'2020-02-17 11:12:09',NULL,NULL,0),(444,3,1,NULL,'2020-02-17 11:12:09',NULL,NULL,0),(445,3,1,NULL,'2020-02-17 11:12:09',NULL,NULL,0),(446,4,3,NULL,'2020-02-17 11:40:00',NULL,NULL,0),(447,4,3,NULL,'2020-02-17 11:40:18',NULL,NULL,0),(448,4,3,NULL,'2020-02-17 11:40:52',NULL,NULL,0),(441,3,1,1,'2020-02-17 14:13:09',NULL,NULL,0),(449,3,1,1,'2020-02-17 14:49:04',1,'2020-02-17 14:49:29',1),(449,3,1,1,'2020-02-17 14:49:29',NULL,NULL,0),(450,4,1,NULL,'2020-02-17 16:02:10',NULL,NULL,0),(451,25,3,1,'2020-02-17 18:48:57',1,'2020-02-17 18:49:39',1),(451,25,3,1,'2020-02-17 18:49:39',NULL,NULL,0),(452,3,1,1,'2020-02-19 09:16:33',NULL,NULL,0),(453,3,1,NULL,'2020-02-19 09:18:40',1,'2020-02-19 09:23:16',1),(453,3,1,1,'2020-02-19 09:23:16',NULL,NULL,0),(454,4,1,1,'2020-02-21 09:35:33',NULL,NULL,0),(455,90,3,1,'2020-02-21 11:14:42',1,'2020-02-21 11:15:29',1),(455,90,3,1,'2020-02-21 11:15:29',NULL,NULL,0),(456,90,3,1,'2020-02-21 11:18:29',NULL,NULL,0),(457,66,1,1,'2020-02-21 11:28:59',NULL,NULL,0),(458,66,1,1,'2020-02-21 11:34:02',NULL,NULL,0),(459,66,1,1,'2020-02-21 11:47:39',NULL,NULL,0),(460,1,3,1,'2020-02-26 15:03:52',NULL,NULL,0),(461,4,1,NULL,'2020-02-28 08:49:33',1,'2020-02-28 08:50:38',1),(461,4,1,1,'2020-02-28 08:50:38',NULL,NULL,0),(462,109,8,1,'2020-02-28 10:37:52',NULL,NULL,0),(463,109,8,1,'2020-02-28 10:42:06',NULL,NULL,0),(464,4,1,NULL,'2020-02-28 10:43:08',1,'2020-02-28 10:43:48',1),(465,109,8,1,'2020-02-28 10:43:44',NULL,NULL,0),(464,4,1,1,'2020-02-28 10:43:48',NULL,NULL,0),(466,19,3,NULL,'2020-02-28 10:49:03',NULL,NULL,0),(467,19,3,NULL,'2020-02-28 10:49:19',NULL,NULL,0),(468,19,3,NULL,'2020-02-28 10:50:24',NULL,NULL,0),(469,4,1,NULL,'2020-02-28 10:51:07',1,'2020-02-28 10:52:12',1),(470,19,3,NULL,'2020-02-28 10:51:11',NULL,NULL,0),(469,4,1,1,'2020-02-28 10:52:12',NULL,NULL,0),(471,19,3,NULL,'2020-02-28 11:01:32',1,'2020-02-28 11:07:16',1),(472,19,3,NULL,'2020-02-28 11:01:32',NULL,NULL,0),(473,19,3,NULL,'2020-02-28 11:01:32',NULL,NULL,0),(474,19,3,NULL,'2020-02-28 11:05:34',NULL,NULL,0),(475,19,3,NULL,'2020-02-28 11:05:50',1,'2020-02-28 11:10:22',1),(471,19,3,1,'2020-02-28 11:07:16',NULL,NULL,0),(475,19,3,1,'2020-02-28 11:10:22',NULL,NULL,0),(476,120,9,1,'2020-02-28 11:17:21',1,'2020-02-28 11:17:50',1),(476,120,9,1,'2020-02-28 11:17:50',NULL,NULL,0),(477,19,3,NULL,'2020-02-28 11:43:53',1,'2020-02-28 11:48:07',1),(478,19,3,1,'2020-02-28 11:46:12',NULL,NULL,0),(479,19,3,1,'2020-02-28 11:47:19',NULL,NULL,0),(477,19,3,1,'2020-02-28 11:48:07',NULL,NULL,0),(480,19,3,1,'2020-02-28 11:49:46',NULL,NULL,0),(481,4,1,1,'2020-02-28 12:02:46',NULL,NULL,0),(482,4,1,NULL,'2020-02-28 12:19:54',NULL,NULL,0),(483,109,8,1,'2020-02-28 16:32:03',1,'2020-02-28 16:34:15',1),(483,109,8,1,'2020-02-28 16:33:06',1,'2020-02-28 16:34:15',1),(483,109,8,1,'2020-02-28 16:34:15',NULL,NULL,0),(484,109,8,1,'2020-02-28 16:37:21',1,'2020-02-28 16:38:03',1),(484,109,8,1,'2020-02-28 16:38:03',NULL,NULL,0),(485,4,1,NULL,'2020-02-28 17:30:49',NULL,NULL,0),(486,4,1,NULL,'2020-02-28 17:31:19',NULL,NULL,0),(487,1,3,1,'2020-03-02 14:11:48',NULL,NULL,0),(488,1,3,1,'2020-03-02 14:13:03',NULL,NULL,0),(489,1,3,1,'2020-03-02 14:15:41',1,'2020-03-02 14:16:23',1),(489,1,3,1,'2020-03-02 14:16:23',NULL,NULL,0),(490,127,5,NULL,'2020-03-03 10:44:26',NULL,NULL,0),(491,127,5,1,'2020-03-03 10:50:14',NULL,NULL,0),(492,127,5,NULL,'2020-03-03 10:52:58',1,'2020-03-03 10:53:29',1),(492,127,5,1,'2020-03-03 10:53:29',NULL,NULL,0),(493,1,3,1,'2020-03-03 10:56:51',NULL,NULL,0),(494,1,5,1,'2020-03-03 10:58:37',NULL,NULL,0),(495,1,5,1,'2020-03-03 11:01:46',NULL,NULL,0),(496,127,5,NULL,'2020-03-03 12:10:46',NULL,NULL,0),(497,127,5,NULL,'2020-03-03 12:11:15',NULL,NULL,0),(498,127,5,NULL,'2020-03-03 13:58:01',1,'2020-03-03 14:02:40',1),(498,127,5,1,'2020-03-03 14:02:40',NULL,NULL,0),(499,127,5,NULL,'2020-03-03 14:03:01',NULL,NULL,0),(500,127,5,NULL,'2020-03-03 14:05:28',NULL,NULL,0),(501,127,5,NULL,'2020-03-03 14:05:52',NULL,NULL,0),(502,127,5,NULL,'2020-03-03 14:23:58',NULL,NULL,0),(503,127,5,NULL,'2020-03-03 14:25:24',NULL,NULL,0),(504,127,5,NULL,'2020-03-03 14:25:33',NULL,NULL,0),(505,127,5,NULL,'2020-03-03 14:36:56',NULL,NULL,0),(506,127,5,NULL,'2020-03-03 14:39:55',NULL,NULL,0),(507,133,5,NULL,'2020-03-03 14:46:49',1,'2020-03-03 14:47:35',1),(507,133,5,1,'2020-03-03 14:47:26',1,'2020-03-03 14:47:35',1),(507,133,5,1,'2020-03-03 14:47:32',1,'2020-03-03 14:47:35',1),(507,133,5,1,'2020-03-03 14:47:35',NULL,NULL,0),(508,4,1,NULL,'2020-03-03 16:24:10',NULL,NULL,0),(509,4,1,NULL,'2020-03-03 16:24:48',NULL,NULL,0),(510,4,1,NULL,'2020-03-03 16:25:44',NULL,NULL,0),(511,4,1,NULL,'2020-03-03 16:29:41',NULL,NULL,0),(512,4,1,NULL,'2020-03-03 16:34:38',NULL,NULL,0),(513,4,1,NULL,'2020-03-03 16:35:29',NULL,NULL,0),(514,4,1,NULL,'2020-03-03 16:37:14',NULL,NULL,0),(515,4,1,NULL,'2020-03-03 16:48:53',NULL,NULL,0),(516,4,1,NULL,'2020-03-03 16:49:28',NULL,NULL,0),(517,4,1,NULL,'2020-03-03 16:50:04',NULL,NULL,0),(518,127,5,NULL,'2020-03-03 16:53:05',NULL,NULL,0),(519,4,1,NULL,'2020-03-03 17:03:00',NULL,NULL,0),(520,4,1,NULL,'2020-03-03 17:06:29',NULL,NULL,0),(521,4,1,NULL,'2020-03-03 17:06:55',NULL,NULL,0),(522,4,1,NULL,'2020-03-03 17:07:33',NULL,NULL,0),(523,4,1,NULL,'2020-03-03 17:11:57',NULL,NULL,0),(524,4,1,NULL,'2020-03-03 17:13:41',NULL,NULL,0),(525,4,1,NULL,'2020-03-03 17:15:53',NULL,NULL,0),(526,4,1,NULL,'2020-03-03 17:16:40',NULL,NULL,0),(527,4,1,NULL,'2020-03-03 17:17:41',NULL,NULL,0),(528,1,3,NULL,'2020-03-03 17:21:47',NULL,NULL,0),(529,1,3,NULL,'2020-03-03 17:21:58',NULL,NULL,0),(530,1,3,NULL,'2020-03-03 17:22:29',NULL,NULL,0),(531,4,1,NULL,'2020-03-03 17:23:30',NULL,NULL,0),(532,4,1,NULL,'2020-03-03 17:26:20',NULL,NULL,0),(533,4,1,NULL,'2020-03-03 17:31:57',NULL,NULL,0),(534,4,1,NULL,'2020-03-03 17:32:54',NULL,NULL,0),(535,4,1,NULL,'2020-03-03 17:36:53',NULL,NULL,0),(536,4,1,NULL,'2020-03-03 17:40:30',NULL,NULL,0),(537,4,1,NULL,'2020-03-03 17:41:35',NULL,NULL,0),(538,4,1,NULL,'2020-03-03 17:49:52',NULL,NULL,0),(539,4,1,NULL,'2020-03-03 17:59:32',NULL,NULL,0),(540,4,1,NULL,'2020-03-03 18:10:41',NULL,NULL,0),(541,4,1,NULL,'2020-03-03 18:15:19',NULL,NULL,0),(542,127,5,NULL,'2020-03-03 18:38:08',NULL,NULL,0),(543,127,5,NULL,'2020-03-03 18:38:32',NULL,NULL,0),(544,4,1,NULL,'2020-03-03 18:40:31',NULL,NULL,0),(545,4,1,NULL,'2020-03-03 18:51:44',NULL,NULL,0),(546,4,1,NULL,'2020-03-04 08:24:07',NULL,NULL,0),(547,4,1,NULL,'2020-03-04 09:05:43',NULL,NULL,0),(548,4,1,NULL,'2020-03-04 09:11:29',NULL,NULL,0),(549,4,1,NULL,'2020-03-04 09:20:32',1,'2020-03-04 09:28:31',1),(550,4,1,NULL,'2020-03-04 09:26:21',NULL,NULL,0),(549,4,1,1,'2020-03-04 09:28:31',NULL,NULL,0),(551,4,1,NULL,'2020-03-04 09:58:19',NULL,NULL,0),(552,4,1,1,'2020-03-04 10:05:53',NULL,NULL,0),(553,4,1,NULL,'2020-03-04 10:20:18',NULL,NULL,0),(554,4,1,1,'2020-03-04 10:28:00',NULL,NULL,0),(555,4,1,NULL,'2020-03-04 10:37:13',NULL,NULL,0),(556,4,1,NULL,'2020-03-04 10:41:23',NULL,NULL,0),(557,4,1,NULL,'2020-03-04 10:44:06',NULL,NULL,0),(558,4,1,NULL,'2020-03-04 10:53:34',NULL,NULL,0),(559,4,1,NULL,'2020-03-04 11:00:16',NULL,NULL,0),(560,4,1,NULL,'2020-03-04 11:02:57',NULL,NULL,0),(561,4,1,NULL,'2020-03-04 11:05:38',NULL,NULL,0),(562,4,1,NULL,'2020-03-04 11:26:44',NULL,NULL,0),(563,4,1,NULL,'2020-03-05 09:22:30',NULL,NULL,0),(564,4,1,NULL,'2020-03-05 09:24:13',NULL,NULL,0),(565,4,1,NULL,'2020-03-05 09:26:19',NULL,NULL,0),(566,4,1,NULL,'2020-03-05 09:26:54',NULL,NULL,0),(567,4,1,NULL,'2020-03-05 09:28:27',NULL,NULL,0),(568,4,1,NULL,'2020-03-05 09:30:58',NULL,NULL,0),(569,4,1,NULL,'2020-03-05 09:32:48',NULL,NULL,0),(570,4,1,NULL,'2020-03-05 10:03:46',NULL,NULL,0),(571,4,1,NULL,'2020-03-05 10:50:21',NULL,NULL,0),(572,4,1,NULL,'2020-03-05 10:50:58',NULL,NULL,0),(573,4,1,NULL,'2020-03-05 10:51:24',NULL,NULL,0),(574,4,1,NULL,'2020-03-05 10:51:46',NULL,NULL,0),(575,1,3,NULL,'2020-03-05 16:14:18',NULL,NULL,0),(576,1,3,NULL,'2020-03-05 16:14:27',NULL,NULL,0),(577,1,3,NULL,'2020-03-05 16:15:42',NULL,NULL,0),(578,4,1,NULL,'2020-03-10 10:27:44',NULL,NULL,0),(579,25,3,1,'2020-03-10 15:43:26',1,'2020-03-10 15:43:56',1),(579,25,3,1,'2020-03-10 15:43:56',NULL,NULL,0),(580,3,1,1,'2020-03-16 10:45:08',1,'2020-03-16 10:45:37',1),(580,3,1,1,'2020-03-16 10:45:37',NULL,NULL,0),(581,3,1,1,'2020-03-16 11:00:30',NULL,NULL,0),(582,3,3,1,'2020-03-16 12:19:39',NULL,NULL,0),(583,3,1,1,'2020-03-16 12:22:00',NULL,NULL,0),(584,3,1,1,'2020-03-16 12:23:11',NULL,NULL,0),(585,3,1,1,'2020-03-16 12:24:09',NULL,NULL,0),(586,4,1,NULL,'2020-03-16 18:02:40',NULL,NULL,0),(587,3,3,1,'2020-03-17 10:35:20',NULL,NULL,0),(588,3,3,1,'2020-03-17 10:40:21',NULL,NULL,0),(589,3,1,1,'2020-03-17 10:41:01',NULL,NULL,0),(590,3,3,1,'2020-03-17 10:43:53',NULL,NULL,0),(591,3,1,1,'2020-03-17 10:44:25',NULL,NULL,0),(592,3,3,1,'2020-03-17 10:46:27',NULL,NULL,0),(593,3,1,1,'2020-03-17 10:47:35',NULL,NULL,0),(594,3,1,1,'2020-03-17 10:48:46',NULL,NULL,0),(595,3,1,1,'2020-03-17 10:49:47',NULL,NULL,0),(596,3,1,NULL,'2020-03-17 10:51:01',1,'2020-03-17 10:54:42',1),(597,3,1,NULL,'2020-03-17 10:51:39',1,'2020-03-17 10:54:23',1),(598,3,1,NULL,'2020-03-17 10:52:06',1,'2020-03-17 10:53:47',1),(599,3,1,NULL,'2020-03-17 10:52:40',1,'2020-03-17 10:53:09',1),(599,3,1,1,'2020-03-17 10:53:01',1,'2020-03-17 10:53:09',1),(599,3,1,1,'2020-03-17 10:53:09',NULL,NULL,0),(598,3,1,1,'2020-03-17 10:53:47',NULL,NULL,0),(597,3,1,1,'2020-03-17 10:54:23',NULL,NULL,0),(596,3,1,1,'2020-03-17 10:54:42',NULL,NULL,0),(600,3,1,1,'2020-03-17 14:51:12',NULL,NULL,0),(601,3,1,1,'2020-03-17 14:51:43',NULL,NULL,0),(602,3,1,1,'2020-03-17 14:52:35',NULL,NULL,0),(603,3,1,1,'2020-03-17 14:55:08',NULL,NULL,0),(604,3,1,1,'2020-03-17 14:56:25',NULL,NULL,0),(605,3,1,1,'2020-03-17 15:00:11',NULL,NULL,0),(606,3,1,1,'2020-03-17 15:21:46',NULL,NULL,0),(607,3,1,1,'2020-03-17 15:27:03',NULL,NULL,0),(608,1,3,NULL,'2020-03-18 10:59:31',1,'2020-03-18 11:01:16',1),(609,1,3,1,'2020-03-18 11:00:36',NULL,NULL,0),(610,1,3,NULL,'2020-03-18 11:01:31',NULL,NULL,0),(611,4,1,NULL,'2020-03-19 09:13:00',NULL,NULL,0),(612,4,1,NULL,'2020-03-23 10:24:46',NULL,NULL,0),(613,4,1,NULL,'2020-03-23 11:33:47',NULL,NULL,0),(614,4,1,NULL,'2020-03-23 11:33:58',NULL,NULL,0),(615,4,1,NULL,'2020-03-24 09:30:21',NULL,NULL,0),(616,4,1,NULL,'2020-03-24 09:30:29',NULL,NULL,0),(617,4,1,NULL,'2020-03-24 15:49:29',NULL,NULL,0),(618,4,1,NULL,'2020-03-24 15:49:38',NULL,NULL,0),(619,4,1,NULL,'2020-03-24 15:49:49',NULL,NULL,0),(620,1,3,1,'2020-03-25 09:09:02',NULL,NULL,0),(620,114,5,1,'2020-03-25 09:09:02',NULL,NULL,0),(621,1,3,1,'2020-03-25 09:10:18',NULL,NULL,0),(621,114,5,1,'2020-03-25 09:10:18',NULL,NULL,0),(621,19,1,1,'2020-03-25 09:10:18',NULL,NULL,0),(622,4,1,NULL,'2020-04-02 10:45:57',1,'2020-04-02 11:01:45',1),(622,4,1,1,'2020-04-02 11:01:45',NULL,NULL,0),(623,4,1,NULL,'2020-04-02 11:09:01',1,'2020-04-02 11:09:55',1),(623,4,1,1,'2020-04-02 11:09:55',NULL,NULL,0),(624,4,1,NULL,'2020-04-02 13:44:11',1,'2020-04-02 13:45:32',1),(624,4,1,1,'2020-04-02 13:44:56',1,'2020-04-02 13:45:32',1),(624,4,1,1,'2020-04-02 13:45:32',NULL,NULL,0),(625,4,1,NULL,'2020-04-02 13:46:12',1,'2020-04-02 13:46:59',1),(625,4,1,1,'2020-04-02 13:46:59',NULL,NULL,0),(626,1,3,1,'2020-04-08 17:34:51',1,'2020-04-08 17:53:25',1),(626,1,3,1,'2020-04-08 17:53:25',NULL,NULL,0),(627,25,3,1,'2020-04-17 16:15:50',NULL,NULL,0),(628,108,1,1,'2020-04-20 10:46:02',1,'2020-04-20 10:47:10',1),(628,108,1,1,'2020-04-20 10:47:10',NULL,NULL,0),(629,155,11,1,'2020-04-20 11:32:47',1,'2020-04-20 11:33:59',1),(629,155,11,1,'2020-04-20 11:33:59',NULL,NULL,0),(630,155,11,1,'2020-04-20 11:36:45',NULL,NULL,0),(631,155,11,1,'2020-04-20 11:38:44',NULL,NULL,0),(632,4,1,NULL,'2020-04-22 09:28:29',NULL,NULL,0),(633,4,1,NULL,'2020-04-27 15:54:40',1,'2020-04-27 15:55:14',1),(633,4,1,1,'2020-04-27 15:55:14',NULL,NULL,0),(634,4,1,NULL,'2020-04-27 16:01:26',1,'2020-04-27 16:01:45',1),(634,4,1,1,'2020-04-27 16:01:45',NULL,NULL,0),(635,4,1,NULL,'2020-04-27 16:18:10',1,'2020-04-27 16:18:52',1),(635,4,1,1,'2020-04-27 16:18:52',NULL,NULL,0),(636,4,1,NULL,'2020-04-27 17:12:38',1,'2020-04-27 17:13:08',1),(636,4,1,1,'2020-04-27 17:13:08',NULL,NULL,0),(637,1,3,1,'2020-04-27 17:23:54',NULL,NULL,0),(638,1,5,1,'2020-04-27 17:24:28',NULL,NULL,0),(639,1,3,NULL,'2020-04-27 17:25:25',1,'2020-04-27 17:25:44',1),(639,1,3,1,'2020-04-27 17:25:44',NULL,NULL,0),(640,4,1,NULL,'2020-04-27 17:39:33',1,'2020-04-27 17:49:19',1),(640,4,1,1,'2020-04-27 17:49:19',NULL,NULL,0),(641,19,3,NULL,'2020-04-28 08:47:17',1,'2020-04-28 08:55:24',1),(642,19,3,NULL,'2020-04-28 08:47:25',1,'2020-04-28 08:56:39',1),(643,19,3,NULL,'2020-04-28 08:47:32',NULL,NULL,0),(644,19,3,NULL,'2020-04-28 08:47:38',1,'2020-04-28 08:54:47',1),(644,19,3,1,'2020-04-28 08:54:47',NULL,NULL,0),(641,19,3,1,'2020-04-28 08:55:24',NULL,NULL,0),(642,19,3,1,'2020-04-28 08:56:39',NULL,NULL,0),(645,19,3,NULL,'2020-04-28 08:56:58',1,'2020-04-28 08:57:07',1),(645,19,3,1,'2020-04-28 08:57:07',NULL,NULL,0),(646,19,3,NULL,'2020-04-28 08:57:53',1,'2020-04-28 08:58:28',1),(647,19,3,NULL,'2020-04-28 08:57:58',1,'2020-04-28 08:58:12',1),(647,19,3,1,'2020-04-28 08:58:12',NULL,NULL,0),(646,19,3,1,'2020-04-28 08:58:28',NULL,NULL,0),(648,19,3,NULL,'2020-04-28 08:59:02',1,'2020-04-28 09:00:28',1),(649,19,3,NULL,'2020-04-28 08:59:17',1,'2020-04-28 09:00:10',1),(649,19,3,1,'2020-04-28 09:00:10',NULL,NULL,0),(650,4,1,NULL,'2020-04-28 09:00:22',1,'2020-04-28 09:07:29',1),(648,19,3,1,'2020-04-28 09:00:28',NULL,NULL,0),(650,4,1,1,'2020-04-28 09:07:29',NULL,NULL,0),(651,25,3,1,'2020-04-28 09:10:41',NULL,NULL,0),(652,4,1,1,'2020-04-28 09:12:47',NULL,NULL,0),(653,3,1,1,'2020-04-28 09:14:12',NULL,NULL,0),(654,19,1,1,'2020-04-28 09:17:04',NULL,NULL,0),(655,19,3,1,'2020-04-28 09:23:47',NULL,NULL,0),(656,19,1,1,'2020-04-28 09:24:53',NULL,NULL,0),(657,3,1,1,'2020-04-28 09:25:43',NULL,NULL,0),(658,19,1,1,'2020-04-28 09:27:04',NULL,NULL,0),(659,19,1,1,'2020-04-28 09:29:04',NULL,NULL,0),(660,3,1,1,'2020-04-28 09:29:22',NULL,NULL,0),(661,3,1,1,'2020-04-28 09:31:33',NULL,NULL,0),(662,19,1,1,'2020-04-28 09:32:19',NULL,NULL,0),(663,4,1,1,'2020-04-28 09:35:24',NULL,NULL,0),(664,4,3,1,'2020-04-28 09:37:53',NULL,NULL,0),(665,3,1,1,'2020-04-28 10:24:15',NULL,NULL,0),(666,3,1,1,'2020-04-28 10:25:21',NULL,NULL,0),(667,3,1,1,'2020-04-28 10:28:57',NULL,NULL,0),(668,3,1,1,'2020-04-28 10:34:43',NULL,NULL,0),(669,3,1,1,'2020-04-28 11:11:48',NULL,NULL,0),(670,19,3,1,'2020-04-28 14:41:17',1,'2020-04-28 14:41:34',1),(670,19,3,1,'2020-04-28 14:41:34',NULL,NULL,0),(671,3,1,1,'2020-04-28 14:48:34',NULL,NULL,0),(672,3,3,1,'2020-04-28 15:31:03',NULL,NULL,0),(673,19,1,1,'2020-04-28 15:52:20',NULL,NULL,0),(674,19,3,1,'2020-04-28 15:54:26',1,'2020-04-28 15:54:47',1),(674,19,3,1,'2020-04-28 15:54:47',NULL,NULL,0),(675,19,1,NULL,'2020-04-28 15:56:48',1,'2020-04-28 15:57:10',1),(676,19,3,NULL,'2020-04-28 15:56:57',1,'2020-04-28 15:57:49',1),(675,19,1,1,'2020-04-28 15:57:10',NULL,NULL,0),(676,19,3,1,'2020-04-28 15:57:49',NULL,NULL,0),(677,12,1,1,'2020-04-29 08:28:13',NULL,NULL,0),(678,12,1,1,'2020-04-29 08:28:31',NULL,NULL,0),(679,143,3,1,'2020-04-29 08:29:53',NULL,NULL,0),(680,143,3,1,'2020-04-29 08:30:08',NULL,NULL,0),(681,143,3,1,'2020-04-29 08:30:47',NULL,NULL,0),(682,143,3,1,'2020-04-29 08:31:01',NULL,NULL,0),(683,12,1,1,'2020-04-29 08:43:06',NULL,NULL,0),(684,12,1,1,'2020-04-29 08:48:57',NULL,NULL,0),(685,12,1,1,'2020-04-29 08:50:31',NULL,NULL,0),(686,143,3,1,'2020-04-29 09:36:00',NULL,NULL,0),(687,143,3,1,'2020-04-29 09:36:16',NULL,NULL,0),(688,143,3,1,'2020-04-29 09:36:29',NULL,NULL,0),(689,143,3,1,'2020-04-29 09:36:45',NULL,NULL,0),(690,143,3,1,'2020-04-29 09:39:53',NULL,NULL,0),(691,143,3,1,'2020-04-29 09:40:07',NULL,NULL,0),(692,143,3,1,'2020-04-29 09:40:19',NULL,NULL,0),(693,143,3,1,'2020-04-29 09:40:32',NULL,NULL,0),(694,1,3,1,'2020-04-29 09:42:02',NULL,NULL,0),(695,1,3,1,'2020-04-29 09:42:14',NULL,NULL,0),(696,1,3,1,'2020-04-29 09:42:26',NULL,NULL,0),(697,1,3,1,'2020-04-29 09:42:37',NULL,NULL,0),(698,143,3,1,'2020-04-29 09:44:36',NULL,NULL,0),(699,3,1,NULL,'2020-04-29 11:27:19',1,'2020-04-29 18:24:30',1),(700,4,1,NULL,'2020-04-29 18:23:09',1,'2020-04-29 18:25:35',1),(701,4,1,NULL,'2020-04-29 18:23:26',1,'2020-04-29 18:24:06',1),(701,4,1,1,'2020-04-29 18:24:06',NULL,NULL,0),(699,3,1,1,'2020-04-29 18:24:30',NULL,NULL,0),(700,4,1,1,'2020-04-29 18:25:35',NULL,NULL,0),(702,3,1,1,'2020-04-29 19:22:46',NULL,NULL,0),(703,3,1,1,'2020-04-29 19:23:59',NULL,NULL,0),(704,4,1,NULL,'2020-04-30 08:46:08',1,'2020-04-30 08:47:27',1),(704,4,1,1,'2020-04-30 08:47:27',NULL,NULL,0),(705,3,1,1,'2020-04-30 10:33:27',NULL,NULL,0),(706,1,3,1,'2020-04-30 11:53:54',NULL,NULL,0),(707,19,1,1,'2020-05-11 17:56:42',NULL,NULL,0),(708,19,1,1,'2020-05-11 17:56:55',NULL,NULL,0),(709,19,1,1,'2020-05-11 17:57:47',NULL,NULL,0),(710,19,1,1,'2020-05-11 18:00:18',NULL,NULL,0),(711,19,1,1,'2020-05-11 18:00:25',NULL,NULL,0),(712,25,3,1,'2020-05-11 18:41:49',NULL,NULL,0),(713,19,1,1,'2020-05-12 19:32:37',1,'2020-05-12 19:32:40',1),(714,19,1,1,'2020-05-13 18:04:34',NULL,NULL,0),(715,19,1,1,'2020-05-13 18:24:54',1,'2020-05-13 18:27:26',1),(716,19,1,1,'2020-05-13 18:25:51',NULL,NULL,0),(715,19,1,1,'2020-05-13 18:27:26',NULL,NULL,0),(717,19,1,1,'2020-05-18 17:16:35',1,'2020-05-18 17:29:54',1),(717,19,1,1,'2020-05-18 17:29:54',NULL,NULL,0),(718,19,1,1,'2020-05-18 17:44:39',1,'2020-05-18 17:47:45',1),(718,19,1,1,'2020-05-18 17:47:45',NULL,NULL,0),(719,1,3,1,'2020-05-22 11:48:11',1,'2020-05-22 11:49:27',1),(719,1,3,1,'2020-05-22 11:49:27',NULL,NULL,0),(720,1,3,1,'2020-05-22 11:51:29',NULL,NULL,0),(721,1,3,1,'2020-05-22 11:54:49',1,'2020-05-22 11:55:39',1),(722,1,3,1,'2020-05-22 11:56:01',NULL,NULL,0),(723,12,1,1,'2020-05-26 13:18:09',NULL,NULL,0),(724,12,1,1,'2020-05-26 13:18:23',1,'2020-05-26 18:16:50',1),(724,12,1,1,'2020-05-26 14:02:45',1,'2020-05-26 18:16:50',1),(724,12,1,1,'2020-05-26 18:16:50',NULL,NULL,0),(725,4,1,1,'2020-05-28 13:50:38',1,'2020-05-28 19:16:39',1),(725,4,1,1,'2020-05-28 18:43:28',1,'2020-05-28 19:16:39',1),(725,4,1,1,'2020-05-28 18:51:24',1,'2020-05-28 19:16:39',1),(725,4,1,1,'2020-05-28 19:16:39',NULL,NULL,0),(726,19,1,1,'2020-05-29 12:59:01',1,'2020-05-29 12:59:16',1),(726,19,1,1,'2020-05-29 12:59:16',NULL,NULL,0),(727,4,1,NULL,'2020-06-04 16:51:35',NULL,NULL,0),(728,19,1,1,'2020-06-05 14:35:01',1,'2020-06-05 14:35:26',1),(728,19,1,1,'2020-06-05 14:35:26',NULL,NULL,0),(729,19,1,1,'2020-06-05 14:36:25',NULL,NULL,0),(730,19,1,1,'2020-06-05 14:37:02',NULL,NULL,0),(731,25,3,1,'2020-06-05 19:42:10',1,'2020-06-05 16:51:35',1),(731,25,3,1,'2020-06-05 19:42:26',1,'2020-06-05 16:51:35',1),(732,25,3,1,'2020-06-05 16:50:33',1,'2020-06-05 16:50:51',1),(732,25,3,1,'2020-06-05 16:50:51',NULL,NULL,0),(731,25,3,1,'2020-06-05 16:51:35',NULL,NULL,0),(733,1,3,1,'2020-06-05 16:52:55',NULL,NULL,0),(734,175,1,NULL,'2020-06-08 10:42:59',1,'2020-06-08 10:44:46',1),(734,175,1,1,'2020-06-08 10:44:46',NULL,NULL,0),(735,1,3,NULL,'2020-06-08 10:49:28',NULL,NULL,0),(736,4,1,1,'2020-06-08 15:39:42',NULL,NULL,0),(737,19,1,1,'2020-06-09 15:37:45',NULL,NULL,0),(738,1,3,NULL,'2020-06-09 15:39:08',1,'2020-06-09 16:02:11',1),(739,1,3,NULL,'2020-06-09 15:39:57',NULL,NULL,0),(740,1,3,NULL,'2020-06-09 15:40:13',1,'2020-06-09 16:00:57',1),(741,1,3,NULL,'2020-06-09 15:40:27',NULL,NULL,0),(742,1,3,NULL,'2020-06-09 15:41:44',1,'2020-06-09 15:53:58',1),(743,1,3,NULL,'2020-06-09 15:42:16',1,'2020-06-09 15:44:58',1),(743,1,3,1,'2020-06-09 15:44:09',1,'2020-06-09 15:44:58',1),(743,1,3,1,'2020-06-09 15:44:30',1,'2020-06-09 15:44:58',1),(743,1,3,1,'2020-06-09 15:44:58',NULL,NULL,0),(742,1,3,1,'2020-06-09 15:53:45',1,'2020-06-09 15:53:58',1),(742,1,3,1,'2020-06-09 15:53:58',NULL,NULL,0),(740,1,3,1,'2020-06-09 16:00:57',NULL,NULL,0),(738,1,3,1,'2020-06-09 16:01:39',1,'2020-06-09 16:02:11',1),(738,1,3,1,'2020-06-09 16:01:52',1,'2020-06-09 16:02:11',1),(738,1,3,1,'2020-06-09 16:02:11',NULL,NULL,0),(744,1,3,NULL,'2020-06-09 16:03:33',NULL,NULL,0),(745,1,3,NULL,'2020-06-09 16:05:05',1,'2020-06-09 16:05:55',1),(745,1,3,1,'2020-06-09 16:05:42',1,'2020-06-09 16:05:55',1),(745,1,3,1,'2020-06-09 16:05:50',1,'2020-06-09 16:05:55',1),(745,1,3,1,'2020-06-09 16:05:55',NULL,NULL,0),(746,1,3,NULL,'2020-06-09 16:07:04',NULL,NULL,0),(747,1,3,NULL,'2020-06-09 16:07:13',NULL,NULL,0),(748,1,3,NULL,'2020-06-09 16:07:21',NULL,NULL,0),(749,1,3,NULL,'2020-06-09 16:07:35',NULL,NULL,0),(750,4,1,NULL,'2020-06-09 16:10:01',NULL,NULL,0),(751,4,1,NULL,'2020-06-09 16:27:49',1,'2020-06-09 16:28:50',1),(751,4,1,1,'2020-06-09 16:28:50',NULL,NULL,0),(752,4,1,NULL,'2020-06-09 16:30:25',NULL,NULL,0),(753,25,3,1,'2020-06-09 16:41:59',1,'2020-06-09 16:42:11',1),(753,25,3,1,'2020-06-09 16:42:11',NULL,NULL,0),(754,25,3,NULL,'2020-06-09 17:52:18',1,'2020-06-09 17:58:55',1),(754,25,3,1,'2020-06-09 17:58:55',NULL,NULL,0),(755,4,1,NULL,'2020-06-10 12:26:06',NULL,NULL,0),(756,4,1,NULL,'2020-06-10 16:49:46',NULL,NULL,0),(757,4,1,NULL,'2020-06-10 16:49:47',NULL,NULL,0),(758,4,1,NULL,'2020-06-10 16:49:47',NULL,NULL,0),(759,4,1,NULL,'2020-06-10 17:00:11',NULL,NULL,0),(760,4,1,NULL,'2020-06-10 17:00:11',NULL,NULL,0),(761,19,1,1,'2020-06-15 16:05:42',NULL,NULL,0),(762,19,1,1,'2020-06-15 16:06:47',NULL,NULL,0),(763,4,1,NULL,'2020-06-15 16:41:54',NULL,NULL,0),(764,4,1,NULL,'2020-06-15 17:48:39',NULL,NULL,0),(765,4,1,NULL,'2020-06-16 09:02:11',NULL,NULL,0),(766,4,1,1,'2020-06-16 14:11:46',NULL,NULL,0),(767,4,1,1,'2020-06-16 14:13:25',1,'2020-06-16 14:13:55',1),(767,4,1,1,'2020-06-16 14:13:55',NULL,NULL,0),(768,4,1,NULL,'2020-06-16 14:14:53',1,'2020-06-16 14:19:14',1),(769,4,1,NULL,'2020-06-16 14:18:26',1,'2020-06-16 14:45:42',1),(768,4,1,1,'2020-06-16 14:19:14',NULL,NULL,0),(770,1,3,1,'2020-06-16 14:23:17',NULL,NULL,0),(771,1,3,1,'2020-06-16 14:25:03',NULL,NULL,0),(772,4,1,1,'2020-06-16 14:34:44',NULL,NULL,0),(773,1,3,1,'2020-06-16 14:44:32',NULL,NULL,0),(769,4,1,1,'2020-06-16 14:45:42',NULL,NULL,0),(774,1,3,1,'2020-06-16 14:46:47',NULL,NULL,0),(775,1,3,1,'2020-06-16 14:49:45',NULL,NULL,0),(776,25,3,1,'2020-06-17 16:47:09',1,'2020-06-17 17:10:04',1),(776,1,5,1,'2020-06-17 17:10:04',NULL,NULL,0),(776,25,3,1,'2020-06-17 17:10:04',NULL,NULL,0),(777,175,1,1,'2020-06-18 17:50:07',1,'2020-06-18 17:50:15',1),(778,4,1,NULL,'2020-06-19 11:36:06',NULL,NULL,0),(779,4,1,NULL,'2020-06-19 11:36:06',NULL,NULL,0),(780,4,1,NULL,'2020-06-19 15:56:43',NULL,NULL,0),(781,4,1,NULL,'2020-06-19 16:36:41',NULL,NULL,0),(782,4,9,NULL,'2020-06-19 17:47:54',NULL,NULL,0),(783,4,1,NULL,'2020-06-22 11:47:15',NULL,NULL,0),(784,4,1,NULL,'2020-06-22 14:28:39',NULL,NULL,0),(785,4,1,NULL,'2020-06-22 15:50:28',NULL,NULL,0),(786,25,3,1,'2020-06-22 17:02:05',1,'2020-06-22 17:03:53',1),(786,25,3,1,'2020-06-22 17:02:21',1,'2020-06-22 17:03:53',1),(786,6,2,1,'2020-06-22 17:03:53',NULL,NULL,0),(786,25,3,1,'2020-06-22 17:03:53',NULL,NULL,0),(787,25,3,1,'2020-06-22 17:04:23',1,'2020-06-22 17:06:52',1),(787,6,2,1,'2020-06-22 17:04:23',1,'2020-06-22 17:06:52',1),(787,6,2,1,'2020-06-22 17:06:52',NULL,NULL,0),(787,25,3,1,'2020-06-22 17:06:52',NULL,NULL,0),(788,4,1,NULL,'2020-06-23 10:02:25',NULL,NULL,0),(789,4,1,NULL,'2020-06-23 10:02:26',NULL,NULL,0),(790,4,1,NULL,'2020-06-23 10:02:26',NULL,NULL,0),(791,25,3,1,'2020-06-23 15:15:42',1,'2020-06-23 15:15:52',1),(791,25,3,1,'2020-06-23 15:15:52',NULL,NULL,0),(792,4,1,NULL,'2020-06-23 17:29:25',NULL,NULL,0),(793,4,1,NULL,'2020-06-24 08:32:47',NULL,NULL,0),(794,4,1,NULL,'2020-06-24 08:32:47',NULL,NULL,0),(795,4,1,NULL,'2020-06-24 08:32:47',NULL,NULL,0),(796,4,1,NULL,'2020-06-24 08:32:47',NULL,NULL,0),(797,4,1,NULL,'2020-06-24 13:58:10',NULL,NULL,0),(798,4,1,NULL,'2020-06-24 13:58:10',NULL,NULL,0),(799,3,3,1,'2020-06-26 17:18:25',NULL,NULL,0),(800,3,3,1,'2020-06-26 17:22:25',NULL,NULL,0),(801,3,1,1,'2020-06-26 17:28:15',NULL,NULL,0),(802,3,1,1,'2020-06-26 17:38:07',NULL,NULL,0),(803,1,3,1,'2020-06-26 17:41:37',NULL,NULL,0),(804,3,1,1,'2020-06-26 17:42:20',NULL,NULL,0),(805,3,1,1,'2020-06-26 17:56:32',NULL,NULL,0),(806,25,3,NULL,'2020-06-29 17:19:54',1,'2020-06-29 17:48:19',1),(806,25,3,1,'2020-06-29 17:36:15',1,'2020-06-29 17:48:19',1),(807,25,3,NULL,'2020-06-29 17:51:21',1,'2020-06-29 17:53:03',1),(808,25,3,NULL,'2020-06-29 17:56:18',1,'2020-06-29 18:19:51',1),(809,1,3,1,'2020-06-29 17:58:17',1,'2020-06-29 17:59:50',1),(810,1,3,1,'2020-06-29 18:05:06',1,'2020-06-29 18:08:54',1),(810,1,3,1,'2020-06-29 18:06:46',1,'2020-06-29 18:08:54',1),(810,1,3,1,'2020-06-29 18:07:05',1,'2020-06-29 18:08:54',1),(810,1,3,1,'2020-06-29 18:08:28',1,'2020-06-29 18:08:54',1),(810,1,3,1,'2020-06-29 18:08:44',1,'2020-06-29 18:08:54',1),(810,1,3,1,'2020-06-29 18:08:49',1,'2020-06-29 18:08:54',1),(810,1,3,1,'2020-06-29 18:08:54',NULL,NULL,0),(811,138,3,1,'2020-06-29 18:12:27',NULL,NULL,0),(812,1,3,1,'2020-06-29 18:16:53',NULL,NULL,0),(813,1,3,1,'2020-06-29 18:17:05',1,'2020-06-29 18:18:29',1),(814,1,3,1,'2020-06-29 18:17:15',1,'2020-06-29 18:21:57',1),(813,1,3,1,'2020-06-29 18:18:29',NULL,NULL,0),(814,1,3,1,'2020-06-29 18:18:56',1,'2020-06-29 18:21:57',1),(814,1,3,1,'2020-06-29 18:19:10',1,'2020-06-29 18:21:57',1),(814,1,3,1,'2020-06-29 18:19:16',1,'2020-06-29 18:21:57',1),(808,25,3,1,'2020-06-29 18:19:39',1,'2020-06-29 18:19:51',1),(808,25,3,1,'2020-06-29 18:19:51',NULL,NULL,0),(814,1,3,1,'2020-06-29 18:21:47',1,'2020-06-29 18:21:57',1),(814,1,3,1,'2020-06-29 18:21:57',NULL,NULL,0),(815,114,8,1,'2020-06-29 18:23:02',NULL,NULL,0),(816,1,3,1,'2020-06-30 16:16:05',1,'2020-06-30 16:16:55',1),(816,114,8,1,'2020-06-30 16:16:05',1,'2020-06-30 16:16:55',1),(816,114,8,1,'2020-06-30 16:16:55',NULL,NULL,0),(816,1,3,1,'2020-06-30 16:16:55',NULL,NULL,0),(817,25,3,1,'2020-06-30 17:17:05',1,'2020-06-30 17:36:08',1),(818,25,3,1,'2020-06-30 17:17:17',1,'2020-06-30 17:32:09',1),(819,25,3,1,'2020-06-30 17:17:32',1,'2020-06-30 17:26:21',1),(820,25,3,1,'2020-06-30 17:18:55',1,'2020-06-30 17:24:30',1),(820,25,3,1,'2020-06-30 17:23:03',1,'2020-06-30 17:24:30',1),(820,1,5,1,'2020-06-30 17:24:30',NULL,NULL,0),(820,164,13,1,'2020-06-30 17:24:30',NULL,NULL,0),(820,25,3,1,'2020-06-30 17:24:30',NULL,NULL,0),(819,25,3,1,'2020-06-30 17:26:21',NULL,NULL,0),(821,1,3,1,'2020-06-30 17:30:14',1,'2020-06-30 17:31:06',1),(821,1,3,1,'2020-06-30 17:30:45',1,'2020-06-30 17:31:06',1),(821,1,3,1,'2020-06-30 17:31:06',NULL,NULL,0),(818,25,3,1,'2020-06-30 17:32:09',NULL,NULL,0),(817,25,3,1,'2020-06-30 17:36:08',NULL,NULL,0),(822,142,3,1,'2020-06-30 17:40:25',NULL,NULL,0),(823,106,3,1,'2020-06-30 17:41:36',NULL,NULL,0),(824,4,1,1,'2020-06-30 17:43:57',NULL,NULL,0),(825,163,13,1,'2020-07-01 09:31:12',NULL,NULL,0),(826,1,3,1,'2020-07-01 09:34:35',1,'2020-07-01 09:39:25',1),(827,114,8,1,'2020-07-01 09:45:55',1,'2020-07-01 09:49:18',1),(827,114,8,1,'2020-07-01 09:49:18',NULL,NULL,0),(828,25,3,1,'2020-07-01 10:40:27',NULL,NULL,0),(829,25,3,1,'2020-07-01 10:40:51',NULL,NULL,0),(830,25,3,1,'2020-07-01 10:41:42',1,'2020-07-01 10:41:58',1),(830,25,3,1,'2020-07-01 10:41:58',NULL,NULL,0),(831,163,13,1,'2020-07-01 16:47:42',NULL,NULL,0),(832,106,3,1,'2020-07-01 16:52:41',NULL,NULL,0),(833,4,1,1,'2020-07-06 15:07:03',1,'2020-07-06 17:52:59',1),(834,4,1,1,'2020-07-06 15:07:57',NULL,NULL,0),(835,1,3,1,'2020-07-06 15:11:43',NULL,NULL,0),(836,4,1,NULL,'2020-07-06 17:22:04',1,'2020-07-06 17:22:50',1),(836,4,1,1,'2020-07-06 17:22:50',NULL,NULL,0),(837,4,1,NULL,'2020-07-06 17:25:23',NULL,NULL,0),(838,4,1,NULL,'2020-07-06 17:51:40',1,'2020-07-06 17:53:54',1),(838,4,1,1,'2020-07-06 17:52:06',1,'2020-07-06 17:53:54',1),(838,4,1,1,'2020-07-06 17:53:54',NULL,NULL,0),(839,4,1,NULL,'2020-07-08 12:17:20',1,'2020-07-08 12:18:10',1),(839,4,1,1,'2020-07-08 12:18:10',NULL,NULL,0),(840,1,3,1,'2020-07-08 16:43:52',1,'2020-07-08 16:44:05',1),(840,1,3,1,'2020-07-08 16:44:05',NULL,NULL,0),(841,1,3,1,'2020-07-08 16:50:19',NULL,NULL,0),(842,12,1,NULL,'2020-07-09 11:28:06',1,'2020-07-09 11:29:04',1),(842,12,1,1,'2020-07-09 11:29:04',NULL,NULL,0),(843,25,3,1,'2020-07-09 21:59:24',NULL,NULL,0),(844,165,14,1,'2020-07-10 13:30:04',NULL,NULL,0),(845,165,14,1,'2020-07-10 13:32:26',NULL,NULL,0),(846,165,14,1,'2020-07-10 13:35:36',NULL,NULL,0),(847,165,14,1,'2020-07-10 13:36:43',NULL,NULL,0),(848,19,14,1,'2020-07-10 14:19:19',NULL,NULL,0),(849,19,14,1,'2020-07-10 14:22:04',NULL,NULL,0),(850,143,14,1,'2020-07-10 14:23:44',NULL,NULL,0),(851,143,14,1,'2020-07-10 14:25:30',NULL,NULL,0),(852,131,14,1,'2020-07-10 14:28:16',NULL,NULL,0),(853,131,14,1,'2020-07-10 14:29:50',NULL,NULL,0),(854,131,14,1,'2020-07-10 14:33:14',NULL,NULL,0),(855,131,14,1,'2020-07-10 14:34:50',NULL,NULL,0),(856,19,14,1,'2020-07-10 14:38:52',NULL,NULL,0),(857,143,14,1,'2020-07-10 14:39:33',NULL,NULL,0),(858,143,14,1,'2020-07-10 14:40:53',NULL,NULL,0),(859,131,14,1,'2020-07-10 14:42:26',NULL,NULL,0),(860,131,14,1,'2020-07-10 14:42:51',NULL,NULL,0),(861,131,14,1,'2020-07-10 14:45:13',NULL,NULL,0),(862,131,14,1,'2020-07-10 14:45:39',NULL,NULL,0),(863,19,14,1,'2020-07-10 14:53:47',NULL,NULL,0),(864,19,14,1,'2020-07-10 14:54:28',NULL,NULL,0),(865,143,14,1,'2020-07-10 14:55:50',NULL,NULL,0),(866,131,14,1,'2020-07-10 14:56:12',NULL,NULL,0),(867,143,14,1,'2020-07-10 14:57:57',NULL,NULL,0),(868,143,14,1,'2020-07-10 14:58:12',NULL,NULL,0),(869,131,14,1,'2020-07-10 14:58:52',NULL,NULL,0),(870,131,14,1,'2020-07-10 14:59:08',NULL,NULL,0),(871,19,14,1,'2020-07-10 15:01:05',NULL,NULL,0),(872,19,14,1,'2020-07-10 15:01:41',NULL,NULL,0),(873,143,14,1,'2020-07-10 15:02:47',NULL,NULL,0),(874,131,14,1,'2020-07-10 15:05:34',NULL,NULL,0),(875,25,3,NULL,'2020-07-13 14:16:46',NULL,NULL,0),(876,1,3,1,'2020-07-14 14:17:37',1,'2020-07-14 14:18:24',1),(876,1,3,1,'2020-07-14 14:18:24',NULL,NULL,0),(877,1,3,1,'2020-07-14 15:00:40',NULL,NULL,0),(878,165,14,1,'2020-07-14 15:56:49',NULL,NULL,0),(879,165,14,1,'2020-07-14 16:03:04',NULL,NULL,0),(880,165,14,1,'2020-07-14 16:13:09',NULL,NULL,0),(881,25,3,NULL,'2020-07-23 11:00:24',1,'2020-07-23 11:11:11',1),(881,25,3,1,'2020-07-23 11:11:11',NULL,NULL,0),(882,25,3,NULL,'2020-07-23 11:11:53',1,'2020-07-23 11:12:13',1),(883,25,3,NULL,'2020-07-23 11:12:38',NULL,NULL,0),(884,25,3,NULL,'2020-07-23 11:21:03',NULL,NULL,0),(885,25,3,NULL,'2020-07-23 11:21:03',NULL,NULL,0),(886,25,3,NULL,'2020-07-23 11:37:21',1,'2020-07-23 11:38:53',1),(886,25,3,1,'2020-07-23 11:38:53',NULL,NULL,0),(887,25,3,NULL,'2020-07-23 12:18:23',NULL,NULL,0),(888,25,3,NULL,'2020-07-23 12:19:18',NULL,NULL,0),(889,25,3,NULL,'2020-07-23 12:19:57',NULL,NULL,0),(890,25,3,NULL,'2020-07-23 12:20:33',NULL,NULL,0),(891,25,3,NULL,'2020-07-23 12:26:41',NULL,NULL,0),(892,25,3,NULL,'2020-07-23 12:29:52',1,'2020-07-23 12:32:34',1),(892,25,3,1,'2020-07-23 12:32:08',1,'2020-07-23 12:32:34',1),(892,25,3,1,'2020-07-23 12:32:34',NULL,NULL,0),(893,25,3,NULL,'2020-07-23 12:33:16',NULL,NULL,0),(894,12,1,NULL,'2020-07-23 16:33:11',1,'2020-07-23 16:36:50',1),(894,12,1,1,'2020-07-23 16:36:50',NULL,NULL,0),(895,4,1,NULL,'2020-07-27 11:27:41',NULL,NULL,0),(896,12,1,NULL,'2020-07-27 12:25:55',1,'2020-07-27 12:26:32',1),(896,12,1,1,'2020-07-27 12:26:32',NULL,NULL,0),(897,12,1,NULL,'2020-07-27 16:07:44',1,'2020-07-27 16:10:03',1),(897,12,1,1,'2020-07-27 16:10:03',NULL,NULL,0),(898,131,14,NULL,'2020-07-28 17:22:52',1,'2020-07-28 17:35:35',1),(898,131,14,1,'2020-07-28 17:35:35',NULL,NULL,0),(899,131,14,1,'2020-07-29 09:02:30',NULL,NULL,0),(900,131,14,1,'2020-07-29 09:04:39',NULL,NULL,0),(901,165,14,1,'2020-07-29 09:43:14',NULL,NULL,0),(902,165,14,1,'2020-07-29 09:43:42',NULL,NULL,0),(903,143,14,1,'2020-07-29 09:45:36',NULL,NULL,0),(904,143,14,1,'2020-07-29 09:45:58',NULL,NULL,0),(905,131,14,1,'2020-07-29 09:48:44',NULL,NULL,0),(906,131,14,1,'2020-07-29 09:49:17',NULL,NULL,0),(907,131,14,1,'2020-07-29 09:50:58',NULL,NULL,0),(908,131,14,1,'2020-07-29 09:51:28',NULL,NULL,0),(909,165,14,1,'2020-07-29 10:15:31',NULL,NULL,0),(910,165,14,1,'2020-07-29 10:16:07',NULL,NULL,0),(911,165,14,1,'2020-07-29 10:19:57',NULL,NULL,0),(912,165,14,1,'2020-07-29 10:21:50',NULL,NULL,0),(913,165,14,1,'2020-07-29 10:24:53',NULL,NULL,0),(914,165,14,1,'2020-07-29 10:27:01',NULL,NULL,0),(915,165,14,1,'2020-07-29 10:28:05',NULL,NULL,0),(916,3,1,1,'2020-07-29 11:35:21',NULL,NULL,0),(917,165,14,1,'2020-07-29 15:42:20',NULL,NULL,0),(918,165,14,1,'2020-07-29 15:43:48',NULL,NULL,0),(919,165,14,1,'2020-07-29 15:44:39',NULL,NULL,0),(920,143,14,1,'2020-07-29 15:45:37',NULL,NULL,0),(921,143,14,1,'2020-07-29 15:45:54',NULL,NULL,0),(922,131,14,1,'2020-07-29 15:46:42',1,'2020-07-29 15:47:37',1),(923,131,14,1,'2020-07-29 15:47:33',NULL,NULL,0),(924,131,14,1,'2020-07-29 15:47:45',NULL,NULL,0),(925,131,14,1,'2020-07-29 15:49:23',NULL,NULL,0),(926,19,14,1,'2020-07-29 17:38:16',NULL,NULL,0),(927,19,14,1,'2020-07-29 17:38:38',NULL,NULL,0),(928,143,14,1,'2020-07-29 17:40:32',NULL,NULL,0),(929,131,14,1,'2020-07-29 17:41:00',NULL,NULL,0),(930,131,14,1,'2020-07-29 17:41:54',NULL,NULL,0),(931,131,14,1,'2020-07-29 17:45:22',NULL,NULL,0),(932,131,14,1,'2020-07-29 17:46:32',NULL,NULL,0),(933,143,14,1,'2020-07-29 17:47:20',NULL,NULL,0),(934,143,14,1,'2020-07-30 09:01:19',NULL,NULL,0),(935,131,14,1,'2020-07-30 09:02:24',NULL,NULL,0),(936,131,14,1,'2020-07-30 09:02:52',NULL,NULL,0),(937,131,14,1,'2020-07-30 09:03:33',NULL,NULL,0),(938,143,14,1,'2020-07-30 09:03:51',NULL,NULL,0),(939,131,14,1,'2020-07-30 09:04:27',NULL,NULL,0),(940,19,14,1,'2020-07-30 09:07:52',NULL,NULL,0),(941,19,14,1,'2020-07-30 09:08:13',NULL,NULL,0),(942,143,14,1,'2020-07-30 09:09:48',NULL,NULL,0),(943,4,1,NULL,'2020-07-30 17:02:35',1,'2020-07-30 17:03:44',1),(943,4,1,1,'2020-07-30 17:03:44',NULL,NULL,0),(944,4,1,NULL,'2020-07-30 17:09:23',1,'2020-07-30 17:11:23',1),(944,4,1,1,'2020-07-30 17:11:23',NULL,NULL,0),(945,4,1,NULL,'2020-07-30 17:25:20',1,'2020-07-30 17:26:25',1),(945,4,1,1,'2020-07-30 17:26:25',NULL,NULL,0),(946,3,1,NULL,'2020-07-30 17:35:52',1,'2020-07-30 17:47:41',1),(946,3,1,1,'2020-07-30 17:37:23',1,'2020-07-30 17:47:41',1),(946,3,1,1,'2020-07-30 17:47:41',NULL,NULL,0),(947,3,1,NULL,'2020-07-31 09:47:18',1,'2020-07-31 09:52:29',1),(947,3,1,1,'2020-07-31 09:52:29',NULL,NULL,0),(948,4,1,NULL,'2020-07-31 10:12:34',NULL,NULL,0),(949,4,1,1,'2020-07-31 10:15:31',1,'2020-07-31 10:15:46',1),(949,4,1,1,'2020-07-31 10:15:46',NULL,NULL,0),(950,131,14,1,'2020-08-03 17:29:22',NULL,NULL,0),(951,131,14,1,'2020-08-03 17:31:18',NULL,NULL,0),(952,165,14,1,'2020-08-03 17:32:44',NULL,NULL,0),(953,167,14,1,'2020-08-03 17:36:42',NULL,NULL,0),(954,131,14,1,'2020-08-03 17:45:08',NULL,NULL,0),(955,131,14,1,'2020-08-03 17:46:31',NULL,NULL,0),(956,165,14,1,'2020-08-03 17:47:01',NULL,NULL,0),(957,167,14,1,'2020-08-03 17:47:31',NULL,NULL,0),(958,19,14,1,'2020-08-03 17:48:12',NULL,NULL,0),(959,19,14,1,'2020-08-21 14:59:24',NULL,NULL,0),(960,4,1,NULL,'2020-08-27 14:40:42',NULL,NULL,0),(961,3,1,NULL,'2020-08-27 18:25:31',1,'2020-08-27 19:00:38',1),(961,3,1,1,'2020-08-27 18:45:55',1,'2020-08-27 19:00:38',1),(962,3,1,NULL,'2020-08-27 19:01:05',1,'2020-09-04 11:30:51',1),(963,25,3,1,'2020-08-28 15:49:08',1,'2020-08-28 16:25:55',1),(963,25,3,1,'2020-08-28 15:49:50',1,'2020-08-28 16:25:55',1),(964,25,3,NULL,'2020-08-28 16:00:26',1,'2020-08-28 16:06:31',1),(964,25,3,1,'2020-08-28 16:04:54',1,'2020-08-28 16:06:31',1),(964,25,3,1,'2020-08-28 16:06:31',NULL,NULL,0),(963,25,3,1,'2020-08-28 16:22:47',1,'2020-08-28 16:25:55',1),(963,25,3,1,'2020-08-28 16:24:52',1,'2020-08-28 16:25:55',1),(963,25,3,1,'2020-08-28 16:25:55',NULL,NULL,0),(962,3,1,1,'2020-09-03 17:19:29',1,'2020-09-04 11:30:51',1),(962,3,1,1,'2020-09-04 09:43:25',1,'2020-09-04 11:30:51',1),(962,3,1,1,'2020-09-04 09:52:05',1,'2020-09-04 11:30:51',1),(962,3,1,1,'2020-09-04 10:35:55',1,'2020-09-04 11:30:51',1),(962,3,1,1,'2020-09-04 10:44:31',1,'2020-09-04 11:30:51',1),(962,3,1,1,'2020-09-04 10:45:53',1,'2020-09-04 11:30:51',1),(962,3,1,1,'2020-09-04 11:21:19',1,'2020-09-04 11:30:51',1),(962,3,1,1,'2020-09-04 11:30:51',NULL,NULL,0),(965,4,1,NULL,'2020-09-08 14:11:09',1,'2020-09-08 14:27:28',1),(965,4,1,1,'2020-09-08 14:24:56',1,'2020-09-08 14:27:28',1),(965,4,1,1,'2020-09-08 14:27:01',1,'2020-09-08 14:27:28',1),(965,4,1,1,'2020-09-08 14:27:28',NULL,NULL,0),(966,4,1,NULL,'2020-09-08 14:32:11',1,'2020-09-08 14:33:45',1),(966,4,1,1,'2020-09-08 14:33:45',NULL,NULL,0),(967,4,1,NULL,'2020-09-08 14:42:46',1,'2020-09-08 14:43:36',1),(967,4,1,1,'2020-09-08 14:43:36',NULL,NULL,0),(968,4,1,NULL,'2020-09-08 15:58:08',1,'2020-09-08 16:01:16',1),(968,4,1,1,'2020-09-08 16:01:16',NULL,NULL,0),(969,19,14,1,'2020-09-10 16:35:46',NULL,NULL,0),(970,19,14,1,'2020-09-10 17:06:46',NULL,NULL,0),(971,4,1,NULL,'2020-09-18 08:20:23',1,'2020-09-18 08:20:59',1),(971,4,1,1,'2020-09-18 08:20:59',NULL,NULL,0),(972,1,3,NULL,'2020-09-21 14:11:47',NULL,NULL,0),(973,1,3,1,'2020-09-21 14:56:01',NULL,NULL,0),(974,4,1,NULL,'2020-09-21 17:34:58',NULL,NULL,0),(975,19,14,1,'2020-09-25 12:22:41',NULL,NULL,0),(976,19,14,1,'2020-09-25 12:22:45',NULL,NULL,0),(977,3,3,1,'2020-10-05 14:27:26',NULL,NULL,0),(978,1,3,NULL,'2020-10-06 09:21:00',1,'2020-10-06 09:23:14',1),(978,1,3,1,'2020-10-06 09:23:14',NULL,NULL,0),(979,1,3,1,'2020-10-06 09:23:29',NULL,NULL,0),(980,4,1,NULL,'2020-10-13 09:15:29',NULL,NULL,0),(981,4,1,NULL,'2020-10-13 12:31:34',NULL,NULL,0),(982,4,1,NULL,'2020-10-13 12:33:37',NULL,NULL,0),(983,4,1,NULL,'2020-10-13 12:33:37',NULL,NULL,0),(984,4,1,NULL,'2020-10-13 16:10:42',NULL,NULL,0),(985,4,1,NULL,'2020-10-15 14:10:54',1,'2020-10-15 14:17:38',1),(986,4,1,NULL,'2020-10-15 14:11:16',1,'2020-10-15 14:16:24',1),(986,4,1,1,'2020-10-15 14:16:16',1,'2020-10-15 14:16:24',1),(986,4,1,1,'2020-10-15 14:16:24',NULL,NULL,0),(985,4,1,1,'2020-10-15 14:17:38',NULL,NULL,0),(987,175,1,NULL,'2020-10-16 10:34:27',NULL,NULL,0),(988,175,1,NULL,'2020-10-16 10:34:27',NULL,NULL,0),(989,175,1,NULL,'2020-10-16 10:37:22',NULL,NULL,0),(990,175,1,NULL,'2020-10-16 10:37:22',NULL,NULL,0),(991,175,1,NULL,'2020-10-16 10:39:03',NULL,NULL,0),(992,175,1,NULL,'2020-10-16 11:38:40',NULL,NULL,0),(993,1,3,NULL,'2020-10-16 17:19:35',1,'2020-10-16 17:23:59',1),(994,1,3,NULL,'2020-10-16 17:19:47',1,'2020-10-16 17:23:26',1),(995,1,3,NULL,'2020-10-16 17:19:53',1,'2020-10-16 17:22:52',1),(996,1,3,NULL,'2020-10-16 17:20:03',1,'2020-10-16 17:22:03',1),(997,1,3,NULL,'2020-10-16 17:20:12',1,'2020-10-16 17:21:18',1),(997,1,3,1,'2020-10-16 17:21:18',NULL,NULL,0),(996,1,3,1,'2020-10-16 17:22:03',NULL,NULL,0),(995,1,3,1,'2020-10-16 17:22:52',NULL,NULL,0),(994,1,3,1,'2020-10-16 17:23:26',NULL,NULL,0),(993,1,3,1,'2020-10-16 17:23:54',1,'2020-10-16 17:23:59',1),(993,1,3,1,'2020-10-16 17:23:59',NULL,NULL,0),(998,1,3,NULL,'2020-10-16 17:31:44',NULL,NULL,0),(999,1,3,NULL,'2020-10-16 17:32:13',NULL,NULL,0),(1000,1,3,NULL,'2020-10-16 17:32:41',NULL,NULL,0),(1001,1,3,NULL,'2020-10-16 17:41:53',1,'2020-10-16 17:43:13',1),(1001,1,3,1,'2020-10-16 17:43:13',NULL,NULL,0),(1002,1,3,NULL,'2020-10-16 17:49:04',NULL,NULL,0),(1003,4,1,NULL,'2020-10-19 17:11:45',NULL,NULL,0),(1004,4,1,NULL,'2020-10-19 17:11:45',NULL,NULL,0),(1005,4,1,NULL,'2020-10-19 17:11:45',NULL,NULL,0),(1006,4,3,NULL,'2020-10-20 10:40:40',NULL,NULL,0),(1007,4,3,NULL,'2020-10-20 10:40:40',NULL,NULL,0),(1008,4,1,NULL,'2020-10-20 10:46:06',NULL,NULL,0),(1009,4,1,NULL,'2020-10-20 10:50:03',NULL,NULL,0),(1010,4,1,NULL,'2020-10-20 10:51:05',NULL,NULL,0),(1011,4,1,NULL,'2020-10-20 10:51:05',NULL,NULL,0),(1012,4,1,NULL,'2020-10-20 10:51:05',NULL,NULL,0),(1013,4,1,NULL,'2020-10-20 10:51:05',NULL,NULL,0),(1014,4,1,NULL,'2020-10-20 10:51:06',NULL,NULL,0),(1015,4,1,NULL,'2020-10-20 10:53:18',NULL,NULL,0),(1016,4,1,NULL,'2020-10-20 11:53:15',NULL,NULL,0),(1017,4,1,NULL,'2020-10-20 11:58:39',NULL,NULL,0),(1018,4,1,NULL,'2020-10-20 15:22:06',NULL,NULL,0),(1019,4,1,NULL,'2020-10-20 15:22:06',NULL,NULL,0),(1020,4,1,NULL,'2020-10-20 15:22:06',NULL,NULL,0),(1021,4,1,NULL,'2020-10-20 15:32:27',NULL,NULL,0),(1022,19,14,1,'2020-10-20 15:48:39',1,'2020-10-20 15:50:00',1),(1022,19,14,1,'2020-10-20 15:50:00',NULL,NULL,0),(1023,19,14,1,'2020-10-20 15:51:39',NULL,NULL,0),(1024,19,14,1,'2020-10-20 15:52:44',NULL,NULL,0),(1025,143,14,1,'2020-10-20 16:55:08',NULL,NULL,0),(1026,4,1,NULL,'2020-10-20 18:08:01',NULL,NULL,0),(1027,4,1,NULL,'2020-10-21 17:43:36',NULL,NULL,0),(1028,4,1,NULL,'2020-10-21 17:57:59',NULL,NULL,0),(1029,4,1,NULL,'2020-10-21 17:57:59',NULL,NULL,0),(1030,4,1,NULL,'2020-10-21 17:57:59',NULL,NULL,0),(1031,4,1,NULL,'2020-10-22 09:34:41',NULL,NULL,0),(1032,4,1,NULL,'2020-10-22 09:34:41',NULL,NULL,0),(1033,4,1,NULL,'2020-10-22 09:34:41',NULL,NULL,0),(1034,4,1,NULL,'2020-10-22 12:51:41',NULL,NULL,0),(1035,4,1,NULL,'2020-10-22 12:52:01',NULL,NULL,0),(1036,4,1,NULL,'2020-10-22 13:20:43',NULL,NULL,0),(1037,4,1,NULL,'2020-10-22 13:21:25',NULL,NULL,0),(1038,4,1,NULL,'2020-10-22 17:10:45',NULL,NULL,0),(1039,4,1,NULL,'2020-10-22 17:14:50',NULL,NULL,0),(1040,4,1,NULL,'2020-10-22 17:15:29',NULL,NULL,0),(1041,4,1,NULL,'2020-10-22 17:15:29',NULL,NULL,0),(1042,4,1,NULL,'2020-10-22 17:34:02',NULL,NULL,0),(1043,4,1,NULL,'2020-10-22 17:44:54',NULL,NULL,0),(1044,4,1,NULL,'2020-10-22 17:45:24',NULL,NULL,0),(1045,4,1,NULL,'2020-10-22 17:45:24',NULL,NULL,0),(1046,4,1,NULL,'2020-10-22 17:52:59',NULL,NULL,0),(1047,4,1,NULL,'2020-10-22 17:53:52',NULL,NULL,0),(1048,4,1,NULL,'2020-10-22 17:53:52',NULL,NULL,0),(1049,4,1,NULL,'2020-10-22 17:55:29',NULL,NULL,0),(1050,4,1,NULL,'2020-10-22 17:56:24',NULL,NULL,0),(1051,4,1,NULL,'2020-10-22 17:56:24',NULL,NULL,0),(1052,4,1,NULL,'2020-10-22 18:02:16',NULL,NULL,0),(1053,4,1,NULL,'2020-10-22 18:07:27',NULL,NULL,0),(1054,4,1,NULL,'2020-10-22 18:09:51',NULL,NULL,0),(1055,4,1,NULL,'2020-10-22 18:09:51',NULL,NULL,0),(1056,4,1,NULL,'2020-10-22 18:11:01',NULL,NULL,0),(1057,4,1,NULL,'2020-10-22 18:11:01',NULL,NULL,0),(1058,4,1,NULL,'2020-10-22 18:11:01',NULL,NULL,0),(1059,4,1,NULL,'2020-10-22 18:38:21',NULL,NULL,0),(1060,4,1,NULL,'2020-10-22 18:39:42',NULL,NULL,0),(1061,4,1,NULL,'2020-10-22 18:39:42',NULL,NULL,0),(1062,4,1,NULL,'2020-10-23 10:04:30',NULL,NULL,0),(1063,4,1,NULL,'2020-10-23 10:05:33',NULL,NULL,0),(1064,4,1,NULL,'2020-10-23 10:05:33',NULL,NULL,0),(1065,4,1,NULL,'2020-10-23 10:25:28',NULL,NULL,0),(1066,4,1,NULL,'2020-10-23 10:26:41',NULL,NULL,0),(1067,4,1,NULL,'2020-10-23 10:26:41',NULL,NULL,0),(1068,4,1,NULL,'2020-10-23 10:42:38',NULL,NULL,0),(1069,4,1,NULL,'2020-10-23 10:43:40',NULL,NULL,0),(1070,4,1,NULL,'2020-10-23 10:43:40',NULL,NULL,0),(1071,4,1,NULL,'2020-10-23 10:44:46',NULL,NULL,0),(1072,4,1,NULL,'2020-10-23 10:45:02',NULL,NULL,0),(1073,4,1,NULL,'2020-10-23 10:45:02',NULL,NULL,0),(1074,4,1,NULL,'2020-10-23 10:45:13',NULL,NULL,0),(1075,4,1,NULL,'2020-10-23 10:45:13',NULL,NULL,0),(1076,4,1,NULL,'2020-10-23 10:45:14',NULL,NULL,0),(1077,4,1,NULL,'2020-10-23 12:36:28',NULL,NULL,0),(1078,4,1,NULL,'2020-10-23 12:36:47',NULL,NULL,0),(1079,4,1,NULL,'2020-10-23 12:36:47',NULL,NULL,0),(1080,4,1,NULL,'2020-10-23 15:23:51',NULL,NULL,0),(1081,4,1,NULL,'2020-10-23 15:24:38',NULL,NULL,0),(1082,4,1,NULL,'2020-10-23 15:25:51',NULL,NULL,0),(1083,4,1,NULL,'2020-10-23 15:25:51',NULL,NULL,0),(1084,4,1,NULL,'2020-10-23 15:36:36',NULL,NULL,0),(1085,4,1,NULL,'2020-10-23 15:42:48',NULL,NULL,0),(1086,4,1,NULL,'2020-10-23 15:42:58',NULL,NULL,0),(1087,4,1,NULL,'2020-10-23 15:42:59',NULL,NULL,0),(1088,4,1,NULL,'2020-10-23 15:43:08',NULL,NULL,0),(1089,4,1,NULL,'2020-10-23 15:43:08',NULL,NULL,0),(1090,4,1,NULL,'2020-10-23 15:43:08',NULL,NULL,0),(1091,4,1,NULL,'2020-10-23 15:45:44',NULL,NULL,0),(1092,4,1,NULL,'2020-10-23 16:03:04',NULL,NULL,0),(1093,4,1,NULL,'2020-10-23 16:12:12',NULL,NULL,0),(1094,4,1,NULL,'2020-10-23 16:14:12',NULL,NULL,0),(1095,4,1,NULL,'2020-10-23 16:16:01',NULL,NULL,0),(1096,4,1,NULL,'2020-10-23 16:19:36',NULL,NULL,0),(1097,4,1,NULL,'2020-10-23 16:19:45',NULL,NULL,0),(1098,4,1,NULL,'2020-10-23 16:19:45',NULL,NULL,0),(1099,4,1,NULL,'2020-10-23 16:21:50',NULL,NULL,0),(1100,4,1,NULL,'2020-10-23 16:28:03',NULL,NULL,0),(1101,4,1,NULL,'2020-10-23 16:38:19',NULL,NULL,0),(1102,4,1,NULL,'2020-10-23 16:41:12',NULL,NULL,0),(1103,4,1,NULL,'2020-10-23 16:41:12',NULL,NULL,0),(1104,4,1,NULL,'2020-10-23 16:49:07',NULL,NULL,0),(1105,4,1,NULL,'2020-10-23 16:51:34',NULL,NULL,0),(1106,4,1,NULL,'2020-10-23 16:51:34',NULL,NULL,0),(1107,4,1,NULL,'2020-10-23 17:06:29',NULL,NULL,0),(1108,4,1,NULL,'2020-10-23 17:06:59',NULL,NULL,0),(1109,4,1,NULL,'2020-10-23 17:06:59',NULL,NULL,0),(1110,4,1,NULL,'2020-10-23 17:15:07',NULL,NULL,0),(1111,4,1,NULL,'2020-10-23 17:15:14',NULL,NULL,0),(1112,4,1,NULL,'2020-10-23 17:15:14',NULL,NULL,0),(1113,4,1,NULL,'2020-10-23 17:20:51',NULL,NULL,0),(1114,4,1,NULL,'2020-10-23 17:21:36',NULL,NULL,0),(1115,4,1,NULL,'2020-10-23 17:21:37',NULL,NULL,0),(1116,4,1,NULL,'2020-10-23 17:24:24',NULL,NULL,0),(1117,4,1,NULL,'2020-10-23 17:24:38',NULL,NULL,0),(1118,4,1,NULL,'2020-10-23 17:24:38',NULL,NULL,0),(1119,4,1,NULL,'2020-10-23 17:43:27',NULL,NULL,0),(1120,4,1,NULL,'2020-10-23 17:48:11',NULL,NULL,0),(1121,4,1,NULL,'2020-10-23 17:52:07',NULL,NULL,0),(1122,4,1,NULL,'2020-10-23 17:53:46',NULL,NULL,0),(1123,4,1,NULL,'2020-10-23 17:53:46',NULL,NULL,0),(1124,4,1,NULL,'2020-10-23 17:56:04',NULL,NULL,0),(1125,4,1,NULL,'2020-10-23 17:56:04',NULL,NULL,0),(1126,4,1,NULL,'2020-10-23 17:59:49',NULL,NULL,0),(1127,4,1,NULL,'2020-10-23 18:00:06',NULL,NULL,0),(1128,4,1,NULL,'2020-10-23 18:00:06',NULL,NULL,0),(1129,4,1,NULL,'2020-10-23 18:03:44',NULL,NULL,0),(1130,4,1,NULL,'2020-10-23 18:04:34',NULL,NULL,0),(1131,4,1,NULL,'2020-10-23 18:04:34',NULL,NULL,0),(1132,4,1,NULL,'2020-10-23 18:10:05',NULL,NULL,0),(1133,4,1,NULL,'2020-10-23 18:13:27',NULL,NULL,0),(1134,4,1,NULL,'2020-10-23 18:13:57',NULL,NULL,0),(1135,4,1,NULL,'2020-10-23 18:13:57',NULL,NULL,0),(1136,4,1,NULL,'2020-10-23 18:26:44',NULL,NULL,0),(1137,4,1,NULL,'2020-10-23 18:28:47',NULL,NULL,0),(1138,4,1,NULL,'2020-10-23 18:29:09',NULL,NULL,0),(1139,4,1,NULL,'2020-10-23 18:32:04',NULL,NULL,0),(1140,4,1,NULL,'2020-10-23 18:32:28',NULL,NULL,0),(1141,4,1,NULL,'2020-10-23 18:32:42',NULL,NULL,0),(1142,4,1,NULL,'2020-10-23 18:42:19',NULL,NULL,0),(1143,4,1,NULL,'2020-10-23 18:53:25',NULL,NULL,0),(1144,4,1,NULL,'2020-10-23 18:55:41',NULL,NULL,0),(1145,4,1,NULL,'2020-10-23 18:55:51',NULL,NULL,0),(1146,4,1,NULL,'2020-10-23 18:56:46',NULL,NULL,0),(1147,4,1,NULL,'2020-10-23 19:02:54',NULL,NULL,0),(1148,4,1,NULL,'2020-10-23 19:05:56',NULL,NULL,0),(1149,4,3,NULL,'2020-10-26 09:34:04',NULL,NULL,0),(1150,4,1,NULL,'2020-10-26 09:40:43',NULL,NULL,0),(1151,4,1,NULL,'2020-10-26 09:40:52',NULL,NULL,0),(1152,4,1,NULL,'2020-10-26 09:41:01',NULL,NULL,0),(1153,4,1,NULL,'2020-10-26 09:41:12',NULL,NULL,0),(1154,4,1,NULL,'2020-10-26 09:59:12',NULL,NULL,0),(1155,4,1,NULL,'2020-10-26 10:20:13',NULL,NULL,0),(1156,4,1,NULL,'2020-10-26 10:23:08',NULL,NULL,0),(1157,4,1,NULL,'2020-10-26 10:27:18',NULL,NULL,0),(1158,4,1,NULL,'2020-10-26 10:27:22',NULL,NULL,0),(1159,4,1,NULL,'2020-10-26 10:27:39',NULL,NULL,0),(1160,4,1,NULL,'2020-10-26 10:27:40',NULL,NULL,0),(1161,4,1,NULL,'2020-10-26 10:28:30',NULL,NULL,0),(1162,4,1,NULL,'2020-10-26 10:29:18',NULL,NULL,0),(1163,4,1,NULL,'2020-10-26 10:29:23',NULL,NULL,0),(1164,4,1,NULL,'2020-10-26 10:29:28',NULL,NULL,0),(1165,4,1,NULL,'2020-10-26 10:29:38',NULL,NULL,0),(1166,4,1,NULL,'2020-10-26 10:54:07',NULL,NULL,0),(1167,4,1,NULL,'2020-10-26 10:54:21',NULL,NULL,0),(1168,4,1,NULL,'2020-10-26 11:58:09',NULL,NULL,0),(1169,4,9,NULL,'2020-10-26 15:42:36',NULL,NULL,0),(1170,4,1,NULL,'2020-10-26 15:50:45',NULL,NULL,0),(1171,4,1,NULL,'2020-10-26 16:04:50',NULL,NULL,0),(1172,4,1,NULL,'2020-10-26 16:04:53',NULL,NULL,0),(1173,4,1,NULL,'2020-10-26 16:05:00',NULL,NULL,0),(1174,4,1,NULL,'2020-10-26 16:27:44',NULL,NULL,0),(1175,4,1,NULL,'2020-10-26 16:32:02',NULL,NULL,0),(1176,4,1,NULL,'2020-10-26 16:48:50',NULL,NULL,0),(1177,4,1,NULL,'2020-10-26 16:49:00',NULL,NULL,0),(1178,4,1,NULL,'2020-10-26 16:59:08',NULL,NULL,0),(1179,4,1,NULL,'2020-10-26 17:01:41',NULL,NULL,0),(1180,4,1,NULL,'2020-10-26 17:17:40',NULL,NULL,0),(1181,4,1,NULL,'2020-10-26 17:23:49',NULL,NULL,0),(1182,4,1,NULL,'2020-10-26 17:23:57',NULL,NULL,0),(1183,4,1,NULL,'2020-10-26 17:27:15',NULL,NULL,0),(1184,4,1,NULL,'2020-10-26 17:27:26',NULL,NULL,0),(1185,4,1,NULL,'2020-10-26 17:27:32',NULL,NULL,0),(1186,4,1,NULL,'2020-10-26 17:27:40',NULL,NULL,0),(1187,4,1,NULL,'2020-10-26 17:31:43',NULL,NULL,0),(1188,4,1,NULL,'2020-10-26 17:31:55',NULL,NULL,0),(1189,4,1,NULL,'2020-10-26 17:32:03',NULL,NULL,0),(1190,4,1,NULL,'2020-10-26 18:03:04',NULL,NULL,0),(1191,4,1,NULL,'2020-10-26 18:44:00',NULL,NULL,0),(1192,4,1,NULL,'2020-10-26 18:58:31',NULL,NULL,0),(1193,4,3,NULL,'2020-10-27 10:53:00',NULL,NULL,0),(1194,4,1,NULL,'2020-10-27 10:58:20',NULL,NULL,0),(1195,4,1,NULL,'2020-10-27 10:59:01',NULL,NULL,0),(1196,4,1,NULL,'2020-10-27 17:22:24',NULL,NULL,0),(1197,4,1,NULL,'2020-10-28 09:18:28',NULL,NULL,0),(1198,4,1,NULL,'2020-10-28 16:16:43',NULL,NULL,0),(1199,4,1,NULL,'2020-10-29 09:17:12',NULL,NULL,0),(1200,4,1,NULL,'2020-10-29 12:12:48',NULL,NULL,0),(1201,4,1,NULL,'2020-10-29 12:12:53',NULL,NULL,0),(1202,4,1,NULL,'2020-11-03 16:29:13',NULL,NULL,0),(1203,4,1,NULL,'2020-11-05 13:08:22',NULL,NULL,0),(1204,4,1,NULL,'2020-11-05 13:08:49',NULL,NULL,0),(1205,4,1,NULL,'2020-11-10 10:36:26',NULL,NULL,0),(1206,1,3,NULL,'2020-11-10 11:04:28',NULL,NULL,0),(1207,4,1,NULL,'2020-11-10 17:21:22',NULL,NULL,0),(1208,4,1,NULL,'2020-11-11 12:50:05',NULL,NULL,0),(1209,4,1,NULL,'2020-11-18 11:52:55',NULL,NULL,0),(1210,4,1,NULL,'2020-11-23 09:43:41',NULL,NULL,0),(1211,3,3,1,'2020-11-26 15:44:58',1,'2020-11-26 15:45:58',1),(1211,3,3,1,'2020-11-26 15:45:34',1,'2020-11-26 15:45:58',1),(1211,3,3,1,'2020-11-26 15:45:40',1,'2020-11-26 15:45:58',1),(1211,3,3,1,'2020-11-26 15:45:58',NULL,NULL,0),(1212,19,14,1,'2020-12-02 10:17:35',NULL,NULL,0),(1213,156,9,4,'2020-12-02 10:29:03',NULL,NULL,0),(1214,156,9,4,'2020-12-02 10:31:53',NULL,NULL,0),(1215,156,9,4,'2020-12-02 10:37:00',NULL,NULL,0),(1216,156,9,NULL,'2020-12-02 10:38:12',4,'2020-12-02 10:38:35',1),(1216,156,9,4,'2020-12-02 10:38:35',NULL,NULL,0),(1217,4,1,NULL,'2020-12-02 10:41:06',1,'2020-12-02 10:43:16',1),(1217,4,1,1,'2020-12-02 10:43:16',NULL,NULL,0),(1218,4,1,NULL,'2020-12-02 10:46:39',1,'2020-12-02 10:49:59',1),(1218,4,1,1,'2020-12-02 10:49:59',NULL,NULL,0),(1219,156,9,4,'2020-12-02 10:57:54',NULL,NULL,0),(1220,156,9,4,'2020-12-02 11:02:12',NULL,NULL,0),(1221,156,9,4,'2020-12-02 11:03:08',NULL,NULL,0),(1222,156,9,4,'2020-12-02 11:42:55',NULL,NULL,0),(1223,156,9,4,'2020-12-02 11:43:36',NULL,NULL,0),(1224,156,9,4,'2020-12-02 11:45:11',NULL,NULL,0),(1225,156,9,4,'2020-12-02 11:46:12',NULL,NULL,0),(1226,156,9,4,'2020-12-02 16:11:59',NULL,NULL,0),(1227,156,9,4,'2020-12-02 18:02:14',NULL,NULL,0),(1228,156,9,4,'2020-12-07 09:27:09',NULL,NULL,0),(1229,4,1,NULL,'2020-12-07 17:22:23',NULL,NULL,0),(1230,4,1,NULL,'2020-12-07 17:31:16',NULL,NULL,0),(1231,19,14,1,'2020-12-10 10:55:36',NULL,NULL,0),(1232,19,14,1,'2020-12-10 12:09:50',NULL,NULL,0),(1233,4,1,NULL,'2020-12-10 12:37:12',NULL,NULL,0),(1234,4,1,NULL,'2020-12-11 09:54:57',NULL,NULL,0),(1235,4,1,NULL,'2020-12-11 15:24:39',NULL,NULL,0),(1236,4,1,NULL,'2020-12-11 17:32:47',NULL,NULL,0),(1237,4,1,NULL,'2020-12-11 17:33:08',NULL,NULL,0),(1238,4,1,NULL,'2020-12-16 10:19:31',NULL,NULL,0),(1239,1,3,NULL,'2020-12-21 11:05:32',NULL,NULL,0),(1240,1,3,NULL,'2020-12-21 11:05:32',NULL,NULL,0),(1241,1,3,NULL,'2020-12-21 11:05:39',NULL,NULL,0),(1242,1,3,NULL,'2020-12-21 11:05:39',NULL,NULL,0),(1243,108,1,1,'2021-01-14 15:58:10',NULL,NULL,0),(1244,108,1,1,'2021-01-14 16:01:50',1,'2021-01-14 16:02:38',1),(1244,108,1,1,'2021-01-14 16:02:38',NULL,NULL,0),(1245,108,1,1,'2021-01-14 16:11:53',NULL,NULL,0),(1245,143,14,1,'2021-01-14 16:11:53',NULL,NULL,0),(1246,108,1,1,'2021-01-14 16:12:35',NULL,NULL,0),(1247,19,14,NULL,'2021-02-17 10:58:01',NULL,NULL,0),(1248,19,14,NULL,'2021-02-17 10:58:01',NULL,NULL,0),(1249,19,14,NULL,'2021-02-17 10:58:01',NULL,NULL,0),(1250,19,14,NULL,'2021-02-17 10:58:01',NULL,NULL,0),(1251,19,14,NULL,'2021-02-17 11:08:20',NULL,NULL,0),(1252,19,14,NULL,'2021-02-17 11:08:20',NULL,NULL,0),(1253,1,3,NULL,'2021-02-17 12:27:54',NULL,NULL,0),(1254,1,3,NULL,'2021-02-17 12:27:54',NULL,NULL,0),(1255,1,3,NULL,'2021-02-17 12:27:54',NULL,NULL,0),(1256,1,3,NULL,'2021-02-17 12:27:54',NULL,NULL,0),(1257,1,3,NULL,'2021-02-17 12:29:29',NULL,NULL,0),(1258,1,3,NULL,'2021-02-17 12:29:29',NULL,NULL,0),(1259,1,3,NULL,'2021-02-17 12:29:29',NULL,NULL,0),(1260,1,3,NULL,'2021-02-17 12:29:29',NULL,NULL,0),(1261,1,3,NULL,'2021-02-17 12:29:45',NULL,NULL,0);
/*!40000 ALTER TABLE `imovel_liberacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imovel_permanente`
--

DROP TABLE IF EXISTS `imovel_permanente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imovel_permanente` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_imovel` int(10) unsigned DEFAULT NULL,
  `id_pessoa` int(10) unsigned DEFAULT NULL,
  `imovel_principal` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `data_insercao` datetime DEFAULT NULL,
  `data_exclusao` datetime DEFAULT NULL,
  `excluido` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `data_mudanca` date DEFAULT NULL,
  `id_autorizante` int(11) DEFAULT NULL,
  `pessoa_titular` tinyint(1) DEFAULT 0,
  `responsavel` tinyint(1) NOT NULL DEFAULT 0,
  `prestador` tinyint(1) NOT NULL DEFAULT 0,
  `reside` tinyint(1) NOT NULL DEFAULT 0,
  `perfil` int(10) unsigned NOT NULL DEFAULT 1,
  `permitir_cad_permanente` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 's',
  `permitir_liberacao` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 's',
  `parentesco` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_2` (`id_imovel`,`id_pessoa`,`excluido`),
  KEY `index_3` (`id_pessoa`,`excluido`),
  KEY `perfil` (`perfil`),
  KEY `I_ID_AUTORIZANTE` (`id_autorizante`),
  CONSTRAINT `imovel_permanente_ibfk_1` FOREIGN KEY (`perfil`) REFERENCES `tipo_perfil` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imovel_permanente`
--

LOCK TABLES `imovel_permanente` WRITE;
/*!40000 ALTER TABLE `imovel_permanente` DISABLE KEYS */;
INSERT INTO `imovel_permanente` VALUES (1,1,1,'s','2017-05-15 17:53:05','2020-01-08 16:13:15','s','1969-12-31',NULL,1,0,0,0,1,'s','s',NULL),(2,1,2,'s','2019-11-25 19:22:02','2019-11-27 10:08:42','s','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(3,1,3,'s','2019-11-25 20:25:26','2020-09-24 17:39:15','s','2019-01-01',NULL,0,0,0,0,1,'s','s',NULL),(4,1,4,'s','2019-11-26 08:42:48','2020-11-30 17:53:03','s','2019-11-26',NULL,0,0,0,0,1,'s','s',NULL),(5,2,2,'n','2019-11-27 10:08:42',NULL,'n','2019-11-27',NULL,0,0,0,0,1,'s','s',NULL),(6,2,1,'n','2019-12-02 17:18:14','2020-01-08 16:13:15','s','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(7,1,19,'s','2019-12-04 09:50:52','2020-07-10 11:26:52','s','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(8,3,25,'s','2019-12-04 10:32:00',NULL,'n','2019-12-04',NULL,0,0,0,0,1,'s','s',NULL),(9,1,45,'s','2019-12-11 12:38:12',NULL,'n','1111-11-11',NULL,0,0,0,0,1,'s','s',NULL),(10,1,55,'s','2019-12-13 08:41:40','2020-01-24 11:58:16','s','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(11,1,66,'s','2019-12-16 10:03:32',NULL,'n','2019-12-16',NULL,0,0,0,0,1,'s','s',NULL),(12,3,1,'s','2020-01-08 16:13:15',NULL,'n','2000-01-01',NULL,1,0,0,0,1,'s','s',NULL),(13,1,91,'s','2020-01-11 08:45:00',NULL,'n','1111-11-11',NULL,0,0,0,0,1,'s','s',NULL),(14,3,19,'n','2020-02-04 11:47:28',NULL,'n','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(15,3,2,'s','2020-02-04 12:03:45',NULL,'n','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(16,1,108,'s','2020-02-04 15:19:28',NULL,'n',NULL,NULL,0,0,0,0,1,'s','s',NULL),(17,3,109,'s','2020-02-14 08:22:20','2020-02-14 08:32:08','s','2020-02-10',NULL,0,0,0,0,1,'s','s',NULL),(18,8,109,'s','2020-02-14 08:32:08',NULL,'n','2020-02-10',NULL,0,0,0,0,1,'s','s',NULL),(19,3,4,'n','2020-02-17 10:09:49','2020-11-30 17:36:55','s','2020-02-17',NULL,0,0,0,0,1,'s','s',NULL),(20,3,3,'s','2020-02-19 10:59:08','2020-03-17 10:47:02','s','2020-01-01',NULL,0,0,0,0,1,'s','s',NULL),(21,5,1,'n','2020-02-26 15:13:40',NULL,'n','2000-01-01',NULL,1,0,0,0,1,'s','s',NULL),(22,1,117,'s','2020-02-28 10:46:14','2020-11-30 17:49:21','s','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(23,9,120,'s','2020-02-28 11:16:15',NULL,'n','2000-01-01',NULL,1,0,0,0,1,'s','s',NULL),(24,5,127,'s','2020-03-03 10:33:00',NULL,'n','1111-11-11',NULL,0,0,0,0,1,'s','s',NULL),(25,5,131,'s','2020-03-03 11:13:57','2020-07-10 11:35:00','s','1111-11-11',NULL,0,0,0,0,1,'s','s',NULL),(26,3,142,'s','2020-03-16 17:02:36',NULL,'n','2019-01-01',NULL,0,0,0,0,1,'s','s',NULL),(27,10,90,'s','2020-04-15 17:44:53',NULL,'n','1969-01-01',NULL,1,0,0,0,1,'s','s',NULL),(28,11,155,'s','2020-04-15 18:01:21',NULL,'n','1969-01-01',NULL,1,0,0,0,1,'s','s',NULL),(29,12,156,'s','2020-04-15 18:02:59','2020-11-30 15:05:42','s','1969-01-01',NULL,0,0,0,0,1,'s','s',NULL),(30,3,3,'n','2020-04-28 15:30:10','2020-09-24 17:39:15','s','2019-01-01',NULL,0,0,0,0,1,'s','s',NULL),(31,13,163,'s','2020-04-29 15:08:32',NULL,'n','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(32,13,164,'s','2020-04-29 15:18:21',NULL,'n','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(33,1,175,'s','2020-06-08 10:39:58',NULL,'n','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(35,9,4,'n','2020-06-16 16:23:47','2020-11-30 17:36:55','s','2020-06-01',NULL,0,0,0,0,1,'s','s',NULL),(36,8,164,'n','2020-06-26 09:21:12',NULL,'n','2010-10-10',NULL,1,0,0,0,1,'s','s',NULL),(37,1,200,'s','2020-07-01 15:27:58','2020-11-30 17:29:34','s','2020-02-02',NULL,1,0,0,0,1,'s','s',NULL),(38,14,19,'s','2020-07-10 11:29:10',NULL,'n','1969-12-31',NULL,0,0,0,0,1,'s','s',NULL),(39,14,131,'s','2020-07-10 11:35:00',NULL,'n','1111-11-11',NULL,0,0,0,0,1,'s','s',NULL),(40,1,3,'s','2020-09-24 17:39:42',NULL,'n',NULL,NULL,0,0,1,1,1,'s','s',NULL),(41,5,3,'n','2020-09-24 17:39:42',NULL,'n',NULL,NULL,0,0,1,0,1,'s','s',NULL),(42,9,156,'s','2020-11-30 15:05:42',NULL,'n','2018-01-01',NULL,0,0,0,0,1,'s','s',NULL),(43,1,4,'s','2020-11-30 17:53:03','2020-11-30 17:53:58','s','2000-01-01',NULL,0,0,0,0,1,'s','s',NULL),(44,9,4,'s','2020-11-30 17:53:58','2020-11-30 17:54:47','s','2000-01-01',NULL,0,0,0,0,1,'s','s',NULL),(45,1,4,'s','2020-11-30 17:54:47',NULL,'n','2000-01-01',NULL,0,0,0,0,1,'s','s',NULL),(46,1,156,'n','2020-12-08 14:49:31',NULL,'n','2000-01-01',NULL,0,0,0,0,1,'s','s',NULL),(47,5,25,'n','2020-12-23 19:07:47',NULL,'n','2020-01-01',NULL,0,0,0,0,1,'s','s',NULL),(48,9,12,'s','2020-12-23 19:07:47',NULL,'s','2020-01-01',NULL,0,0,0,0,1,'s','s',NULL),(49,13,216,'s','2021-03-01 15:59:24',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(50,9,192,'s','2021-03-01 15:59:58',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(51,14,165,'s','2021-03-01 16:00:31',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(52,3,7,'s','2021-03-01 16:02:19',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(53,14,143,'s','2021-03-01 16:06:49',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(54,1,136,'s','2021-03-01 16:07:20',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(55,5,133,'s','2021-03-01 16:07:36',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(56,5,132,'s','2021-03-01 16:07:51',NULL,'n',NULL,NULL,0,0,0,0,1,'s','s',''),(57,3,12,'s','2021-03-01 16:08:54',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(58,1,54,'s','2021-03-01 16:09:45',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s',''),(59,3,106,'s','2021-03-01 16:10:30',NULL,'n',NULL,NULL,0,0,0,0,2,'s','s','');
/*!40000 ALTER TABLE `imovel_permanente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informativo`
--

DROP TABLE IF EXISTS `informativo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informativo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Mensagem ou Imagem',
  `conteudo` text COLLATE utf8_unicode_ci NOT NULL,
  `datainicial` date NOT NULL,
  `datafinal` date NOT NULL,
  `image` mediumblob NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informativo`
--

LOCK TABLES `informativo` WRITE;
/*!40000 ALTER TABLE `informativo` DISABLE KEYS */;
/*!40000 ALTER TABLE `informativo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_fornecedor_pedidos`
--

DROP TABLE IF EXISTS `item_fornecedor_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_fornecedor_pedidos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idfornecedorpedido` int(10) unsigned NOT NULL,
  `iditem` int(10) unsigned NOT NULL,
  `quantidadeFornecedor` int(11) NOT NULL,
  `valorUnitarioFornecedor` double(8,2) NOT NULL,
  `valorTotal` double(8,2) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_fornecedor_pedidos_idfornecedorpedido_foreign` (`idfornecedorpedido`),
  KEY `item_fornecedor_pedidos_iditem_foreign` (`iditem`),
  CONSTRAINT `item_fornecedor_pedidos_idfornecedorpedido_foreign` FOREIGN KEY (`idfornecedorpedido`) REFERENCES `fornecedor_pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_fornecedor_pedidos_iditem_foreign` FOREIGN KEY (`iditem`) REFERENCES `item_pedidos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_fornecedor_pedidos`
--

LOCK TABLES `item_fornecedor_pedidos` WRITE;
/*!40000 ALTER TABLE `item_fornecedor_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_fornecedor_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_pedidos`
--

DROP TABLE IF EXISTS `item_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_pedidos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpedido` int(10) unsigned NOT NULL,
  `idproduto` int(10) unsigned NOT NULL,
  `tipo_lancamento` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Produto ou Serviço',
  `quantidade` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_pedidos_idpedido_foreign` (`idpedido`),
  KEY `item_pedidos_idproduto_foreign` (`idproduto`),
  CONSTRAINT `item_pedidos_idpedido_foreign` FOREIGN KEY (`idpedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_pedidos_idproduto_foreign` FOREIGN KEY (`idproduto`) REFERENCES `produtos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_pedidos`
--

LOCK TABLES `item_pedidos` WRITE;
/*!40000 ALTER TABLE `item_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamento_agendar`
--

DROP TABLE IF EXISTS `lancamento_agendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamento_agendar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_conta` int(10) unsigned NOT NULL,
  `id_fornecedor` int(10) unsigned NOT NULL,
  `id_tipo_documento` int(10) unsigned DEFAULT NULL,
  `mes_competencia` int(11) NOT NULL,
  `ano_competencia` int(11) NOT NULL,
  `data_base` date NOT NULL,
  `valor` decimal(15,2) NOT NULL,
  `numero_nf` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'NULL',
  `data_emissao_nf` date DEFAULT NULL,
  `id_localizacao` int(10) unsigned NOT NULL,
  `id_departamento` int(10) unsigned DEFAULT NULL,
  `observacao` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_centro_custo` int(10) unsigned DEFAULT NULL COMMENT 'ID Centro de custo',
  PRIMARY KEY (`id`),
  KEY `lancamento_agendar_id_fornecedor_foreign` (`id_fornecedor`),
  KEY `lancamento_agendar_id_localizacao_foreign` (`id_localizacao`),
  KEY `lancamento_agendar_id_departamento_foreign` (`id_departamento`),
  KEY `lancamento_agendar_id_conta_foreign` (`id_conta`),
  KEY `lancamento_agendar_id_centro_custo_foreign` (`id_centro_custo`),
  CONSTRAINT `lancamento_agendar_id_centro_custo_foreign` FOREIGN KEY (`id_centro_custo`) REFERENCES `centro_custos` (`id`),
  CONSTRAINT `lancamento_agendar_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`),
  CONSTRAINT `lancamento_agendar_id_departamento_foreign` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id`),
  CONSTRAINT `lancamento_agendar_id_fornecedor_foreign` FOREIGN KEY (`id_fornecedor`) REFERENCES `empresa` (`id`),
  CONSTRAINT `lancamento_agendar_id_localizacao_foreign` FOREIGN KEY (`id_localizacao`) REFERENCES `localidades` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento_agendar`
--

LOCK TABLES `lancamento_agendar` WRITE;
/*!40000 ALTER TABLE `lancamento_agendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamento_agendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamento_antigo_lancamentos`
--

DROP TABLE IF EXISTS `lancamento_antigo_lancamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamento_antigo_lancamentos` (
  `id_lancamento_antigo` int(10) unsigned NOT NULL,
  `id_lancamento` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `lancamento_antigo_lancamentos_id_lancamento_antigo_index` (`id_lancamento_antigo`),
  KEY `lancamento_antigo_lancamentos_id_lancamento_index` (`id_lancamento`),
  CONSTRAINT `lancamento_antigo_lancamentos_id_lancamento_antigo_foreign` FOREIGN KEY (`id_lancamento_antigo`) REFERENCES `lancamento_antigos` (`id`),
  CONSTRAINT `lancamento_antigo_lancamentos_id_lancamento_foreign` FOREIGN KEY (`id_lancamento`) REFERENCES `lancamentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento_antigo_lancamentos`
--

LOCK TABLES `lancamento_antigo_lancamentos` WRITE;
/*!40000 ALTER TABLE `lancamento_antigo_lancamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamento_antigo_lancamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamento_antigos`
--

DROP TABLE IF EXISTS `lancamento_antigos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamento_antigos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_configuracao_carteira` int(10) unsigned DEFAULT NULL,
  `id_layout_remessa` int(10) unsigned DEFAULT NULL,
  `idimovel` int(10) unsigned NOT NULL,
  `data_vencimento` date NOT NULL,
  `descricao` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `observacao` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancelamento` tinyint(1) NOT NULL DEFAULT 0,
  `motivo_cancelamento` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `tipo_cobranca` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `valor` decimal(15,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `lancamento_antigos_id_configuracao_carteira_foreign` (`id_configuracao_carteira`),
  KEY `lancamento_antigos_id_layout_remessa_foreign` (`id_layout_remessa`),
  KEY `lancamento_antigos_idimovel_index` (`idimovel`),
  KEY `lancamento_antigos_id_empresa_index` (`id_empresa`),
  CONSTRAINT `lancamento_antigos_id_configuracao_carteira_foreign` FOREIGN KEY (`id_configuracao_carteira`) REFERENCES `configuracao_carteiras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lancamento_antigos_id_layout_remessa_foreign` FOREIGN KEY (`id_layout_remessa`) REFERENCES `layout_remessas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento_antigos`
--

LOCK TABLES `lancamento_antigos` WRITE;
/*!40000 ALTER TABLE `lancamento_antigos` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamento_antigos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamento_avulsos`
--

DROP TABLE IF EXISTS `lancamento_avulsos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamento_avulsos` (
  `id_lancamento` int(10) unsigned NOT NULL,
  `id_configuracao_carteira` int(10) unsigned DEFAULT NULL,
  `id_layout_remessa` int(10) unsigned DEFAULT NULL,
  `idimovel` int(10) unsigned DEFAULT NULL,
  `data_vencimento` date NOT NULL,
  `observacao` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancelamento` tinyint(1) NOT NULL DEFAULT 0,
  `motivo_cancelamento` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `tipo_cobranca` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_lancamento`),
  KEY `lancamento_avulsos_id_configuracao_carteira_foreign` (`id_configuracao_carteira`),
  KEY `lancamento_avulsos_id_layout_remessa_foreign` (`id_layout_remessa`),
  KEY `lancamento_avulsos_idimovel_foreign` (`idimovel`),
  KEY `lancamento_avulsos_id_empresa_foreign` (`id_empresa`),
  CONSTRAINT `lancamento_avulsos_id_configuracao_carteira_foreign` FOREIGN KEY (`id_configuracao_carteira`) REFERENCES `configuracao_carteiras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lancamento_avulsos_id_empresa_foreign` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  CONSTRAINT `lancamento_avulsos_id_lancamento_foreign` FOREIGN KEY (`id_lancamento`) REFERENCES `lancamentos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lancamento_avulsos_id_layout_remessa_foreign` FOREIGN KEY (`id_layout_remessa`) REFERENCES `layout_remessas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lancamento_avulsos_idimovel_foreign` FOREIGN KEY (`idimovel`) REFERENCES `imovel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento_avulsos`
--

LOCK TABLES `lancamento_avulsos` WRITE;
/*!40000 ALTER TABLE `lancamento_avulsos` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamento_avulsos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamento_fundo`
--

DROP TABLE IF EXISTS `lancamento_fundo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamento_fundo` (
  `id_lancamento` int(10) unsigned NOT NULL,
  `id_receita_calculos` int(10) unsigned NOT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_lancamento`),
  KEY `lancamento_fundo_id_receita_calculos_foreign` (`id_receita_calculos`),
  KEY `lancamento_fundo_id_imovel_foreign` (`id_imovel`),
  CONSTRAINT `lancamento_fundo_id_imovel_foreign` FOREIGN KEY (`id_imovel`) REFERENCES `imovel` (`id`),
  CONSTRAINT `lancamento_fundo_id_lancamento_foreign` FOREIGN KEY (`id_lancamento`) REFERENCES `lancamentos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lancamento_fundo_id_receita_calculos_foreign` FOREIGN KEY (`id_receita_calculos`) REFERENCES `receita_calculos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento_fundo`
--

LOCK TABLES `lancamento_fundo` WRITE;
/*!40000 ALTER TABLE `lancamento_fundo` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamento_fundo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamento_recorrentes`
--

DROP TABLE IF EXISTS `lancamento_recorrentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamento_recorrentes` (
  `id_lancamento` int(10) unsigned NOT NULL,
  `idlocalidade` int(10) unsigned DEFAULT NULL,
  `tipo_associacao` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'IMÓVEIS, PARCEIROS ou LOCALIZAÇÃO',
  `data_ini` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `rateio` tinyint(1) DEFAULT NULL,
  `fixo` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_centro_custo` int(10) unsigned DEFAULT NULL COMMENT 'ID Centro de custo',
  `id_conta` int(10) unsigned DEFAULT NULL COMMENT 'ID Plano de Contas',
  PRIMARY KEY (`id_lancamento`),
  KEY `lancamento_recorrentes_idlocalidade_foreign` (`idlocalidade`),
  KEY `lancamento_recorrentes_id_centro_custo_foreign` (`id_centro_custo`),
  KEY `lancamento_recorrentes_id_conta_foreign` (`id_conta`),
  CONSTRAINT `lancamento_recorrentes_id_centro_custo_foreign` FOREIGN KEY (`id_centro_custo`) REFERENCES `centro_custos` (`id`),
  CONSTRAINT `lancamento_recorrentes_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`),
  CONSTRAINT `lancamento_recorrentes_id_lancamento_foreign` FOREIGN KEY (`id_lancamento`) REFERENCES `lancamentos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lancamento_recorrentes_idlocalidade_foreign` FOREIGN KEY (`idlocalidade`) REFERENCES `localidades` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento_recorrentes`
--

LOCK TABLES `lancamento_recorrentes` WRITE;
/*!40000 ALTER TABLE `lancamento_recorrentes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamento_recorrentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamento_taxas`
--

DROP TABLE IF EXISTS `lancamento_taxas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamento_taxas` (
  `id_lancamento` int(10) unsigned NOT NULL,
  `id_receita_calculos` int(10) unsigned NOT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_lancamento`),
  KEY `lancamento_taxas_id_receita_calculos_foreign` (`id_receita_calculos`),
  KEY `lancamento_taxas_id_imovel_foreign` (`id_imovel`),
  CONSTRAINT `lancamento_taxas_id_imovel_foreign` FOREIGN KEY (`id_imovel`) REFERENCES `imovel` (`id`),
  CONSTRAINT `lancamento_taxas_id_lancamento_foreign` FOREIGN KEY (`id_lancamento`) REFERENCES `lancamentos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lancamento_taxas_id_receita_calculos_foreign` FOREIGN KEY (`id_receita_calculos`) REFERENCES `receita_calculos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento_taxas`
--

LOCK TABLES `lancamento_taxas` WRITE;
/*!40000 ALTER TABLE `lancamento_taxas` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamento_taxas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamentos`
--

DROP TABLE IF EXISTS `lancamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `valor` decimal(15,2) NOT NULL,
  `saldo_receber` decimal(15,2) NOT NULL,
  `id_conta` int(10) unsigned DEFAULT NULL,
  `descricao` text COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `categoria` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=> Taxa, 2=> Fundo, 3=> Juridico, 4=> Custas, 5=> Multa, 6=>Juros, 7=> Descontos, 8=> Outros',
  `id_centro_custo` int(10) unsigned DEFAULT NULL COMMENT 'ID Centro de custo',
  `permanente` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N' COMMENT 'Flag para identificação de lançamentos permanentes que compõe o histórico do recebimento. Valores aceitos: S = Sim e N = Não',
  PRIMARY KEY (`id`),
  KEY `lancamentos_id_centro_custo_foreign` (`id_centro_custo`),
  KEY `lancamentos_id_conta_foreign` (`id_conta`),
  CONSTRAINT `lancamentos_id_centro_custo_foreign` FOREIGN KEY (`id_centro_custo`) REFERENCES `centro_custos` (`id`),
  CONSTRAINT `lancamentos_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamentos`
--

LOCK TABLES `lancamentos` WRITE;
/*!40000 ALTER TABLE `lancamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamentos_estimados`
--

DROP TABLE IF EXISTS `lancamentos_estimados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamentos_estimados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `valor` decimal(15,2) NOT NULL,
  `id_conta` int(10) unsigned NOT NULL,
  `fundo_reserva` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lancamentos_estimados_id_conta_foreign` (`id_conta`),
  CONSTRAINT `lancamentos_estimados_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamentos_estimados`
--

LOCK TABLES `lancamentos_estimados` WRITE;
/*!40000 ALTER TABLE `lancamentos_estimados` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamentos_estimados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout_remessas`
--

DROP TABLE IF EXISTS `layout_remessas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layout_remessas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout_remessas`
--

LOCK TABLES `layout_remessas` WRITE;
/*!40000 ALTER TABLE `layout_remessas` DISABLE KEYS */;
INSERT INTO `layout_remessas` VALUES (1,'CNAB400','2021-02-09 23:01:19','2021-02-09 23:01:19'),(2,'CNAB240','2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `layout_remessas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout_retornos`
--

DROP TABLE IF EXISTS `layout_retornos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layout_retornos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout_retornos`
--

LOCK TABLES `layout_retornos` WRITE;
/*!40000 ALTER TABLE `layout_retornos` DISABLE KEYS */;
INSERT INTO `layout_retornos` VALUES (1,'CNAB400','2021-02-09 23:01:19','2021-02-09 23:01:19'),(2,'CNAB240','2021-02-09 23:01:19','2021-02-09 23:01:19');
/*!40000 ALTER TABLE `layout_retornos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liberacao`
--

DROP TABLE IF EXISTS `liberacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liberacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_liberacao` datetime DEFAULT NULL,
  `descricao` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_atendente` int(11) DEFAULT NULL,
  `id_morador_autorizante` int(11) NOT NULL DEFAULT 0,
  `obs` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nome` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mae` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nascimento` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cpf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexo` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'm',
  `tipo_pessoa` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_prestador` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_pessoa_liberada` int(11) DEFAULT NULL,
  `id_validade_liberacao` int(10) unsigned DEFAULT NULL,
  `uid_grupo_liberacao` int(11) DEFAULT NULL,
  `empresa` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cargo` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `placa` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cor` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_veiculo` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `origem` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `excluida` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_exclusao` datetime DEFAULT NULL,
  `id_pessoa_exclusao` int(11) DEFAULT NULL,
  `codigo` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `documento_visitante` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orgao_expeditor_visitante` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `utilizada` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_lista_convidados` int(10) unsigned NOT NULL DEFAULT 0,
  `cnh_numero` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cnh_categoria` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cnh_data_venc` date DEFAULT NULL,
  `foto_rosto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foto_documento` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entrada_acompanhante` tinyint(1) NOT NULL DEFAULT 1,
  `expressa` tinyint(1) NOT NULL DEFAULT 0,
  `clube` tinyint(1) NOT NULL DEFAULT 0,
  `id_saldo_convite` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_4` (`id_pessoa_liberada`,`tipo_pessoa`,`excluida`,`id_validade_liberacao`),
  KEY `index_2` (`tipo_pessoa`,`excluida`,`id_validade_liberacao`) USING BTREE,
  KEY `index_3` (`tipo_pessoa`,`nome`,`excluida`,`id_validade_liberacao`) USING BTREE,
  KEY `Index_6` (`tipo_pessoa`,`excluida`) USING BTREE,
  KEY `I_ID_VALIDADE_LIBERACAO` (`id_validade_liberacao`),
  KEY `I_TIPO_PRESTADOR` (`tipo_prestador`),
  KEY `I__PESSOA_LIBERADA` (`id_pessoa_liberada`),
  KEY `I_ORIGEM_ID_LISTA_EXCLUIDA` (`origem`,`id_lista_convidados`,`excluida`),
  KEY `I_UID_GRUPO_LIBERACAO` (`uid_grupo_liberacao`)
) ENGINE=InnoDB AUTO_INCREMENT=1262 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liberacao`
--

LOCK TABLES `liberacao` WRITE;
/*!40000 ALTER TABLE `liberacao` DISABLE KEYS */;
INSERT INTO `liberacao` VALUES (1,'2019-12-02 14:49:22',NULL,1,4,'Ira entre só ela mesma.','MARIA','NENE','01/10/1981','62910939282','41576335046','f','v',NULL,9,48,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:22',4,NULL,NULL,'','s',0,'123131231','a','2033-01-01',NULL,NULL,0,0,0,NULL),(2,'2019-12-02 14:53:10',NULL,NULL,4,NULL,'João uber',NULL,'','','',NULL,'p','t',NULL,49,NULL,'TAXI/UBER','MOTORISTA','FGFF232',NULL,NULL,NULL,'s','s','2019-12-02 14:53:19',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(3,'2019-12-02 14:56:05',NULL,1,4,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,51,NULL,'Taxi/Uber','Motorista','12343gf','GOl','branco',NULL,'s','s','2019-12-13 16:15:22',4,NULL,NULL,'','s',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(4,'2019-12-02 15:09:15',NULL,1,4,'Entrega','RAFAEL','DALVA','01/01/2009','62438827273','49794648078','m','p','e',11,53,NULL,'Big lar','Entregador',NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:22',4,NULL,NULL,'','s',0,'12313122332','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(5,'2019-12-02 15:18:46',NULL,NULL,4,NULL,'Gil',NULL,'','','',NULL,'p','',NULL,54,NULL,'Hgv','Adm','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(6,'2019-12-02 17:06:15',NULL,NULL,1,NULL,'Kkj',NULL,'','','',NULL,'v','',NULL,55,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(7,'2019-12-03 17:36:23',NULL,NULL,4,NULL,'wwww',NULL,'','','',NULL,'p','',NULL,56,NULL,'teste','teste','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(8,'2019-12-03 17:36:55',NULL,NULL,4,NULL,'ff',NULL,'','','',NULL,'p','e',NULL,57,NULL,'ee123','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(9,'2019-12-03 17:37:13',NULL,NULL,4,NULL,'ff',NULL,'','','',NULL,'v','',NULL,58,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(10,'2019-12-03 18:12:29',NULL,1,1,NULL,'PESSOA 1','M','05/05/2000','44444444444',NULL,'m','v',NULL,14,59,1575407574,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'trh543','STH','s',0,'34t34','a','2026-06-06','tmp/15754075495de6cfbdbeb46.jpeg',NULL,1,0,0,NULL),(11,'2019-12-03 18:12:31',NULL,1,1,NULL,'PESSOA 2','N','03/03/2003','33333333333',NULL,'m','v',NULL,15,60,1575407574,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'dfgbhfyjh','TYJETY','s',0,'ggh','d','2020-06-06','tmp/15754075515de6cfbf262c0.jpeg',NULL,1,0,0,NULL),(12,'2019-12-03 18:12:32',NULL,1,1,NULL,'PESSOA 3','KJ','09/09/1999','67456745674','54278951167','m','v',NULL,16,61,1575407574,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'54278951167','CPF','s',0,'a','a','2201-05-05',NULL,NULL,1,0,0,NULL),(13,'2019-12-03 18:15:07',NULL,1,1,NULL,'TESTE','M','01/01/2000','67464674657',NULL,'m','v',NULL,17,62,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'opuh098','KJHG','s',0,'tyjh','c','2021-05-05',NULL,NULL,1,0,0,NULL),(14,'2019-12-04 09:46:00',NULL,1,1,NULL,'ASDSAD','ADADSD','22/12/2000','12322132321',NULL,'m','v',NULL,18,63,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'teste','TESTE','s',0,'5456654','b','2020-12-12',NULL,NULL,1,0,0,NULL),(15,'2019-12-04 09:52:05',NULL,1,19,NULL,'SHHS','SDAD','12/12/2000','62655656666','85225648258','m','v',NULL,20,65,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,'ssad','a','2020-12-13',NULL,NULL,0,0,0,NULL),(16,'2019-12-04 09:59:52',NULL,1,4,'My teste','MARIO','MARIA','01/01/1989','62938484378','94995611029','m','v',NULL,21,67,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','s',0,'123123123','ac','2033-01-01',NULL,NULL,1,0,0,NULL),(17,'2019-12-04 10:20:02',NULL,1,4,'My teste','MARIO','MARIA','01/01/1989','62938484378','94995611029','m','v',NULL,21,70,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:22',4,NULL,NULL,'','s',0,'12312313','c','2033-01-01',NULL,NULL,1,0,0,NULL),(18,'2019-12-04 10:22:09',NULL,1,1,NULL,'RAFAEL','M','05/05/2000','55555555555',NULL,'m','v',NULL,22,71,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'ergerg','RGERG','s',0,'6uy65u56','a','2020-06-06',NULL,NULL,1,0,0,NULL),(19,'2019-12-04 10:24:03',NULL,1,3,NULL,'HTYHTYH','M','06/09/2000','44444444444',NULL,'m','v',NULL,23,72,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'tyhtyhy','TYH','n',0,'tyj','c','2050-01-01',NULL,NULL,1,0,0,NULL),(20,'2019-12-04 10:25:23',NULL,1,2,NULL,'TESTE','NM','08/08/2000','45643645643',NULL,'m','v',NULL,24,73,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'e3t43','RGWER','n',0,'4675y','b','2020-08-09',NULL,NULL,1,0,0,NULL),(21,'2019-12-04 10:32:59',NULL,1,19,NULL,'JOAO','SADSAD','13/06/1991','62662666565','14450594959','m','v',NULL,26,77,1575466388,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'ss1d','a','2020-12-12',NULL,NULL,1,0,0,NULL),(22,'2019-12-04 10:33:00',NULL,1,19,NULL,'JOAQUIM','6S6D5','11/12/2000','62626266662','66548251520','f','v',NULL,27,78,1575466388,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'sdsdds','b','2020-12-12','tmp/15754663805de7b58c16331.jpeg',NULL,0,0,0,NULL),(23,'2019-12-04 10:34:03',NULL,1,25,NULL,'VISITANTE','N','09/09/2000','55555555555',NULL,'m','v',NULL,28,81,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1234','W45H5','n',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(24,'2019-12-04 10:33:00',NULL,1,19,NULL,'SDASDSA','ASDAD','12/12/1909','36626226262','51644627612','m','v',NULL,29,79,1575466388,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'sdsad2','SDS','s',0,'2323','b','2020-12-12',NULL,NULL,1,0,0,NULL),(25,'2019-12-04 10:34:39',NULL,1,25,NULL,'VISITANTE','N','09/09/2000','55555555555',NULL,'m','v',NULL,28,82,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1234','W45H5','n',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(26,'2019-12-04 10:50:41',NULL,1,19,NULL,'65SD6','2323','12/12/2000',NULL,NULL,'m','v',NULL,NULL,86,1575467122,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'doc','TESTE','n',0,'asdas','b','2200-12-12','tmp/15754674415de7b9b14da77.jpeg',NULL,1,0,0,NULL),(27,'2019-12-04 10:53:24',NULL,1,3,NULL,'PESSOA 1','4546456','12/12/2000','12312312313',NULL,'m','v',NULL,30,87,1575467630,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'pessoa1','1','s',0,'456456','b','2200-12-12','tmp/15754676045de7ba544d925.jpeg',NULL,1,0,0,NULL),(28,'2019-12-04 10:53:24',NULL,1,3,NULL,'PESSOA 2','2SA2D1','21/12/2000','3212212121',NULL,'f','v',NULL,31,88,1575467630,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'pessoa2','2','s',0,'sd1sd','a','2020-12-12','tmp/15754676045de7ba54daa80.jpeg',NULL,1,0,0,NULL),(29,'2019-12-04 10:53:25',NULL,1,3,NULL,'PESSOA 3','56SD','12/11/1999','32323223333',NULL,'f','v',NULL,32,89,1575467630,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'pessoa 3','3','s',0,'s65d456sd','b','2020-12-12','tmp/15754676055de7ba556fd97.jpeg',NULL,1,0,0,NULL),(30,'2019-12-04 10:54:23',NULL,NULL,4,'Teste','Ana',NULL,'','','',NULL,'v','',NULL,90,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-04 10:54:36',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(31,'2019-12-04 10:54:53',NULL,NULL,4,NULL,'Lurde',NULL,'','','',NULL,'v','',NULL,91,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-04 11:06:44',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(32,'2019-12-04 11:06:35',NULL,NULL,4,NULL,'123123',NULL,'','','',NULL,'v','',NULL,92,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-04 11:06:42',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(33,'2019-12-04 11:06:51',NULL,1,19,NULL,'PESSOA 4','132123','12/12/2000','62986566566',NULL,'m','v',NULL,33,93,1575468437,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'pessoa4','4','s',0,'21254','ab','2020-12-12','tmp/15754684115de7bd7ba2ae1.jpeg',NULL,1,0,0,NULL),(34,'2019-12-04 11:06:52',NULL,1,19,NULL,'PESSOA 5','2122','12/12/2000','65566545456',NULL,'m','v',NULL,34,94,1575468437,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'pessoa5','5','s',0,'sd2121','a','2020-12-12','tmp/15754684125de7bd7c69395.jpeg',NULL,1,0,0,NULL),(35,'2019-12-04 11:10:39',NULL,1,19,NULL,'PESSOA 6','21S2D','12/12/2000','62626666262','71678269956','m','v',NULL,35,95,1575468665,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'pessoa6','6','s',0,'s2d12','b','2020-12-12','tmp/15754686395de7be5f8d3fc.jpeg',NULL,1,0,0,NULL),(36,'2019-12-04 11:10:40',NULL,1,19,NULL,'PESSOA 7','SD4D54','12/12/2000','32163616665','53900620784','m','v',NULL,36,96,1575468665,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'pessoa7','7','s',0,'5s4d5','a','2020-12-12','tmp/15754686405de7be6040e80.jpeg',NULL,1,0,0,NULL),(37,'2019-12-04 11:22:35',NULL,NULL,4,NULL,'ana',NULL,'','','',NULL,'v','',NULL,97,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-04 11:51:03',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(38,'2019-12-04 11:22:59',NULL,NULL,4,NULL,'teste',NULL,'','','',NULL,'p','',NULL,98,NULL,'qweqw','qweqwe','',NULL,NULL,NULL,'s','s','2019-12-04 11:51:01',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(39,'2019-12-04 11:25:35',NULL,NULL,4,NULL,'Ge',NULL,'','','',NULL,'v','',NULL,99,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-04 11:50:59',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(40,'2019-12-04 11:26:02',NULL,NULL,4,NULL,'Tee',NULL,'','','',NULL,'p','t',NULL,100,NULL,'TAXI/UBER','MOTORISTA','FGGF122',NULL,NULL,NULL,'s','s','2019-12-04 11:50:55',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(41,'2019-12-04 11:49:55',NULL,NULL,4,NULL,'ee',NULL,'','','',NULL,'v','',NULL,101,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-04 11:50:53',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(42,'2019-12-04 13:52:38',NULL,NULL,4,NULL,'tt',NULL,'','','',NULL,'v','',NULL,102,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-04 13:52:42',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(43,'2019-12-04 15:29:07',NULL,NULL,4,NULL,'Tio',NULL,'','','',NULL,'v','',NULL,103,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(44,'2019-12-04 15:59:07',NULL,1,19,NULL,'ASDASDS','0000000000','12/12/2000','12121212121','99919172928','m','v',NULL,37,104,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(45,'2019-12-04 16:01:43',NULL,1,19,NULL,'BADASDAS','ASDASDSA','12/12/2000','12121211212','62765012717','m','v',NULL,38,105,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'ad2asdaed2','b','2020-12-12',NULL,NULL,1,0,0,NULL),(46,'2019-12-04 16:03:45',NULL,1,19,NULL,'ASDASDSA','202D0','12/12/2000','62986565145','70666483310','m','v',NULL,NULL,106,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'s2d0s2','c',NULL,NULL,NULL,1,0,0,NULL),(47,'2019-12-04 16:03:51',NULL,1,19,NULL,'ASDASDSA','202D0','12/12/2000','62986565145','70666483310','m','v',NULL,40,107,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'s2d0s2','c','2020-12-12',NULL,NULL,1,0,0,NULL),(48,'2019-12-04 17:39:01',NULL,1,19,NULL,'ASSADASDASD','0000','12/12/2000','12231232132','02746045400','m','v',NULL,41,108,1575491967,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'000','c','2020-12-12','tmp/15754919415de81965cdc36.jpeg',NULL,1,0,0,NULL),(49,'2019-12-04 17:39:03',NULL,1,19,NULL,'DDASDASD','000000','12/12/2000','11212121121','67176281629','m','v',NULL,42,109,1575491967,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'0000','d','2020-12-12','tmp/15754919435de81967288aa.jpeg',NULL,1,0,0,NULL),(50,'2019-12-06 09:49:01',NULL,1,25,NULL,'PESSOA 1','N','05/05/2000','45635634563',NULL,'m','v',NULL,43,110,1575636570,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'erg345','WRETGH','s',0,'l','b','2021-05-05','tmp/15756365415dea4e3d42f51.jpeg',NULL,1,0,0,NULL),(51,'2019-12-06 09:49:02',NULL,1,25,NULL,'PESSOA 2','M','01/01/2000','45635643563',NULL,'m','v',NULL,44,111,1575636570,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'45t45t','435T35','s',0,'j','a','2020-01-01','tmp/15756365425dea4e3ecb8e3.jpeg',NULL,1,0,0,NULL),(52,'2019-12-09 16:28:39',NULL,NULL,4,'My teste','MARIO','MARIA','01011989','62938484378','94995611029','m','v','',21,114,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(53,'2019-12-10 10:43:50',NULL,NULL,4,NULL,'MARIO',NULL,NULL,NULL,NULL,NULL,'v',NULL,21,128,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',16,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(54,'2019-12-10 10:44:14',NULL,NULL,4,NULL,'JOÃO UBER',NULL,NULL,NULL,NULL,NULL,'v',NULL,10,129,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',16,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(55,'2019-12-10 10:47:33',NULL,NULL,4,NULL,'ANA',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,130,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-11 12:03:10',4,NULL,NULL,'','n',17,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(56,'2019-12-10 10:47:33',NULL,NULL,4,NULL,'MARCELA',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,131,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-11 12:03:10',4,NULL,NULL,'','n',17,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(57,'2019-12-10 15:39:41',NULL,NULL,1,NULL,'Ueue',NULL,'','','',NULL,'v','',NULL,132,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-10 17:24:51',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(58,'2019-12-10 16:21:56',NULL,NULL,1,NULL,'Nsns',NULL,'','','',NULL,'p','t',NULL,133,NULL,'TAXI/UBER','MOTORISTA','ABDSjjs',NULL,NULL,NULL,'s','s','2019-12-10 17:24:50',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(59,'2019-12-10 16:23:08',NULL,NULL,1,NULL,'Keke',NULL,'','','',NULL,'p','e',NULL,134,NULL,'Ekek','ENTREGADOR','',NULL,NULL,NULL,'s','s','2019-12-10 16:33:24',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(60,'2019-12-10 16:28:17',NULL,NULL,1,NULL,'Ff',NULL,'','','',NULL,'v','',NULL,135,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-10 16:33:22',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(61,'2019-12-10 16:29:17',NULL,NULL,1,NULL,'Nsjs',NULL,'','','04311617127',NULL,'v','',NULL,136,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-10 16:33:21',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(62,'2019-12-10 17:24:46',NULL,NULL,1,NULL,'Teste',NULL,'','','',NULL,'v','',NULL,137,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(63,'2019-12-10 17:25:39',NULL,NULL,1,'Nehehejeje','Teste2','Sjssjn','16022000','66666666666','88112067660',NULL,'v','',NULL,138,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(64,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'Ffj',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,139,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(65,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'Ggg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,140,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(66,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'Gggh',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,141,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(67,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'JOÃO UBER',NULL,NULL,NULL,NULL,NULL,'v',NULL,10,142,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(68,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'JOÃO UBER',NULL,NULL,NULL,NULL,NULL,'v',NULL,10,143,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(69,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'MARIA',NULL,NULL,NULL,NULL,NULL,'v',NULL,9,144,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(70,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'MARIO',NULL,NULL,NULL,NULL,NULL,'v',NULL,21,145,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(71,'2019-12-10 17:51:32',NULL,NULL,4,NULL,'MARIO',NULL,NULL,NULL,NULL,NULL,'v',NULL,21,146,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',18,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(72,'2019-12-11 12:03:47',NULL,NULL,4,NULL,'JOÃO UBER',NULL,NULL,NULL,NULL,NULL,'v',NULL,10,147,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',19,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(73,'2019-12-11 12:03:47',NULL,NULL,4,NULL,'MARIO',NULL,NULL,NULL,NULL,NULL,'v',NULL,21,148,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','n',19,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(74,'2019-12-11 12:03:47',NULL,NULL,4,NULL,'RAFAEL',NULL,NULL,NULL,NULL,NULL,'v',NULL,11,149,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:20',4,NULL,NULL,'','n',19,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(75,'2019-12-11 15:25:47',NULL,1,1,NULL,'JOAQUIM','',NULL,NULL,NULL,'m','v',NULL,NULL,154,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(76,'2019-12-11 15:26:07',NULL,1,1,NULL,'POVÃO','',NULL,NULL,NULL,'m','v',NULL,NULL,155,1576088804,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(77,'2019-12-11 15:26:07',NULL,1,1,NULL,'TESTE','',NULL,NULL,NULL,'m','v',NULL,NULL,156,1576088804,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(78,'2019-12-12 10:10:23',NULL,NULL,19,NULL,'Cpf',NULL,'','','56896403365',NULL,'v','',NULL,157,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(79,'2019-12-12 10:13:23',NULL,1,19,NULL,'CPF DO BRUNO','ASDAS','22/10/2000','11111111111','04311617127','m','v',NULL,46,159,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','b','2020-11-11',NULL,NULL,0,0,0,NULL),(80,'2019-12-12 10:16:35',NULL,1,19,NULL,'CPF DO BRUNO 2','TRES','13/01/2000','33333333333','04311617127','f','v',NULL,47,161,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(81,'2019-12-12 10:19:22',NULL,1,1,NULL,'BRUNO 4','4','14/04/2004','44444444444',NULL,'m','v',NULL,48,162,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'as56d4','6SD6S6','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(82,'2019-12-12 10:22:23',NULL,1,1,NULL,'BRUNO 5','ASDAD','15/05/2005','55555555555','04311617127','m','v',NULL,49,163,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(83,'2019-12-12 15:27:21',NULL,1,1,NULL,'VISITANTE','11','11/11/2001','11111111111','97653472001','m','v',NULL,50,174,1576172899,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'hjkkjhk25','c','2020-12-12',NULL,NULL,1,0,0,NULL),(84,'2019-12-12 15:27:21',NULL,1,1,NULL,'PRESTADOR','2','22/12/2002',NULL,'35371040498','m','p',NULL,51,175,1576172899,'empresa','cargo',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'hjgjghu','c','2020-12-12',NULL,NULL,1,0,0,NULL),(85,'2019-12-12 15:27:22',NULL,1,1,NULL,'TAXI','4','13/03/2003',NULL,'22363628039','m','p','t',52,176,1576172899,'Taxi/Uber','Motorista','asd4s56','a6s5d4sa','as6d4',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'dasd2eae2','a','2020-12-12',NULL,NULL,1,0,0,NULL),(86,'2019-12-12 15:27:22',NULL,1,1,NULL,'ENTREGAS','4','14/04/2004',NULL,'38833731847','m','p','e',53,177,1576172899,'entregas','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'123','a','2020-12-12',NULL,NULL,1,0,0,NULL),(87,'2019-12-12 16:05:12',NULL,NULL,19,NULL,'CPF DO BRUNO 2',NULL,NULL,NULL,NULL,NULL,'v',NULL,47,178,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 11:33:24',19,NULL,NULL,'','n',20,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(88,'2019-12-12 16:13:03',NULL,NULL,19,NULL,'SHHS',NULL,NULL,NULL,NULL,NULL,'v',NULL,20,179,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 11:33:24',19,NULL,NULL,'','n',20,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(89,'2019-12-12 16:23:30',NULL,NULL,19,NULL,'CPF DO BRUNO 2',NULL,NULL,NULL,NULL,NULL,'v',NULL,47,180,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',21,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(90,'2019-12-12 16:23:30',NULL,NULL,19,NULL,'CPF DO BRUNO 2',NULL,NULL,NULL,NULL,NULL,'v',NULL,47,181,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',21,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(91,'2019-12-12 16:23:30',NULL,NULL,19,NULL,'CPF DO BRUNO 2',NULL,NULL,NULL,NULL,NULL,'v',NULL,47,182,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',21,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(92,'2019-12-12 17:35:07',NULL,NULL,19,NULL,'Shsh',NULL,'','','',NULL,'v','',NULL,183,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 10:28:42',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(93,'2019-12-13 08:50:43',NULL,NULL,1,NULL,'Udkkd',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,184,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-16 09:03:59',1,NULL,NULL,'','n',22,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(94,'2019-12-13 10:15:25',NULL,NULL,19,'Obs','Cpf','Shhs','12122000','46464494499','04311617127',NULL,'v','',NULL,185,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 10:28:41',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(95,'2019-12-13 10:21:37',NULL,NULL,19,NULL,'Hh',NULL,'','','',NULL,'v','',NULL,186,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 10:28:39',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(96,'2019-12-13 10:27:00',NULL,1,19,NULL,'VISITANTE','654SD5','11/11/2000','21231222323','18202476356','m','v',NULL,57,193,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(97,'2019-12-13 10:26:40',NULL,1,19,'Hahaa','VISITANTE PRE CADASTRADO','SJSJ','12/12/2000','49949494979','34874551025','m','v',NULL,56,192,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(98,'2019-12-13 10:27:53',NULL,NULL,19,NULL,'VISITANTE','654SD5','11112000','21231222323','18202476356','m','v','',57,194,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 10:28:38',19,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(99,'2019-12-13 10:28:47',NULL,NULL,19,NULL,'VISITANTE','654SD5','11112000','21231222323','18202476356','m','v','',57,195,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 10:29:13',19,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(100,'2019-12-13 10:28:52',NULL,NULL,19,'Hahaa','VISITANTE PRE CADASTRADO','SJSJ','12122000','49949494979','34874551025','m','v','',56,196,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 10:29:12',19,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(101,'2019-12-13 10:29:22',NULL,NULL,19,'1','VISITANTE','654SD5','11112000','21231222323','18202476356','m','v','',57,197,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(102,'2019-12-13 10:29:31',NULL,NULL,19,'1','VISITANTE PRE CADASTRADO','SJSJ','12122000','49949494979','34874551025','m','v','',56,198,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(103,'2019-12-13 10:34:54',NULL,NULL,19,NULL,'CPF DO BRUNO','ASDAS','22102000','11111111111','04311617127','m','v','',46,199,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(104,'2019-12-13 11:21:29',NULL,1,19,'Sjjsjs','PREATDOR','SJD','12/12/1955','62987646464','66597183703','m','p',NULL,59,204,NULL,'Jsjsj','Jddj',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(105,'2019-12-13 11:21:15',NULL,1,19,NULL,'PREATDOR 2','55','11/11/1955','66565666666','25245126575','m','p',NULL,58,202,NULL,'Jwj','Sjjs',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(106,'2019-12-13 11:22:31',NULL,NULL,19,'Sjjsjs','PREATDOR','SJD','12121955','62987646464','66597183703','m','p','',59,205,NULL,'Jsjsj','Jddj','',NULL,NULL,NULL,'s','s','2019-12-13 11:26:14',19,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(107,'2019-12-13 11:23:53',NULL,1,19,'Muito baderneiro. Ficar de olho.','PREATDOR','SJD','12/12/1955','62987646464','66597183703','m','v',NULL,59,206,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'66597183703','CPF','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(108,'2019-12-13 11:26:41',NULL,1,19,'Muito baderneiro. Ficar de olho.','PREATDOR','SJD','12/12/1955','62987646464','66597183703','m','v',NULL,59,207,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'66597183703','CPF','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(109,'2019-12-13 11:27:06',NULL,NULL,19,'Sjjsjs','PREATDOR','SJD','12121955','62987646464','66597183703','m','p','',59,208,NULL,'Jsjsj','Jddj','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'66597183703','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(110,'2019-12-13 11:34:12',NULL,NULL,19,NULL,'Antoim',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,209,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',23,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(111,'2019-12-13 11:34:12',NULL,NULL,19,NULL,'CPF DO BRUNO 2',NULL,NULL,NULL,NULL,NULL,'v',NULL,47,210,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',23,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(112,'2019-12-13 11:34:12',NULL,NULL,19,NULL,'PREATDOR',NULL,NULL,NULL,NULL,NULL,'v',NULL,59,211,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',23,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(113,'2019-12-13 11:34:12',NULL,NULL,19,NULL,'Skksks',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,212,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',23,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(114,'2019-12-13 11:34:12',NULL,NULL,19,NULL,'VISITANTE PRE CADASTRADO',NULL,NULL,NULL,NULL,NULL,'v',NULL,56,213,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',23,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(115,'2019-12-13 11:34:53',NULL,NULL,19,NULL,'Uai',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,214,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',24,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(116,'2019-12-13 11:36:56',NULL,NULL,19,NULL,'Djjd',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,215,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',25,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(117,'2019-12-13 11:38:06',NULL,NULL,19,NULL,'Nsnd',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,216,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',26,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(118,'2019-12-13 14:09:38',NULL,1,4,'Teste','JDE','MARIA','01/01/2000','63721737237','47391768073','m','v',NULL,60,218,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:21',4,NULL,NULL,'','s',0,'314348218','a','2033-01-01',NULL,NULL,0,0,0,NULL),(119,'2019-12-13 14:14:26',NULL,1,4,'Teste !!','JDE','MARIA','01/01/2000','63721737237','47391768073','m','v',NULL,60,222,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:20',4,NULL,NULL,'','s',0,'e131231','b','2023-01-01',NULL,NULL,0,0,0,NULL),(120,'2019-12-13 14:34:13',NULL,1,4,'>>> teste','JDE','MARIA','01/01/2001','63721737237','47391768073','m','v',NULL,60,227,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-13 16:15:20',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(121,'2019-12-13 15:47:33',NULL,NULL,4,'','MARIO',NULL,'','','',NULL,'v','',21,228,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 16:15:30',4,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(122,'2019-12-13 16:10:42',NULL,NULL,4,'','MARIO',NULL,'','','',NULL,'v','',21,229,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 16:15:28',4,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(123,'2019-12-13 16:12:57',NULL,NULL,4,'','MARIO',NULL,'','','32199076016',NULL,'v','',21,230,NULL,'','','',NULL,NULL,NULL,'s','s','2019-12-13 16:15:26',4,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(124,'2019-12-13 16:24:22',NULL,1,4,'Mais uma observação','ANA','MARIA','23/10/1983','62939392882','92173196006','f','v',NULL,61,237,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,'123321','c','2033-12-20',NULL,NULL,1,0,0,NULL),(125,'2019-12-13 16:19:38',NULL,1,3,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','v',NULL,10,233,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1231313','CNH','s',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(126,'2019-12-13 16:28:54',NULL,1,3,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','v',NULL,10,238,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1231313','CNH','s',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(127,'2019-12-13 16:28:50',NULL,NULL,4,'','Vitor',NULL,'10/23/1990','','',NULL,'v','',NULL,239,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(128,'2019-12-13 17:12:35',NULL,1,1,NULL,'OUTRO CADASTRO','5','11/11/2000','63545656465','04311617127','m','v',NULL,62,240,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(129,'2019-12-13 17:15:20',NULL,1,1,NULL,'BRUNO 5 ALTERADO','ASDAD','15/05/2005','55555555555','04311617127','m','v',NULL,49,242,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'04311617127','CPF','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(130,'2019-12-13 17:32:59',NULL,1,19,NULL,'VISITANTE','654SD5','11/11/2000','21231222323','18202476356','m','v',NULL,57,246,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(131,'2019-12-13 17:33:17',NULL,1,1,NULL,'CPF DO BRUNO','ASDAS','22/10/2000','11111111111','04311617127','m','v',NULL,46,248,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'04311617127','CPF','n',0,'asdasd','b','2020-11-11',NULL,NULL,1,0,0,NULL),(132,'2019-12-13 17:34:38',NULL,1,1,NULL,'FFDASF','',NULL,NULL,NULL,'m','v',NULL,NULL,249,1576269318,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(133,'2019-12-13 18:00:07',NULL,1,1,NULL,'P1','1','11/11/2000','11111111111','73223934650','m','v',NULL,63,250,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'asdasd','b','2020-11-11',NULL,NULL,1,0,0,NULL),(134,'2019-12-13 18:00:39',NULL,1,1,NULL,'ASDADDA','52165','11/11/2000','11111111111','73223934650','m','v',NULL,64,251,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'5456456','a','2020-10-02',NULL,NULL,1,0,0,NULL),(135,'2019-12-16 08:31:20',NULL,NULL,1,'Hahaha','Obd',NULL,NULL,'','',NULL,'v','',NULL,252,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL),(136,'2019-12-16 09:04:10',NULL,NULL,1,NULL,'Sjs',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,259,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',27,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(137,'2019-12-16 09:07:52',NULL,1,1,NULL,'ASDSAD2','21D','11/11/2000','21122112121','65917001960','m','v',NULL,65,261,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asds321d','d','2020-11-11',NULL,NULL,1,0,0,NULL),(138,'2019-12-16 11:49:31',NULL,NULL,4,NULL,'Jader',NULL,NULL,NULL,NULL,NULL,'v','',NULL,267,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-16 11:52:06',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(139,'2019-12-16 12:02:03',NULL,1,4,NULL,'JADER','MARIA','01/01/2000','62938273728','49659380038','m','v',NULL,67,271,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,'123123123','e','2033-01-01',NULL,NULL,1,0,0,NULL),(140,'2019-12-16 12:03:15',NULL,1,4,NULL,'TESTE','ANA','01/01/2000','62373273772','63814875001','m','p',NULL,68,272,NULL,'Teste','Teste',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,'12313123','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(141,'2019-12-16 12:04:12',NULL,1,4,NULL,'TESTE ENT','JOANA','01/01/2000','00000000000','25883904041','m','p','e',69,273,NULL,'Locarga','Entregador',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(142,'2019-12-16 12:05:23',NULL,1,4,NULL,'MY UBER','HEBE','01/01/2000','00000000000','07601175006','m','p','t',70,274,NULL,'Taxi/Uber','Motorista','3333333','gol','preto',NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(143,'2019-12-16 12:06:18',NULL,NULL,4,NULL,'JADER',NULL,NULL,NULL,NULL,'m','v','',67,275,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(144,'2019-12-16 12:06:18',NULL,NULL,4,NULL,'JADER',NULL,NULL,NULL,NULL,'m','v','',67,276,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(145,'2019-12-16 12:12:31',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,277,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',28,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(146,'2019-12-16 12:16:24',NULL,NULL,4,NULL,'Mario',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,278,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',29,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(147,'2019-12-16 13:54:18',NULL,NULL,4,NULL,'Joao',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,279,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',30,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(148,'2019-12-16 14:04:07',NULL,NULL,4,NULL,'Gio',NULL,NULL,NULL,NULL,NULL,'p','',NULL,280,NULL,'Teste','Algum',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(149,'2019-12-16 14:27:47',NULL,NULL,4,NULL,'Jone',NULL,NULL,NULL,NULL,NULL,'p','e',NULL,281,NULL,'Novo Mundo','ENTREGADOR',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(150,'2019-12-16 16:09:56',NULL,NULL,19,NULL,'Tsset',NULL,NULL,NULL,NULL,NULL,'v','',NULL,282,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(151,'2019-12-16 16:10:05',NULL,NULL,19,NULL,'Yeyse',NULL,NULL,NULL,NULL,NULL,'p','',NULL,283,NULL,'Nsn','Sjjs',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(152,'2019-12-16 16:10:11',NULL,NULL,19,NULL,'Sjjs',NULL,NULL,NULL,NULL,NULL,'p','t',NULL,284,NULL,'TAXI/UBER','MOTORISTA',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(153,'2019-12-16 16:10:19',NULL,NULL,19,NULL,'Jsjs',NULL,NULL,NULL,NULL,NULL,'p','e',NULL,285,NULL,'Nzn','ENTREGADOR',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(154,'2019-12-16 16:10:37',NULL,NULL,19,NULL,'Sjjs',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,286,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',31,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(155,'2019-12-16 16:10:37',NULL,NULL,19,NULL,'Tsst',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,287,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',31,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(156,'2019-12-17 08:32:06',NULL,NULL,19,NULL,'PREATDOR',NULL,NULL,NULL,NULL,NULL,'v',NULL,59,288,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',32,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(157,'2019-12-17 08:32:06',NULL,NULL,19,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,289,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',32,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(158,'2019-12-17 08:32:06',NULL,NULL,19,NULL,'Teste2',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,290,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',32,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(159,'2019-12-17 09:39:19',NULL,NULL,4,NULL,'Outro Pre',NULL,NULL,NULL,NULL,NULL,'p','',NULL,291,NULL,'Teste','New',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(160,'2019-12-17 10:06:20',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,292,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 10:11:21',4,NULL,NULL,'','n',33,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(161,'2019-12-17 10:13:29',NULL,NULL,4,NULL,'Bia',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,293,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 11:59:52',4,NULL,NULL,'','n',34,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(162,'2019-12-17 10:13:29',NULL,NULL,4,NULL,'Mariana',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,294,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 11:59:52',4,NULL,NULL,'','n',34,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(163,'2019-12-17 10:13:29',NULL,NULL,4,NULL,'Raquel',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,295,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 11:59:52',4,NULL,NULL,'','n',34,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(164,'2019-12-17 10:30:35',NULL,NULL,1,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,296,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 10:02:52',1,NULL,NULL,'','n',35,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(165,'2019-12-17 10:30:35',NULL,NULL,1,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,297,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 10:02:52',1,NULL,NULL,'','n',35,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(166,'2019-12-17 12:00:40',NULL,NULL,4,NULL,'Mario',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,298,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 15:05:50',4,NULL,NULL,'','n',36,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(167,'2019-12-17 12:06:21',NULL,1,4,NULL,'MARLUCI','N','01/01/2000','46445645645',NULL,'m','v',NULL,71,302,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 15:05:50',4,NULL,'ty5445y','yhjy','n',36,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(168,'2019-12-17 12:00:40',NULL,NULL,4,NULL,'Rivaldo',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,300,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 15:05:50',4,NULL,NULL,'','n',36,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(169,'2019-12-17 12:10:40',NULL,NULL,4,NULL,'Joana',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,303,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 12:24:42',4,NULL,NULL,'','n',37,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(170,'2019-12-17 12:10:40',NULL,NULL,4,NULL,'Laura',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,304,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 12:24:42',4,NULL,NULL,'','n',37,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(171,'2019-12-17 12:10:40',NULL,NULL,4,NULL,'Luciana',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,305,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 12:24:42',4,NULL,NULL,'','n',37,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(172,'2019-12-17 12:25:21',NULL,NULL,4,NULL,'AA',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,306,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 12:32:23',4,NULL,NULL,'','n',38,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(173,'2019-12-17 12:25:21',NULL,NULL,4,NULL,'FF',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,307,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 12:32:23',4,NULL,NULL,'','n',38,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(174,'2019-12-17 12:25:21',NULL,NULL,4,NULL,'OO',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,308,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 12:32:23',4,NULL,NULL,'','n',38,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(175,'2019-12-17 12:33:04',NULL,NULL,4,NULL,'AA',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,309,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 13:43:27',4,NULL,NULL,'','n',39,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(176,'2019-12-17 12:33:04',NULL,NULL,4,NULL,'FF',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,310,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 13:43:27',4,NULL,NULL,'','n',39,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(177,'2019-12-17 12:33:04',NULL,NULL,4,NULL,'OO',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,311,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 13:43:27',4,NULL,NULL,'','n',39,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(178,'2019-12-17 13:40:38',NULL,NULL,4,NULL,'Joana',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,312,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 13:43:22',4,NULL,NULL,'','n',40,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(179,'2019-12-17 14:33:06',NULL,NULL,4,NULL,'FF',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,313,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 15:05:45',4,NULL,NULL,'','n',47,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(180,'2019-12-17 14:33:06',NULL,NULL,4,NULL,'GG',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,314,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 15:05:45',4,NULL,NULL,'','n',47,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(181,'2019-12-17 14:33:06',NULL,NULL,4,NULL,'RR',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,315,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 15:05:45',4,NULL,NULL,'','n',47,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(182,'2019-12-17 14:41:54',NULL,NULL,4,NULL,'Ana',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,316,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 15:05:48',4,NULL,NULL,'','n',48,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(183,'2019-12-17 16:39:10',NULL,NULL,4,NULL,'ANa',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,317,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 16:40:28',4,NULL,NULL,'','n',49,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(184,'2019-12-17 16:40:10',NULL,NULL,4,NULL,'RE',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,318,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-17 16:40:29',4,NULL,NULL,'','n',50,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(185,'2019-12-17 17:42:40',NULL,1,19,NULL,'BRUNO1','1','11/11/2001','11111111111','60626455154','m','v',NULL,72,319,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(186,'2019-12-17 17:44:58',NULL,1,19,NULL,'BRUNO2','1','11/11/2001','11111111111','60626455154','m','v',NULL,72,320,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(187,'2019-12-17 17:46:23',NULL,1,19,NULL,'BRUNO2','2','22/10/2002','22222222222','60626455154','f','v',NULL,72,321,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(188,'2019-12-17 17:46:56',NULL,1,19,NULL,'BRUNO2','2','22/10/2002','22222222222','60626455154','f','v',NULL,72,322,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'22222','a','2020-12-22','img/avatar.jpg',NULL,1,0,0,NULL),(189,'2019-12-17 17:52:30',NULL,1,1,NULL,'BRUNO2','2','22/10/2002','22222222222','60626455154','f','v',NULL,72,324,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'doc','NHE','s',0,'22222','a','2020-12-22','img/avatar.jpg',NULL,1,0,0,NULL),(190,'2019-12-17 17:53:16',NULL,NULL,1,'Que coisa não?','BRUNO2','2','22102002','22222222222','60626455154','f','v','',72,325,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'doc','NHE','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(191,'2019-12-17 17:54:28',NULL,NULL,1,NULL,'Data',NULL,'','','',NULL,'v','',NULL,326,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(192,'2019-12-17 17:55:02',NULL,1,1,NULL,'NIVER','1','12041991','11111111111','48462443180','f','v',NULL,NULL,328,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(193,'2019-12-17 17:59:33',NULL,1,19,NULL,'ASDASD','1','11/11/1999','11111111111','48462443180','m','v',NULL,73,333,1576616351,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(194,'2019-12-17 17:59:33',NULL,1,19,NULL,'ADASDASD','A','11/11/2000',NULL,'33763841423','f','p',NULL,74,335,1576616351,'asdsad','asdasd',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(195,'2019-12-17 17:59:33',NULL,1,19,NULL,'ASDASDD','SADAS','11/11/2000',NULL,'28118737322','m','v',NULL,75,334,1576616351,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(196,'2019-12-17 18:09:40',NULL,1,19,NULL,'ASDSADSAASD','SD','11/11/2000','11111111111','83271561281','m','v',NULL,76,336,1576617023,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg','img/avatar.jpg',1,0,0,NULL),(197,'2019-12-17 18:09:40',NULL,1,19,NULL,'BRUNO MOURA','MAE','31/12/1969','62985246609','04311617127','m','v',NULL,19,337,1576617023,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'as56d4','6SD6S6','s',0,'',NULL,NULL,'upload/img/pessoa/5df2a3b87715f.jpeg',NULL,1,0,0,NULL),(198,'2019-12-17 18:09:40',NULL,1,19,NULL,'ASDASDAS','9999','12/12/1999','11111111111','13458631100','f','v',NULL,77,338,1576617023,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg','img/avatar.jpg',1,0,0,NULL),(199,'2019-12-17 18:09:41',NULL,1,19,NULL,'SDSDSDDS','AAA','11/11/2000','11111111111','37080769744','f','v',NULL,78,339,1576617023,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg','img/avatar.jpg',1,0,0,NULL),(200,'2019-12-17 18:54:43',NULL,1,19,NULL,'ADASD','995','11/11/1999','11111111111','71524741760','m','v',NULL,79,340,1576619730,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(201,'2019-12-17 18:54:43',NULL,1,19,NULL,'BRUNO MOURA','SDSD','31/12/1969','62985246609','04311617127','m','v',NULL,19,341,1576619730,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'as56d4','6SD6S6','s',0,'',NULL,NULL,'upload/img/pessoa/5df2a3b87715f.jpeg',NULL,1,0,0,NULL),(202,'2019-12-17 18:54:44',NULL,1,19,NULL,'SDSDS','2000','11/11/2000','11111111111','27586224919','m','p',NULL,80,342,1576619730,'222','222',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'img/avatar.jpg','img/avatar.jpg',1,0,0,NULL),(203,'2019-12-18 10:02:36',NULL,NULL,1,NULL,'Tesye',NULL,NULL,NULL,NULL,NULL,'v','',NULL,343,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:37',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(204,'2019-12-18 10:02:43',NULL,NULL,1,NULL,'BRUNO2',NULL,NULL,NULL,NULL,'f','v','',72,344,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:36',1,NULL,'doc','NHE','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(205,'2019-12-18 10:05:39',NULL,1,1,NULL,'HSHS','A','12/12/2000','12121212121','83845675144','m','v',NULL,81,347,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',51,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(206,'2019-12-18 10:03:05',NULL,NULL,1,NULL,'Tesye',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,346,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:31:55',1,NULL,NULL,'','n',51,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(207,'2019-12-18 10:12:26',NULL,NULL,1,NULL,'Zjjs',NULL,NULL,NULL,NULL,NULL,'v','',NULL,348,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:35',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(208,'2019-12-18 10:13:08',NULL,NULL,1,NULL,'Djkd',NULL,NULL,NULL,NULL,NULL,'v','',NULL,349,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:33',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(209,'2019-12-18 10:13:23',NULL,NULL,1,NULL,'Zksk',NULL,NULL,NULL,NULL,NULL,'v','',NULL,350,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:32',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(210,'2019-12-18 10:17:11',NULL,NULL,1,NULL,'Jwj',NULL,NULL,NULL,NULL,NULL,'v','',NULL,351,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:31',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(211,'2019-12-18 10:17:23',NULL,NULL,1,NULL,'Nzns',NULL,NULL,NULL,NULL,NULL,'v','',NULL,352,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:29',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(212,'2019-12-18 11:28:50',NULL,NULL,4,NULL,'e123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,353,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 11:50:42',4,NULL,NULL,'','n',52,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(213,'2019-12-18 11:43:31',NULL,NULL,4,NULL,'3123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,354,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 11:50:41',4,NULL,NULL,'','n',53,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(214,'2019-12-18 11:44:23',NULL,NULL,4,NULL,'1221e',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,355,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 11:50:37',4,NULL,NULL,'','n',54,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(215,'2019-12-18 11:44:23',NULL,NULL,4,NULL,'12e12',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,356,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 11:50:37',4,NULL,NULL,'','n',54,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(216,'2019-12-18 11:45:37',NULL,NULL,4,NULL,'21e12e',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,357,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 11:50:39',4,NULL,NULL,'','n',55,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(217,'2019-12-18 11:46:08',NULL,NULL,4,NULL,'12e12e',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,358,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 11:50:44',4,NULL,NULL,'','n',56,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(218,'2019-12-18 11:52:02',NULL,NULL,4,NULL,'Jshxj',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,359,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 12:03:09',4,NULL,NULL,'','n',57,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(219,'2019-12-18 11:52:32',NULL,NULL,4,NULL,'Fjdjf',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,360,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 12:02:01',4,NULL,NULL,'','n',58,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(220,'2019-12-18 11:52:32',NULL,NULL,4,NULL,'Ljdjd',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,361,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 12:02:01',4,NULL,NULL,'','n',58,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(221,'2019-12-18 11:54:15',NULL,NULL,4,NULL,'Dois dias',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,362,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 12:01:59',4,NULL,NULL,'','n',59,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(222,'2019-12-18 11:54:15',NULL,NULL,4,NULL,'Uma dia',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,363,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 12:01:59',4,NULL,NULL,'','n',59,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(223,'2019-12-18 12:03:27',NULL,NULL,4,NULL,'Eueyr',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,364,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 12:04:31',4,NULL,NULL,'','n',60,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(224,'2019-12-18 13:11:57',NULL,NULL,4,NULL,'qweqe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,365,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 13:23:55',4,NULL,NULL,'','n',61,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(225,'2019-12-18 13:37:31',NULL,NULL,1,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v','',NULL,366,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:28',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(226,'2019-12-18 13:39:24',NULL,NULL,1,NULL,'Jsks',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,367,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:31:56',1,NULL,NULL,'','n',62,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(227,'2019-12-18 13:39:40',NULL,NULL,1,NULL,'Jeej',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,368,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:32:00',1,NULL,NULL,'','n',63,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(228,'2019-12-18 13:48:45',NULL,NULL,4,NULL,'JAD',NULL,NULL,NULL,NULL,NULL,'v','',NULL,369,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:14:59',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(229,'2019-12-18 13:49:48',NULL,NULL,4,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v','',NULL,370,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:14:57',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(230,'2019-12-18 14:09:35',NULL,NULL,4,NULL,'JAderee',NULL,NULL,NULL,NULL,NULL,'v','',NULL,371,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:14:52',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(231,'2019-12-18 14:10:08',NULL,NULL,4,NULL,'eee',NULL,NULL,NULL,NULL,NULL,'v','',NULL,372,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:14:51',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(232,'2019-12-18 14:14:02',NULL,NULL,1,NULL,'Jsjsj',NULL,NULL,NULL,NULL,NULL,'v','',NULL,373,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:26',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(233,'2019-12-18 14:14:10',NULL,NULL,1,NULL,'Ndkd',NULL,NULL,NULL,NULL,NULL,'v','',NULL,374,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:25',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(234,'2019-12-18 14:14:20',NULL,NULL,1,NULL,'Krke',NULL,NULL,NULL,NULL,NULL,'v','',NULL,375,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:24',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(235,'2019-12-18 14:14:28',NULL,NULL,1,NULL,'Ejd',NULL,NULL,NULL,NULL,NULL,'v','',NULL,376,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:22',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(236,'2019-12-18 14:14:41',NULL,NULL,4,NULL,'Header',NULL,NULL,NULL,NULL,NULL,'v','',NULL,377,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:14:49',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(237,'2019-12-18 14:14:48',NULL,NULL,1,NULL,'Ndmd',NULL,NULL,NULL,NULL,NULL,'v','',NULL,378,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:21',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(238,'2019-12-18 14:15:00',NULL,NULL,1,NULL,'Mxmd',NULL,NULL,NULL,NULL,NULL,'v','',NULL,379,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:19',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(239,'2019-12-18 14:15:13',NULL,NULL,1,NULL,'Nxxxm',NULL,NULL,NULL,NULL,NULL,'v','',NULL,380,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:15:17',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(240,'2019-12-18 14:16:00',NULL,NULL,1,NULL,'Nsm',NULL,NULL,NULL,NULL,NULL,'v','',NULL,381,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(241,'2019-12-18 14:22:24',NULL,NULL,4,NULL,'123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,382,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:23:45',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(242,'2019-12-18 14:22:24',NULL,NULL,4,NULL,'123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,383,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:23:43',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(243,'2019-12-18 14:24:13',NULL,NULL,4,NULL,'rr',NULL,NULL,NULL,NULL,NULL,'v','',NULL,384,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 14:25:36',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(244,'2019-12-18 15:21:31',NULL,NULL,4,NULL,'213123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,385,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(245,'2019-12-18 15:30:31',NULL,NULL,4,NULL,'qeqwe',NULL,NULL,NULL,NULL,NULL,'v','',NULL,386,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(246,'2019-12-18 15:34:48',NULL,NULL,4,NULL,'4433',NULL,NULL,NULL,NULL,NULL,'v','',NULL,387,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(247,'2019-12-18 16:27:07',NULL,NULL,4,NULL,'Grtt',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,388,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:30:15',4,NULL,NULL,'','n',64,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(248,'2019-12-18 16:28:02',NULL,NULL,4,NULL,'Gffgg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,389,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:30:17',4,NULL,NULL,'','n',65,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(249,'2019-12-18 16:28:58',NULL,NULL,4,NULL,'Fdgg',NULL,NULL,NULL,NULL,NULL,'v','',NULL,390,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(250,'2019-12-18 16:30:42',NULL,NULL,4,NULL,'Gddgg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,391,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:36:57',4,NULL,NULL,'','n',66,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(251,'2019-12-18 16:30:42',NULL,NULL,4,NULL,'Gfggh',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,392,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:36:57',4,NULL,NULL,'','n',66,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(252,'2019-12-18 16:31:23',NULL,NULL,4,NULL,'Hdgg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:36:59',4,NULL,NULL,'','n',67,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(253,'2019-12-18 16:32:20',NULL,NULL,4,NULL,'Fggf',NULL,NULL,NULL,NULL,NULL,'v','',NULL,394,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(254,'2019-12-18 16:38:12',NULL,NULL,4,NULL,'Fghhj',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,395,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:56:00',4,NULL,NULL,'','n',68,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(255,'2019-12-18 16:39:01',NULL,NULL,4,NULL,'Ggfgghh',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,396,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:56:02',4,NULL,NULL,'','n',69,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(256,'2019-12-18 16:40:54',NULL,NULL,4,NULL,'Ggrfg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,397,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 16:55:58',4,NULL,NULL,'','n',70,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(257,'2019-12-18 16:41:23',NULL,NULL,4,NULL,'Ffddfg',NULL,NULL,NULL,NULL,NULL,'v','',NULL,398,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(258,'2019-12-18 16:41:47',NULL,NULL,4,NULL,'Fdggh',NULL,NULL,NULL,NULL,NULL,'v','',NULL,399,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(259,'2019-12-18 16:56:25',NULL,NULL,4,NULL,'eqwe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,400,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:02:45',4,NULL,NULL,'','n',71,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(260,'2019-12-18 17:00:35',NULL,NULL,4,NULL,'e312e3',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,401,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:02:47',4,NULL,NULL,'','n',72,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(261,'2019-12-18 17:01:15',NULL,NULL,4,NULL,'21e12e',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,402,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:02:48',4,NULL,NULL,'','n',73,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(262,'2019-12-18 17:03:12',NULL,NULL,4,NULL,'eqeweq',NULL,NULL,NULL,NULL,NULL,'v','',NULL,403,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:51:41',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(263,'2019-12-18 17:03:51',NULL,NULL,4,NULL,'qeqeqwe',NULL,NULL,NULL,NULL,NULL,'v','',NULL,404,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:51:43',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(264,'2019-12-18 17:09:34',NULL,NULL,4,NULL,'qweqwe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,405,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:52:04',4,NULL,NULL,'','n',74,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(265,'2019-12-18 17:33:55',NULL,1,1,NULL,'DDD','A','11/11/2000','11111111111','71268014320','m','v',NULL,82,408,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',75,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(266,'2019-12-18 17:33:34',NULL,NULL,1,NULL,'Skkss',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,407,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-18 17:36:28',1,NULL,NULL,'','n',75,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(267,'2019-12-18 17:36:39',NULL,NULL,1,NULL,'Ffs',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,409,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',76,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(268,'2019-12-18 17:52:31',NULL,NULL,4,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,410,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 09:34:29',4,NULL,NULL,'','n',77,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(269,'2019-12-18 17:53:47',NULL,NULL,4,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,411,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 09:34:31',4,NULL,NULL,'','n',78,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(270,'2019-12-19 09:36:14',NULL,NULL,18,NULL,'Fgdfg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,412,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',79,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(271,'2019-12-19 09:41:56',NULL,NULL,18,NULL,'123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,413,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',80,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(272,'2019-12-19 09:43:18',NULL,NULL,18,NULL,'12213',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,414,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',81,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(273,'2019-12-19 09:43:18',NULL,NULL,18,NULL,'13123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,415,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',81,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(274,'2019-12-19 09:49:18',NULL,NULL,4,NULL,'Hfgg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,416,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 10:09:16',4,NULL,NULL,'','n',82,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(275,'2019-12-19 09:49:18',NULL,NULL,4,NULL,'Tyyy',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,417,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 10:09:16',4,NULL,NULL,'','n',82,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(276,'2019-12-19 09:53:37',NULL,NULL,4,NULL,'Tr',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,418,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 10:09:17',4,NULL,NULL,'','n',83,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(277,'2019-12-19 09:56:36',NULL,NULL,4,NULL,'Fgg',NULL,NULL,NULL,NULL,NULL,'v','',NULL,419,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-19 10:49:28',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(278,'2019-12-19 09:57:08',NULL,NULL,4,NULL,'Hgf',NULL,NULL,NULL,NULL,NULL,'v','',NULL,420,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-19 10:49:26',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(279,'2019-12-19 09:57:44',NULL,NULL,4,NULL,'Te',NULL,NULL,NULL,NULL,NULL,'v','',NULL,421,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2019-12-19 10:49:24',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(280,'2019-12-19 11:05:29',NULL,NULL,4,NULL,'Jader',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,422,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 13:45:19',4,NULL,NULL,'','n',84,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(281,'2019-12-19 11:05:49',NULL,NULL,4,NULL,'Gdf',NULL,NULL,NULL,NULL,NULL,'v','',NULL,423,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(282,'2019-12-19 11:21:27',NULL,1,1,NULL,'JEJ','SDSD','11/11/2000','11111111111','28225701755','f','v',NULL,NULL,424,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 11:32:03',1,NULL,'sddswwewe','dsddsss','n',85,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(283,'2019-12-19 11:16:33',NULL,NULL,1,NULL,'Jss',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,425,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 11:32:06',1,NULL,NULL,'','n',86,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(284,'2019-12-19 11:18:00',NULL,NULL,1,NULL,'Ssjjs',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,426,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 11:32:05',1,NULL,NULL,'','n',87,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(285,'2019-12-19 11:21:49',NULL,1,1,NULL,'TESTEASDD','ASDS','11/11/2000','11111111111','58289840551','m','v',NULL,NULL,427,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'asdasd','asdsadsa','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(286,'2019-12-19 11:22:09',NULL,1,1,NULL,'SDADSDSA','ASDSD','11/11/2000','11111111111','88382141404','m','v',NULL,NULL,428,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'asdsad','233332','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(287,'2019-12-19 11:41:35',NULL,1,1,NULL,'KKKKK','656','11/11/1999','11111111111','30737103450','m','v',NULL,84,433,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 12:09:53',1,NULL,NULL,NULL,'n',88,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(288,'2019-12-19 11:38:44',NULL,1,1,NULL,'JSJS2','ASDDD','12/12/2000','11111111111','60952181797','m','v',NULL,83,431,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',89,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(289,'2019-12-19 12:12:10',NULL,1,1,NULL,'HOJE','A','12/12/2000','11111111111','62710820684','m','v',NULL,86,438,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',90,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(290,'2019-12-19 12:11:04',NULL,NULL,1,NULL,'Amanhã',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,435,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 17:18:26',1,NULL,NULL,'','n',91,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(291,'2019-12-19 12:11:47',NULL,1,1,NULL,'HOJE É AMANHA','222','12/12/2000','11111111111','44217384254','m','v',NULL,85,437,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',92,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(292,'2019-12-19 12:16:00',NULL,1,1,NULL,'SABADO','AAA','11/11/2000','11111111111','55807578678','m','v',NULL,87,440,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 17:18:25',1,NULL,NULL,NULL,'n',93,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(293,'2019-12-19 12:22:13',NULL,1,1,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','p','t',88,442,NULL,'Taxi/Uber','Motorista','nky2705','suzuki','preta',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'','ab','2030-01-01','img/avatar.jpg',NULL,1,0,0,NULL),(294,'2019-12-19 12:33:21',NULL,1,1,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','v',NULL,88,443,1576769401,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,'upload/img/pessoa/15767689335dfb95a56cf81.jpeg',NULL,1,0,0,NULL),(295,'2019-12-19 12:37:16',NULL,1,1,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','v',NULL,88,445,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'123123123','SSP','s',0,'465446','a','2030-01-01','upload/img/pessoa/15767689335dfb95a56cf81.jpeg',NULL,1,0,0,NULL),(296,'2019-12-19 12:38:27',NULL,1,1,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','v',NULL,88,447,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'123123123','SSP','s',0,'465446','a','2030-01-01','upload/img/pessoa/15767699055dfb99719a679.jpeg',NULL,1,0,0,NULL),(297,'2019-12-19 13:00:11',NULL,1,1,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','v',NULL,88,448,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'123123123','SSP','s',0,'465446','a','2030-01-01','upload/img/pessoa/15767699055dfb99719a679.jpeg','upload/img/pessoa/15767712105dfb9e8ab3039.jpeg',1,0,0,NULL),(298,'2019-12-19 13:46:14',NULL,NULL,4,NULL,'qeqee',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,449,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 13:48:17',4,NULL,NULL,'','n',94,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(299,'2019-12-19 13:46:14',NULL,NULL,4,NULL,'qweqwe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,450,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 13:48:17',4,NULL,NULL,'','n',94,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(300,'2019-12-19 13:55:37',NULL,NULL,4,NULL,'eee',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,451,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:08:32',4,NULL,NULL,'','n',95,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(301,'2019-12-19 13:55:37',NULL,NULL,4,NULL,'rrrrr',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,452,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:08:32',4,NULL,NULL,'','n',95,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(302,'2019-12-19 13:56:13',NULL,NULL,4,NULL,'eeee',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,453,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:08:32',4,NULL,NULL,'','n',95,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(303,'2019-12-19 14:01:05',NULL,NULL,4,NULL,'vvv',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,454,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:08:32',4,NULL,NULL,'','n',95,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(304,'2019-12-19 14:09:16',NULL,NULL,4,NULL,'Tesss',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,455,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:11:22',4,NULL,NULL,'','n',96,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(305,'2019-12-19 14:12:07',NULL,NULL,4,NULL,'EE',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,456,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:40:13',4,NULL,NULL,'','n',97,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(306,'2019-12-19 14:12:07',NULL,NULL,4,NULL,'ER',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,457,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:40:13',4,NULL,NULL,'','n',97,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(307,'2019-12-19 14:15:05',NULL,NULL,4,NULL,'CV',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,458,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:40:13',4,NULL,NULL,'','n',97,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(308,'2019-12-19 14:41:05',NULL,NULL,4,NULL,'Hj',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,459,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:50:41',4,NULL,NULL,'','n',98,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(309,'2019-12-19 14:50:14',NULL,NULL,4,NULL,'Fggg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,460,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 14:50:41',4,NULL,NULL,'','n',98,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(310,'2019-12-19 14:51:09',NULL,NULL,4,NULL,'Fgvb',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,461,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 15:40:34',4,NULL,NULL,'','n',99,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(311,'2019-12-19 15:41:07',NULL,NULL,4,NULL,'rrr',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,462,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-19 16:21:27',4,NULL,NULL,'','n',100,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(312,'2019-12-19 16:21:55',NULL,NULL,4,NULL,'ema',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,464,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 08:46:55',4,NULL,NULL,'','n',101,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(313,'2019-12-19 16:31:29',NULL,NULL,4,NULL,'55',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,465,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 08:46:51',4,NULL,NULL,'','n',102,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(314,'2019-12-19 16:31:29',NULL,NULL,4,NULL,'56',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,466,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 08:46:51',4,NULL,NULL,'','n',102,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(315,'2019-12-20 09:35:10',NULL,NULL,4,NULL,'qwe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,467,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 09:45:27',4,NULL,NULL,'','n',103,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(316,'2019-12-20 09:52:38',NULL,1,4,NULL,'FF','MARIA','01/01/2000','00000000000','96815939014','m','v',NULL,89,470,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 14:44:53',4,NULL,NULL,NULL,'n',104,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(317,'2019-12-20 09:46:22',NULL,NULL,4,NULL,'rr',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,469,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 14:44:53',4,NULL,NULL,'','n',104,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(318,'2019-12-20 09:55:33',NULL,NULL,4,NULL,'FF',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,471,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 14:44:53',4,NULL,NULL,'','n',104,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(319,'2019-12-20 09:55:33',NULL,NULL,4,NULL,'rr',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,472,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 14:44:53',4,NULL,NULL,'','n',104,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(320,'2019-12-20 14:45:37',NULL,NULL,4,NULL,'ewe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,473,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:18',4,NULL,NULL,'','n',105,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(321,'2019-12-20 14:45:37',NULL,NULL,4,NULL,'ewq',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,474,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:18',4,NULL,NULL,'','n',105,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(322,'2019-12-20 14:50:00',NULL,NULL,4,NULL,'Amanha',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,475,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:16',4,NULL,NULL,'','n',106,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(323,'2019-12-20 14:50:00',NULL,NULL,4,NULL,'Hoje',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,476,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:16',4,NULL,NULL,'','n',106,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(324,'2019-12-20 14:53:09',NULL,NULL,4,NULL,'Terça',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,477,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:16',4,NULL,NULL,'','n',106,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(325,'2019-12-20 14:54:35',NULL,NULL,4,NULL,'Quinta',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,478,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:16',4,NULL,NULL,'','n',106,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(326,'2019-12-20 15:57:18',NULL,NULL,4,NULL,'ewqwe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,479,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:14',4,NULL,NULL,'','n',107,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(327,'2019-12-20 15:57:18',NULL,NULL,4,NULL,'qeqe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,480,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 16:08:14',4,NULL,NULL,'','n',107,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(328,'2019-12-20 17:18:36',NULL,NULL,1,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,481,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2019-12-20 17:19:01',1,NULL,NULL,'','n',108,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(329,'2019-12-20 17:19:12',NULL,NULL,1,NULL,'Hoje',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,482,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',109,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(330,'2019-12-20 17:19:41',NULL,NULL,1,NULL,'Amanhã',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,483,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',110,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(331,'2019-12-20 17:20:42',NULL,NULL,1,NULL,'Amanhã e depois',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,484,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',111,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(332,'2020-01-02 16:36:12',NULL,NULL,4,NULL,'123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,485,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(333,'2020-01-06 17:32:57',NULL,NULL,4,NULL,'213',NULL,NULL,NULL,NULL,NULL,'v','',NULL,487,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(334,'2020-01-06 17:32:57',NULL,NULL,4,NULL,'213',NULL,NULL,NULL,NULL,NULL,'v','',NULL,486,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(335,'2020-01-06 17:38:49',NULL,NULL,4,NULL,'eee',NULL,NULL,NULL,NULL,NULL,'v','',NULL,488,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(336,'2020-01-10 11:42:32',NULL,NULL,4,'','Maria',NULL,NULL,'','',NULL,'v','',NULL,489,NULL,'','','',NULL,NULL,NULL,'s','s','2020-01-10 12:19:14',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(337,'2020-01-10 12:08:22',NULL,NULL,4,'','Gh',NULL,NULL,'','',NULL,'v','',NULL,490,NULL,'','','',NULL,NULL,NULL,'s','s','2020-01-10 12:19:12',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(338,'2020-01-10 12:09:45',NULL,NULL,4,'Rffvg','Hdgg',NULL,NULL,'','',NULL,'v','',NULL,491,NULL,'','','',NULL,NULL,NULL,'s','s','2020-01-10 12:19:09',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(339,'2020-01-10 12:19:33',NULL,NULL,4,'','Fgf',NULL,NULL,'','',NULL,'p','t',NULL,492,NULL,'TAXI/UBER','MOTORISTA','GDT2eqw',NULL,NULL,NULL,'s','s','2020-01-10 12:21:30',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(340,'2020-01-10 12:21:19',NULL,NULL,4,'','Ftrfg',NULL,NULL,'','',NULL,'p','',NULL,493,NULL,'Ghft','Vfgg','',NULL,NULL,NULL,'s','s','2020-01-10 12:21:26',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(341,'2020-01-10 14:28:00',NULL,NULL,4,'Teste','Teste',NULL,'01/01/1989','62991057272','70104174072',NULL,'v','',NULL,494,NULL,'','','GFF5432',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(342,'2020-01-22 08:50:46',NULL,1,25,NULL,'MARIA','',NULL,NULL,NULL,'m','v',NULL,NULL,495,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'gm49','WEFG','n',0,'',NULL,NULL,'img/avatar.jpg',NULL,1,0,0,NULL),(343,'2020-01-22 18:01:43',NULL,NULL,4,NULL,'2313',NULL,NULL,NULL,NULL,NULL,'v','',NULL,496,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-22 18:07:49',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(344,'2020-01-22 18:01:54',NULL,NULL,4,NULL,'2131321',NULL,NULL,NULL,NULL,NULL,'v','',NULL,497,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-22 18:07:47',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(345,'2020-01-22 18:03:01',NULL,NULL,4,NULL,'1213123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,498,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-22 18:07:46',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(346,'2020-01-23 09:45:45',NULL,NULL,4,NULL,'Tedf',NULL,NULL,NULL,NULL,NULL,'v','',NULL,499,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 10:15:53',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(347,'2020-01-23 09:45:52',NULL,NULL,4,NULL,'Gerggh',NULL,NULL,NULL,NULL,NULL,'v','',NULL,500,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 10:15:51',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(348,'2020-01-23 09:53:18',NULL,NULL,4,NULL,'3123123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,501,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 10:15:49',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(349,'2020-01-23 10:57:17',NULL,NULL,4,NULL,'1132123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,502,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 11:03:01',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(350,'2020-01-23 10:57:28',NULL,NULL,4,NULL,'123123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,503,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 11:03:04',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(351,'2020-01-23 11:23:54',NULL,NULL,4,NULL,'313123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,504,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 11:28:09',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(352,'2020-01-23 11:24:02',NULL,NULL,4,NULL,'313123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,505,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 11:28:11',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(353,'2020-01-23 11:28:21',NULL,NULL,4,NULL,'1233',NULL,NULL,NULL,NULL,NULL,'v','',NULL,506,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 11:47:05',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(354,'2020-01-23 11:28:27',NULL,NULL,4,NULL,'23123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,507,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 11:47:03',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(355,'2020-01-23 11:28:34',NULL,NULL,4,NULL,'123123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,508,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-23 11:47:01',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(356,'2020-01-23 15:29:25',NULL,NULL,4,NULL,'12323',NULL,NULL,NULL,NULL,NULL,'v','',NULL,509,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(357,'2020-01-23 15:29:32',NULL,NULL,4,NULL,'312313',NULL,NULL,NULL,NULL,NULL,'v','',NULL,510,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(358,'2020-01-23 15:29:40',NULL,NULL,4,NULL,'123123123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,511,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(359,'2020-01-24 08:46:21',NULL,NULL,4,NULL,'Dnndns',NULL,NULL,NULL,NULL,NULL,'v','',NULL,512,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(360,'2020-01-24 08:46:26',NULL,NULL,4,NULL,'Jerje',NULL,NULL,NULL,NULL,NULL,'v','',NULL,513,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(361,'2020-01-24 08:46:36',NULL,NULL,4,NULL,'Jdjd',NULL,NULL,NULL,NULL,NULL,'v','',NULL,514,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(362,'2020-01-28 16:28:40',NULL,NULL,4,NULL,'113',NULL,NULL,NULL,NULL,NULL,'v','',NULL,515,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-28 16:49:07',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(363,'2020-01-28 16:33:25',NULL,NULL,4,NULL,'1233',NULL,NULL,NULL,NULL,NULL,'v','',NULL,516,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-28 16:49:04',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(364,'2020-01-28 16:36:08',NULL,NULL,4,NULL,'1123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,517,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-28 16:49:05',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(365,'2020-01-28 17:05:02',NULL,NULL,4,NULL,'12323',NULL,NULL,NULL,NULL,NULL,'v','',NULL,518,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(366,'2020-01-28 17:05:38',NULL,NULL,4,NULL,'123123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,519,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-28 17:22:04',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(367,'2020-01-28 17:21:58',NULL,NULL,4,NULL,'2113123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,520,NULL,'','',NULL,NULL,NULL,NULL,'s','s','2020-01-28 17:22:03',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(368,'2020-01-29 14:34:40',NULL,NULL,4,NULL,'12321',NULL,NULL,NULL,NULL,NULL,'v','',NULL,521,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(369,'2020-01-29 14:34:51',NULL,NULL,4,NULL,'312313',NULL,NULL,NULL,NULL,NULL,'v','',NULL,522,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(370,'2020-01-29 14:34:58',NULL,NULL,4,NULL,'13123',NULL,NULL,NULL,NULL,NULL,'v','',NULL,523,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(371,'2020-01-29 14:35:06',NULL,NULL,4,NULL,'11111',NULL,NULL,NULL,NULL,NULL,'v','',NULL,524,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(372,'2020-01-30 10:43:20',NULL,NULL,4,NULL,'Jader',NULL,NULL,NULL,NULL,NULL,'v','',NULL,525,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(373,'2020-01-30 14:58:18',NULL,1,4,'Vai entrar com um som.','JOANA','MERIA','01/01/1999','00000000000','26738827075','f','v',NULL,92,527,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(374,'2020-01-30 15:10:22',NULL,1,4,NULL,'MARCIO','INES','10/12/1988','62991057275','24258835099','m','v',NULL,93,528,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(375,'2020-01-30 15:18:08',NULL,1,4,'Vai entrar com um som.','JOANA','LUCIANA','01/01/1999','00000000000','26738827075','f','v',NULL,92,530,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(376,'2020-01-31 17:21:12',NULL,NULL,4,'','Mario',NULL,NULL,'','',NULL,'v','',NULL,531,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(377,'2020-01-31 21:41:23',NULL,NULL,45,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'p','e',NULL,532,NULL,'Eduardo','ENTREGADOR',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(378,'2020-01-31 21:41:57',NULL,NULL,45,NULL,'Eduardo Jorge',NULL,NULL,NULL,NULL,NULL,'v','',NULL,533,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(379,'2020-02-03 08:51:46',NULL,NULL,4,'','Jo',NULL,NULL,'','',NULL,'v','',NULL,534,NULL,'','','',NULL,NULL,NULL,'s','s','2020-02-03 12:11:53',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(380,'2020-02-03 08:52:38',NULL,NULL,4,'','Ana ap.',NULL,NULL,'','',NULL,'v','',NULL,535,NULL,'','','',NULL,NULL,NULL,'s','s','2020-02-03 12:11:52',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(381,'2020-02-03 12:15:05',NULL,1,4,'Entrar com um notebook','MARIA','NENE','01/01/2000','62991057272','82148097032','f','v',NULL,94,537,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(382,'2020-02-03 14:54:22',NULL,1,4,'Liberação pelo web.','MARCIO','JOANA','10/12/1988','62991057275','24258835099','m','v',NULL,93,539,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(383,'2020-02-03 15:12:58',NULL,1,4,NULL,'FLAVIA','RAQUEL','01/01/2000','62991057275','96898398024','f','v',NULL,95,543,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',112,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(384,'2020-02-03 16:20:08',NULL,1,4,NULL,'JOANA','TESTE','01/01/2000','62991057275','60893496073','f','v',NULL,92,545,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:11',4,NULL,NULL,'','s',112,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(385,'2020-02-03 16:18:38',NULL,1,4,NULL,'LAURA','BIA','01/01/2000','62991057275','48625975054','f','v',NULL,96,544,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',112,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(386,'2020-02-03 17:04:34',NULL,1,4,NULL,'ANTONIO','YNES','01/01/2000','62991057275','17258060022','m','v',NULL,97,549,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',113,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(387,'2020-02-03 17:02:27',NULL,1,4,NULL,'LAURA','MARI','01/01/2000','62991057275','58958417080','f','v',NULL,96,548,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',113,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(388,'2020-02-03 17:13:13',NULL,1,4,NULL,'IGOR','JORGE','01/01/2000','62991057275','79480062062','m','v',NULL,98,550,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(389,'2020-02-04 09:58:31',NULL,NULL,19,'','Jdsjsj',NULL,NULL,'','',NULL,'v','',NULL,551,NULL,'','','',NULL,NULL,NULL,'s','s','2020-02-04 10:03:25',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(390,'2020-02-04 10:03:48',NULL,1,19,NULL,'TESTE APP','ASDA','11/11/2000','11111111111','35836316767','m','v',NULL,99,553,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(391,'2020-02-04 10:05:46',NULL,1,19,NULL,'TESTE PORTARIA','ASDAD','11/11/2000','11111111111','42410097006','m','v',NULL,100,554,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-02-04 10:14:12',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(392,'2020-02-04 10:15:27',NULL,1,19,'Teste','TESTE APP','AAA','11/11/2000','11111111111','35836316767','m','v',NULL,99,556,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:33',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(393,'2020-02-04 10:17:52',NULL,1,19,NULL,'TESTE PORTARIA','ASDAD','11/11/2000','11111111111','42410097006','m','v',NULL,100,557,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(394,'2020-02-04 10:19:49',NULL,1,19,'Nhe','TESTE PORTARIA','NHE','11/11/2000','11111111111','42410097006','m','v',NULL,100,559,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:33',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(395,'2020-02-04 10:21:51',NULL,1,19,'Nhe','TESTE PORTARIA','NHE','11/11/2000','11111111111','42410097006','m','v',NULL,100,560,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:44',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(396,'2020-02-04 10:30:21',NULL,1,19,'Shsj','PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,567,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(397,'2020-02-04 10:31:53',NULL,1,19,'Cuidado','TAXI','ADSADD','12/12/2000','11111111111','20766386104','f','p','t',102,568,NULL,'Taxi/Uber','Motorista','KSK1a34','adas','ss',NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(398,'2020-02-04 10:28:04',NULL,NULL,19,'','Msssm',NULL,NULL,'','',NULL,'p','t',NULL,563,NULL,'TAXI/UBER','MOTORISTA','BAD1234',NULL,NULL,NULL,'s','s','2020-02-04 10:29:14',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(399,'2020-02-04 10:28:16',NULL,NULL,19,'','Sjsj',NULL,NULL,'','',NULL,'p','t',NULL,564,NULL,'TAXI/UBER','MOTORISTA','KAK11as',NULL,NULL,NULL,'s','s','2020-02-04 10:29:12',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(400,'2020-02-04 10:28:36',NULL,NULL,19,'','Abd111a',NULL,NULL,'','',NULL,'p','t',NULL,565,NULL,'TAXI/UBER','MOTORISTA','AJD112a',NULL,NULL,NULL,'s','s','2020-02-04 10:29:10',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(401,'2020-02-04 10:32:33',NULL,1,19,NULL,'TSSG','ASD','12/12/2000','11111111111','47716878115','m','p','e',103,569,NULL,'Sjks','Entregador',NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(402,'2020-02-04 10:51:02',NULL,NULL,19,NULL,'TESTE APP',NULL,NULL,NULL,NULL,NULL,'v',NULL,99,570,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:44',19,NULL,NULL,'','n',114,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(403,'2020-02-04 10:51:45',NULL,NULL,19,'','Hgh',NULL,NULL,'','',NULL,'v','',NULL,571,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(404,'2020-02-04 10:52:02',NULL,NULL,19,'','Hhj',NULL,NULL,'','',NULL,'v','',NULL,572,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(405,'2020-02-04 10:52:32',NULL,NULL,19,'','Jej',NULL,NULL,'','',NULL,'v','',NULL,573,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(406,'2020-02-04 10:52:42',NULL,NULL,19,'','Hshs',NULL,NULL,'','',NULL,'v','',NULL,574,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(407,'2020-02-04 10:52:49',NULL,NULL,19,'','Sjks',NULL,NULL,'','',NULL,'v','',NULL,575,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(408,'2020-02-04 10:53:05',NULL,NULL,19,'','Jsks',NULL,NULL,'','',NULL,'v','',NULL,576,NULL,'','','',NULL,NULL,NULL,'s','s','2020-02-04 10:55:52',19,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(409,'2020-02-04 10:54:21',NULL,1,19,NULL,'JSJS','ASASD','11/11/2000','11111111111','42151851737','m','v',NULL,104,578,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-04 10:55:50',19,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(410,'2020-02-04 10:57:15',NULL,NULL,19,'','Jsjs',NULL,NULL,'','',NULL,'v','',NULL,579,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(411,'2020-02-04 10:59:06',NULL,1,19,NULL,'ZÉ','ASDSAD','12/12/2000','11111111111','13715527625','m','v',NULL,105,581,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(412,'2020-02-04 15:09:59',NULL,NULL,106,'','Shjss',NULL,NULL,'','',NULL,'v','',NULL,582,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(413,'2020-02-04 15:11:11',NULL,1,106,NULL,'JSJS','',NULL,NULL,NULL,NULL,'v',NULL,NULL,584,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(414,'2020-02-04 15:12:29',NULL,1,106,NULL,'6','ASDSAD','12/12/2000','11111111111','63745308107','f','v',NULL,107,586,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(415,'2020-02-05 14:50:50',NULL,1,19,NULL,'TAXI','SDDD','12/12/2000','11111111111','20766386104','f','p','t',102,596,NULL,'Taxi/Uber','Motorista','KSK1a34','2e3dwdad','sddsd',NULL,'s','s','2021-02-17 11:35:33',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(416,'2020-02-05 12:30:14',NULL,NULL,4,NULL,'13',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,588,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 12:30:19',4,NULL,NULL,'','n',115,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(417,'2020-02-05 14:29:58',NULL,NULL,4,NULL,'w12313',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,589,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 14:51:55',4,NULL,NULL,'','n',116,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(418,'2020-02-05 14:48:08',NULL,1,19,NULL,'ZÉ','SSS','12/12/2000','11111111111','13715527625','m','v',NULL,105,591,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:33',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(419,'2020-02-05 14:49:44',NULL,1,19,NULL,'ZÉ','SSS','12/12/2000','11111111111','13715527625','m','v',NULL,105,593,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:44',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(420,'2020-02-05 14:50:31',NULL,1,19,NULL,'ZÉ','SSSS','12/12/2000','11111111111','13715527625','m','v',NULL,105,595,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:54',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(421,'2020-02-05 14:52:01',NULL,1,19,NULL,'PESSOA NORMAL','DDASDA','31/12/1969','62985246609','22783612100','m','v',NULL,106,597,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:02',19,NULL,'6545656','32545','s',0,'',NULL,NULL,'upload/img/pessoa/5e398f29c049b.jpeg',NULL,1,0,0,NULL),(422,'2020-02-05 14:52:49',NULL,NULL,4,NULL,'123213',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,598,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 15:24:05',4,NULL,NULL,'','n',118,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(423,'2020-02-05 15:14:45',NULL,NULL,4,NULL,'qweqe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,599,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 15:24:03',4,NULL,NULL,'','n',120,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(424,'2020-02-05 15:24:58',NULL,NULL,4,NULL,'wer',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,600,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 15:44:19',4,NULL,NULL,'','n',121,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(425,'2020-02-05 15:28:54',NULL,NULL,4,NULL,'342424',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,601,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 15:44:21',4,NULL,NULL,'','n',122,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(426,'2020-02-05 15:35:20',NULL,NULL,4,NULL,'1313',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,602,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 15:44:14',4,NULL,NULL,'','n',123,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(427,'2020-02-05 15:35:56',NULL,NULL,4,NULL,'13123123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,603,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 15:44:16',4,NULL,NULL,'','n',124,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(428,'2020-02-05 15:44:06',NULL,NULL,4,NULL,'13123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,604,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 15:44:17',4,NULL,NULL,'','n',125,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(429,'2020-02-05 15:56:38',NULL,NULL,4,NULL,'123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,605,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 16:28:10',4,NULL,NULL,'','n',126,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(430,'2020-02-05 16:01:16',NULL,NULL,4,NULL,'21123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,606,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 16:28:12',4,NULL,NULL,'','n',127,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(431,'2020-02-05 16:02:51',NULL,NULL,4,NULL,'qweqe',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,607,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-02-05 16:28:13',4,NULL,NULL,'','n',128,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(432,'2020-02-05 16:59:07',NULL,1,4,NULL,'IGOR','JORGE P','01/01/2000','62991057275','79480062062','m','v',NULL,98,609,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(433,'2020-02-05 16:59:43',NULL,NULL,4,'','IGOR','JORGE','01/01/2000','62991057275','79480062062','m','v','',98,610,NULL,'','','',NULL,NULL,NULL,'s','s','2020-02-05 17:01:31',4,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(434,'2020-02-05 17:02:29',NULL,NULL,4,NULL,'Gdrr',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,611,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',129,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(435,'2020-02-12 12:36:01',NULL,1,1,NULL,'RAFAEL GONZAGA GONÇALVES','RAFAEL','22/07/1992','62984169089','03404718160','m','v',NULL,3,612,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:41',1,NULL,'5410848','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(436,'2020-02-12 15:39:07',NULL,NULL,4,'','Gygh',NULL,NULL,'','',NULL,'v','',NULL,613,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(437,'2020-02-13 11:12:42',NULL,NULL,4,'','12323',NULL,NULL,'','',NULL,'v','',NULL,614,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(438,'2020-02-17 09:24:05',NULL,1,4,'Entro com som','GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,616,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(439,'2020-02-17 10:33:47',NULL,1,4,'Entro com som','GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,617,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(440,'2020-02-17 11:01:21',NULL,1,3,NULL,'JOANA PEREIRA SOUZA','JOANA SOUZA','01/01/1992','62999999999','15351747065','f','v',NULL,111,619,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,'1234568','a','2022-01-01',NULL,NULL,1,0,0,NULL),(441,'2020-02-17 14:13:08',NULL,1,3,NULL,'JOANA PEREIRA SOUZA','JOANA SOUZA','01/01/1992','62999999999','15351747065','f','v',NULL,111,628,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(442,'2020-02-17 11:07:57',NULL,NULL,3,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,'v','',NULL,621,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(443,'2020-02-17 11:12:09',NULL,NULL,3,NULL,'Bruno',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,622,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',130,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(444,'2020-02-17 11:12:09',NULL,NULL,3,NULL,'JOANA PEREIRA SOUZA',NULL,NULL,NULL,NULL,NULL,'v',NULL,111,623,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',130,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(445,'2020-02-17 11:12:09',NULL,NULL,3,NULL,'Pedro',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,624,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',130,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(446,'2020-02-17 11:40:00',NULL,NULL,4,NULL,'Fgdf',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,625,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',131,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(447,'2020-02-17 11:40:18',NULL,NULL,4,NULL,'Tttgg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,626,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',132,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(448,'2020-02-17 11:40:52',NULL,NULL,4,NULL,'Ttttg',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,627,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',133,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(449,'2020-02-17 14:49:29',NULL,1,3,NULL,'ROBERTO MIRANDA','TRRWRW','22/07/1992','6299999999','62685365095','m','v',NULL,8,630,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'542125','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(450,'2020-02-17 16:02:10',NULL,NULL,4,'','Teste',NULL,NULL,'','',NULL,'v','',NULL,631,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(451,'2020-02-17 18:49:39',NULL,1,25,NULL,'SDF','M','05/05/2000','43534534534','15762277909','m','v',NULL,112,633,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(452,'2020-02-19 09:16:33',NULL,1,3,NULL,'JUAKIM','JOANA','31/12/1969','23232323232','35447162327','m','v',NULL,13,634,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'asd22d','2D','s',0,'',NULL,NULL,'upload/img/pessoa/5de5726114b3f.jpeg',NULL,1,0,0,NULL),(453,'2020-02-19 09:23:16',NULL,1,3,NULL,'JUAKIM','JOANA','31/12/1969','23232323232','35447162327','m','v',NULL,13,636,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'asd22d','2D','s',0,NULL,NULL,NULL,'upload/img/pessoa/5de5726114b3f.jpeg',NULL,1,0,0,NULL),(454,'2020-02-21 09:35:33',NULL,1,4,NULL,'GESICA','TESTE','01/01/2000','00000000000','65054811095','f','p',NULL,113,637,NULL,'Adm','Gerente',NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(455,'2020-02-21 11:15:29',NULL,1,90,NULL,'JOAO CABEÇÃO','MARIAZINHA','10/10/1990','62966666666','02855517010','m','v',NULL,114,639,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'252525','SSPGO','s',0,'353535','ab','2030-12-25',NULL,NULL,1,0,0,NULL),(456,'2020-02-21 11:18:29',NULL,1,90,NULL,'JOAO CABEÇÃO','MARIAZINHA','10/10/1990','62966666666','02855517010','m','v',NULL,114,640,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'252525','SSPGO','s',0,'353535','ab','2030-12-25',NULL,NULL,1,0,0,NULL),(457,'2020-02-21 11:28:59',NULL,1,66,NULL,'JOAO CABEÇÃO','MARIAZINHA','10/10/1990','62966666666','02855517010','m','v',NULL,114,641,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'252525','SSPGO','s',0,'353535','ab','2030-12-25',NULL,NULL,1,0,0,NULL),(458,'2020-02-21 11:34:02',NULL,1,66,NULL,'JOAO CABEÇÃO','MARIAZINHA','10/10/1990','62966666666','02855517010','m','v',NULL,114,642,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'252525','SSPGO','s',0,'353535','ab','2030-12-25',NULL,NULL,1,0,0,NULL),(459,'2020-02-21 11:47:39',NULL,1,66,NULL,'JOAO CABEÇÃO','MARIAZINHA','10/10/1990','62966666666','02855517010','m','v',NULL,114,643,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'252525','SSPGO','s',0,'353535','ab','2030-12-25',NULL,NULL,1,0,0,NULL),(460,'2020-02-26 15:03:52',NULL,1,1,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','p','t',88,644,NULL,'Taxi/Uber','Motorista','nky2705','suzuki','preta',NULL,'p','n',NULL,NULL,NULL,'123123123','SSP','n',0,'465446','a','2030-01-01','upload/img/pessoa/15767699055dfb99719a679.jpeg','upload/img/pessoa/15767712105dfb9e8ab3039.jpeg',1,0,0,NULL),(461,'2020-02-28 08:50:38',NULL,1,4,'Uber vai entrar em minha casa.','FABIO NASCIMENTO','MARIA','01/01/2000','00000000000','36298252061','m','p','t',115,646,NULL,'Taxi/Uber','Motorista','kpf0999','Gol','branco',NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(462,'2020-02-28 10:37:52',NULL,1,109,NULL,'JOAO CABEÇÃO','MARIAZINHA','10/10/1990','62966666666','02855517010','m','v',NULL,114,647,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'252525','SSPGO','n',0,'353535','ab','2030-12-25',NULL,NULL,1,0,0,NULL),(463,'2020-02-28 10:42:06',NULL,1,109,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','v',NULL,88,648,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'123123123','SSP','n',0,'465446','a','2030-01-01','upload/img/pessoa/15767699055dfb99719a679.jpeg','upload/img/pessoa/15767712105dfb9e8ab3039.jpeg',1,0,0,NULL),(464,'2020-02-28 10:43:48',NULL,1,4,'Ira entrar com um notebook.','RONALDO','MARIA','01/01/2000','62928818288','75039751052','m','v',NULL,116,651,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(465,'2020-02-28 10:43:44',NULL,1,109,NULL,'JOAO VITOR','MARCIA','15/02/1986','62991057275','85732820027','m','v',NULL,7,650,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'12312313','SSPGO','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(466,'2020-02-28 10:49:03',NULL,NULL,19,'','Pessoa',NULL,NULL,'','',NULL,'v','',NULL,652,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(467,'2020-02-28 10:49:19',NULL,NULL,19,'','Prestador',NULL,NULL,'','',NULL,'p','',NULL,653,NULL,'Jsjs','Djjdjj','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(468,'2020-02-28 10:50:24',NULL,NULL,19,'','Yaxi',NULL,NULL,'','',NULL,'p','t',NULL,654,NULL,'TAXI/UBER','MOTORISTA','AHS1233',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(469,'2020-02-28 10:52:12',NULL,1,4,'Ira entrar com um/1 notebook.','RONALDO','MARIA','01/01/2000','62928818288','75039751052','m','v',NULL,116,657,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(470,'2020-02-28 10:51:11',NULL,NULL,19,'','Zksk',NULL,NULL,'','',NULL,'p','e',NULL,656,NULL,'Jxjs','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(471,'2020-02-28 11:07:16',NULL,1,19,NULL,'DNDNND','ASDSAD','11/11/2000','11111111111','69328826128','m','v',NULL,118,663,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',134,'ad22d','b','2020-11-11',NULL,NULL,1,0,0,NULL),(472,'2020-02-28 11:01:32',NULL,NULL,19,NULL,'Jsjss',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,659,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',134,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(473,'2020-02-28 11:01:32',NULL,NULL,19,NULL,'Jsjss',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,660,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',134,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(474,'2020-02-28 11:05:34',NULL,NULL,19,'','Taxista',NULL,NULL,'','',NULL,'p','t',NULL,661,NULL,'TAXI/UBER','MOTORISTA','AJD1233',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(475,'2020-02-28 11:10:22',NULL,1,19,NULL,'ENTREGUISTA','ASD','12/12/2000','11111111111','52657102301','f','p','e',119,664,NULL,'Anan','Entregador',NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,'d2s2','b','2020-12-12',NULL,NULL,1,0,0,NULL),(476,'2020-02-28 11:17:50',NULL,1,120,NULL,'JOAO CABEÇÃO','MARIAZINHA','10/10/1990','62966666666','02855517010','m','v',NULL,114,666,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'252525','SSPGO','s',0,'353535','ab','2030-12-25',NULL,NULL,1,0,0,NULL),(477,'2020-02-28 11:48:07',NULL,1,19,NULL,'TAX','AASD','11/11/2000','21566666666','57960539731','m','p','t',122,670,NULL,'Taxi/Uber','Motorista','ADN1334','adsd','ddsd',NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(478,'2020-02-28 11:46:12',NULL,1,19,NULL,'ADSDD','222','11/02/2000','11111111111','13236464186','m','v',NULL,121,668,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(479,'2020-02-28 11:47:19',NULL,1,19,NULL,'ADSDD','222','11/02/2000','11111111111','13236464186','m','v',NULL,121,669,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:33',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(480,'2020-02-28 11:49:46',NULL,1,19,NULL,'ADSDD','222','11/02/2000','11111111111','13236464186','m','v',NULL,121,671,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(481,'2020-02-28 12:02:46',NULL,1,4,NULL,'LIB PELO PORTARIA','MARIA','01/01/2000','00000000000','21611157072','m','v',NULL,123,672,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(482,'2020-02-28 12:19:54',NULL,NULL,4,'','Test',NULL,NULL,'','',NULL,'v','',NULL,673,NULL,'','','',NULL,NULL,NULL,'s','s','2020-02-28 17:35:10',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(483,'2020-02-28 16:34:15',NULL,1,109,'uber','TADEU ERNESTO','MARIA TEREZA','09/12/1990','62955555555','55512739115','m','p','t',124,676,NULL,'Taxi/Uber','Motorista','pro9j89','Voyage','preto',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'1235464549','ab','2050-12-02',NULL,NULL,1,0,0,NULL),(484,'2020-02-28 16:38:03',NULL,1,109,NULL,'YURI SOUSA','JOAQUINA RODRIGUES','09/05/1990','62954649696','32768248762','m','p','t',125,678,NULL,'Taxi/Uber','Motorista','prq8i89','gol','PRETA',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'554897863','ab','2021-05-08',NULL,NULL,1,0,0,NULL),(485,'2020-02-28 17:30:49',NULL,NULL,4,'','Jader',NULL,NULL,'','',NULL,'p','e',NULL,679,NULL,'Gol','ENTREGADOR','',NULL,NULL,NULL,'s','s','2020-02-28 17:30:59',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(486,'2020-02-28 17:31:19',NULL,NULL,4,'','Gol',NULL,NULL,'','',NULL,'p','e',NULL,680,NULL,'Gol','ENTREGADOR','',NULL,NULL,NULL,'s','s','2020-02-28 17:35:08',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(487,'2020-03-02 14:11:48',NULL,1,1,NULL,'TESTE FOTO TEMP','UZER','01/01/1980','62999999999','14248598248','m','v',NULL,126,681,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,'598248','SSPGO','s',0,'142485','ab','2025-05-01','upload/img/pessoa/15831691045e5d3e50c7a10.jpeg',NULL,1,0,0,NULL),(488,'2020-03-02 14:13:03',NULL,1,1,NULL,'TESTE FOTO TEMP','UZER','01/01/1980','62999999999','14248598248','m','v',NULL,126,682,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:54',1,NULL,'598248','SSPGO','s',0,'142485','ab','2025-05-01','upload/img/pessoa/15831691045e5d3e50c7a10.jpeg',NULL,1,0,0,NULL),(489,'2020-03-02 14:16:23',NULL,1,1,NULL,'TESTE FOTO TEMP','UZER','01/01/1980','62999999999','14248598248','m','v',NULL,126,684,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:19:06',1,NULL,'598248','SSPGO','s',0,'142485','ab','2025-05-01','upload/img/pessoa/15831691045e5d3e50c7a10.jpeg',NULL,1,0,0,NULL),(490,'2020-03-03 10:44:26',NULL,NULL,127,'','Xhsns',NULL,NULL,'','',NULL,'v','',NULL,685,NULL,'','','',NULL,NULL,NULL,'s','s','2020-03-03 14:25:07',127,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(491,'2020-03-03 10:50:14',NULL,1,127,NULL,'PORTARIA','SADASD','11/11/2000','11122122222','83645055720','m','v',NULL,128,686,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(492,'2020-03-03 10:53:29',NULL,1,127,NULL,'PORTARIA','SADASD','11/11/2000','11122122222','83645055720','m','v',NULL,128,688,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(493,'2020-03-03 10:56:51',NULL,1,1,NULL,'OTA PESSOA','SDASD','11/11/2000','11111111111','15418342088','m','v',NULL,129,689,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(494,'2020-03-03 10:58:37',NULL,1,1,NULL,'OTA PESSOA','SDASD','11/11/2000','11111111111','15418342088','m','v',NULL,129,690,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:54',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(495,'2020-03-03 11:01:46',NULL,1,1,NULL,'OTA PESSOA 2','1QASDASDSAD','11/11/2000','11111111111','88089751008','m','v',NULL,130,691,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(496,'2020-03-03 12:10:46',NULL,NULL,127,'','Nsnssn',NULL,NULL,'','',NULL,'v','',NULL,692,NULL,'','','',NULL,NULL,NULL,'s','s','2020-03-03 14:25:05',127,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(497,'2020-03-03 12:11:15',NULL,NULL,127,'','Bjdd',NULL,NULL,'','',NULL,'v','',NULL,693,NULL,'','','',NULL,NULL,NULL,'s','s','2020-03-03 14:25:04',127,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(498,'2020-03-03 14:02:40',NULL,1,127,NULL,'PORTARIA','SADASD','11/11/2000','11122122222','83645055720','m','v',NULL,128,695,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(499,'2020-03-03 14:03:01',NULL,NULL,127,'','PORTARIA','SADASD','11/11/2000','11122122222','83645055720','m','v','',128,696,NULL,'','','',NULL,NULL,NULL,'s','s','2020-03-03 14:25:02',127,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(500,'2020-03-03 14:05:28',NULL,NULL,127,NULL,'Sjjsns',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,697,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-03-03 14:40:04',127,NULL,NULL,'','n',135,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(501,'2020-03-03 14:05:52',NULL,NULL,127,NULL,'Hhh',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,698,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-03-03 14:40:02',127,NULL,NULL,'','n',136,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(502,'2020-03-03 14:23:58',NULL,NULL,127,'','Hshs',NULL,NULL,'','',NULL,'p','t',NULL,699,NULL,'TAXI/UBER','MOTORISTA','JJS2333',NULL,NULL,NULL,'s','s','2020-03-03 14:25:00',127,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(503,'2020-03-03 14:25:24',NULL,NULL,127,'','Taxi',NULL,NULL,'','',NULL,'p','t',NULL,700,NULL,'TAXI/UBER','MOTORISTA','ASF3333',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(504,'2020-03-03 14:25:33',NULL,NULL,127,'','Sjjddj',NULL,NULL,'','',NULL,'p','e',NULL,701,NULL,'Jsjddj','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(505,'2020-03-03 14:36:56',NULL,NULL,127,'','Jdjdd',NULL,NULL,'','',NULL,'v','',NULL,702,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(506,'2020-03-03 14:39:55',NULL,NULL,127,NULL,'Jjssn',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,703,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-03-03 14:40:00',127,NULL,NULL,'','n',137,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(507,'2020-03-03 14:47:35',NULL,1,133,NULL,'DJJD','1111','11/11/2000','11111111111','77441675898','m','v',NULL,134,707,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',138,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(508,'2020-03-03 16:24:10',NULL,NULL,4,'','Gf',NULL,NULL,'','',NULL,'p','t',NULL,708,NULL,'TAXI/UBER','MOTORISTA','DDSDDFF',NULL,NULL,NULL,'s','s','2020-03-03 16:36:49',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(509,'2020-03-03 16:24:48',NULL,NULL,4,'','Dfsw',NULL,NULL,'','',NULL,'p','t',NULL,709,NULL,'TAXI/UBER','MOTORISTA','RERR222',NULL,NULL,NULL,'s','s','2020-03-03 16:36:37',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(510,'2020-03-03 16:25:44',NULL,NULL,4,'','Ttgg',NULL,NULL,'','',NULL,'p','t',NULL,710,NULL,'TAXI/UBER','MOTORISTA','3234334',NULL,NULL,NULL,'s','s','2020-03-03 16:36:31',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(511,'2020-03-03 16:29:41',NULL,NULL,4,'','Rfrr',NULL,NULL,'','',NULL,'p','t',NULL,711,NULL,'TAXI/UBER','MOTORISTA','BIOOooo',NULL,NULL,NULL,'s','s','2020-03-03 16:36:51',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(512,'2020-03-03 16:34:38',NULL,NULL,4,'','1233',NULL,NULL,'','',NULL,'p','t',NULL,712,NULL,'TAXI/UBER','MOTORISTA','bio0t55',NULL,NULL,NULL,'s','s','2020-03-03 16:36:29',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(513,'2020-03-03 16:35:29',NULL,NULL,4,'','123123',NULL,NULL,'','',NULL,'p','t',NULL,713,NULL,'TAXI/UBER','MOTORISTA','reotttt',NULL,NULL,NULL,'s','s','2020-03-03 16:36:22',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(514,'2020-03-03 16:37:14',NULL,NULL,4,'','Ftg56',NULL,NULL,'','',NULL,'p','t',NULL,714,NULL,'TAXI/UBER','MOTORISTA','FDR1o43',NULL,NULL,NULL,'s','s','2020-03-03 17:03:25',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(515,'2020-03-03 16:48:53',NULL,NULL,4,'','Qwe',NULL,NULL,'','',NULL,'p','t',NULL,717,NULL,'TAXI/UBER','MOTORISTA','GGT5yt2',NULL,NULL,NULL,'s','s','2020-03-03 17:03:16',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(516,'2020-03-03 16:49:28',NULL,NULL,4,'','Gddd',NULL,NULL,'','',NULL,'p','t',NULL,718,NULL,'TAXI/UBER','MOTORISTA','Hui',NULL,NULL,NULL,'s','s','2020-03-03 17:03:15',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(517,'2020-03-03 16:50:04',NULL,NULL,4,'','Gfjh',NULL,NULL,'','',NULL,'p','t',NULL,719,NULL,'TAXI/UBER','MOTORISTA','GUO2qwe',NULL,NULL,NULL,'s','s','2020-03-03 17:03:13',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(518,'2020-03-03 16:53:05',NULL,NULL,127,'','Frd',NULL,NULL,'','',NULL,'p','t',NULL,720,NULL,'TAXI/UBER','MOTORISTA','SIS8888',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(519,'2020-03-03 17:03:00',NULL,NULL,4,'','Ghhg4',NULL,NULL,'','',NULL,'p','t',NULL,721,NULL,'TAXI/UBER','MOTORISTA','FGDG3gg',NULL,NULL,NULL,'s','s','2020-03-03 17:03:11',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(520,'2020-03-03 17:06:29',NULL,NULL,4,'','23',NULL,NULL,'','',NULL,'p','t',NULL,722,NULL,'TAXI/UBER','MOTORISTA','bio1e34',NULL,NULL,NULL,'s','s','2020-03-03 17:25:57',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(521,'2020-03-03 17:06:55',NULL,NULL,4,'','ee',NULL,NULL,'','',NULL,'p','t',NULL,723,NULL,'TAXI/UBER','MOTORISTA','bio3f44',NULL,NULL,NULL,'s','s','2020-03-03 17:25:56',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(522,'2020-03-03 17:07:33',NULL,NULL,4,'','rrr',NULL,NULL,'','',NULL,'p','t',NULL,724,NULL,'TAXI/UBER','MOTORISTA','der1e32',NULL,NULL,NULL,'s','s','2020-03-03 17:25:53',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(523,'2020-03-03 17:11:57',NULL,NULL,4,'','dede',NULL,NULL,'','',NULL,'p','t',NULL,725,NULL,'TAXI/UBER','MOTORISTA','rrrrrrrr',NULL,NULL,NULL,'s','s','2020-03-03 17:25:51',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(524,'2020-03-03 17:13:41',NULL,NULL,4,'','213rewwee',NULL,NULL,'','',NULL,'p','t',NULL,726,NULL,'TAXI/UBER','MOTORISTA','3ee43ee',NULL,NULL,NULL,'s','s','2020-03-03 17:25:49',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(525,'2020-03-03 17:15:53',NULL,NULL,4,'','Hhft',NULL,NULL,'','',NULL,'p','t',NULL,727,NULL,'TAXI/UBER','MOTORISTA','DFR2f34',NULL,NULL,NULL,'s','s','2020-03-03 17:25:47',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(526,'2020-03-03 17:16:40',NULL,NULL,4,'','Dfg3g',NULL,NULL,'','',NULL,'p','t',NULL,728,NULL,'TAXI/UBER','MOTORISTA','FGR3D43',NULL,NULL,NULL,'s','s','2020-03-03 17:25:46',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(527,'2020-03-03 17:17:41',NULL,NULL,4,'','Fgsa',NULL,NULL,'','',NULL,'p','t',NULL,729,NULL,'TAXI/UBER','MOTORISTA','FGS1F33',NULL,NULL,NULL,'s','s','2020-03-03 17:25:44',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(528,'2020-03-03 17:21:47',NULL,NULL,1,NULL,'Taxi 2',NULL,NULL,NULL,NULL,NULL,'p','t',NULL,730,NULL,'TAXI/UBER','MOTORISTA',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(529,'2020-03-03 17:21:58',NULL,NULL,1,NULL,'Entrega 2',NULL,NULL,NULL,NULL,NULL,'p','e',NULL,731,NULL,'Jssj','ENTREGADOR',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(530,'2020-03-03 17:22:29',NULL,NULL,1,NULL,'OTA PESSOA 2',NULL,NULL,NULL,NULL,NULL,'v',NULL,130,732,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-16 17:18:54',1,NULL,NULL,'','n',139,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(531,'2020-03-03 17:23:30',NULL,NULL,4,'','123',NULL,NULL,'','',NULL,'p','t',NULL,733,NULL,'TAXI/UBER','MOTORISTA','bio3r33',NULL,NULL,NULL,'s','s','2020-03-03 17:25:42',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(532,'2020-03-03 17:26:20',NULL,NULL,4,'','re',NULL,NULL,'','',NULL,'p','t',NULL,734,NULL,'TAXI/UBER','MOTORISTA','rew4r44',NULL,NULL,NULL,'s','s','2020-03-03 17:37:06',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(533,'2020-03-03 17:31:57',NULL,NULL,4,'','213123',NULL,NULL,'','',NULL,'p','t',NULL,735,NULL,'TAXI/UBER','MOTORISTA','rie2e33',NULL,NULL,NULL,'s','s','2020-03-03 17:37:04',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(534,'2020-03-03 17:32:54',NULL,NULL,4,'','Gff',NULL,NULL,'','',NULL,'p','t',NULL,736,NULL,'TAXI/UBER','MOTORISTA','GHJ1f44',NULL,NULL,NULL,'s','s','2020-03-03 17:37:01',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(535,'2020-03-03 17:36:53',NULL,NULL,4,'','123',NULL,NULL,'','',NULL,'p','t',NULL,737,NULL,'TAXI/UBER','MOTORISTA','123eree',NULL,NULL,NULL,'s','s','2020-03-03 17:36:59',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(536,'2020-03-03 17:40:30',NULL,NULL,4,'','Rrw',NULL,NULL,'','',NULL,'p','t',NULL,738,NULL,'TAXI/UBER','MOTORISTA','FGR3w55',NULL,NULL,NULL,'s','s','2020-03-03 17:42:04',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(537,'2020-03-03 17:41:35',NULL,NULL,4,'','Ftr',NULL,NULL,'','',NULL,'p','t',NULL,739,NULL,'TAXI/UBER','MOTORISTA','FRR1D33',NULL,NULL,NULL,'s','s','2020-03-03 17:42:03',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(538,'2020-03-03 17:49:52',NULL,NULL,4,'','eee',NULL,NULL,'','',NULL,'p','t',NULL,740,NULL,'TAXI/UBER','MOTORISTA','1231213',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(539,'2020-03-03 17:59:32',NULL,NULL,4,'','qwe',NULL,NULL,'','',NULL,'p','t',NULL,742,NULL,'TAXI/UBER','MOTORISTA','qwe23ww',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(540,'2020-03-03 18:10:41',NULL,NULL,4,'','213',NULL,NULL,'','',NULL,'p','t',NULL,743,NULL,'TAXI/UBER','MOTORISTA','ree1e23',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(541,'2020-03-03 18:15:19',NULL,NULL,4,'','Trd',NULL,NULL,'','',NULL,'p','t',NULL,744,NULL,'TAXI/UBER','MOTORISTA','TFD1W3r',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(542,'2020-03-03 18:38:08',NULL,NULL,127,'HdjejShake\nJejejk','Hshs',NULL,'12/12/2000','44451546646','04311617127',NULL,'v','',NULL,745,NULL,'','','Jajajjj',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(543,'2020-03-03 18:38:32',NULL,NULL,127,'','Jakskw',NULL,NULL,'','',NULL,'p','t',NULL,746,NULL,'TAXI/UBER','MOTORISTA','Sjj1234',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(544,'2020-03-03 18:40:31',NULL,NULL,4,'','123',NULL,NULL,'','',NULL,'p','t',NULL,747,NULL,'TAXI/UBER','MOTORISTA','gre1re',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(545,'2020-03-03 18:51:44',NULL,NULL,4,'','qweqe',NULL,NULL,'','',NULL,'p','t',NULL,748,NULL,'TAXI/UBER','MOTORISTA','vrr2e4r',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(546,'2020-03-04 08:24:07',NULL,NULL,4,'','qwqe',NULL,NULL,'','',NULL,'p','t',NULL,749,NULL,'TAXI/UBER','MOTORISTA','eee3w33',NULL,NULL,NULL,'s','s','2020-03-04 09:17:31',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(547,'2020-03-04 09:05:43',NULL,NULL,4,'','wqe',NULL,NULL,'','',NULL,'p','t',NULL,750,NULL,'TAXI/UBER','MOTORISTA','ewe1e33',NULL,NULL,NULL,'s','s','2020-03-04 09:17:30',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(548,'2020-03-04 09:11:29',NULL,NULL,4,'','erer',NULL,NULL,'','',NULL,'p','t',NULL,751,NULL,'TAXI/UBER','MOTORISTA','rereq21',NULL,NULL,NULL,'s','s','2020-03-04 09:17:28',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(549,'2020-03-04 09:28:31',NULL,1,4,NULL,'PLACA','MARIA','10/10/2000','00000000000','30095278028','m','p','t',135,754,NULL,'Taxi/Uber','Motorista','bio2e33','gol','red',NULL,'s','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(550,'2020-03-04 09:26:21',NULL,NULL,4,'novo teste','Teste placa',NULL,'10/10/2000','62991093988','06863930072',NULL,'v','',NULL,753,NULL,'','','bio3e33',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(551,'2020-03-04 09:58:19',NULL,NULL,4,NULL,'Ed',NULL,NULL,'','',NULL,'p','t',NULL,755,NULL,'TAXI/UBER','MOTORISTA','erw1e32',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(559,'2020-03-04 11:00:16',NULL,NULL,4,'Uber vai entrar em minha casa.','FABIO NASCIMENTO','MARIA','01/01/2000','00000000000','36298252061','m','p','t',115,763,NULL,'TAXI/UBER','MOTORISTA','kpf0999',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(560,'2020-03-04 11:02:57',NULL,NULL,4,'eeeee','qwewe',NULL,NULL,'','',NULL,'p','t',NULL,764,NULL,'TAXI/UBER','MOTORISTA','qweqwqe',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(561,'2020-03-04 11:05:38',NULL,NULL,4,NULL,'qweqwe',NULL,NULL,'','',NULL,'p','t',NULL,765,NULL,'TAXI/UBER','MOTORISTA','ewreerw',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(562,'2020-03-04 11:26:44',NULL,NULL,4,'Tese','teste Oi',NULL,NULL,'','',NULL,'p','t',NULL,766,NULL,'TAXI/UBER','MOTORISTA','qwe321s',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(563,'2020-03-05 09:22:30',NULL,NULL,4,NULL,'Gddf',NULL,NULL,'','',NULL,'p','t',NULL,767,NULL,'TAXI/UBER','MOTORISTA','BIK3F34',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(564,'2020-03-05 09:24:13',NULL,NULL,4,'New test','Teste',NULL,NULL,'','',NULL,'p','t',NULL,768,NULL,'TAXI/UBER','MOTORISTA','HJK7fdf',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(565,'2020-03-05 09:26:19',NULL,NULL,4,NULL,'River',NULL,NULL,'','',NULL,'p','e',NULL,769,NULL,'Tm','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(566,'2020-03-05 09:26:54',NULL,NULL,4,NULL,'Com obs',NULL,NULL,'','',NULL,'p','e',NULL,770,NULL,'Ym','ENTREGADOR','ERF33df',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(567,'2020-03-05 09:28:27',NULL,NULL,4,'Test novo','Gde ffe',NULL,NULL,'','',NULL,'p','e',NULL,771,NULL,'Gf','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(568,'2020-03-05 09:30:58',NULL,NULL,4,'Rest','Pres nor',NULL,NULL,'','',NULL,'p','',NULL,772,NULL,'Tr','Adm','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(569,'2020-03-05 09:32:48',NULL,NULL,4,'Fftgfggr','Fdde',NULL,'01/01/2000','','',NULL,'p','',NULL,773,NULL,'Gyn','Geren.','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(570,'2020-03-05 10:03:46',NULL,NULL,4,'Entrar hoje','Mynew',NULL,'25/08/1988','00000000000','',NULL,'v','',NULL,774,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(571,'2020-03-05 10:50:21',NULL,NULL,4,NULL,'Dhdh',NULL,NULL,NULL,NULL,NULL,'v','',NULL,775,NULL,'','',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(572,'2020-03-05 10:50:58',NULL,NULL,4,NULL,'Fhhfdh',NULL,NULL,NULL,NULL,NULL,'p','t',NULL,776,NULL,'TAXI/UBER','MOTORISTA',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(573,'2020-03-05 10:51:24',NULL,NULL,4,NULL,'Local',NULL,NULL,NULL,NULL,NULL,'p','',NULL,777,NULL,'Dhr','Dhe',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(574,'2020-03-05 10:51:46',NULL,NULL,4,NULL,'Tu',NULL,NULL,NULL,NULL,NULL,'p','e',NULL,778,NULL,'Teste','ENTREGADOR',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(575,'2020-03-05 16:14:18',NULL,NULL,1,NULL,'Jsjsjs',NULL,NULL,'','',NULL,'p','t',NULL,779,NULL,'TAXI/UBER','MOTORISTA','SHSJSJS',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(576,'2020-03-05 16:14:27',NULL,NULL,1,NULL,'Skksjs',NULL,NULL,'','',NULL,'p','t',NULL,780,NULL,'TAXI/UBER','MOTORISTA','1221111',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(577,'2020-03-05 16:15:42',NULL,NULL,1,NULL,'Entregas',NULL,NULL,'','',NULL,'p','e',NULL,781,NULL,'Zbzns','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(578,'2020-03-10 10:27:44',NULL,NULL,4,NULL,'Gff',NULL,NULL,'','',NULL,'p','t',NULL,782,NULL,'TAXI/UBER','MOTORISTA','GHY4ewe',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(579,'2020-03-10 15:43:56',NULL,1,25,NULL,'SEDGFSDF','M','05/05/2000','45642356356','36717167467','m','v',NULL,137,784,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'sdferg4','sghe5r','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(580,'2020-03-16 10:45:37',NULL,1,3,NULL,'ROBERTO DINAMITE','JOANA','01/01/1998','62999999999','71514712032','m','v',NULL,140,786,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'84559','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(581,'2020-03-16 11:00:30',NULL,1,3,NULL,'ROBERTO DINAMITE','JOANA','01/01/1998','62999999999','71514712032','m','v',NULL,140,787,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'84559','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(582,'2020-03-16 12:19:39',NULL,1,3,NULL,'JULIA ROBERTA DINIZ','HELENA SOUZA DINIZ','01/01/1998','62999999999','50479391033','m','v',NULL,141,788,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(583,'2020-03-16 12:22:00',NULL,1,3,NULL,'JULIA ROBERTA DINIZ','HELENA SOUZA DINIZ','01/01/1998','62999999999','50479391033','m','v',NULL,141,789,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(584,'2020-03-16 12:23:11',NULL,1,3,NULL,'JULIA ROBERTA DINIZ','HELENA SOUZA DINIZ','01/01/1998','62999999999','50479391033','m','v',NULL,141,790,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(585,'2020-03-16 12:24:09',NULL,1,3,NULL,'JULIA ROBERTA DINIZ','HELENA SOUZA DINIZ','01/01/1998','62999999999','50479391033','m','p','t',141,791,NULL,'Taxi/Uber','Motorista','nlk2258','Fiesta','branco',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(586,'2020-03-16 18:02:40',NULL,NULL,4,NULL,'Jsjssjdj',NULL,NULL,'','',NULL,'v','',NULL,792,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(587,'2020-03-17 10:35:20',NULL,1,3,NULL,'ROBERTO CARLOS','',NULL,NULL,NULL,'m','v',NULL,144,793,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'125432','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(588,'2020-03-17 10:40:21',NULL,1,3,NULL,'FELIPE MARIO','',NULL,NULL,NULL,'m','v',NULL,145,794,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1545678','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(589,'2020-03-17 10:41:01',NULL,1,3,NULL,'FELIPE MARIANO','',NULL,NULL,NULL,'m','v',NULL,146,795,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'124558','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(590,'2020-03-17 10:43:53',NULL,1,3,NULL,'MARCELA GONZAGA','',NULL,NULL,NULL,'m','v',NULL,147,796,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1215265','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(591,'2020-03-17 10:44:25',NULL,1,3,NULL,'CARLOS AUGUSTO SOUZA','',NULL,NULL,NULL,'m','v',NULL,148,797,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'7854121','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(592,'2020-03-17 10:46:27',NULL,1,3,NULL,'JOAQUIM DA SILVA CAMARGO','',NULL,NULL,NULL,'m','p',NULL,149,798,NULL,'Global Piscinas','Piscineiro',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1264859','SSP','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(593,'2020-03-17 10:47:35',NULL,1,3,NULL,'JOAQUIM DA SILVA CAMARGO','','31/12/1969',NULL,NULL,'m','p',NULL,149,799,NULL,'Global Piscinas','Piscineiro',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1264859','SSP','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(594,'2020-03-17 10:48:46',NULL,1,3,NULL,'PAULO HENRIQUE','',NULL,NULL,NULL,'m','p','e',150,800,NULL,'IFOOD','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'2326581','SSP','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(595,'2020-03-17 10:49:47',NULL,1,3,NULL,'JULIANO SOUZA','',NULL,NULL,NULL,'m','p','t',151,801,NULL,'Taxi/Uber','Motorista','nlk2258','GOl','preto',NULL,'p','n',NULL,NULL,NULL,'04524','SSP','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(596,'2020-03-17 10:54:42',NULL,1,3,NULL,'JOANA PEREIRA SOUZA','JOANA SOUZA','01/01/1992','62999999999','15351747065','f','v',NULL,111,810,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(597,'2020-03-17 10:54:23',NULL,1,3,NULL,'WEIDHER NERES','',NULL,NULL,NULL,'m','p',NULL,154,809,NULL,'Vaneli','Gerente comercial',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'522665','SSP','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(598,'2020-03-17 10:53:47',NULL,1,3,NULL,'MARCELO','',NULL,NULL,NULL,'m','p','t',153,808,NULL,'Taxi/Uber','Motorista','NKL5434','Hb20','Preto',NULL,'s','n',NULL,NULL,NULL,'74858','SSPO','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(599,'2020-03-17 10:53:09',NULL,1,3,NULL,'CAROLINA','',NULL,NULL,NULL,'f','p','e',152,807,NULL,'Ifood','Entregador',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'7459895','SSP','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(600,'2020-03-17 14:51:12',NULL,1,3,NULL,'CARLOS AUGUSTO SOUZA','','31/12/1969',NULL,NULL,'m','v',NULL,148,811,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'7854121','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(601,'2020-03-17 14:51:43',NULL,1,3,NULL,'JOAQUIM DA SILVA CAMARGO','','31/12/1969',NULL,NULL,'m','p',NULL,149,812,NULL,'Global Piscinas','Piscineiro',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1264859','SSP','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(602,'2020-03-17 14:52:35',NULL,1,3,NULL,'MARCELA GONZAGA','','31/12/1969',NULL,NULL,'m','p','t',147,813,NULL,'Taxi/Uber','Motorista','nlk2258','Gol','Preto',NULL,'p','n',NULL,NULL,NULL,'1215265','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(603,'2020-03-17 14:55:08',NULL,1,3,NULL,'WEIDHER NERES','','31/12/1969',NULL,NULL,'m','p',NULL,154,814,NULL,'Vaneli','Gerente comercial',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'522665','SSP','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(604,'2020-03-17 14:56:25',NULL,1,3,NULL,'CAROLINA','','31/12/1969',NULL,NULL,'f','p','e',152,815,NULL,'Ifood','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'7459895','SSP','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(605,'2020-03-17 15:00:11',NULL,1,3,NULL,'MARCELA GONZAGA','','31/12/1969',NULL,NULL,'m','p','t',147,816,NULL,'Taxi/Uber','Motorista','nlk2258','Gol','Preto',NULL,'p','n',NULL,NULL,NULL,'1215265','SSPGO','s',0,'5225152','b','2022-01-01',NULL,NULL,1,0,0,NULL),(606,'2020-03-17 15:21:46',NULL,1,3,NULL,'MARCELA GONZAGA','','31/12/1969',NULL,NULL,'m','p','t',147,817,NULL,'Taxi/Uber','Motorista','nlk2258','Gol','Preto',NULL,'p','n',NULL,NULL,NULL,'1215265','SSPGO','s',0,'5225152','b','2022-01-01',NULL,NULL,1,0,0,NULL),(607,'2020-03-17 15:27:03',NULL,1,3,NULL,'MARCELA GONZAGA','','31/12/1969',NULL,NULL,'m','p','t',147,818,NULL,'Taxi/Uber','Motorista','nlk2258','Gol','Preto',NULL,'p','n',NULL,NULL,NULL,'1215265','SSPGO','s',0,'5225152','b','2022-01-01',NULL,NULL,1,0,0,NULL),(608,'2020-03-18 10:59:31',NULL,NULL,1,NULL,'OTA PESSOA 2','1QASDASDSAD','11/11/2000','11111111111','88089751008','m','v','',130,819,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(609,'2020-03-18 11:00:36',NULL,1,1,NULL,'OTA PESSOA 2','1QASDASDSAD','11/11/2000','11111111111','88089751008','m','v',NULL,130,820,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:19:06',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(610,'2020-03-18 11:01:31',NULL,NULL,1,NULL,'OTA PESSOA 2','1QASDASDSAD','11/11/2000','11111111111','88089751008','m','v','',130,821,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(611,'2020-03-19 09:13:00',NULL,NULL,4,NULL,'RONALDO','MARIA','01/01/2000','62928818288','75039751052','m','v','',116,822,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(612,'2020-03-23 10:24:46',NULL,NULL,4,NULL,'Djeje',NULL,NULL,'','',NULL,'v','',NULL,823,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(613,'2020-03-23 11:33:47',NULL,NULL,4,NULL,'qweqwe',NULL,NULL,'','',NULL,'v','',NULL,824,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(614,'2020-03-23 11:33:58',NULL,NULL,4,NULL,'RONALDO','MARIA','01/01/2000','62928818288','75039751052','m','v','',116,825,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(615,'2020-03-24 09:30:21',NULL,NULL,4,NULL,'LAURA','BIA','01/01/2000','62991057275','48625975054','f','v','',96,826,NULL,'','','',NULL,NULL,NULL,'s','s','2020-03-24 14:49:17',4,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(616,'2020-03-24 09:30:29',NULL,NULL,4,NULL,'IGOR','JORGE','01/01/2000','62991057275','79480062062','m','v','',98,827,NULL,'','','',NULL,NULL,NULL,'s','s','2020-03-24 14:49:15',4,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(617,'2020-03-24 15:49:29',NULL,NULL,4,NULL,'LIB PELO PORTARIA','MARIA','01/01/2000','00000000000','21611157072','m','v','',123,828,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(618,'2020-03-24 15:49:38',NULL,NULL,4,NULL,'GESICA','TESTE','01/01/2000','00000000000','65054811095','f','p','',113,829,NULL,'Adm','Gerente','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(619,'2020-03-24 15:49:49',NULL,NULL,4,NULL,'FABIO NASCIMENTO','MARIA','01/01/2000','00000000000','36298252061','m','p','t',115,830,NULL,'TAXI/UBER','MOTORISTA','kpf0999',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(620,'2020-03-25 09:09:02',NULL,1,1,'teste','PAULO VITOR NUNES DO NASCIMENTO','MARIA','09/05/1989','62999999999','02191613136','m','v',NULL,88,831,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'123123123','SSP','n',0,'465446','a','2030-01-01','upload/img/pessoa/15767699055dfb99719a679.jpeg','upload/img/pessoa/15767712105dfb9e8ab3039.jpeg',1,0,0,NULL),(621,'2020-03-25 09:10:18',NULL,1,1,NULL,'VISITANTE','N','09/09/2000','55555555555',NULL,'m','v',NULL,28,832,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'1234','W45H5','n',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(622,'2020-04-02 11:01:45',NULL,1,4,NULL,'FLAVIA','RAQUEL','01/01/2000','62991057275','96898398024','f','v',NULL,95,834,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(623,'2020-04-02 11:09:55',NULL,1,4,NULL,'LAURA','BIA','01/01/2000','62991057275','48625975054','f','v',NULL,96,836,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:18',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(624,'2020-04-02 13:45:32',NULL,1,4,NULL,'RONALDO','MARIA','01/01/2000','62928818288','75039751052','m','v',NULL,116,839,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:13',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(625,'2020-04-02 13:46:59',NULL,1,4,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,841,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:14',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(626,'2020-04-08 17:53:25',NULL,1,1,NULL,'RAFAEL GONZAGA GONÇALVES','RAFAEL','22/07/1992','62984169089','03404718160','m','v',NULL,3,843,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'5410848','SSPGO','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(627,'2020-04-17 16:15:50',NULL,1,25,NULL,'GAWERG','',NULL,NULL,NULL,'m','v',NULL,158,844,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'adrfgarga','ARGAWER','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(628,'2020-04-20 10:47:10',NULL,1,108,NULL,'NAYARA','',NULL,NULL,'02546713140','f','p',NULL,159,846,NULL,'uzer','executiva de vendas',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(629,'2020-04-20 11:33:59',NULL,1,155,NULL,'RONALDO UZER','','10/10/1982','62992981141','14282768665','m','v',NULL,157,848,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'14282768','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(630,'2020-04-20 11:36:45',NULL,1,155,NULL,'RONALDO UZER','','10/10/1982','62992981141','14282768665','m','v',NULL,157,849,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'14282768','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(631,'2020-04-20 11:38:44',NULL,1,155,NULL,'RONALDO UZER','','10/10/1982','62992981141','14282768665','m','v',NULL,157,850,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'14282768','SSPGO','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(632,'2020-04-22 09:28:29',NULL,NULL,4,NULL,'MARIA','NENE','01/01/2000','62991057272','82148097032','f','v','',94,851,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(633,'2020-04-27 15:55:14',NULL,1,4,NULL,'MARIA','NENE','01/01/2000','62991057272','82148097032','f','v',NULL,94,853,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(634,'2020-04-27 16:01:45',NULL,1,4,NULL,'FLAVIA','RAQUEL','01/01/2000','62991057275','96898398024','f','v',NULL,95,855,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:43:18',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(635,'2020-04-27 16:18:52',NULL,1,4,NULL,'RONALDO','MARIA','01/01/2000','62928818288','75039751052','m','v',NULL,116,857,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:46:00',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(636,'2020-04-27 17:13:08',NULL,1,4,NULL,'GESICA','TESTE','01/01/2000','00000000000','65054811095','f','p',NULL,113,859,NULL,'Adm','Gerente',NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(637,'2020-04-27 17:23:54',NULL,1,1,NULL,'ADSDD','',NULL,NULL,'53355054194','m','v',NULL,160,860,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(638,'2020-04-27 17:24:28',NULL,1,1,NULL,'ADSDD','','31/12/1969',NULL,'53355054194','m','v',NULL,160,861,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:54',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(639,'2020-04-27 17:25:44',NULL,1,1,NULL,'ADSDD','',NULL,NULL,'53355054194','m','v',NULL,160,863,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-16 17:19:06',1,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(640,'2020-04-27 17:49:19',NULL,1,4,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,865,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(641,'2020-04-28 08:55:24',NULL,1,19,NULL,'VISITANTE','',NULL,NULL,'32125239809','m','v',NULL,161,871,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(642,'2020-04-28 08:56:39',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,872,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:33',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(643,'2020-04-28 08:47:32',NULL,NULL,19,NULL,'TAXI','ADSADD','12/12/2000','11111111111','20766386104','f','p','t',102,868,NULL,'TAXI/UBER','MOTORISTA','KSK1a34',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(644,'2020-04-28 08:54:47',NULL,1,19,NULL,'ENTREGUISTA','ASD','12/12/2000','11111111111','52657102301','f','p','e',119,870,NULL,'Anan','Entregador',NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:33',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(645,'2020-04-28 08:57:07',NULL,1,19,NULL,'VISITANTE','',NULL,NULL,'32125239809','m','v',NULL,161,874,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:32',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(646,'2020-04-28 08:58:28',NULL,1,19,NULL,'VISITANTE','',NULL,NULL,'32125239809','m','v',NULL,161,878,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:44',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(647,'2020-04-28 08:58:12',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,877,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:44',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(648,'2020-04-28 09:00:28',NULL,1,19,NULL,'TESTE PORTARIA','ASDAD','11/11/2000','11111111111','42410097006','m','v',NULL,100,883,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:54',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(649,'2020-04-28 09:00:10',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,881,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:54',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(650,'2020-04-28 09:07:29',NULL,1,4,NULL,'MARIA','NENE','01/01/2000','62991057272','82148097032','f','v',NULL,94,884,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:16',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(651,'2020-04-28 09:10:41',NULL,1,25,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,885,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(652,'2020-04-28 09:12:47',NULL,1,4,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,886,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:20',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(653,'2020-04-28 09:14:12',NULL,1,3,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,887,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(654,'2020-04-28 09:17:04',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,888,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(655,'2020-04-28 09:23:47',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,889,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(656,'2020-04-28 09:24:53',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,890,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(657,'2020-04-28 09:25:43',NULL,1,3,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,891,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(658,'2020-04-28 09:27:04',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,892,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(659,'2020-04-28 09:29:04',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,893,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(660,'2020-04-28 09:29:22',NULL,1,3,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,894,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(661,'2020-04-28 09:31:33',NULL,1,3,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,895,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(662,'2020-04-28 09:32:19',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,896,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(663,'2020-04-28 09:35:24',NULL,1,4,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,897,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:42:42',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(664,'2020-04-28 09:37:53',NULL,1,4,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,898,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:44:08',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(665,'2020-04-28 10:24:15',NULL,1,3,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,899,NULL,'Taxi/Uber','Motorista','12343gf','GOl','branco',NULL,'p','n',NULL,NULL,NULL,'1231313','CNH','n',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(666,'2020-04-28 10:25:21',NULL,1,3,NULL,'GUSTAVO GOMES','',NULL,NULL,'19946891026','m','v',NULL,162,900,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(667,'2020-04-28 10:28:57',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,901,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(668,'2020-04-28 10:34:43',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,902,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(669,'2020-04-28 11:11:48',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,903,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(670,'2020-04-28 14:41:34',NULL,1,19,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,905,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(671,'2020-04-28 14:48:34',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,906,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(672,'2020-04-28 15:31:03',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,907,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(673,'2020-04-28 15:52:20',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,908,NULL,'Prestador','Empresa',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(674,'2020-04-28 15:54:47',NULL,1,19,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,910,NULL,'asdasd','sssss',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(675,'2020-04-28 15:57:10',NULL,1,19,NULL,'PESSOA NORMAL','DDASDA','31/12/1969','62985246609','22783612100','m','v',NULL,106,913,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:32',19,NULL,'6545656','32545','s',0,NULL,NULL,NULL,'upload/img/pessoa/5e398f29c049b.jpeg',NULL,1,0,0,NULL),(676,'2020-04-28 15:57:49',NULL,1,19,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,914,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:32',19,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(677,'2020-04-29 08:28:13',NULL,1,12,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,915,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(678,'2020-04-29 08:28:31',NULL,1,12,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,916,NULL,'asdasd','sssss',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(679,'2020-04-29 08:29:53',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,917,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(680,'2020-04-29 08:30:08',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,918,NULL,'asdasd','sssss',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(681,'2020-04-29 08:30:47',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,919,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(682,'2020-04-29 08:31:01',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,920,NULL,'asdasd','sssss',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(683,'2020-04-29 08:43:06',NULL,1,12,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,921,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(684,'2020-04-29 08:48:57',NULL,1,12,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p','t',101,922,NULL,'Taxi/Uber','Motorista','adssada','asd','sad',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(685,'2020-04-29 08:50:31',NULL,1,12,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p','e',101,923,NULL,'Taxi/Uber','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(686,'2020-04-29 09:36:00',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,924,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(687,'2020-04-29 09:36:16',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,925,NULL,'Taxi/Uber','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(688,'2020-04-29 09:36:29',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p','t',101,926,NULL,'Taxi/Uber','Motorista','adssada','asd','sad',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(689,'2020-04-29 09:36:45',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p','e',101,927,NULL,'Taxi/Uber','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(690,'2020-04-29 09:39:53',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,928,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(691,'2020-04-29 09:40:07',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,929,NULL,'Taxi/Uber','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(692,'2020-04-29 09:40:19',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p','t',101,930,NULL,'Taxi/Uber','Motorista','adssada','asd','sad',NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(693,'2020-04-29 09:40:32',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p','e',101,931,NULL,'Taxi/Uber','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(694,'2020-04-29 09:42:02',NULL,1,1,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,932,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(695,'2020-04-29 09:42:14',NULL,1,1,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p',NULL,101,933,NULL,'Taxi/Uber','Entregador',NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:54',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(696,'2020-04-29 09:42:26',NULL,1,1,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','p','t',101,934,NULL,'Taxi/Uber','Motorista','adssada','asd','sad',NULL,'p','s','2020-10-16 17:19:06',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(697,'2020-04-29 09:42:37',NULL,1,1,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,935,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:19:12',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(698,'2020-04-29 09:44:36',NULL,1,143,NULL,'PRESTADOR','ASDD','12/12/2000','11111111111','04185769202','f','v',NULL,101,936,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(699,'2020-04-29 18:24:30',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,941,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(700,'2020-04-29 18:25:35',NULL,1,4,NULL,'GESICA','TESTE','01/01/2000','00000000000','65054811095','f','p',NULL,113,942,NULL,'Adm','Gerente',NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:04',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(701,'2020-04-29 18:24:06',NULL,1,4,NULL,'IGOR','JORGE','01/01/2000','62991057275','79480062062','m','v',NULL,98,940,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:06',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(702,'2020-04-29 19:22:46',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(703,'2020-04-29 19:23:59',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,944,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(704,'2020-04-30 08:47:27',NULL,1,4,NULL,'MARIA','NENE','01/01/2000','62991057272','82148097032','f','v',NULL,94,946,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:46:00',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(705,'2020-04-30 10:33:27',NULL,1,3,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,947,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(706,'2020-04-30 11:53:54',NULL,1,1,NULL,'GUSTAVO GOMES','','31/12/1969',NULL,'19946891026','m','v',NULL,162,948,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'5256256','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(707,'2020-05-11 17:56:42',NULL,1,19,NULL,'ASDASDA DAS DAS','',NULL,NULL,'44735468960','m','p',NULL,NULL,949,NULL,'uzer','designer',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(708,'2020-05-11 17:56:55',NULL,1,19,NULL,'ASDASDA DAS DAS','',NULL,NULL,'44735468960','m','p',NULL,NULL,950,NULL,'uzer','designer',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(709,'2020-05-11 17:57:47',NULL,1,19,NULL,'ASDASDA DAS DAS','',NULL,NULL,'44735468960','m','p',NULL,NULL,951,NULL,'uzer','designer',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(710,'2020-05-11 18:00:18',NULL,1,19,NULL,'ASDASDA DAS DAS','',NULL,NULL,'44735468960','m','p','t',NULL,952,NULL,'Taxi/Uber','Motorista','','','',NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(711,'2020-05-11 18:00:25',NULL,1,19,NULL,'ASDASDA DAS DAS','',NULL,NULL,'21433095386','m','p','t',NULL,953,NULL,'Taxi/Uber','Motorista','','','',NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(712,'2020-05-11 18:41:49',NULL,1,25,NULL,'TESTE ENTRADA','M','05/05/2000','56345634563','67078355130','m','v',NULL,168,954,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(713,'2020-05-12 19:32:37',NULL,1,19,NULL,'ASD','',NULL,NULL,NULL,'m','v',NULL,NULL,955,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(714,'2020-05-13 18:04:34',NULL,1,19,NULL,'ASDSAD','5ASDSAD','12/12/2000','62988999998','52738644538','m','p',NULL,169,956,NULL,'adasda','dasdsad',NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:02',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(715,'2020-05-13 18:27:26',NULL,1,19,NULL,'ASDSAD','5ASDSAD','12/12/2000','62988999998','52738644538','m','v',NULL,169,959,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:32',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(716,'2020-05-13 18:25:51',NULL,1,19,NULL,'OIOI','',NULL,NULL,NULL,'m','v',NULL,NULL,958,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(717,'2020-05-18 17:29:54',NULL,1,19,NULL,'CPF DO BRUNO','ASDAS','22/10/2000','11111111111','04311617127','m','p','t',46,961,NULL,'Taxi/Uber','Motorista','abdasda','123','123',NULL,'p','n',NULL,NULL,NULL,'04311617127','CPF','n',0,'asdasd','b','2020-11-11',NULL,NULL,1,0,0,NULL),(718,'2020-05-18 17:47:45',NULL,1,19,NULL,'ASDASD','',NULL,NULL,NULL,'m','p',NULL,NULL,963,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(719,'2020-05-22 11:49:27',NULL,1,1,NULL,'ROBERTO ALMEIDA','TESTE','11/11/2000','62222222222','48971028394','m','v',NULL,166,965,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,'32rdd','SD2345','s',0,'54545657496','ab','2025-12-20','upload/img/pessoa/5ea9c59baaf88.jpeg',NULL,1,0,0,NULL),(720,'2020-05-22 11:51:29',NULL,1,1,NULL,'ROBERTO ALMEIDA','TESTE','11/11/2000','62222222222','48971028394','m','v',NULL,166,966,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:54',1,NULL,'32rdd','SD2345','s',0,'45645498','ab','2025-12-25','upload/img/pessoa/5ea9c59baaf88.jpeg',NULL,1,0,0,NULL),(721,'2020-05-22 11:54:49',NULL,1,1,NULL,'RONALDO UZER','TESTE','10/10/1982','62992981141','14282768665','m','v',NULL,157,967,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'14282768','SSPGO','n',0,'324165464','ab','2025-12-25',NULL,NULL,1,0,0,NULL),(722,'2020-05-22 11:56:01',NULL,1,1,NULL,'NEW PRESTADOR','TESTE','01/01/2000','62991057275','05623139078','m','v',NULL,139,968,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,'232764','SSP','s',0,'5465465496','ab','2025-12-20',NULL,NULL,1,0,0,NULL),(723,'2020-05-26 13:18:09',NULL,1,12,NULL,'OUTRO CADASTRO','5','11/11/2000','63545656465','04311617127','m','v',NULL,62,969,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(724,'2020-05-26 18:16:50',NULL,1,12,NULL,'BRUNO MOURA','ASDSASDDAS','31/12/1969','62985246609','04311617127','m','v',NULL,19,972,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'as56d4','6SD6S6','n',0,'',NULL,NULL,'upload/img/pessoa/5df2a3b87715f.jpeg',NULL,1,0,0,NULL),(725,'2020-05-28 19:16:39',NULL,1,4,NULL,'BRUNO MOURA','FDDF','31/12/1969','62985246609','04311617127','m','v',NULL,19,976,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'as56d4','6SD6S6','n',0,'',NULL,NULL,'upload/img/pessoa/5df2a3b87715f.jpeg',NULL,1,0,0,NULL),(726,'2020-05-29 12:59:16',NULL,1,19,NULL,'ASDSAD','ASDASDD','12/12/2000','23213231321','21337246484','m','p',NULL,170,978,NULL,'asdas','dasdasd',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(727,'2020-06-04 16:51:35',NULL,NULL,4,NULL,'Jader',NULL,NULL,'','',NULL,'v','',NULL,979,NULL,'','','',NULL,NULL,NULL,'s','s','2020-06-04 16:54:45',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(728,'2020-06-05 14:35:26',NULL,1,19,NULL,'SADASSAD','ASDSD','12/12/2000','62622666262','27747379315','m','v',NULL,171,981,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:01',19,NULL,'asasdasd','DASD','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(729,'2020-06-05 14:36:25',NULL,1,19,NULL,'SADASSAD','ASDSD','12/12/2000','62622666262','27747379315','m','v',NULL,171,982,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:32',19,NULL,'asasdasd','DASD','s',0,'656454','a','2020-12-12',NULL,NULL,1,0,0,NULL),(730,'2020-06-05 14:37:02',NULL,1,19,NULL,'SADASSAD','ASDSD','12/12/2000','62622666262','27747379315','m','p',NULL,171,983,NULL,'asdsaddad','sadsd',NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:44',19,NULL,'asasdasd','DASD','s',0,'656454','a','2020-12-12',NULL,NULL,1,0,0,NULL),(731,'2020-06-05 16:51:35',NULL,1,25,NULL,'ENTREGADOR','M','05/05/2000','54334533452','84471676660','m','p','e',172,988,NULL,'adfvdfsf','Entregador',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'asdfasd','ASDF','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(732,'2020-06-05 16:50:51',NULL,1,25,NULL,'TAXI','M','05/05/2000','34545345234','62456635396','m','p','t',173,987,NULL,'Taxi/Uber','Motorista','ergerge','rgwer','gerg',NULL,'p','n',NULL,NULL,NULL,'tghwerg','ERGER','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(733,'2020-06-05 16:52:55',NULL,1,1,NULL,'PRESTADOR','M','05/05/2000','45243535345','72916785108','m','p',NULL,174,989,NULL,'dfgs','dfgsdf',NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(734,'2020-06-08 10:44:46',NULL,1,175,NULL,'IFOOD','23ASDASD','12/12/2000','12323323333','32726786200','f','p','e',176,991,NULL,'Ifood','Entregador',NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(735,'2020-06-08 10:49:28',NULL,NULL,1,NULL,'Heh',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,992,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',140,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(736,'2020-06-08 15:39:42',NULL,1,4,NULL,'MEU VISITANTE','MARIA','01/01/2000','00000000000','12471462006','m','v',NULL,177,993,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:19',4,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(737,'2020-06-09 15:37:45',NULL,1,19,NULL,'VEICULO VISITANTE','AAA','21/12/2000','62626626262','82784266516','m','v',NULL,178,994,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:01',19,NULL,NULL,'','s',0,'asdsd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(738,'2020-06-09 16:02:11',NULL,1,1,NULL,'DUDUSI','ASDASD','12/12/2000','62662666662','81662784805','f','v',NULL,NULL,1009,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,'asdasdasd','b','2020-12-12','upload/img/pessoa/15917293305edfdcb28a25d.jpeg','upload/img/pessoa/15917293305edfdcb28c19d.jpeg',1,0,0,NULL),(739,'2020-06-09 15:39:57',NULL,NULL,1,NULL,'Ejej',NULL,NULL,'','',NULL,'p','',NULL,996,NULL,'Isks','Jsjs','JSJSsk',NULL,NULL,NULL,'s','s','2020-06-09 15:41:02',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(740,'2020-06-09 16:00:57',NULL,1,1,NULL,'JSJ','AAA','12/12/2000','62662662626','74827548579','m','p','t',181,1006,NULL,'Taxi/Uber','Motorista','JSJSksk','dsdasds','dadsd',NULL,'s','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'1212131','a','2020-12-12','upload/img/pessoa/15917289025edfdb06cabb3.jpeg','upload/img/pessoa/15917289025edfdb06ccaf4.jpeg',1,0,0,NULL),(741,'2020-06-09 15:40:27',NULL,NULL,1,NULL,'Jsj',NULL,NULL,'','',NULL,'p','e',NULL,998,NULL,'Jsjs','ENTREGADOR','JSJSsk',NULL,NULL,NULL,'s','s','2020-06-09 15:41:14',1,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(742,'2020-06-09 15:53:58',NULL,1,1,NULL,'JSJSS','20000','12/12/2000','62956555555','85374605593','m','p',NULL,180,1005,NULL,'Keke','Jdjd',NULL,NULL,NULL,NULL,'s','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,NULL,NULL,NULL,'upload/img/pessoa/15917288375edfdac5baee2.jpeg','upload/img/pessoa/15917288375edfdac5c04d3.jpeg',1,0,0,NULL),(743,'2020-06-09 15:44:58',NULL,1,1,NULL,'ENTREGADOR DE PLACA','ASDSAD','12/12/2000','23232323232','63497653462','f','p','e',179,1003,NULL,'Djd','Entregador',NULL,NULL,NULL,NULL,'s','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'dasdds','a','2020-10-20','upload/img/pessoa/15917282965edfd8a8ad457.jpeg','upload/img/pessoa/15917282965edfd8a8b0338.jpeg',1,0,0,NULL),(744,'2020-06-09 16:03:33',NULL,NULL,1,NULL,'Sjj',NULL,NULL,'','',NULL,'v','',NULL,1010,NULL,'','','JSJSk',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(745,'2020-06-09 16:05:55',NULL,1,1,NULL,'KKDD','ASASD','12/12/2000','21212121222','13838120396','m','v',NULL,NULL,1014,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,'2131212','a','2020-12-12','upload/img/pessoa/15917295505edfdd8e8c7cc.jpeg','upload/img/pessoa/15917295505edfdd8e8e325.jpeg',1,0,0,NULL),(746,'2020-06-09 16:07:04',NULL,NULL,1,NULL,'ROBERTO ALMEIDA','TESTE','11/11/2000','62222222222','48971028394','m','v','',166,1015,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'32rdd','SD2345','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(747,'2020-06-09 16:07:13',NULL,NULL,1,NULL,'JSJSS','20000','12/12/2000','62956555555','85374605593','m','p','',180,1016,NULL,'Keke','Jdjd','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(748,'2020-06-09 16:07:21',NULL,NULL,1,NULL,'JSJ','AAA','12/12/2000','62662662626','74827548579','m','p','t',181,1017,NULL,'TAXI/UBER','MOTORISTA','JSJSksk',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(749,'2020-06-09 16:07:35',NULL,NULL,1,NULL,'ENTREGADOR DE PLACA','ASDSAD','12/12/2000','23232323232','63497653462','f','p','e',179,1018,NULL,'Djd','ENTREGADOR','JSJSksk',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(750,'2020-06-09 16:10:01',NULL,NULL,4,NULL,'Gffg',NULL,NULL,'','',NULL,'v','',NULL,1019,NULL,'','','Ffgf',NULL,NULL,NULL,'s','s','2020-06-09 16:26:44',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(751,'2020-06-09 16:28:50',NULL,1,4,'Telefone esta no form','TESTE TEL','MARIA','01/01/2000','62991057275','22529055068','m','v',NULL,187,1021,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:19',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(752,'2020-06-09 16:30:24',NULL,NULL,4,NULL,'TESTE TEL','MARIA','01/01/2000','62991057275','22529055068','m','v','',187,1022,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(753,'2020-06-09 16:42:11',NULL,1,25,NULL,'EU TESTE','G','05/05/2000','34643564563','47493291004','m','v',NULL,188,1024,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'wf3','3f3','n',0,'ret','a','2021-05-05',NULL,NULL,1,0,0,NULL),(754,'2020-06-09 17:58:55',NULL,1,25,NULL,'UBER FAST','J','01/01/2000','78678678657','54025077833','m','p','t',NULL,1026,NULL,'Taxi/Uber','Motorista','Qji3455','hhjghj','ukkukuy',NULL,'s','n',NULL,NULL,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(755,'2020-06-10 12:26:06',NULL,NULL,4,NULL,'Jaderson',NULL,NULL,'','',NULL,'v','',NULL,1027,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(756,'2020-06-10 16:49:46',NULL,NULL,4,NULL,'ANTONIO',NULL,NULL,NULL,NULL,NULL,'v',NULL,97,1028,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-10 16:57:10',4,NULL,NULL,'','n',141,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(757,'2020-06-10 16:49:47',NULL,NULL,4,NULL,'FLAVIA',NULL,NULL,NULL,NULL,NULL,'v',NULL,95,1029,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-10 16:57:10',4,NULL,NULL,'','n',141,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(758,'2020-06-10 16:49:47',NULL,NULL,4,NULL,'GUSTAVO',NULL,NULL,NULL,NULL,NULL,'v',NULL,110,1030,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-10 16:57:10',4,NULL,NULL,'','n',141,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(759,'2020-06-10 17:00:11',NULL,NULL,4,NULL,'GUSTAVO',NULL,NULL,NULL,NULL,NULL,'v',NULL,110,1031,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-10 17:00:51',4,NULL,NULL,'','n',142,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(760,'2020-06-10 17:00:11',NULL,NULL,4,NULL,'Leo',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1032,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-10 17:00:51',4,NULL,NULL,'','n',142,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(761,'2020-06-15 16:05:42',NULL,1,19,'asdasdsdasd','BRUNO MOURA','AAAAAA','31/12/1969','62985246609','04311617127','m','v',NULL,19,1033,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:01',19,NULL,'as56d4','6SD6S6','n',0,'656+55645656456','b','2020-10-10','upload/img/pessoa/5df2a3b87715f.jpeg',NULL,1,0,0,NULL),(762,'2020-06-15 16:06:47',NULL,1,19,NULL,'DASDASDDSAASD','12121','12/12/2000','12121211212','16701475337','m','v',NULL,NULL,1034,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'12121','a','2020-12-12',NULL,NULL,1,0,0,NULL),(763,'2020-06-15 16:41:54',NULL,NULL,4,NULL,'Fnfjf',NULL,NULL,'','',NULL,'p','e',NULL,1035,NULL,'Ggfg','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(764,'2020-06-15 17:48:39',NULL,NULL,4,NULL,'Fgg',NULL,NULL,'','',NULL,'p','t',NULL,1036,NULL,'TAXI/UBER','MOTORISTA','Fg',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(765,'2020-06-16 09:02:11',NULL,NULL,4,NULL,'Tes',NULL,NULL,'','',NULL,'v','',NULL,1037,NULL,'','','',NULL,NULL,NULL,'s','s','2020-06-16 09:02:21',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(766,'2020-06-16 14:11:46',NULL,1,4,NULL,'RAFAEL GONZAGA GONÇALVES','RAFAEL','22/07/1992','62984169089','03404718160','m','v',NULL,3,1038,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:19',4,NULL,'5410848','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(767,'2020-06-16 14:13:55',NULL,1,4,NULL,'TESTE','MARIA','01/01/2000','00000000000','12886504009','m','v',NULL,190,1040,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:19',4,NULL,'ewoqeqe','EQEE','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(768,'2020-06-16 14:19:14',NULL,1,4,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1043,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:46:00',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(769,'2020-06-16 14:45:42',NULL,1,4,NULL,'MARIA','NENE','01/01/2000','62991057272','82148097032','f','v',NULL,94,1048,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:46:28',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(770,'2020-06-16 14:23:17',NULL,1,1,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1044,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'1231245645','ab','2022-01-01',NULL,NULL,1,0,0,NULL),(771,'2020-06-16 14:25:03',NULL,1,1,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1045,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:54',1,NULL,NULL,'','s',0,'1231245645','ab','2022-01-01',NULL,NULL,1,0,0,NULL),(772,'2020-06-16 14:34:44',NULL,1,4,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1046,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-13 12:41:19',4,NULL,NULL,'','s',0,'1231245645','ab','2022-01-01',NULL,NULL,1,0,0,NULL),(773,'2020-06-16 14:44:32',NULL,1,1,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1047,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:19:06',1,NULL,NULL,'','s',0,'1231245645','ab','2022-01-01',NULL,NULL,1,0,0,NULL),(774,'2020-06-16 14:46:47',NULL,1,1,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1049,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:19:12',1,NULL,NULL,'','s',0,'1231245645','ab','2022-01-01',NULL,NULL,1,0,0,NULL),(775,'2020-06-16 14:49:45',NULL,1,1,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1050,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:19:18',1,NULL,NULL,'','s',0,'1231245645','ab','2022-01-01',NULL,NULL,1,0,0,NULL),(776,'2020-06-17 17:10:04',NULL,1,25,NULL,'TESTE NOVO','',NULL,NULL,NULL,'m','v',NULL,NULL,1052,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(777,'2020-06-18 17:50:07',NULL,1,175,NULL,'GGGGG','',NULL,NULL,NULL,'m','v',NULL,NULL,1053,NULL,NULL,NULL,'','','',NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(778,'2020-06-19 11:36:06',NULL,NULL,4,NULL,'RAFAEL GONZAGA GONÇALVES',NULL,NULL,NULL,NULL,NULL,'v',NULL,3,1054,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-19 16:01:54',4,NULL,NULL,'','n',143,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(779,'2020-06-19 11:36:06',NULL,NULL,4,NULL,'TESTE',NULL,NULL,NULL,NULL,NULL,'v',NULL,190,1055,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-19 16:01:54',4,NULL,NULL,'','n',143,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(780,'2020-06-19 15:56:43',NULL,NULL,4,NULL,'jader',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1056,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-06-19 16:01:56',4,NULL,NULL,'','n',144,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(781,'2020-06-19 16:36:41',NULL,NULL,4,NULL,'qwee',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1057,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',145,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(782,'2020-06-19 17:47:54',NULL,NULL,4,NULL,'qweqwe',NULL,NULL,'','',NULL,'v','',NULL,1058,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(783,'2020-06-22 11:47:15',NULL,NULL,4,NULL,'ruy',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1059,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',146,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(784,'2020-06-22 14:28:39',NULL,NULL,4,NULL,'RAFAEL GONZAGA GONÇALVES',NULL,NULL,NULL,NULL,NULL,'v',NULL,3,1060,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:41',4,NULL,NULL,'','n',146,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(785,'2020-06-22 15:50:28',NULL,NULL,4,NULL,'HENRRIQUE',NULL,NULL,NULL,NULL,NULL,'v',NULL,191,1061,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:42:41',4,NULL,NULL,'','n',146,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(786,'2020-06-22 17:03:53',NULL,1,25,NULL,'LIBERAÇÃO VÁRIOS IMÓVEIS','M','05/05/2000','87687678678','56503602944','m','v',NULL,NULL,1064,NULL,NULL,NULL,'','','',NULL,'p','n',NULL,NULL,NULL,'ga43w','arg34','n',0,'543456','b','2023-04-07',NULL,NULL,1,0,0,NULL),(787,'2020-06-22 17:06:52',NULL,1,25,NULL,'LIBERAÇÃO VÁRIOS IMÓVEIS','M','05/05/2000','87687678678','56503602944','m','v',NULL,193,1066,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,'ga43w','ARG34','n',0,'543456','b','2023-04-07',NULL,NULL,1,0,0,NULL),(788,'2020-06-23 10:02:25',NULL,NULL,4,NULL,'Eniela',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1067,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',147,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(789,'2020-06-23 10:02:25',NULL,NULL,4,NULL,'Flavia',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1068,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',147,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(790,'2020-06-23 10:02:26',NULL,NULL,4,NULL,'RAFAEL GONZAGA GONÇALVES',NULL,NULL,NULL,NULL,NULL,'v',NULL,3,1069,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:02',4,NULL,NULL,'','n',147,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(791,'2020-06-23 15:15:52',NULL,1,25,NULL,'FDGHDGF','HJ','02/02/2000','31313212312','05076264437','m','v',NULL,194,1071,NULL,NULL,NULL,'','','',NULL,'p','n',NULL,NULL,NULL,'dfghdfg','dfg','n',0,'fdghdg','b','2021-05-05',NULL,NULL,1,0,0,NULL),(792,'2020-06-23 17:29:25',NULL,NULL,4,NULL,'Teste',NULL,NULL,'','',NULL,'v','',NULL,1072,NULL,'','','',NULL,NULL,NULL,'s','s','2020-06-23 17:30:30',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(793,'2020-06-24 08:32:47',NULL,NULL,4,NULL,'ENIELA',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1073,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',148,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(794,'2020-06-24 08:32:47',NULL,NULL,4,NULL,'HENRRIQUE',NULL,NULL,NULL,NULL,NULL,'v',NULL,191,1074,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:44:00',4,NULL,NULL,'','n',148,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(795,'2020-06-24 08:32:47',NULL,NULL,4,NULL,'Meu teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1075,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',148,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(796,'2020-06-24 08:32:47',NULL,NULL,4,NULL,'RAFAEL GONZAGA GONÇALVES',NULL,NULL,NULL,NULL,NULL,'v',NULL,3,1076,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:46:00',4,NULL,NULL,'','n',148,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(797,'2020-06-24 13:58:10',NULL,NULL,4,NULL,'HENRRIQUE',NULL,NULL,NULL,NULL,NULL,'v',NULL,191,1077,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:46:00',4,NULL,NULL,'','n',149,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(798,'2020-06-24 13:58:10',NULL,NULL,4,NULL,'Novo teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1078,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',149,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(799,'2020-06-26 17:18:25',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1079,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(800,'2020-06-26 17:22:25',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1080,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(801,'2020-06-26 17:28:15',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1081,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(802,'2020-06-26 17:38:07',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1082,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(803,'2020-06-26 17:41:37',NULL,1,1,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1083,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:40',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(804,'2020-06-26 17:42:20',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1084,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(805,'2020-06-26 17:56:32',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1085,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(806,'2020-06-29 17:36:15',NULL,1,25,NULL,'TESTEUBER','D','05/05/2000','32123123122',NULL,NULL,'p','t',NULL,1087,NULL,'Taxi/Uber','Motorista','pqj1010','dsfgsd','sgtfhstgh','carro','s','n',NULL,NULL,NULL,'drfgae4','sdrgs','n',0,'erwtgr','e','2023-05-05',NULL,NULL,1,0,0,NULL),(807,'2020-06-29 17:51:21',NULL,NULL,25,NULL,'Uber teSte',NULL,NULL,'','',NULL,'p','t',NULL,1088,NULL,'TAXI/UBER','MOTORISTA','Abc1010',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(808,'2020-06-29 18:19:51',NULL,1,25,NULL,'TESTE VISITANTE','',NULL,NULL,NULL,NULL,'v',NULL,NULL,1107,NULL,NULL,NULL,'Abc1010','vbncv','bncvbn','bicicleta','s','n',NULL,NULL,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(809,'2020-06-29 17:58:17',NULL,1,1,NULL,'KJSHFDBGHJDF','',NULL,NULL,NULL,'m','v',NULL,NULL,1090,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(810,'2020-06-29 18:08:54',NULL,1,1,NULL,'TESTE2','LJKH','10/10/2000','53615646645','14526268127','m','v',NULL,195,1097,NULL,NULL,NULL,'abc1010','ths','th','carro','p','s','2020-10-16 17:18:40',1,NULL,'fghgh','DFGHDGFH','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(811,'2020-06-29 18:12:27',NULL,1,138,NULL,'TESTE2','LJKH','10/10/2000','53615646645','14526268127','m','v',NULL,195,1098,NULL,NULL,NULL,'abc1010','ths','th','carro','p','n',NULL,NULL,NULL,'fghgh','DFGHDGFH','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(812,'2020-06-29 18:16:53',NULL,1,1,NULL,'SDFGSFDG','',NULL,NULL,NULL,'m','p',NULL,NULL,1099,NULL,'dfgsdfgs','dfgsdfgsfd','abc1010','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(813,'2020-06-29 18:18:29',NULL,1,1,NULL,'RGSRGR','',NULL,NULL,NULL,'m','p','t',NULL,1102,NULL,'Taxi/Uber','Motorista','abc1010','dfghd','ghfg','carro','p','n',NULL,NULL,NULL,NULL,NULL,'n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(814,'2020-06-29 18:21:57',NULL,1,1,NULL,'ENTREGAS','2DF','10/10/2000','65556545645','14342796694','m','p','e',196,1109,NULL,'fdgdfg','Entregador','abc1010','thth','tht','carro','p','s','2020-10-16 17:18:39',1,NULL,'fdgsdfg','FDGFDG','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(815,'2020-06-29 18:23:02',NULL,1,114,NULL,'TAXI','',NULL,NULL,NULL,'m','p','t',NULL,1110,NULL,'Taxi/Uber','Motorista','abc1010','iuhi','juhuhi','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(816,'2020-06-30 16:16:55',NULL,1,1,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,1112,NULL,'Taxi/Uber','Motorista','12343gf','GOl','branco','','p','n',NULL,NULL,NULL,'1231313','CNH','n',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(817,'2020-06-30 17:36:08',NULL,1,25,NULL,'JOAO ENTREGADOR','SDF','05/05/2000','65656546665',NULL,'m','p',NULL,198,1124,NULL,'hgj','hgjfgh','wwwwwww','sdfgsf','sdgf','carro','p','n',NULL,NULL,NULL,'dfrg43','ERGEWR','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(818,'2020-06-30 17:32:09',NULL,1,25,NULL,'JOAO ENTREGADOR','SDF','05/05/2000','65656546665',NULL,'m','p',NULL,198,1123,NULL,'hgj','hgjfgh','wwwwwww','sdfgsf','sdgf','carro','p','n',NULL,NULL,NULL,'dfrg43','ERGEWR','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(819,'2020-06-30 17:26:21',NULL,1,25,NULL,'ENTREGAS','RTYJRY','06/06/2000','65465456465',NULL,'m','p','e',197,1119,NULL,'tryjrytjy','Entregador','wwwwwww','arfgrg','serg','carro','p','n',NULL,NULL,NULL,'dyth56','DTEYHJ','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(820,'2020-06-30 17:24:30',NULL,1,25,NULL,'HERBERT RICHERS','TRY','01/01/2000','43676746574','47841033257','m','p',NULL,189,1118,NULL,'ujrytj','hjk','wwwwwww','dfsgsdf','t','carro','p','s','2020-10-16 17:18:39',1,NULL,'rgys4','SDFHG','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(821,'2020-06-30 17:31:06',NULL,1,1,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,1122,NULL,'Taxi/Uber','Motorista','wwwwwww','GOl','branco','carro','p','n',NULL,NULL,NULL,'1231313','CNH','n',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(822,'2020-06-30 17:40:25',NULL,1,142,NULL,'ENTREGAS','RTYJRY','06/06/2000','65465456465',NULL,'m','p','e',197,1125,NULL,'tryjrytjy','Entregador','wwwwwww','arfgrg','serg','carro','p','n',NULL,NULL,NULL,'dyth56','DTEYHJ','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(823,'2020-06-30 17:41:36',NULL,1,106,NULL,'ERT45W3GTW345','',NULL,NULL,NULL,'m','v',NULL,NULL,1126,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(824,'2020-06-30 17:43:57',NULL,1,4,NULL,'TYUK','LKJ','05/05/2000','65456464564',NULL,'m','v',NULL,199,1127,NULL,NULL,NULL,'','','','pedestre','p','s','2020-10-13 12:41:19',4,NULL,'yukt','KUKTUK','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(825,'2020-07-01 09:31:12',NULL,1,163,NULL,'TESTE','TESTE','05/05/1990','62999999999','41413747507','m','v',NULL,NULL,1128,NULL,NULL,NULL,'qqqqqqq','gol','preto','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(826,'2020-07-01 09:34:35',NULL,1,1,NULL,'TESTE','',NULL,NULL,NULL,'m','v',NULL,NULL,1129,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(827,'2020-07-01 09:49:18',NULL,1,114,NULL,'JOAO ENTREGADOR','SDF','05/05/2000','65656546665',NULL,'m','p',NULL,198,1131,NULL,'hgj','hgjfgh','wwwwwww','sdfgsf','sdgf','moto','p','n',NULL,NULL,NULL,'dfrg43','ERGEWR','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(828,'2020-07-01 10:40:27',NULL,1,25,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,1132,NULL,'Taxi/Uber','Motorista','12343gf','GOl','branco','carro','p','n',NULL,NULL,NULL,'1231313','CNH','s',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(829,'2020-07-01 10:40:51',NULL,1,25,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,1133,NULL,'Taxi/Uber','Motorista','12343gf','GOl','branco','carro','p','n',NULL,NULL,NULL,'1231313','CNH','s',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(830,'2020-07-01 10:41:58',NULL,1,25,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,1135,NULL,'Taxi/Uber','Motorista','12343gf','GOl','branco','moto','p','n',NULL,NULL,NULL,'1231313','CNH','s',0,'1231313','ab','2033-01-01',NULL,NULL,1,0,0,NULL),(831,'2020-07-01 16:47:42',NULL,1,163,NULL,'TESTES','',NULL,NULL,NULL,'m','v',NULL,NULL,1136,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(832,'2020-07-01 16:52:41',NULL,1,106,NULL,'JOAO ENTREGADOR','SDF','05/05/2000','65656546665',NULL,'m','p',NULL,198,1137,NULL,'hgj','hgjfgh','wwwwwww','sdfgsf','sdgf','carro','p','n',NULL,NULL,NULL,'dfrg43','ERGEWR','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(833,'2020-07-06 15:07:03',NULL,1,4,NULL,'MARIA','NENE','01/01/2000','62991057272','82148097032','f','v',NULL,94,1138,NULL,NULL,NULL,'GFG7tew','Gol','branco','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(834,'2020-07-06 15:07:57',NULL,1,4,'Ira entre só ela mesma.','MARIA','NENE','01/10/1981','62910939282','41576335046','f','v',NULL,9,1139,NULL,NULL,NULL,'','','','outro','p','n',NULL,NULL,NULL,NULL,'','n',0,'123131231','a','2033-01-01',NULL,NULL,1,0,0,NULL),(835,'2020-07-06 15:11:43',NULL,1,1,NULL,'EEEEEEEEEEEEE','KJH','01/01/2000','65465454565',NULL,'m','v',NULL,201,1140,NULL,NULL,NULL,'','','','bicicleta','p','s','2020-10-16 17:18:39',1,NULL,'efessdvsd','SDVDS','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(836,'2020-07-06 17:22:50',NULL,1,4,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1142,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:46:30',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(837,'2020-07-06 17:25:23',NULL,NULL,4,NULL,'TESTE','MARIA','01/01/2000','00000000000','12886504009','m','v','',190,1143,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'ewoqeqe','EQEE','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(838,'2020-07-06 17:53:54',NULL,1,4,NULL,'HENRRIQUE','MARIA','01/01/1921','62999999999','70094126186','m','v',NULL,191,1146,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:47:05',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(839,'2020-07-08 12:18:10',NULL,1,4,NULL,'VISITANTE','MARIA','01/01/2000','62998433030','40346673038','m','v',NULL,203,1148,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-13 12:41:19',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(840,'2020-07-08 16:44:05',NULL,1,1,NULL,'TESTE PRO TAMBORE 1 08072020','UZER','18/12/1991','62985094441','19120870493','m','v',NULL,205,1150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:39',1,NULL,'20870493','SSPGO','s',0,'191208','ab','2025-04-05',NULL,NULL,1,0,0,NULL),(841,'2020-07-08 16:50:19',NULL,1,1,NULL,'TESTE PRO TAMBORE 1 08072020','UZER','18/12/1991','62985094441','19120870493','m','v',NULL,205,1151,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2020-10-16 17:18:54',1,NULL,'20870493','SSPGO','s',0,'191208','ab','2025-04-05',NULL,NULL,1,0,0,NULL),(842,'2020-07-09 11:29:04',NULL,1,12,NULL,'LIB. TEMPORARIO','MARIA','01/01/2000','62991505087','32462797050','m','v',NULL,206,1153,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(843,'2020-07-09 21:59:24',NULL,1,25,NULL,'EWRGWERG','',NULL,NULL,NULL,'m','v',NULL,NULL,1154,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(844,'2020-07-10 13:30:04',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1155,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(845,'2020-07-10 13:32:26',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1156,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(846,'2020-07-10 13:35:36',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1157,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(847,'2020-07-10 13:36:43',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1158,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(848,'2020-07-10 14:19:19',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1159,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:01',19,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(849,'2020-07-10 14:22:04',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1160,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:32',19,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(850,'2020-07-10 14:23:44',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1161,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(851,'2020-07-10 14:25:30',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1162,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(852,'2020-07-10 14:28:16',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1163,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(853,'2020-07-10 14:29:50',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1164,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(854,'2020-07-10 14:33:14',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1165,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(855,'2020-07-10 14:34:50',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1166,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(856,'2020-07-10 14:38:52',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1167,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:44',19,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(857,'2020-07-10 14:39:33',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1168,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(858,'2020-07-10 14:40:53',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1169,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(859,'2020-07-10 14:42:26',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1170,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(860,'2020-07-10 14:42:51',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1171,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(861,'2020-07-10 14:45:13',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1172,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(862,'2020-07-10 14:45:39',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1173,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(863,'2020-07-10 14:53:47',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1174,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','s','2021-02-17 11:35:54',19,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(864,'2020-07-10 14:54:28',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1175,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(865,'2020-07-10 14:55:50',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1176,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(866,'2020-07-10 14:56:12',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1177,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(867,'2020-07-10 14:57:57',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1178,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(868,'2020-07-10 14:58:12',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1179,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(869,'2020-07-10 14:58:52',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1180,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(870,'2020-07-10 14:59:08',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1181,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(871,'2020-07-10 15:01:05',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1182,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(872,'2020-07-10 15:01:41',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1183,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(873,'2020-07-10 15:02:47',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1184,NULL,'hahah','hahaha',NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(874,'2020-07-10 15:05:34',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1185,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(875,'2020-07-13 14:16:45',NULL,NULL,25,NULL,'Pessoa teste App',NULL,NULL,'','',NULL,'v','',NULL,1186,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(876,'2020-07-14 14:18:24',NULL,1,1,NULL,'JOAO UZER','MARIA','09/05/1990','62999999999','26414150118','m','v',NULL,208,1188,NULL,NULL,NULL,'','','','pedestre','p','s','2020-10-16 17:18:39',1,NULL,NULL,'','s',0,'45645646456','a','2023-02-23',NULL,NULL,1,0,0,NULL),(877,'2020-07-14 15:00:40',NULL,1,1,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','p',NULL,110,1189,NULL,'empresa','empresa','nlk2558','modelo','cor','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'25265365','ad','2022-01-01',NULL,NULL,1,0,0,NULL),(878,'2020-07-14 15:56:49',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1190,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(879,'2020-07-14 16:03:04',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1191,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(880,'2020-07-14 16:13:09',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1192,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdads','a','2020-12-12',NULL,NULL,1,0,0,NULL),(881,'2020-07-23 11:11:11',NULL,1,25,'Obs de teste','RAFAEL TESTE','M','10/10/2000','62989865322','85711779290','m','v',NULL,209,1194,NULL,NULL,NULL,'bioaabb','golf','red','carro','s','n',NULL,NULL,NULL,NULL,'','s',0,'56uje56','a','2023-05-05',NULL,NULL,1,0,0,NULL),(882,'2020-07-23 11:11:53',NULL,NULL,25,NULL,'RAFAEL TESTE','M','10/10/2000','62989865322','85711779290','m','v','',209,1195,NULL,'','','bioaabb',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(883,'2020-07-23 11:12:38',NULL,NULL,25,NULL,'RAFAEL TESTE','M','10/10/2000','62989865322','85711779290','m','v','',209,1196,NULL,'','','bioaabb',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(884,'2020-07-23 11:21:03',NULL,NULL,25,NULL,'JOÃO UBER',NULL,NULL,NULL,NULL,NULL,'v',NULL,10,1197,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',150,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(885,'2020-07-23 11:21:03',NULL,NULL,25,NULL,'RAFAEL TESTE',NULL,NULL,NULL,NULL,NULL,'v',NULL,209,1198,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',150,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(886,'2020-07-23 11:38:53',NULL,1,25,NULL,'TESTE NOVO 222','NM','01/01/2000','32132131321','88062576256','m','v',NULL,210,1200,NULL,NULL,NULL,'','','','pedestre','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(887,'2020-07-23 12:18:23',NULL,NULL,25,NULL,'RAFAEL TESTE','M','10/10/2000','62989865322','85711779290','m','v','',209,1201,NULL,'','','bioaabb',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(888,'2020-07-23 12:19:18',NULL,NULL,25,NULL,'HERBERT RICHERS','TRY','01/01/2000','43676746574','47841033257','m','p','',189,1202,NULL,'ujrytj','hjk','wwwwwww',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'rgys4','SDFHG','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(889,'2020-07-23 12:19:57',NULL,NULL,25,NULL,'JOÃO UBER','TELMA','01/01/2000','62999105399','85722348023','m','p','t',10,1203,NULL,'TAXI/UBER','MOTORISTA','12343gf',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'1231313','CNH','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(890,'2020-07-23 12:20:33',NULL,NULL,25,NULL,'ENTREGADOR','M','05/05/2000','54334533452','84471676660','m','p','e',172,1204,NULL,'adfvdfsf','ENTREGADOR','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'asdfasd','ASDF','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(891,'2020-07-23 12:26:41',NULL,NULL,25,'Uauauauua','JOAO ENTREGADOR','SDF','05/05/2000','65656546665','','m','p','',198,1205,NULL,'Amazon','Chief of Entregas','wwwwwww',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'dfrg43','ERGEWR','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(892,'2020-07-23 12:32:34',NULL,1,25,NULL,'DOC TESTE','N','01/01/2000','32165841654',NULL,'m','p',NULL,211,1208,NULL,'uai','sô','sdkrguf','lexus','prata','carro','s','n',NULL,NULL,NULL,'778899','JHG','s',0,'876656','ab','2023-06-05',NULL,NULL,1,0,0,NULL),(893,'2020-07-23 12:33:16',NULL,NULL,25,NULL,'DOC TESTE','N','01/01/2000','32165841654','','m','p','',211,1209,NULL,'uai','sô','sdkrguf',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'778899','JHG','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(894,'2020-07-23 16:36:50',NULL,1,12,NULL,'VISITANTE TESTE','MARIA','01/01/2000','00000000000','96440965093','m','v',NULL,212,1211,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(895,'2020-07-27 11:27:41',NULL,NULL,4,NULL,'VISITANTE','MARIA','01/01/2000','62998433030','40346673038','m','v','',203,1212,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(896,'2020-07-27 12:26:32',NULL,1,12,NULL,'LIB. TEMPORARIO','MARIA','01/01/2000','62991505087','32462797050','m','v',NULL,206,1214,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(897,'2020-07-27 16:10:03',NULL,1,12,NULL,'LIB. TEMPORARIO','MARIA','01/01/2000','62991505087','32462797050','m','v',NULL,206,1216,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(898,'2020-07-28 17:35:35',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1218,NULL,NULL,NULL,'','asdasdsaddasdasd','adsad','carro','s','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(899,'2020-07-29 09:02:30',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1219,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(900,'2020-07-29 09:04:39',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1220,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(901,'2020-07-29 09:43:14',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1221,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(902,'2020-07-29 09:43:42',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1222,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(903,'2020-07-29 09:45:36',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1223,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(904,'2020-07-29 09:45:58',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1224,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(905,'2020-07-29 09:48:44',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1225,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(906,'2020-07-29 09:49:17',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1226,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(907,'2020-07-29 09:50:58',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1227,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(908,'2020-07-29 09:51:28',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1228,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(909,'2020-07-29 10:15:31',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1229,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(910,'2020-07-29 10:16:07',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1230,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(911,'2020-07-29 10:19:57',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1231,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(912,'2020-07-29 10:21:50',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1232,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(913,'2020-07-29 10:24:53',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1233,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(914,'2020-07-29 10:27:01',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1234,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(915,'2020-07-29 10:28:05',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1235,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(916,'2020-07-29 11:35:21',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','p',NULL,110,1236,NULL,'empresa','empresa',NULL,NULL,NULL,'carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'25265365','ad','2022-01-01',NULL,NULL,1,0,0,NULL),(917,'2020-07-29 15:42:20',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1237,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(918,'2020-07-29 15:43:48',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1238,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(919,'2020-07-29 15:44:39',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1239,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(920,'2020-07-29 15:45:37',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1240,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(921,'2020-07-29 15:45:54',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1241,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(922,'2020-07-29 15:46:42',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1242,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(923,'2020-07-29 15:47:33',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1243,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(924,'2020-07-29 15:47:45',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1244,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(925,'2020-07-29 15:49:23',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1245,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(926,'2020-07-29 17:38:16',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1246,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(927,'2020-07-29 17:38:38',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1247,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(928,'2020-07-29 17:40:32',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1248,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(929,'2020-07-29 17:41:00',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1249,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(930,'2020-07-29 17:41:54',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1250,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(931,'2020-07-29 17:45:22',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1251,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(932,'2020-07-29 17:46:32',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1252,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(933,'2020-07-29 17:47:20',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1253,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(934,'2020-07-30 09:01:19',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1254,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(935,'2020-07-30 09:02:24',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1255,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(936,'2020-07-30 09:02:52',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1256,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(937,'2020-07-30 09:03:33',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1257,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(938,'2020-07-30 09:03:51',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1258,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(939,'2020-07-30 09:04:27',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1259,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(940,'2020-07-30 09:07:52',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1260,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(941,'2020-07-30 09:08:13',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1261,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(942,'2020-07-30 09:09:48',NULL,1,143,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1262,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(943,'2020-07-30 17:03:44',NULL,1,4,NULL,'MEU VISITANTE','MARIA','01/01/2000','00000000000','02061640095','m','v',NULL,213,1264,NULL,NULL,NULL,'','','','outro','s','s','2020-10-13 12:41:19',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(944,'2020-07-30 17:11:23',NULL,1,4,NULL,'MEU VISITANTE','MARIA','01/01/2000','00000000000','02061640095','m','v',NULL,213,1266,NULL,NULL,NULL,'','','','outro','s','s','2020-10-13 12:42:41',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(945,'2020-07-30 17:26:25',NULL,1,4,NULL,'MEU VISITANTE','MARIA','01/01/2000','00000000000','02061640095','m','v',NULL,213,1268,NULL,NULL,NULL,'','','','outro','s','s','2020-10-13 12:43:58',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(946,'2020-07-30 17:47:41',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1271,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(947,'2020-07-31 09:52:29',NULL,1,3,NULL,'NOVO VISIT','MARIA','01/01/2001','00000000000','76687192027','m','v',NULL,214,1273,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(948,'2020-07-31 10:12:34',NULL,NULL,4,NULL,'VISITANTE','MARIA','01/01/2000','62998433030','40346673038','m','v','',203,1274,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(949,'2020-07-31 10:15:46',NULL,1,4,NULL,'NOVO VISIT','MARIA','01/01/2001','00000000000','76687192027','m','v',NULL,214,1276,NULL,NULL,NULL,'1asdasd','wqaeawe','awewe','carro','p','s','2020-10-13 12:41:19',4,NULL,NULL,'','s',0,'asdasd','b','2020-11-11',NULL,NULL,1,0,0,NULL),(950,'2020-08-03 17:29:22',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1277,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(951,'2020-08-03 17:31:18',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1278,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(952,'2020-08-03 17:32:44',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1279,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(953,'2020-08-03 17:36:42',NULL,1,167,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1280,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(954,'2020-08-03 17:45:08',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1281,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(955,'2020-08-03 17:46:31',NULL,1,131,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','p',NULL,207,1282,NULL,'hahah','hahaha','as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(956,'2020-08-03 17:47:01',NULL,1,165,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1283,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(957,'2020-08-03 17:47:31',NULL,1,167,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1284,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(958,'2020-08-03 17:48:12',NULL,1,19,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1285,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(959,'2020-08-21 14:59:24',NULL,1,19,NULL,'DSASAD','',NULL,NULL,NULL,'m','v',NULL,NULL,1286,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(960,'2020-08-27 14:40:42',NULL,NULL,4,NULL,'LIB PELO PORTARIA',NULL,NULL,NULL,NULL,NULL,'v',NULL,123,1287,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-08-27 14:41:10',4,NULL,NULL,'','n',151,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(961,'2020-08-27 18:45:55',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1289,NULL,NULL,NULL,'opk5625','hb20','preto','carro','s','n',NULL,NULL,NULL,NULL,NULL,'n',0,'6525626','ab','2022-08-01',NULL,NULL,1,0,0,NULL),(962,'2020-09-04 11:30:51',NULL,1,3,NULL,'GUSTAVO','DALVA','01/01/2000','62991057274','03353291016','m','v',NULL,110,1306,NULL,NULL,NULL,'nlk2215','hb20','preto','carro','s','n',NULL,NULL,NULL,NULL,'','s',0,'525252565','ab','2022-09-03',NULL,NULL,1,0,0,NULL),(963,'2020-08-28 16:25:55',NULL,1,25,NULL,'TESTE HORARIOS','','05/05/2000','61651644564',NULL,'m','p',NULL,NULL,1298,NULL,'dfghdfg','hdfgh','','','','pedestre','p','n',NULL,NULL,NULL,'ga4we','SFDGSFDG','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(964,'2020-08-28 16:06:31',NULL,1,25,NULL,'HORARIO APP','',NULL,NULL,NULL,NULL,'p',NULL,NULL,1295,NULL,'Jdjjjd','Kkkkkkk','',NULL,NULL,'carro','s','n',NULL,NULL,NULL,NULL,NULL,'n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(965,'2020-09-08 14:27:28',NULL,1,4,NULL,'NOVO VISIT','MARIA','01/01/2001','00000000000','76687192027','m','v',NULL,214,1310,NULL,NULL,NULL,'1asdasd','gol/braNCO','verde','carro','s','s','2020-10-13 12:42:41',4,NULL,NULL,'','s',0,'21312313','ab','2021-01-01',NULL,NULL,1,0,0,NULL),(966,'2020-09-08 14:33:45',NULL,1,4,NULL,'VISITANTE','MARIA','01/01/2000','62998433030','40346673038','m','v',NULL,203,1312,NULL,NULL,NULL,'','','','outro','s','s','2020-10-13 12:42:41',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(967,'2020-09-08 14:43:36',NULL,1,4,NULL,'MEU VISITANTE','MARIA','01/01/2000','00000000000','02061640095','m','v',NULL,213,1314,NULL,NULL,NULL,'','','','outro','s','s','2020-10-13 12:46:00',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(968,'2020-09-08 16:01:16',NULL,1,4,'Vai entrar','TESTE VISIT','MARIA','01/01/2000','00000000000','79863781070','m','v',NULL,215,1316,NULL,NULL,NULL,'','','','outro','s','s','2020-10-13 12:41:19',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(969,'2020-09-10 16:35:46',NULL,1,19,NULL,'ALEXANDRE','',NULL,NULL,NULL,'m','v',NULL,NULL,1317,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(970,'2020-09-10 17:06:46',NULL,1,19,NULL,'BRUNO MOURA','','31/12/1969','62985246609','04311617127','m','v',NULL,19,1318,NULL,NULL,NULL,NULL,NULL,NULL,'carro','p','n',NULL,NULL,NULL,'as56d4','6SD6S6','n',0,'',NULL,NULL,'upload/img/pessoa/5df2a3b87715f.jpeg',NULL,1,0,0,NULL),(971,'2020-09-18 08:20:59',NULL,1,4,NULL,'TESTE VISIT','MARIA','01/01/2000','00000000000','79863781070','m','v',NULL,215,1320,NULL,NULL,NULL,'','','','outro','s','s','2020-10-13 12:42:41',4,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(972,'2020-09-21 14:11:47',NULL,NULL,1,NULL,'JOAO UZER','MARIA','09/05/1990','62999999999','26414150118','m','v','',208,1321,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(973,'2020-09-21 14:56:01',NULL,1,1,NULL,'JOAO UZER','MARIA','09/05/1990','62999999999','26414150118','m','p',NULL,208,1322,NULL,'empresa','cargo','','','','outro','p','s','2020-10-16 17:18:54',1,NULL,NULL,'','s',0,'45645646456','a','2023-02-23',NULL,NULL,1,0,0,NULL),(974,'2020-09-21 17:34:58',NULL,NULL,4,NULL,'TESTE VISIT','MARIA','01/01/2000','00000000000','79863781070','m','v','',215,1323,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(975,'2020-09-25 12:22:41',NULL,1,19,NULL,'ASD','',NULL,NULL,NULL,'m','p','t',NULL,1324,NULL,'Taxi/Uber','Motorista','','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(976,'2020-09-25 12:22:45',NULL,1,19,NULL,'ASD','',NULL,NULL,NULL,'m','p','e',NULL,1325,NULL,NULL,'Entregador','','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(977,'2020-10-05 14:27:26',NULL,1,3,NULL,'ASDASDSD','',NULL,NULL,NULL,'m','v',NULL,NULL,1326,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(978,'2020-10-06 09:23:14',NULL,1,1,NULL,'JOAO UZER','MARIA','09/05/1990','62999999999','26414150118','m','v',NULL,208,1328,NULL,NULL,NULL,'','','','outro','s','s','2020-10-16 17:19:06',1,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(979,'2020-10-06 09:23:29',NULL,1,1,NULL,'ARLINDO','ASDASD','12/12/2000','33262622626','64811153103','m','v',NULL,207,1329,NULL,NULL,NULL,'as12a3s','asdasd','asdasd','carro','p','s','2020-10-16 17:18:39',1,NULL,NULL,'','s',0,'asdasd','a','2020-12-12',NULL,NULL,1,0,0,NULL),(980,'2020-10-13 09:15:29',NULL,NULL,4,NULL,'TESTE VISIT',NULL,NULL,NULL,NULL,NULL,'v',NULL,215,1330,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',152,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(981,'2020-10-13 12:31:34',NULL,NULL,4,NULL,'Meu teste',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1331,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',152,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(982,'2020-10-13 12:33:37',NULL,NULL,4,NULL,'Teste 01',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1332,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',153,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(983,'2020-10-13 12:33:37',NULL,NULL,4,NULL,'Teste 2',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1333,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',153,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(984,'2020-10-13 16:10:42',NULL,NULL,4,NULL,'23123123',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1334,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',153,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(985,'2020-10-15 14:17:38',NULL,1,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1339,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(986,'2020-10-15 14:16:24',NULL,1,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1338,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(987,'2020-10-16 10:34:27',NULL,NULL,175,NULL,'João',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1340,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-16 10:34:40',175,NULL,NULL,'','n',154,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(988,'2020-10-16 10:34:27',NULL,NULL,175,NULL,'Laura',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1341,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-16 10:34:40',175,NULL,NULL,'','n',154,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(989,'2020-10-16 10:37:22',NULL,NULL,175,NULL,'João',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1342,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',155,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(990,'2020-10-16 10:37:22',NULL,NULL,175,NULL,'Laura',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1343,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',155,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(991,'2020-10-16 10:39:03',NULL,NULL,175,NULL,'Victor',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1344,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',155,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(992,'2020-10-16 11:38:40',NULL,NULL,175,NULL,'Pedro',NULL,NULL,'','00714990167',NULL,'p','',NULL,1345,NULL,'Uzer tecnologia','Suporte','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(993,'2020-10-16 17:23:59',NULL,1,1,NULL,'BRUNO MOURA','ASDSAD','12/12/2000','12001212212','82723313301','m','v',NULL,223,1356,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(994,'2020-10-16 17:23:26',NULL,1,1,NULL,'ALESSANDRO GONZAGA','ASDASD','12/12/2000','12121222222','51406081620','m','v',NULL,222,1354,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(995,'2020-10-16 17:22:52',NULL,1,1,NULL,'GUSTAVO CAVALCANTI','ASDAD','12/12/2000','51454545545','77222536280','m','v',NULL,221,1353,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(996,'2020-10-16 17:22:03',NULL,1,1,NULL,'CLEUNICE ALMEIDA','ASDSAD','12/12/2000','12121212121','85228832203','f','v',NULL,220,1352,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(997,'2020-10-16 17:21:18',NULL,1,1,NULL,'FERNANDA SILVA','ASDAD','12/12/2000','12121212121','96746635414','f','v',NULL,219,1351,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(998,'2020-10-16 17:31:44',NULL,NULL,1,NULL,'Bruno moura',NULL,NULL,'','',NULL,'v','',NULL,1357,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(999,'2020-10-16 17:32:13',NULL,NULL,1,NULL,'Elias',NULL,NULL,'','',NULL,'p','',NULL,1358,NULL,'Global','Piscineiro','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1000,'2020-10-16 17:32:41',NULL,NULL,1,NULL,'Robson',NULL,NULL,'','',NULL,'p','e',NULL,1359,NULL,'Ifood','ENTREGADOR','SJD3884',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1001,'2020-10-16 17:43:13',NULL,1,1,'Vão vir alguns amigos juntos','JOAQUIM','21211','12/12/2000','12121221221','93978200449','m','v',NULL,224,1361,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1002,'2020-10-16 17:49:04',NULL,NULL,1,'Vai vir junto de outros amigos','Antonio',NULL,NULL,'','93978200449',NULL,'v','',NULL,1362,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1003,'2020-10-19 17:11:45',NULL,NULL,4,NULL,'JOANA DA SILVA',NULL,NULL,NULL,NULL,NULL,'v',NULL,217,1363,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',156,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1004,'2020-10-19 17:11:45',NULL,NULL,4,NULL,'MAIS UM TESTE',NULL,NULL,NULL,NULL,NULL,'v',NULL,218,1364,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-19 17:17:11',4,NULL,NULL,'','n',156,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1005,'2020-10-19 17:11:45',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1365,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',156,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1006,'2020-10-20 10:40:40',NULL,NULL,4,NULL,'JOANA DA SILVA',NULL,NULL,NULL,NULL,NULL,'v',NULL,217,1366,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1007,'2020-10-20 10:40:40',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1367,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1008,'2020-10-20 10:46:06',NULL,NULL,4,NULL,'Joana Darker',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1368,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1009,'2020-10-20 10:50:03',NULL,NULL,4,NULL,'Leo',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1369,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1010,'2020-10-20 10:51:05',NULL,NULL,4,NULL,'XC',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1370,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1011,'2020-10-20 10:51:05',NULL,NULL,4,NULL,'XE',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1371,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1012,'2020-10-20 10:51:05',NULL,NULL,4,NULL,'XQ',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1372,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1013,'2020-10-20 10:51:05',NULL,NULL,4,NULL,'XT',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1373,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1014,'2020-10-20 10:51:05',NULL,NULL,4,NULL,'XX',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1374,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1015,'2020-10-20 10:53:18',NULL,NULL,4,NULL,'TESTE VISIT',NULL,NULL,NULL,NULL,NULL,'v',NULL,215,1375,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1016,'2020-10-20 11:53:15',NULL,NULL,4,NULL,'TESTE VISIT',NULL,NULL,NULL,NULL,NULL,'v',NULL,215,1376,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1017,'2020-10-20 11:58:39',NULL,NULL,4,NULL,'JOANA DA SILVA',NULL,NULL,NULL,NULL,NULL,'v',NULL,217,1377,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-20 15:20:17',4,NULL,NULL,'','n',157,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1018,'2020-10-20 15:22:06',NULL,NULL,4,NULL,'JOANA DA SILVA',NULL,NULL,NULL,NULL,NULL,'v',NULL,217,1378,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',158,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1019,'2020-10-20 15:22:06',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1379,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',158,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1020,'2020-10-20 15:22:06',NULL,NULL,4,NULL,'TESTE VISIT',NULL,NULL,NULL,NULL,NULL,'v',NULL,215,1380,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',158,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1021,'2020-10-20 15:32:27',NULL,NULL,4,NULL,'MAIS UM TESTE',NULL,NULL,NULL,NULL,NULL,'v',NULL,218,1381,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',158,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1022,'2020-10-20 15:50:00',NULL,1,19,'asdad','ASDASD','GFDFQ','11/11/2000','62999999999','88191677350','m','v',NULL,225,1383,NULL,NULL,NULL,'','','','outro','p','s','2021-02-17 11:35:01',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1023,'2020-10-20 15:51:39',NULL,1,19,'asdad','ASDASD','GFDFQ','11/11/2000','62999999999','88191677350','m','v',NULL,225,1384,NULL,NULL,NULL,'','','','outro','p','s','2021-02-17 11:35:32',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1024,'2020-10-20 15:52:44',NULL,1,19,NULL,'ASDASD','GFDFQ','11/11/2000','62999999999','88191677350','m','v',NULL,225,1385,NULL,NULL,NULL,'','','','outro','p','s','2021-02-17 11:35:44',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1025,'2020-10-20 16:55:08',NULL,1,143,NULL,'ASD','',NULL,NULL,NULL,'m','v',NULL,NULL,1386,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1026,'2020-10-20 18:08:01',NULL,NULL,4,NULL,'Rjrjjfjffnfjfj',NULL,NULL,'','',NULL,'v','',NULL,1387,NULL,'','','',NULL,NULL,NULL,'s','s','2020-10-20 18:30:30',4,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1027,'2020-10-21 17:43:36',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1388,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-21 17:57:09',4,NULL,NULL,'','n',159,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1028,'2020-10-21 17:57:59',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1389,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',160,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1029,'2020-10-21 17:57:59',NULL,NULL,4,NULL,'João',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1390,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',160,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1030,'2020-10-21 17:57:59',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1391,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',160,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1031,'2020-10-22 09:34:41',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1392,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-22 17:54:40',4,NULL,NULL,'','n',161,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1032,'2020-10-22 09:34:41',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1393,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-22 17:54:40',4,NULL,NULL,'','n',161,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1033,'2020-10-22 09:34:41',NULL,NULL,4,NULL,'Mercedes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1394,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:40',4,NULL,NULL,'','n',161,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1034,'2020-10-22 12:51:41',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1395,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:40',4,NULL,NULL,'','n',161,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1035,'2020-10-22 12:52:01',NULL,NULL,4,NULL,'TESTE VISIT',NULL,NULL,NULL,NULL,NULL,'v',NULL,215,1396,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:40',4,NULL,NULL,'','n',161,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1036,'2020-10-22 13:20:43',NULL,NULL,4,NULL,'Joana da Silva Neto',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1397,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:40',4,NULL,NULL,'','n',161,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1037,'2020-10-22 13:21:25',NULL,NULL,4,NULL,'Barbara Evans',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1398,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:40',4,NULL,NULL,'','n',161,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1038,'2020-10-22 17:10:45',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1399,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:13:23',4,NULL,NULL,'','n',164,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1039,'2020-10-22 17:14:50',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1400,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:43',4,NULL,NULL,'','n',165,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1040,'2020-10-22 17:15:29',NULL,NULL,4,NULL,'Jojo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1401,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:44',4,NULL,NULL,'','n',166,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1041,'2020-10-22 17:15:29',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1402,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:44',4,NULL,NULL,'','n',166,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1042,'2020-10-22 17:34:02',NULL,NULL,4,NULL,'PP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1403,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:46',4,NULL,NULL,'','n',167,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1043,'2020-10-22 17:44:54',NULL,NULL,4,NULL,'rr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1404,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:33',4,NULL,NULL,'','n',168,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1044,'2020-10-22 17:45:24',NULL,NULL,4,NULL,'eee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1405,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:35',4,NULL,NULL,'','n',169,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1045,'2020-10-22 17:45:24',NULL,NULL,4,NULL,'rr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1406,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:35',4,NULL,NULL,'','n',169,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1046,'2020-10-22 17:52:59',NULL,NULL,4,NULL,'tt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1407,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:36',4,NULL,NULL,'','n',170,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1047,'2020-10-22 17:53:52',NULL,NULL,4,NULL,'www',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1408,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:38',4,NULL,NULL,'','n',171,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1048,'2020-10-22 17:53:52',NULL,NULL,4,NULL,'tt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1409,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 17:54:38',4,NULL,NULL,'','n',171,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1049,'2020-10-22 17:55:29',NULL,NULL,4,NULL,'ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1410,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:00:24',4,NULL,NULL,'','n',172,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1050,'2020-10-22 17:56:24',NULL,NULL,4,NULL,'ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1411,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:00:26',4,NULL,NULL,'','n',173,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1051,'2020-10-22 17:56:24',NULL,NULL,4,NULL,'ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1412,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:00:26',4,NULL,NULL,'','n',173,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1052,'2020-10-22 18:02:16',NULL,NULL,4,NULL,'Teste 1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1413,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:06:54',4,NULL,NULL,'','n',174,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1053,'2020-10-22 18:07:27',NULL,NULL,4,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1414,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:37:41',4,NULL,NULL,'','n',175,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1054,'2020-10-22 18:09:51',NULL,NULL,4,NULL,'Teste 02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1415,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:37:42',4,NULL,NULL,'','n',176,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1055,'2020-10-22 18:09:51',NULL,NULL,4,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1416,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:37:42',4,NULL,NULL,'','n',176,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1056,'2020-10-22 18:11:01',NULL,NULL,4,NULL,'TEste 03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1417,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:37:44',4,NULL,NULL,'','n',177,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1057,'2020-10-22 18:11:01',NULL,NULL,4,NULL,'Teste 02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1418,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:37:44',4,NULL,NULL,'','n',177,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1058,'2020-10-22 18:11:01',NULL,NULL,4,NULL,'Teste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1419,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-22 18:37:44',4,NULL,NULL,'','n',177,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1059,'2020-10-22 18:38:21',NULL,NULL,4,NULL,'MAria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1420,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',178,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1060,'2020-10-22 18:39:42',NULL,NULL,4,NULL,'rere',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1421,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',179,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1061,'2020-10-22 18:39:42',NULL,NULL,4,NULL,'MAria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1422,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',179,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1062,'2020-10-23 10:04:30',NULL,NULL,4,NULL,'Jesica',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1423,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 10:44:13',4,NULL,NULL,'','n',180,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1063,'2020-10-23 10:05:33',NULL,NULL,4,NULL,'Aurelio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1424,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 10:44:11',4,NULL,NULL,'','n',181,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1064,'2020-10-23 10:05:33',NULL,NULL,4,NULL,'Jesica',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1425,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 10:44:11',4,NULL,NULL,'','n',181,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1065,'2020-10-23 10:25:28',NULL,NULL,4,NULL,'Jeferson',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1426,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 10:44:15',4,NULL,NULL,'','n',182,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1066,'2020-10-23 10:26:41',NULL,NULL,4,NULL,'Johanathan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1427,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 10:44:09',4,NULL,NULL,'','n',183,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1067,'2020-10-23 10:26:41',NULL,NULL,4,NULL,'Jeferson',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1428,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 10:44:09',4,NULL,NULL,'','n',183,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1068,'2020-10-23 10:42:38',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1429,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:36',4,NULL,NULL,'','n',184,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1069,'2020-10-23 10:43:40',NULL,NULL,4,NULL,'Jone',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1430,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:36',4,NULL,NULL,'','n',184,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1070,'2020-10-23 10:43:40',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1431,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:36',4,NULL,NULL,'','n',184,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1071,'2020-10-23 10:44:46',NULL,NULL,4,NULL,'React',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1432,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:38',4,NULL,NULL,'','n',185,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1072,'2020-10-23 10:45:02',NULL,NULL,4,NULL,'Ruby',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1433,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:38',4,NULL,NULL,'','n',185,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1073,'2020-10-23 10:45:02',NULL,NULL,4,NULL,'React',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1434,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:38',4,NULL,NULL,'','n',185,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1074,'2020-10-23 10:45:13',NULL,NULL,4,NULL,'Sass',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1435,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:38',4,NULL,NULL,'','n',185,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1075,'2020-10-23 10:45:13',NULL,NULL,4,NULL,'Ruby',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1436,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:38',4,NULL,NULL,'','n',185,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1076,'2020-10-23 10:45:14',NULL,NULL,4,NULL,'React',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1437,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:38',4,NULL,NULL,'','n',185,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1077,'2020-10-23 12:36:28',NULL,NULL,4,NULL,'Ana Ap.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1438,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:40',4,NULL,NULL,'','n',186,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1078,'2020-10-23 12:36:47',NULL,NULL,4,NULL,'Fernanda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1439,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:40',4,NULL,NULL,'','n',186,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1079,'2020-10-23 12:36:47',NULL,NULL,4,NULL,'Ana Ap.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1440,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:40',4,NULL,NULL,'','n',186,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1080,'2020-10-23 15:23:51',NULL,NULL,4,NULL,'Zé',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1441,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:15',4,NULL,NULL,'','n',187,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1081,'2020-10-23 15:24:38',NULL,NULL,4,NULL,'Neto',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1442,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:42',4,NULL,NULL,'','n',188,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1082,'2020-10-23 15:25:51',NULL,NULL,4,NULL,'Vivi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1443,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:42',4,NULL,NULL,'','n',188,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1083,'2020-10-23 15:25:51',NULL,NULL,4,NULL,'Neto',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1444,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:42',4,NULL,NULL,'','n',188,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1084,'2020-10-23 15:36:36',NULL,NULL,4,NULL,'Mane',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1445,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 15:41:09',4,NULL,NULL,'','n',189,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1085,'2020-10-23 15:42:48',NULL,NULL,4,NULL,'Ze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1446,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1086,'2020-10-23 15:42:58',NULL,NULL,4,NULL,'Mane',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1447,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1087,'2020-10-23 15:42:58',NULL,NULL,4,NULL,'Ze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1448,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1088,'2020-10-23 15:43:08',NULL,NULL,4,NULL,'Beatriz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1449,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1089,'2020-10-23 15:43:08',NULL,NULL,4,NULL,'Mane',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1450,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1090,'2020-10-23 15:43:08',NULL,NULL,4,NULL,'Ze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1451,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1091,'2020-10-23 15:45:44',NULL,NULL,4,NULL,'Toni',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1452,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 16:15:43',4,NULL,NULL,'','n',191,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1092,'2020-10-23 16:03:04',NULL,NULL,4,NULL,'Matheus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1453,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 16:15:37',4,NULL,NULL,'','n',192,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1093,'2020-10-23 16:12:12',NULL,NULL,4,NULL,'Mane',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1454,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1094,'2020-10-23 16:14:12',NULL,NULL,4,NULL,'Joana',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1455,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1095,'2020-10-23 16:16:01',NULL,NULL,4,NULL,'GOGO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1456,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:40',4,NULL,NULL,'','n',190,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1096,'2020-10-23 16:19:36',NULL,NULL,4,NULL,'Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1457,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:23',4,NULL,NULL,'','n',193,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1097,'2020-10-23 16:19:45',NULL,NULL,4,NULL,'Dois',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1458,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:23',4,NULL,NULL,'','n',193,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1098,'2020-10-23 16:19:45',NULL,NULL,4,NULL,'Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1459,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:23',4,NULL,NULL,'','n',193,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1099,'2020-10-23 16:21:50',NULL,NULL,4,NULL,'Tres',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1460,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:23',4,NULL,NULL,'','n',193,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1100,'2020-10-23 16:28:03',NULL,NULL,4,NULL,'Quatro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1461,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:23',4,NULL,NULL,'','n',193,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1101,'2020-10-23 16:38:19',NULL,NULL,4,NULL,'Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1462,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 16:48:07',4,NULL,NULL,'','n',194,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1102,'2020-10-23 16:41:12',NULL,NULL,4,NULL,'Dois',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1463,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 16:48:07',4,NULL,NULL,'','n',194,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1103,'2020-10-23 16:41:12',NULL,NULL,4,NULL,'Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1464,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 16:48:07',4,NULL,NULL,'','n',194,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1104,'2020-10-23 16:49:07',NULL,NULL,4,NULL,'G',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1465,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:05:43',4,NULL,NULL,'','n',195,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1105,'2020-10-23 16:51:34',NULL,NULL,4,NULL,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1466,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:05:43',4,NULL,NULL,'','n',195,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1106,'2020-10-23 16:51:34',NULL,NULL,4,NULL,'G',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1467,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:05:43',4,NULL,NULL,'','n',195,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1107,'2020-10-23 17:06:29',NULL,NULL,4,NULL,'r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1468,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:38',4,NULL,NULL,'','n',196,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1108,'2020-10-23 17:06:59',NULL,NULL,4,NULL,'e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1469,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:38',4,NULL,NULL,'','n',196,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1109,'2020-10-23 17:06:59',NULL,NULL,4,NULL,'r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1470,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:38',4,NULL,NULL,'','n',196,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1110,'2020-10-23 17:15:07',NULL,NULL,4,NULL,'q',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1471,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:21',4,NULL,NULL,'','n',197,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1111,'2020-10-23 17:15:14',NULL,NULL,4,NULL,'w',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1472,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:21',4,NULL,NULL,'','n',197,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1112,'2020-10-23 17:15:14',NULL,NULL,4,NULL,'q',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:19:21',4,NULL,NULL,'','n',197,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1113,'2020-10-23 17:20:51',NULL,NULL,4,NULL,'Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1474,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:35',4,NULL,NULL,'','n',198,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1114,'2020-10-23 17:21:36',NULL,NULL,4,NULL,'Dois',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1475,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:35',4,NULL,NULL,'','n',198,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1115,'2020-10-23 17:21:37',NULL,NULL,4,NULL,'Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1476,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:35',4,NULL,NULL,'','n',198,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1116,'2020-10-23 17:24:24',NULL,NULL,4,NULL,'Tres',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1477,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:35',4,NULL,NULL,'','n',198,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1117,'2020-10-23 17:24:38',NULL,NULL,4,NULL,'Quatro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1478,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:35',4,NULL,NULL,'','n',198,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1118,'2020-10-23 17:24:38',NULL,NULL,4,NULL,'Tres',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1479,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:42:35',4,NULL,NULL,'','n',198,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1119,'2020-10-23 17:43:27',NULL,NULL,4,NULL,'Queem',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1480,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:51:27',4,NULL,NULL,'','n',199,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1120,'2020-10-23 17:48:11',NULL,NULL,4,NULL,'Larisa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1481,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 17:51:25',4,NULL,NULL,'','n',200,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1121,'2020-10-23 17:52:07',NULL,NULL,4,NULL,'eeee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1482,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:40',4,NULL,NULL,'','n',201,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1122,'2020-10-23 17:53:46',NULL,NULL,4,NULL,'qqqqq',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1483,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:40',4,NULL,NULL,'','n',201,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1123,'2020-10-23 17:53:46',NULL,NULL,4,NULL,'eeee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1484,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:40',4,NULL,NULL,'','n',201,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1124,'2020-10-23 17:56:04',NULL,NULL,4,NULL,'e2e21e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1485,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:42',4,NULL,NULL,'','n',202,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1125,'2020-10-23 17:56:04',NULL,NULL,4,NULL,'e2e21e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1486,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:42',4,NULL,NULL,'','n',202,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1126,'2020-10-23 17:59:49',NULL,NULL,4,NULL,'1231',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1487,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:42',4,NULL,NULL,'','n',202,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1127,'2020-10-23 18:00:06',NULL,NULL,4,NULL,'23123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1488,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:42',4,NULL,NULL,'','n',202,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1128,'2020-10-23 18:00:06',NULL,NULL,4,NULL,'1231',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1489,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:42',4,NULL,NULL,'','n',202,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1129,'2020-10-23 18:03:44',NULL,NULL,4,NULL,'eee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1490,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:39',4,NULL,NULL,'','n',203,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1130,'2020-10-23 18:04:34',NULL,NULL,4,NULL,'rrr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1491,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:39',4,NULL,NULL,'','n',203,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1131,'2020-10-23 18:04:34',NULL,NULL,4,NULL,'eee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1492,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:09:39',4,NULL,NULL,'','n',203,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1132,'2020-10-23 18:10:05',NULL,NULL,4,NULL,'Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1493,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:12:58',4,NULL,NULL,'','n',204,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1133,'2020-10-23 18:13:27',NULL,NULL,4,NULL,'eeee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:26:08',4,NULL,NULL,'','n',205,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1134,'2020-10-23 18:13:57',NULL,NULL,4,NULL,'BBB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1495,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:26:08',4,NULL,NULL,'','n',205,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1135,'2020-10-23 18:13:57',NULL,NULL,4,NULL,'eeee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1496,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:26:08',4,NULL,NULL,'','n',205,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1136,'2020-10-23 18:26:44',NULL,NULL,4,NULL,'13123123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1497,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-23 18:28:18',4,NULL,NULL,'','n',206,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1137,'2020-10-23 18:28:47',NULL,NULL,4,NULL,'ooo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1498,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',207,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1138,'2020-10-23 18:29:09',NULL,NULL,4,NULL,'llll',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1499,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',207,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1139,'2020-10-23 18:32:04',NULL,NULL,4,NULL,'Bruno',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',207,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1140,'2020-10-23 18:32:28',NULL,NULL,4,NULL,'Denize',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1501,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',207,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1141,'2020-10-23 18:32:42',NULL,NULL,4,NULL,'Quezia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1502,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',207,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1142,'2020-10-23 18:42:19',NULL,NULL,4,NULL,'Cida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1503,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',207,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1143,'2020-10-23 18:53:25',NULL,NULL,4,NULL,'Geraldo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1504,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',207,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1144,'2020-10-23 18:55:41',NULL,NULL,4,NULL,'Gabriel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1505,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 09:43:22',4,NULL,NULL,'','n',208,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1145,'2020-10-23 18:55:51',NULL,NULL,4,NULL,'Fernanda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1506,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 09:43:22',4,NULL,NULL,'','n',208,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1146,'2020-10-23 18:56:46',NULL,NULL,4,NULL,'Sandra',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1507,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 09:43:22',4,NULL,NULL,'','n',208,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1147,'2020-10-23 19:02:54',NULL,NULL,4,NULL,'Giovanna',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1508,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 09:43:22',4,NULL,NULL,'','n',208,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1148,'2020-10-23 19:05:56',NULL,NULL,4,NULL,'Diogo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1509,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 09:43:22',4,NULL,NULL,'','n',208,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1149,'2020-10-26 09:34:04',NULL,NULL,4,NULL,'Jose',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1510,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1150,'2020-10-26 09:40:43',NULL,NULL,4,NULL,'Fernanda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1511,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1151,'2020-10-26 09:40:52',NULL,NULL,4,NULL,'Jesica',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1512,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1152,'2020-10-26 09:41:01',NULL,NULL,4,NULL,'Marcos',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1513,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1153,'2020-10-26 09:41:12',NULL,NULL,4,NULL,'Gabriel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1514,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1154,'2020-10-26 09:59:12',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1515,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1155,'2020-10-26 10:20:13',NULL,NULL,4,NULL,'Marivalda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1516,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1156,'2020-10-26 10:23:08',NULL,NULL,4,NULL,'Ggtg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1517,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 10:26:53',4,NULL,NULL,'','n',209,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1157,'2020-10-26 10:27:18',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1518,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1158,'2020-10-26 10:27:22',NULL,NULL,4,NULL,'Sjjsjd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1519,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1159,'2020-10-26 10:27:39',NULL,NULL,4,NULL,'Sjjsjd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1520,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1160,'2020-10-26 10:27:40',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1521,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1161,'2020-10-26 10:28:30',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1522,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1162,'2020-10-26 10:29:18',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1523,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1163,'2020-10-26 10:29:23',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1524,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1164,'2020-10-26 10:29:28',NULL,NULL,4,NULL,'TESTE VISIT',NULL,NULL,NULL,NULL,NULL,'v',NULL,215,1525,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1165,'2020-10-26 10:29:38',NULL,NULL,4,NULL,'Gdd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1526,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1166,'2020-10-26 10:54:07',NULL,NULL,4,NULL,'Talk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1527,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1167,'2020-10-26 10:54:21',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1528,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1168,'2020-10-26 11:58:09',NULL,NULL,4,NULL,'qweqwe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1529,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:07',4,NULL,NULL,'','n',213,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1169,'2020-10-26 15:42:36',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1530,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:03',4,NULL,NULL,'','n',216,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1170,'2020-10-26 15:50:45',NULL,NULL,4,NULL,'Zeze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1531,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:01:05',4,NULL,NULL,'','n',210,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1171,'2020-10-26 16:04:50',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1532,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:48:00',4,NULL,NULL,'','n',219,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1172,'2020-10-26 16:04:53',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1533,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','s','2020-10-26 16:48:00',4,NULL,NULL,'','n',219,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1173,'2020-10-26 16:05:00',NULL,NULL,4,NULL,'Zilda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1534,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:48:00',4,NULL,NULL,'','n',219,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1174,'2020-10-26 16:27:43',NULL,NULL,4,NULL,'DODO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1535,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:48:01',4,NULL,NULL,'','n',222,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1175,'2020-10-26 16:32:02',NULL,NULL,4,NULL,'Vanessa Gomes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1536,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 16:48:01',4,NULL,NULL,'','n',222,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1176,'2020-10-26 16:48:50',NULL,NULL,4,NULL,'Maria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1537,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',226,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1177,'2020-10-26 16:48:59',NULL,NULL,4,NULL,'Fernanda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1538,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',226,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1178,'2020-10-26 16:59:08',NULL,NULL,4,NULL,'Dilma',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1539,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',226,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1179,'2020-10-26 17:01:41',NULL,NULL,4,NULL,'Dina',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1540,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',228,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1180,'2020-10-26 17:17:40',NULL,NULL,4,NULL,'Taninha',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1541,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',226,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1181,'2020-10-26 17:23:49',NULL,NULL,4,NULL,'Marcos',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1542,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1182,'2020-10-26 17:23:57',NULL,NULL,4,NULL,'Julio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1543,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1183,'2020-10-26 17:27:15',NULL,NULL,4,NULL,'Carol',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1544,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1184,'2020-10-26 17:27:26',NULL,NULL,4,NULL,'Rafael',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1545,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1185,'2020-10-26 17:27:32',NULL,NULL,4,NULL,'Bruno',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1546,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1186,'2020-10-26 17:27:40',NULL,NULL,4,NULL,'Alex',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1547,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1187,'2020-10-26 17:31:43',NULL,NULL,4,NULL,'Ronildo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1548,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1188,'2020-10-26 17:31:55',NULL,NULL,4,NULL,'Naldo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1549,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2020-10-26 18:44:26',4,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1189,'2020-10-26 17:32:03',NULL,NULL,4,NULL,'Jean',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1550,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1190,'2020-10-26 18:03:04',NULL,NULL,4,NULL,'João',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1551,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1191,'2020-10-26 18:44:00',NULL,NULL,4,NULL,'Sandro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1552,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',230,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1192,'2020-10-26 18:58:31',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1553,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',226,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1193,'2020-10-27 10:53:00',NULL,NULL,4,NULL,'Fernando',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1554,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',232,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1194,'2020-10-27 10:58:20',NULL,NULL,4,NULL,'Kelly',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1555,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',232,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1195,'2020-10-27 10:59:01',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1556,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',232,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1196,'2020-10-27 17:22:24',NULL,NULL,4,NULL,'Tranquilo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1557,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',232,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1197,'2020-10-28 09:18:28',NULL,NULL,4,NULL,'João Pedro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1558,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',233,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1198,'2020-10-28 16:16:43',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v',NULL,217,1559,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',233,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1199,'2020-10-29 09:17:12',NULL,NULL,4,NULL,'Maria Clara',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1560,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',234,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1200,'2020-10-29 12:12:48',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v',NULL,218,1561,NULL,NULL,NULL,'',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',235,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1201,'2020-10-29 12:12:53',NULL,NULL,4,NULL,'Nsjs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1562,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',235,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1202,'2020-11-03 16:29:13',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v','',218,1563,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1203,'2020-11-05 13:08:22',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v','',217,1564,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1204,'2020-11-05 13:08:49',NULL,NULL,4,NULL,'Ghhuu',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1565,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',236,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1205,'2020-11-10 10:36:26',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v','',217,1566,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1206,'2020-11-10 11:04:28',NULL,NULL,1,NULL,'ALESSANDRO GONZAGA','ASDASD','12/12/2000','12121222222','51406081620','m','v','',222,1567,NULL,'','','',NULL,NULL,NULL,'s','s','2020-11-10 11:04:31',1,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1207,'2020-11-10 17:21:22',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v','',217,1568,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1208,'2020-11-11 12:50:04',NULL,NULL,4,NULL,'Hffft',NULL,NULL,'','',NULL,'v','',NULL,1569,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1209,'2020-11-18 11:52:55',NULL,NULL,4,NULL,'MAIS UM TESTE','SILVA','01/01/2005','00000000000','43245206070','f','v','',218,1570,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1210,'2020-11-23 09:43:41',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v','',217,1571,NULL,'','','',NULL,NULL,NULL,'s','s','2020-11-23 09:43:43',4,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1211,'2020-11-26 15:45:58',NULL,1,3,'Uber vai entrar em minha casa.','FABIO NASCIMENTO','MARIA','01/01/2000','62999999999','36298252061','m','p','t',115,1575,NULL,'Taxi/Uber','Motorista','kpf0999','Gol','branco','carro','p','n',NULL,NULL,NULL,NULL,'','s',0,'252222555','ab','2022-01-01',NULL,NULL,1,0,0,NULL),(1212,'2020-12-02 10:17:35',NULL,1,19,NULL,'JOAQUIM','','13/06/1991','62985656555','47467562284','m','p',NULL,226,1576,NULL,'teste','teste','','','','outro','p','s','2021-02-17 11:35:01',19,NULL,NULL,'','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1213,'2020-12-02 10:29:03',NULL,4,156,'Uber carro gol','JOÃO UBER','TELMA','01/01/2000','62999999999','85722348023','m','p','e',10,1577,NULL,'uber','Entregador','12343gf','GOl','branco','carro','p','n',NULL,NULL,NULL,'1231313','CNH','s',0,'1231313','ab','2033-01-01','upload/img/pessoa/16069121115fc7886f206b9.jpeg','upload/img/pessoa/16069121115fc7886f1eb60.jpeg',1,0,0,NULL),(1214,'2020-12-02 10:31:53',NULL,4,156,NULL,'ASDSAD','ADADSD','22/12/2000','33333333333',NULL,'m','v',NULL,18,1578,NULL,NULL,NULL,'','','','outro','p','n',NULL,NULL,NULL,'teste','TESTE','s',0,'5456654','b','2020-12-12',NULL,NULL,1,0,0,NULL),(1215,'2020-12-02 10:37:00',NULL,4,156,NULL,'ASDSAD','ADADSD','22/12/2000','33333333333',NULL,'m','v',NULL,18,1579,NULL,NULL,NULL,NULL,NULL,NULL,'carro','p','n',NULL,NULL,NULL,'teste','TESTE','s',0,'5456654','b','2020-12-12',NULL,NULL,1,0,0,NULL),(1216,'2020-12-02 10:38:35',NULL,4,156,NULL,'ASDSAD','ADADSD','22/12/2000','33333333333',NULL,'m','v',NULL,18,1581,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,'teste','TESTE','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1217,'2020-12-02 10:43:16',NULL,1,4,NULL,'TESTE NOVO','MARIA','01/01/2000','00000000000','77102337086','m','v',NULL,227,1583,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1218,'2020-12-02 10:49:59',NULL,1,4,NULL,'TESTE NOVO','MARIA','01/01/2000','00000000000','77102337086','m','v',NULL,227,1585,NULL,NULL,NULL,'','','','outro','s','n',NULL,NULL,NULL,NULL,'','s',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1219,'2020-12-02 10:57:54',NULL,4,156,NULL,'VISITANTE','N','09/09/2000','99999999999',NULL,'m','v',NULL,28,1586,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'1234','W45H5','s',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(1220,'2020-12-02 11:02:12',NULL,4,156,NULL,'VISITANTE','N','09/09/2000','99999999999',NULL,'m','v',NULL,28,1587,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'1234','W45H5','s',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(1221,'2020-12-02 11:03:08',NULL,4,156,NULL,'ASDSAD','ADADSD','22/12/2000','33333333333',NULL,'m','v',NULL,18,1588,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'teste','TESTE','s',0,'5456654','b','2020-12-12',NULL,NULL,1,0,0,NULL),(1222,'2020-12-02 11:42:55',NULL,4,156,NULL,'JOAO VITOR','MARCIA','15/02/1986','62991057275','85732820027','m','v',NULL,7,1589,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'12312313','SSPGO','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1223,'2020-12-02 11:43:36',NULL,4,156,NULL,'VISITANTE','N','09/09/2000','99999999999',NULL,'m','v',NULL,28,1590,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'1234','W45H5','s',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(1224,'2020-12-02 11:45:11',NULL,4,156,NULL,'VISITANTE','N','09/09/2000','99999999999',NULL,'m','v',NULL,28,1591,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'1234','W45H5','s',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(1225,'2020-12-02 11:46:12',NULL,4,156,NULL,'VISITANTE','N','09/09/2000','99999999999',NULL,'m','v',NULL,28,1592,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'1234','W45H5','s',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(1226,'2020-12-02 16:11:59',NULL,4,156,NULL,'PESSOAL LEGAL','N','09/09/2000','99999999999',NULL,'m','v',NULL,28,1593,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'1234','W45H5','s',0,'345645','b','2050-05-05',NULL,NULL,1,0,0,NULL),(1227,'2020-12-02 18:02:14',NULL,4,156,NULL,'ASDSAD','ADADSD','22/12/2000','33333333333',NULL,'m','v',NULL,18,1594,NULL,NULL,NULL,'','','','pedestre','p','n',NULL,NULL,NULL,'teste','TESTE','s',0,'5456654','b','2020-12-12',NULL,NULL,1,0,0,NULL),(1228,'2020-12-07 09:27:09',NULL,4,156,NULL,'ASDSAD','ADADSD','22/12/2000','33333333333',NULL,'m','v',NULL,18,1595,NULL,NULL,NULL,NULL,NULL,NULL,'carro','p','n',NULL,NULL,NULL,'teste','TESTE','s',0,'5456654','b','2020-12-12',NULL,NULL,1,0,0,NULL),(1229,'2020-12-07 17:22:23',NULL,NULL,4,'Teste','Teat Ios',NULL,NULL,'','',NULL,'v','',NULL,1596,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1230,'2020-12-07 17:31:16',NULL,NULL,4,NULL,'Gg',NULL,NULL,'','',NULL,'v','',NULL,1597,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1231,'2020-12-10 10:55:36',NULL,1,19,NULL,'HJMN','',NULL,NULL,NULL,'m','v',NULL,NULL,1598,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1232,'2020-12-10 12:09:50',NULL,1,19,NULL,'CPF DO BRUNO 2','TRES','13/01/2000','23323333333','04311617127','f','v',NULL,47,1599,NULL,NULL,NULL,'','','','outro','p','n',NULL,NULL,NULL,NULL,'','n',0,'321232','a','2021-12-12',NULL,NULL,1,0,0,NULL),(1233,'2020-12-10 12:37:12',NULL,NULL,4,NULL,'TESTE NOVO',NULL,NULL,NULL,NULL,NULL,'v',NULL,227,1600,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',237,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1234,'2020-12-11 09:54:57',NULL,NULL,4,NULL,'TESTE NOVO','MARIA','01/01/2000','00000000000','77102337086','m','v','',227,1601,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1235,'2020-12-11 15:24:39',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v','',217,1602,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1236,'2020-12-11 17:32:47',NULL,NULL,4,NULL,'Ggyh',NULL,NULL,'','',NULL,'v','',NULL,1603,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1237,'2020-12-11 17:33:08',NULL,NULL,4,NULL,'JOANA DA SILVA','MARIA','01/01/2000','00000000000','04792492025','f','v','',217,1604,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1238,'2020-12-16 10:19:31',NULL,NULL,4,NULL,'TESTE NOVO','MARIA','01/01/2000','00000000000','77102337086','m','v','',227,1605,NULL,'','','',NULL,NULL,NULL,'s','n',NULL,NULL,NULL,'','','n',0,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1239,'2020-12-21 11:05:31',NULL,NULL,1,NULL,'ALESSANDRO GONZAGA',NULL,NULL,NULL,NULL,NULL,'v',NULL,222,1606,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',238,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1240,'2020-12-21 11:05:32',NULL,NULL,1,NULL,'BRUNO MOURA',NULL,NULL,NULL,NULL,NULL,'v',NULL,223,1607,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',238,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1241,'2020-12-21 11:05:39',NULL,NULL,1,NULL,'ALESSANDRO GONZAGA',NULL,NULL,NULL,NULL,NULL,'v',NULL,222,1608,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',238,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1242,'2020-12-21 11:05:39',NULL,NULL,1,NULL,'GUSTAVO CAVALCANTI',NULL,NULL,NULL,NULL,NULL,'v',NULL,221,1609,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',238,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1243,'2021-01-14 15:58:10',NULL,1,108,NULL,'TESTE PRESTADOR','','01/01/2000','62654564646',NULL,'m','p',NULL,229,1610,NULL,'dfgsfgsf','gsfg','','','','outro','p','n',NULL,NULL,NULL,'abcd','SDFG','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1244,'2021-01-14 16:02:38',NULL,1,108,NULL,'TESTE PRESTADOR','','01/01/2000','62654564646',NULL,'m','p',NULL,229,1612,NULL,'dfgsfgsf','gsfg','','','','outro','p','n',NULL,NULL,NULL,'abcd','SDFG','s',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1245,'2021-01-14 16:11:53',NULL,1,108,NULL,'TESTE PRESTADOR','','01/01/2000','62654564646',NULL,'m','p',NULL,229,1613,NULL,'dfgsfgsf','gsfg','','','','outro','p','n',NULL,NULL,NULL,'abcd','SDFG','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1246,'2021-01-14 16:12:35',NULL,1,108,NULL,'PESSOA','',NULL,NULL,NULL,'m','v',NULL,NULL,1614,NULL,NULL,NULL,'','','','carro','p','n',NULL,NULL,NULL,NULL,'','n',0,'',NULL,NULL,NULL,NULL,1,0,0,NULL),(1247,'2021-02-17 10:58:01',NULL,NULL,19,NULL,'Ana',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1615,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:15',19,NULL,NULL,'','n',239,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1248,'2021-02-17 10:58:01',NULL,NULL,19,NULL,'Gustavo',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1616,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:15',19,NULL,NULL,'','n',239,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1249,'2021-02-17 10:58:01',NULL,NULL,19,NULL,'João',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1617,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:15',19,NULL,NULL,'','n',239,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1250,'2021-02-17 10:58:01',NULL,NULL,19,NULL,'Pedro',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1618,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:15',19,NULL,NULL,'','n',239,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1251,'2021-02-17 11:08:20',NULL,NULL,19,NULL,'ARLINDO',NULL,NULL,NULL,NULL,NULL,'v',NULL,207,1619,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:15',19,NULL,NULL,'','n',239,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1252,'2021-02-17 11:08:20',NULL,NULL,19,NULL,'SADASSAD',NULL,NULL,NULL,NULL,NULL,'v',NULL,171,1620,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 11:35:15',19,NULL,NULL,'','n',239,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1253,'2021-02-17 12:27:54',NULL,NULL,1,NULL,'CLEUNICE ALMEIDA',NULL,NULL,NULL,NULL,NULL,'v',NULL,220,1621,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 12:28:11',1,NULL,NULL,'','n',240,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1254,'2021-02-17 12:27:54',NULL,NULL,1,NULL,'FERNANDA SILVA',NULL,NULL,NULL,NULL,NULL,'v',NULL,219,1622,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 12:28:11',1,NULL,NULL,'','n',240,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1255,'2021-02-17 12:27:54',NULL,NULL,1,NULL,'GUSTAVO CAVALCANTI',NULL,NULL,NULL,NULL,NULL,'v',NULL,221,1623,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 12:28:11',1,NULL,NULL,'','n',240,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1256,'2021-02-17 12:27:54',NULL,NULL,1,NULL,'João',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1624,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','s','2021-02-17 12:28:11',1,NULL,NULL,'','n',240,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1257,'2021-02-17 12:29:28',NULL,NULL,1,NULL,'ALESSANDRO GONZAGA',NULL,NULL,NULL,NULL,NULL,'v',NULL,222,1625,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',241,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1258,'2021-02-17 12:29:29',NULL,NULL,1,NULL,'CLEUNICE ALMEIDA',NULL,NULL,NULL,NULL,NULL,'v',NULL,220,1626,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',241,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1259,'2021-02-17 12:29:29',NULL,NULL,1,NULL,'GUSTAVO CAVALCANTI',NULL,NULL,NULL,NULL,NULL,'v',NULL,221,1627,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',241,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1260,'2021-02-17 12:29:29',NULL,NULL,1,NULL,'Joao',NULL,NULL,NULL,NULL,NULL,'v',NULL,NULL,1628,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',241,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL),(1261,'2021-02-17 12:29:45',NULL,NULL,1,NULL,'FERNANDA SILVA',NULL,NULL,NULL,NULL,NULL,'v',NULL,219,1629,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,NULL,NULL,'','n',241,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL);
/*!40000 ALTER TABLE `liberacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_convidados`
--

DROP TABLE IF EXISTS `lista_convidados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lista_convidados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(10) unsigned NOT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `data_evento` date NOT NULL,
  `nome_evento` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `local_evento` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hora_inicio` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `hora_final` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  `data_evento_final` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_SOFTDELETED_DATAEVENTO` (`softdeleted`,`data_evento`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_convidados`
--

LOCK TABLES `lista_convidados` WRITE;
/*!40000 ALTER TABLE `lista_convidados` DISABLE KEYS */;
INSERT INTO `lista_convidados` VALUES (16,4,1,'2019-12-10','rr',NULL,'10:44','23:59','2019-12-10 12:43:50','2019-12-10 12:44:14',0,'2019-12-10'),(17,4,1,'2019-12-19','Festa confra',NULL,'20:00','03:00','2019-12-10 12:47:33','2019-12-10 13:42:10',1,'2019-12-20'),(18,4,1,'2019-12-10','Fjfjfj',NULL,'17:51','23:59','2019-12-10 19:51:32','2019-12-10 19:51:32',0,'2019-12-10'),(19,4,1,'2019-12-11','Teste',NULL,'12:04','23:59','2019-12-11 14:03:47','2019-12-11 14:03:47',0,'2019-12-11'),(20,19,1,'2019-12-12','Niver',NULL,'16:05','23:59','2019-12-12 18:05:12','2019-12-12 18:13:17',1,'2019-12-18'),(21,19,1,'2019-12-12','Neme',NULL,'16:24','23:59','2019-12-12 18:23:30','2019-12-12 18:23:30',0,'2019-12-12'),(22,1,1,'2019-12-31','Krek',NULL,'08:51','23:59','2019-12-13 10:50:43','2019-12-13 10:51:20',1,'2019-12-31'),(23,19,1,'2019-12-13','Jsjss',NULL,'11:34','23:59','2019-12-13 13:34:12','2019-12-13 13:34:12',0,'2019-12-13'),(24,19,1,'2019-12-13','Sjjs',NULL,'11:35','23:59','2019-12-13 13:34:53','2019-12-13 13:34:53',0,'2019-12-13'),(25,19,1,'2019-12-13','Jsjs',NULL,'11:37','23:59','2019-12-13 13:36:56','2019-12-13 13:36:56',0,'2019-12-14'),(26,19,1,'2019-12-13','Ndn',NULL,'06:38','23:59','2019-12-13 13:38:06','2019-12-13 13:38:06',0,'2019-12-13'),(27,1,1,'2019-12-16','Jdje',NULL,'09:04','23:59','2019-12-16 11:04:10','2019-12-16 11:04:10',0,'2019-12-16'),(28,4,1,'2019-12-16','Ana',NULL,'12:12','23:59','2019-12-16 14:12:31','2019-12-16 14:12:31',0,'2019-12-16'),(29,4,1,'2019-12-16','tste',NULL,'12:17','23:59','2019-12-16 14:16:24','2019-12-16 14:16:24',0,'2019-12-16'),(30,4,1,'2019-12-16','Teste',NULL,'13:54','23:59','2019-12-16 15:54:18','2019-12-16 15:54:18',0,'2019-12-16'),(31,19,1,'2019-12-16','Jsjsjs',NULL,'16:11','23:59','2019-12-16 18:10:37','2019-12-16 18:10:37',0,'2019-12-16'),(32,19,1,'2019-12-17','Teste',NULL,'08:32','23:59','2019-12-17 10:32:06','2019-12-17 10:32:06',0,'2019-12-17'),(33,4,1,'2019-12-17','Aniv. Joana',NULL,'10:06','23:59','2019-12-17 12:06:19','2019-12-17 12:06:19',1,'2019-12-17'),(34,4,1,'2019-12-17','Party House',NULL,'10:13','23:59','2019-12-17 12:13:29','2019-12-17 12:13:29',1,'2019-12-17'),(35,1,1,'2019-12-17','Teste',NULL,'10:31','23:59','2019-12-17 12:30:35','2019-12-17 12:31:53',1,'2019-12-24'),(36,4,1,'2019-12-17','TTSS',NULL,'12:01','23:59','2019-12-17 14:00:40','2019-12-17 14:00:40',1,'2019-12-17'),(37,4,1,'2019-12-17','2 Dias de Festa',NULL,'12:11','23:59','2019-12-17 14:10:40','2019-12-17 14:10:40',1,'2019-12-19'),(38,4,1,'2019-12-17','2 dias de festa',NULL,'12:25','23:59','2019-12-17 14:25:21','2019-12-17 14:25:21',1,'2019-12-19'),(39,4,1,'2019-12-17','2 dias de festa',NULL,'12:33','23:59','2019-12-17 14:33:04','2019-12-17 14:33:04',1,'2019-12-19'),(40,4,1,'2019-12-17','Plus',NULL,'13:41','23:59','2019-12-17 15:40:38','2019-12-17 15:40:38',1,'2019-12-20'),(47,4,1,'2019-12-17','errer',NULL,'14:33','23:59','2019-12-17 16:33:06','2019-12-17 16:33:06',1,'2019-12-19'),(48,4,1,'2019-12-17','Teste',NULL,'14:42','23:59','2019-12-17 16:41:54','2019-12-17 16:41:54',1,'2019-12-17'),(49,4,1,'2019-12-20','123213',NULL,'16:39','23:59','2019-12-17 18:39:10','2019-12-17 18:39:10',1,'2019-12-20'),(50,4,1,'2019-12-17','12312',NULL,'16:40','23:59','2019-12-17 18:40:10','2019-12-17 18:40:10',1,'2019-12-30'),(51,1,1,'2019-12-18','Teyse',NULL,'10:03','23:59','2019-12-18 12:03:05','2019-12-18 12:03:05',1,'2019-12-18'),(52,4,1,'2019-12-19','123',NULL,'11:28','23:59','2019-12-18 13:28:50','2019-12-18 13:28:50',1,'2019-12-19'),(53,4,1,'2019-12-18','312',NULL,'11:44','23:59','2019-12-18 13:43:31','2019-12-18 13:43:31',1,'2019-12-18'),(54,4,1,'2019-12-18','21e2',NULL,'11:44','23:59','2019-12-18 13:44:23','2019-12-18 13:44:23',1,'2019-12-20'),(55,4,1,'2019-12-18','22',NULL,'11:45','23:59','2019-12-18 13:45:37','2019-12-18 13:45:37',1,'2019-12-18'),(56,4,1,'2019-12-20','122e1',NULL,'11:46','23:59','2019-12-18 13:46:08','2019-12-18 13:46:08',1,'2019-12-20'),(57,4,1,'2019-12-19','Djjd',NULL,'11:51','23:59','2019-12-18 13:52:02','2019-12-18 13:52:02',1,'2019-12-19'),(58,4,1,'2019-12-18','Hoje',NULL,'11:53','23:59','2019-12-18 13:52:32','2019-12-18 13:52:32',1,'2019-12-18'),(59,4,1,'2019-12-18','Dias',NULL,'11:54','23:59','2019-12-18 13:54:15','2019-12-18 13:54:15',1,'2019-12-20'),(60,4,1,'2019-12-18','Gg',NULL,'12:04','23:59','2019-12-18 14:03:27','2019-12-18 14:03:27',1,'2019-12-18'),(61,4,1,'2019-12-18','123',NULL,'13:09','23:59','2019-12-18 15:11:57','2019-12-18 15:11:57',1,'2019-12-19'),(62,1,1,'2019-12-18','Jsjs',NULL,'13:39','23:59','2019-12-18 15:39:24','2019-12-18 15:39:24',1,'2019-12-19'),(63,1,1,'2019-12-19','Jsjd',NULL,'13:40','23:59','2019-12-18 15:39:40','2019-12-18 15:39:40',1,'2019-12-20'),(64,4,1,'2019-12-18','Fdfg',NULL,'16:27','23:59','2019-12-18 18:27:07','2019-12-18 18:27:07',1,'2019-12-18'),(65,4,1,'2019-12-18','Fff',NULL,'16:28','23:59','2019-12-18 18:28:02','2019-12-18 18:28:02',1,'2019-12-20'),(66,4,1,'2019-12-18','Fgh',NULL,'16:31','23:59','2019-12-18 18:30:42','2019-12-18 18:30:42',1,'2019-12-18'),(67,4,1,'2019-12-18','Vgh',NULL,'16:32','23:59','2019-12-18 18:31:23','2019-12-18 18:31:23',1,'2019-12-20'),(68,4,1,'2019-12-18','Fggg',NULL,'16:38','23:59','2019-12-18 18:38:12','2019-12-18 18:38:12',1,'2019-12-18'),(69,4,1,'2019-12-18','Fghh',NULL,'16:39','23:59','2019-12-18 18:39:01','2019-12-18 18:39:01',1,'2019-12-20'),(70,4,1,'2019-12-18','Ffhgh',NULL,'16:41','23:59','2019-12-18 18:40:54','2019-12-18 18:40:54',1,'2019-12-25'),(71,4,1,'2019-12-18','123',NULL,'16:57','23:59','2019-12-18 18:56:25','2019-12-18 18:56:25',1,'2019-12-20'),(72,4,1,'2019-12-18','2e12e',NULL,'17:01','23:59','2019-12-18 19:00:35','2019-12-18 19:00:35',1,'2019-12-18'),(73,4,1,'2019-12-18','1e2e1',NULL,'17:01','23:59','2019-12-18 19:01:15','2019-12-18 19:01:15',1,'2019-12-20'),(74,4,1,'2019-12-18','qwewqe',NULL,'17:10','23:59','2019-12-18 19:09:34','2019-12-18 19:09:34',1,'2019-12-18'),(75,1,1,'2019-12-18','Fhdfj',NULL,'17:33','23:59','2019-12-18 19:32:27','2019-12-18 19:33:34',1,'2019-12-18'),(76,1,1,'2019-12-18','Gfsd',NULL,'17:37','23:59','2019-12-18 19:36:39','2019-12-18 19:36:39',0,'2019-12-18'),(77,4,1,'2019-12-18','Dois dias',NULL,'17:53','23:59','2019-12-18 19:52:31','2019-12-18 19:52:31',1,'2019-12-20'),(78,4,1,'2019-12-18','Dois dias',NULL,'17:53','23:59','2019-12-18 19:53:47','2019-12-18 19:53:47',1,'2019-12-20'),(79,18,1,'2019-12-19','Gsfg',NULL,'09:36','23:59','2019-12-19 11:36:14','2019-12-19 11:36:14',0,'2019-12-19'),(80,18,1,'2019-12-19','12313',NULL,'09:42','23:59','2019-12-19 11:41:56','2019-12-19 11:41:56',0,'2019-12-19'),(81,18,1,'2019-12-19','rr',NULL,'09:43','23:59','2019-12-19 11:43:18','2019-12-19 11:43:18',0,'2019-12-22'),(82,4,1,'2019-12-19','Gfgg',NULL,'09:49','23:59','2019-12-19 11:49:18','2019-12-19 11:49:18',1,'2019-12-21'),(83,4,1,'2019-12-19','Hj',NULL,'09:54','23:59','2019-12-19 11:53:37','2019-12-19 11:53:37',1,'2019-12-19'),(84,4,1,'2019-12-19','Tf',NULL,'11:06','23:59','2019-12-19 13:05:29','2019-12-19 13:05:29',1,'2019-12-19'),(85,1,1,'2019-12-19','Hsjs',NULL,'11:16','23:59','2019-12-19 13:16:10','2019-12-19 13:16:10',1,'2019-12-19'),(86,1,1,'2019-12-20','Jdjdj',NULL,'11:17','23:59','2019-12-19 13:16:33','2019-12-19 13:16:33',1,'2019-12-20'),(87,1,1,'2019-12-19','Djjsdm',NULL,'11:18','23:59','2019-12-19 13:18:00','2019-12-19 13:18:00',1,'2019-12-26'),(88,1,1,'2019-12-19','Hsjs',NULL,'11:33','23:59','2019-12-19 13:32:31','2019-12-19 13:41:00',1,'2019-12-20'),(89,1,1,'2019-12-19','Jdjd',NULL,'11:33','23:59','2019-12-19 13:32:41','2019-12-19 13:32:41',1,'2019-12-19'),(90,1,1,'2019-12-19','Hoje',NULL,'12:11','23:59','2019-12-19 14:10:23','2019-12-19 14:10:23',0,'2019-12-19'),(91,1,1,'2019-12-20','Maanha',NULL,'12:11','23:59','2019-12-19 14:11:04','2019-12-19 14:11:04',1,'2019-12-20'),(92,1,1,'2019-12-19','Hoje e manhã',NULL,'12:12','23:59','2019-12-19 14:11:21','2019-12-19 14:11:21',1,'2019-12-20'),(93,1,1,'2019-12-19','Sábado',NULL,'12:13','23:59','2019-12-19 14:12:55','2019-12-19 14:15:39',1,'2019-12-21'),(94,4,1,'2019-12-19','ee',NULL,'13:46','23:59','2019-12-19 15:46:14','2019-12-19 15:46:35',1,'2019-12-21'),(95,4,1,'2019-12-19','Teste',NULL,'13:56','23:59','2019-12-19 15:55:37','2019-12-19 16:01:05',1,'2019-12-22'),(96,4,1,'2019-12-19','Teste',NULL,'14:09','23:59','2019-12-19 16:09:16','2019-12-19 16:10:45',1,'2019-12-19'),(97,4,1,'2019-12-19','Teste 01',NULL,'14:12','23:59','2019-12-19 16:12:07','2019-12-19 16:15:04',1,'2019-12-19'),(98,4,1,'2019-12-19','Tutu',NULL,'14:41','23:59','2019-12-19 16:41:05','2019-12-19 16:50:14',1,'2019-12-19'),(99,4,1,'2019-12-19','Fggg',NULL,'14:51','23:59','2019-12-19 16:51:09','2019-12-19 17:36:01',1,'2019-12-19'),(100,4,1,'2019-12-19','2132',NULL,'15:41','23:59','2019-12-19 17:41:07','2019-12-19 17:42:27',1,'2019-12-19'),(101,4,1,'2019-12-21','123',NULL,'16:22','23:59','2019-12-19 18:21:55','2019-12-19 18:21:55',1,'2019-12-21'),(102,4,1,'2019-12-21','55',NULL,'16:32','23:59','2019-12-19 18:31:29','2019-12-19 18:31:29',1,'2019-12-21'),(103,4,1,'2019-12-20','qwee',NULL,'09:35','23:59','2019-12-20 11:35:10','2019-12-20 11:39:06',1,'2019-12-20'),(104,4,1,'2019-12-20','domingo',NULL,'09:46','23:59','2019-12-20 11:46:22','2019-12-20 11:55:33',1,'2019-12-21'),(105,4,1,'2019-12-20','Teste',NULL,'14:46','23:59','2019-12-20 16:45:37','2019-12-20 16:46:50',1,'2019-12-20'),(106,4,1,'2019-12-20','Segunda',NULL,'14:50','23:59','2019-12-20 16:50:00','2019-12-20 16:56:12',1,'2019-12-20'),(107,4,1,'2019-12-20','Teste 02',NULL,'15:57','23:59','2019-12-20 17:57:18','2019-12-20 18:00:36',1,'2019-12-21'),(108,1,1,'2019-12-20','Jsjs',NULL,'17:19','23:59','2019-12-20 19:18:36','2019-12-20 19:18:36',1,'2019-12-20'),(109,1,1,'2019-12-20','Hoje',NULL,'17:20','23:59','2019-12-20 19:19:12','2019-12-20 19:19:12',0,'2019-12-20'),(110,1,1,'2019-12-21','Amanhã',NULL,'17:20','23:59','2019-12-20 19:19:41','2019-12-20 19:19:41',0,'2019-12-21'),(111,1,1,'2019-12-20','Hj Amanhã e depois',NULL,'17:20','23:59','2019-12-20 19:20:42','2019-12-20 19:20:42',0,'2019-12-22'),(112,4,1,'2020-02-03','Aniv. Pedro',NULL,'15:10','23:59','2020-02-03 17:10:30','2020-02-03 17:10:30',0,'2020-02-03'),(113,4,1,'2020-02-03','My. Teste',NULL,'16:59','23:59','2020-02-03 18:59:06','2020-02-03 18:59:06',0,'2020-02-03'),(114,19,1,'2020-02-04','Ejje',NULL,'10:50','23:59','2020-02-04 12:51:02','2020-02-04 12:51:02',0,'2020-02-04'),(115,4,1,'2020-02-06','REr',NULL,'12:26','23:59','2020-02-05 14:30:14','2020-02-05 14:30:14',1,'2020-02-06'),(116,4,1,'2020-02-05','123',NULL,'14:30','23:59','2020-02-05 16:29:58','2020-02-05 16:29:58',1,'2020-02-05'),(118,4,1,'2020-02-06','1123123',NULL,'14:53','23:59','2020-02-05 16:52:49','2020-02-05 16:52:49',1,'2020-02-06'),(120,4,1,'2020-02-05','ee',NULL,'15:15','23:59','2020-02-05 17:14:45','2020-02-05 17:14:45',1,'2020-02-06'),(121,4,1,'2020-02-06','234234',NULL,'15:25','23:59','2020-02-05 17:24:58','2020-02-05 17:24:58',1,'2020-02-06'),(122,4,1,'2020-02-06','234',NULL,'15:26','23:59','2020-02-05 17:28:54','2020-02-05 17:28:54',1,'2020-02-10'),(123,4,1,'2020-02-05','123123',NULL,'15:35','23:59','2020-02-05 17:35:20','2020-02-05 17:35:20',1,'2020-02-05'),(124,4,1,'2020-02-05','11',NULL,'15:36','23:59','2020-02-05 17:35:56','2020-02-05 17:35:56',1,'2020-02-10'),(125,4,1,'2020-02-05','12323',NULL,'15:37','23:59','2020-02-05 17:44:06','2020-02-05 17:44:06',1,'2020-02-05'),(126,4,1,'2020-02-05','123',NULL,'15:56','23:59','2020-02-05 17:56:38','2020-02-05 17:56:38',1,'2020-02-05'),(127,4,1,'2020-02-05','33',NULL,'15:57','23:59','2020-02-05 18:01:16','2020-02-05 18:01:16',1,'2020-02-05'),(128,4,1,'2020-02-05','ee',NULL,'16:02','23:59','2020-02-05 18:02:51','2020-02-05 18:02:51',1,'2020-02-06'),(129,4,1,'2020-02-07','Ddfr',NULL,'17:02','23:59','2020-02-05 19:02:29','2020-02-05 19:02:29',0,'2020-02-07'),(130,3,1,'2020-02-17','Aniversário Rafael',NULL,'11:12','23:59','2020-02-17 14:12:09','2020-02-17 14:12:09',0,'2020-02-17'),(131,4,3,'2020-02-17','Fdtt',NULL,'11:39','23:59','2020-02-17 14:40:00','2020-02-17 14:40:00',0,'2020-02-17'),(132,4,3,'2020-02-17','Fgttt',NULL,'11:40','23:59','2020-02-17 14:40:18','2020-02-17 14:40:18',0,'2020-02-17'),(133,4,3,'2020-02-17','Cfff',NULL,'11:40','23:59','2020-02-17 14:40:52','2020-02-17 14:40:52',0,'2020-02-20'),(134,19,3,'2020-02-28','Jdjd',NULL,'11:01','23:59','2020-02-28 14:01:32','2020-02-28 14:01:32',0,'2020-02-28'),(135,127,5,'2020-03-08','Bdndnn',NULL,'14:05','23:59','2020-03-03 17:05:28','2020-03-03 17:05:28',1,'2020-03-08'),(136,127,5,'2020-03-03','Ghh',NULL,'14:06','23:59','2020-03-03 17:05:52','2020-03-03 17:05:52',1,'2020-03-04'),(137,127,5,'2020-03-03','Bzbz',NULL,'14:40','23:59','2020-03-03 17:39:55','2020-03-03 17:39:55',1,'2020-03-03'),(138,133,5,'2020-03-03','Ndnd',NULL,'14:47','23:59','2020-03-03 17:46:49','2020-03-03 17:46:49',0,'2020-03-03'),(139,1,3,'2020-03-03','Lista 2',NULL,'17:23','23:59','2020-03-03 20:22:29','2020-03-03 20:22:29',0,'2020-03-03'),(140,1,3,'2020-06-08','Dyhd',NULL,'10:49','23:59','2020-06-08 13:49:28','2020-06-08 13:49:28',0,'2020-06-08'),(141,4,1,'2020-06-10','Hggh',NULL,'16:49','23:59','2020-06-10 19:49:46','2020-06-10 19:49:46',1,'2020-06-10'),(142,4,1,'2020-06-10','Gghhb',NULL,'17:00','23:59','2020-06-10 20:00:11','2020-06-10 20:00:51',0,'2020-06-10'),(143,4,1,'2020-06-19','wqwqee',NULL,'11:35','23:59','2020-06-19 14:36:06','2020-06-19 14:36:06',1,'2020-06-19'),(144,4,1,'2020-06-19','qeqwe',NULL,'15:56','23:59','2020-06-19 18:56:43','2020-06-19 18:56:43',1,'2020-06-19'),(145,4,1,'2020-06-19','teste',NULL,'16:35','23:59','2020-06-19 19:36:41','2020-06-19 19:36:41',0,'2020-06-19'),(146,4,1,'2020-06-22','teste 01',NULL,'11:47','23:59','2020-06-22 14:47:15','2020-06-22 18:50:28',0,'2020-06-22'),(147,4,1,'2020-06-23','House',NULL,'10:01','23:59','2020-06-23 13:02:25','2020-06-23 15:36:27',0,'2020-06-23'),(148,4,1,'2020-06-24','Novo Teste',NULL,'08:32','23:59','2020-06-24 11:32:47','2020-06-24 11:32:47',0,'2020-06-27'),(149,4,1,'2020-06-24','New',NULL,'13:57','23:59','2020-06-24 16:58:10','2020-06-24 16:58:10',0,'2020-06-26'),(150,25,3,'2020-07-23','Teste evento',NULL,'11:21','23:59','2020-07-23 14:21:03','2020-07-23 14:21:03',0,'2020-07-23'),(151,4,1,'2020-08-27','Cjdjd',NULL,'14:40','23:59','2020-08-27 17:40:42','2020-08-27 17:40:42',1,'2020-08-27'),(152,4,1,'2020-10-13','Ftgyy',NULL,'12:30','23:00','2020-10-13 12:15:29','2020-10-13 15:31:34',0,'2020-10-14'),(153,4,1,'2020-10-13','Teste Agora',NULL,'12:33','23:59','2020-10-13 15:33:37','2020-10-13 19:10:42',0,'2020-10-13'),(154,175,1,'2020-11-19','Aniversário do Gabriel',NULL,'12:00','17:00','2020-10-16 13:34:27','2020-10-16 13:34:27',1,'2020-11-19'),(155,175,1,'2020-10-16','Aniversário do Gabriel',NULL,'10:37','23:59','2020-10-16 13:37:22','2020-10-16 13:39:03',0,'2020-10-16'),(156,4,1,'2020-10-19','Bom festa',NULL,'16:11','23:59','2020-10-19 20:11:45','2020-10-19 21:36:03',0,'2020-10-19'),(157,4,1,'2020-10-20','Churrasco das Coroas',NULL,'09:40','23:59','2020-10-20 13:40:40','2020-10-20 14:58:39',1,'2020-10-20'),(158,4,1,'2020-10-20','Teste Hoje',NULL,'14:22','23:59','2020-10-20 18:22:06','2020-10-20 18:32:27',0,'2020-10-20'),(159,4,1,'2020-10-21','edede',NULL,'16:43','23:59','2020-10-21 20:43:36','2020-10-21 20:43:36',1,'2020-10-21'),(160,4,1,'2020-10-21','Teste',NULL,'16:57','23:59','2020-10-21 20:57:59','2020-10-21 20:57:59',0,'2020-10-21'),(161,4,1,'2020-10-22','Festa',NULL,'08:34','23:59','2020-10-22 12:34:41','2020-10-22 18:12:11',1,'2020-10-22'),(162,4,1,'2020-10-22','Teste',NULL,'15:12','23:59','2020-10-22 19:12:34','2020-10-22 19:12:34',0,'2020-10-22'),(163,4,1,'2020-10-22','qeeqe',NULL,'15:12','23:59','2020-10-22 19:12:48','2020-10-22 19:12:48',0,'2020-10-22'),(164,4,1,'2020-10-22','Globo',NULL,'16:10','23:59','2020-10-22 20:10:45','2020-10-22 20:10:45',1,'2020-10-22'),(165,4,1,'2020-10-22','hg',NULL,'16:14','23:59','2020-10-22 20:14:50','2020-10-22 20:14:50',1,'2020-10-22'),(166,4,1,'2020-10-22','hg',NULL,'16:14','23:59','2020-10-22 20:15:29','2020-10-22 20:15:29',1,'2020-10-22'),(167,4,1,'2020-10-22','BB',NULL,'16:33','23:59','2020-10-22 20:34:02','2020-10-22 20:34:02',1,'2020-10-22'),(168,4,1,'2020-10-22','YY',NULL,'16:44','23:59','2020-10-22 20:44:54','2020-10-22 20:44:54',1,'2020-10-22'),(169,4,1,'2020-10-22','YY',NULL,'16:44','23:59','2020-10-22 20:45:23','2020-10-22 20:45:23',1,'2020-10-22'),(170,4,1,'2020-10-22','GG',NULL,'16:52','23:59','2020-10-22 20:52:59','2020-10-22 20:52:59',1,'2020-10-22'),(171,4,1,'2020-10-22','GG',NULL,'16:52','23:59','2020-10-22 20:53:52','2020-10-22 20:53:52',1,'2020-10-22'),(172,4,1,'2020-10-22','Routes',NULL,'16:55','23:59','2020-10-22 20:55:29','2020-10-22 20:55:29',1,'2020-10-22'),(173,4,1,'2020-10-22','Routes',NULL,'16:55','23:59','2020-10-22 20:56:24','2020-10-22 20:56:24',1,'2020-10-22'),(174,4,1,'2020-10-22','Festa Now',NULL,'17:02','23:59','2020-10-22 21:02:16','2020-10-22 21:02:16',1,'2020-10-22'),(175,4,1,'2020-10-22','Now',NULL,'17:07','23:59','2020-10-22 21:07:27','2020-10-22 21:07:27',1,'2020-10-22'),(176,4,1,'2020-10-22','Now',NULL,'17:07','23:59','2020-10-22 21:09:50','2020-10-22 21:09:50',1,'2020-10-22'),(177,4,1,'2020-10-22','Now',NULL,'17:07','23:59','2020-10-22 21:11:01','2020-10-22 21:11:01',1,'2020-10-22'),(178,4,1,'2020-10-22','Teste',NULL,'17:37','23:59','2020-10-22 21:38:21','2020-10-22 21:38:21',0,'2020-10-22'),(179,4,1,'2020-10-22','Teste',NULL,'17:37','23:59','2020-10-22 21:39:42','2020-10-22 21:39:42',0,'2020-10-22'),(180,4,1,'2020-10-23','TT',NULL,'09:03','23:59','2020-10-23 13:04:30','2020-10-23 13:04:30',1,'2020-10-23'),(181,4,1,'2020-10-23','TT',NULL,'09:03','23:59','2020-10-23 13:05:33','2020-10-23 13:05:33',1,'2020-10-23'),(182,4,1,'2020-10-23','RR',NULL,'09:24','23:59','2020-10-23 13:25:28','2020-10-23 13:25:28',1,'2020-10-23'),(183,4,1,'2020-10-23','RR',NULL,'09:24','23:59','2020-10-23 13:26:41','2020-10-23 13:26:41',1,'2020-10-23'),(184,4,1,'2020-10-23','Java',NULL,'09:41','23:59','2020-10-23 13:42:38','2020-10-23 13:43:40',1,'2020-10-23'),(185,4,1,'2020-10-23','PHP',NULL,'09:44','23:59','2020-10-23 13:44:46','2020-10-23 13:45:13',1,'2020-10-23'),(186,4,1,'2020-10-23','Gmail.com',NULL,'11:36','23:59','2020-10-23 15:36:28','2020-10-23 15:36:47',1,'2020-10-23'),(190,4,1,'2020-10-23','Home Office',NULL,'14:42','23:59','2020-10-23 18:42:48','2020-10-23 19:16:01',1,'2020-10-23'),(191,4,1,'2020-10-23','Home Office',NULL,'14:42','23:59','2020-10-23 18:45:44','2020-10-23 18:45:44',1,'2020-10-23'),(192,4,1,'2020-10-23','Home Office',NULL,'14:42','23:59','2020-10-23 19:03:04','2020-10-23 19:03:04',1,'2020-10-23'),(193,4,1,'2020-10-23','Two',NULL,'15:19','23:59','2020-10-23 19:19:36','2020-10-23 19:28:03',1,'2020-10-23'),(194,4,1,'2020-10-23','Teste',NULL,'15:37','23:59','2020-10-23 19:38:19','2020-10-23 19:41:12',1,'2020-10-23'),(195,4,1,'2020-10-23','Qedwdew',NULL,'15:48','23:59','2020-10-23 19:49:07','2020-10-23 19:51:34',1,'2020-10-23'),(196,4,1,'2020-10-23','Trewwerwqe',NULL,'16:05','23:59','2020-10-23 20:06:29','2020-10-23 20:06:59',1,'2020-10-23'),(197,4,1,'2020-10-23','eeqeqwe',NULL,'16:15','23:59','2020-10-23 20:15:07','2020-10-23 20:15:14',1,'2020-10-23'),(198,4,1,'2020-10-23','Teste',NULL,'16:20','23:59','2020-10-23 20:20:51','2020-10-23 20:24:38',1,'2020-10-23'),(199,4,1,'2020-10-23','NEW Console',NULL,'16:42','23:59','2020-10-23 20:43:27','2020-10-23 20:43:27',1,'2020-10-23'),(200,4,1,'2020-10-23','WEEK',NULL,'16:47','23:59','2020-10-23 20:48:11','2020-10-23 20:48:11',1,'2020-10-23'),(201,4,1,'2020-10-23','Teste',NULL,'16:51','23:59','2020-10-23 20:52:07','2020-10-23 20:53:46',1,'2020-10-23'),(202,4,1,'2020-10-23','2e1e21e',NULL,'16:55','23:59','2020-10-23 20:56:04','2020-10-23 21:00:06',1,'2020-10-23'),(203,4,1,'2020-10-23','qeqweqw',NULL,'17:02','23:59','2020-10-23 21:03:44','2020-10-23 21:04:34',1,'2020-10-23'),(204,4,1,'2020-10-23','Teste',NULL,'17:09','23:59','2020-10-23 21:10:05','2020-10-23 21:10:05',1,'2020-10-23'),(205,4,1,'2020-10-23','Teste',NULL,'17:13','23:59','2020-10-23 21:13:27','2020-10-23 21:13:57',1,'2020-10-23'),(206,4,1,'2020-10-23','Teste',NULL,'17:26','23:59','2020-10-23 21:26:44','2020-10-23 21:26:44',1,'2020-10-23'),(207,4,1,'2020-10-23','123123',NULL,'17:28','23:59','2020-10-23 21:28:47','2020-10-23 21:53:25',0,'2020-10-23'),(208,4,1,'2020-10-25','Aniv Malu',NULL,'17:30','00:00','2020-10-23 21:55:41','2020-10-23 22:05:56',1,'2020-10-26'),(209,4,1,'2020-10-26','Nova lista',NULL,'08:00','23:59','2020-10-26 12:34:04','2020-10-26 13:23:08',1,'2020-10-26'),(210,4,1,'2020-10-26','Teste Novo',NULL,'09:27','23:59','2020-10-26 13:27:17','2020-10-26 18:50:45',1,'2020-10-26'),(211,4,1,'2020-10-26','Zhhz',NULL,'09:27','23:59','2020-10-26 13:30:38','2020-10-26 13:30:38',0,'2020-10-26'),(212,4,1,'2020-10-26','Zhhz',NULL,'09:27','23:59','2020-10-26 13:45:44','2020-10-26 13:45:44',0,'2020-10-26'),(213,4,1,'2020-10-26','Teste',NULL,'10:57','23:59','2020-10-26 14:58:09','2020-10-26 14:58:09',1,'2020-10-26'),(214,4,1,'2020-10-26','Novas Ids',NULL,'14:40','23:59','2020-10-26 18:40:29','2020-10-26 18:40:29',0,'2020-10-26'),(215,4,9,'2020-10-26','localhost',NULL,'14:41','23:59','2020-10-26 18:42:08','2020-10-26 18:42:08',0,'2020-10-28'),(216,4,9,'2020-10-26','localhost',NULL,'14:41','23:59','2020-10-26 18:42:36','2020-10-26 18:42:36',1,'2020-10-28'),(217,4,1,'2020-10-26','Zoeira',NULL,'09:27','23:59','2020-10-26 18:43:07','2020-10-26 18:43:07',0,'2020-10-26'),(218,4,1,'2020-10-26','Aniv. Tia Ana',NULL,'15:04','23:59','2020-10-26 19:04:44','2020-10-26 19:04:44',0,'2020-10-26'),(219,4,1,'2020-10-26','Aniv. Tia Ana',NULL,'15:04','23:59','2020-10-26 19:04:50','2020-10-26 19:14:13',1,'2020-10-26'),(220,4,1,'2020-10-26','Teste',NULL,'15:15','23:59','2020-10-26 19:15:03','2020-10-26 19:15:03',0,'2020-10-26'),(221,4,1,'2020-10-26','eeqeqwe',NULL,'15:15','23:59','2020-10-26 19:15:41','2020-10-26 19:15:41',0,'2020-10-26'),(222,4,1,'2020-10-26','TeseEE',NULL,'15:26','23:59','2020-10-26 19:26:56','2020-10-26 19:32:02',1,'2020-10-26'),(223,4,1,'2020-10-26','Tese Now',NULL,'15:26','23:59','2020-10-26 19:39:49','2020-10-26 19:39:49',0,'2020-10-26'),(224,4,1,'2020-10-26','Aniv. Tia Ana',NULL,'15:04','23:59','2020-10-26 19:41:24','2020-10-26 19:41:24',0,'2020-10-26'),(225,4,1,'2020-10-26','TeseEE',NULL,'15:26','23:59','2020-10-26 19:45:48','2020-10-26 19:45:48',0,'2020-10-26'),(226,4,1,'2020-10-26','Festa Samba 01',NULL,'15:48','23:59','2020-10-26 19:48:27','2020-10-26 22:04:50',0,'2020-10-26'),(227,4,1,'2020-10-26','Festa Samba Mais',NULL,'15:48','23:59','2020-10-26 19:50:07','2020-10-26 19:50:07',0,'2020-10-26'),(228,4,1,'2020-10-26','Festa Fantasia',NULL,'16:01','23:59','2020-10-26 20:01:30','2020-10-26 20:01:50',0,'2020-10-26'),(229,4,1,'2020-10-26','Festa sem usuario',NULL,'16:15','23:59','2020-10-26 20:15:09','2020-10-26 20:15:09',0,'2020-10-26'),(230,4,1,'2020-10-26','Futebel Final de Semana',NULL,'16:23','23:59','2020-10-26 20:23:22','2020-10-26 21:44:26',0,'2020-10-26'),(231,4,1,'2020-10-26','Gghh',NULL,'17:38','23:59','2020-10-26 21:38:18','2020-10-26 21:38:18',0,'2020-10-26'),(232,4,1,'2020-10-27','Tomorrow',NULL,'09:51','23:59','2020-10-27 13:52:27','2020-10-27 21:57:51',0,'2020-10-27'),(233,4,1,'2020-10-28','Festas dos Devs',NULL,'08:18','23:59','2020-10-28 12:18:16','2020-10-28 19:54:27',0,'2020-10-28'),(234,4,1,'2020-10-29','Festa aniv. Julia',NULL,'08:16','23:59','2020-10-29 12:16:58','2020-10-29 15:54:10',0,'2020-10-29'),(235,4,1,'2020-10-29','Ejjejj',NULL,'11:12','23:59','2020-10-29 15:12:32','2020-10-29 15:54:42',0,'2020-10-29'),(236,4,1,'2020-11-05','Ghijj',NULL,'12:09','23:59','2020-11-05 15:08:49','2020-11-05 15:08:49',0,'2020-11-05'),(237,4,1,'2020-12-10','Frgg',NULL,'11:37','23:59','2020-12-10 15:37:12','2020-12-10 15:37:12',0,'2020-12-10'),(238,1,3,'2020-12-25','Jej',NULL,'10:05','23:59','2020-12-21 14:05:31','2020-12-21 14:05:39',0,'2020-12-25'),(239,19,14,'2021-02-17','Aniversário do Gabriel',NULL,'09:56','23:59','2021-02-17 13:58:01','2021-02-17 14:08:20',1,'2021-02-17'),(240,1,3,'2021-02-17','Aniversário do Bruno',NULL,'11:27','23:59','2021-02-17 15:27:54','2021-02-17 15:27:54',1,'2021-02-17'),(241,1,3,'2021-02-17','Aniversário do Bruno',NULL,'18:00','23:59','2021-02-17 15:29:28','2021-02-17 15:29:45',0,'2021-02-17');
/*!40000 ALTER TABLE `lista_convidados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localidades`
--

DROP TABLE IF EXISTS `localidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localidades` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  `id_externo` int(11) DEFAULT NULL,
  `row_version` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localidades`
--

LOCK TABLES `localidades` WRITE;
/*!40000 ALTER TABLE `localidades` DISABLE KEYS */;
INSERT INTO `localidades` VALUES (1,'JARDINS ATENAS',0,NULL,'2021-02-05 16:46:41'),(2,'Alphaville cruzeiro DO SUL',0,NULL,'2021-02-09 15:48:15');
/*!40000 ALTER TABLE `localidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_processos`
--

DROP TABLE IF EXISTS `log_processos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_processos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_inicio_processo` date NOT NULL,
  `data_fim_processo` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_processos`
--

LOCK TABLES `log_processos` WRITE;
/*!40000 ALTER TABLE `log_processos` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_processos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lpr`
--

DROP TABLE IF EXISTS `lpr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lpr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placa` varchar(16) NOT NULL,
  `datahora` datetime NOT NULL,
  `camera` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lpr`
--

LOCK TABLES `lpr` WRITE;
/*!40000 ALTER TABLE `lpr` DISABLE KEYS */;
INSERT INTO `lpr` VALUES (1,'FGH3321','2020-03-30 14:55:00',4),(2,'FGH3321','2020-03-30 14:56:00',4),(3,'PQZ9893','2020-03-30 13:57:00',5),(4,'PQZ9893','2020-03-30 13:58:00',5),(5,'FGH3321','2020-03-30 13:58:00',5),(6,'FGH3321','2020-03-30 14:59:00',4),(7,'FGH3321','2020-03-30 15:00:00',5),(8,'FGH3321','2020-03-30 15:01:00',4),(9,'FGH3321','2020-03-30 15:02:00',5),(10,'PQZ9893','2020-03-30 15:03:00',4),(11,'PQZ9893','2020-03-30 15:04:00',4),(12,'PQZ9893','2020-03-30 15:05:00',5),(13,'PQZ9893','2020-03-30 15:05:00',4),(14,'PQZ9893','2020-03-30 15:07:00',4),(15,'PQZ9893','2020-03-30 15:07:00',4),(16,'PQZ9893','2020-03-30 15:08:00',5),(17,'PQZ9893','2020-03-30 15:09:00',5),(18,'PQZ9893','2020-03-30 15:09:00',4),(19,'PQZ9893','2020-03-30 15:10:00',5),(20,'PQZ9893','2020-03-30 15:10:00',4),(21,'PQZ9893','2020-03-30 15:11:00',5),(22,'PQZ9893','2020-03-30 15:11:00',4),(23,'PQZ9893','2020-03-30 15:11:00',4),(24,'PQZ9893','2020-03-30 15:13:00',4),(25,'PQZ9893','2020-03-30 15:14:00',5),(26,'PQZ9893','2020-03-30 15:15:00',5),(27,'PQZ9893','2020-03-30 15:15:00',4),(28,'PQZ9893','2020-03-30 15:16:00',5),(29,'PQZ9893','2020-03-30 15:16:00',4),(30,'PQZ9893','2020-03-30 15:16:00',5),(31,'PQZ9893','2020-03-30 15:17:00',5),(32,'PQZ9893','2020-03-30 15:17:00',4),(33,'PQZ9893','2020-03-30 15:18:00',5),(34,'PQZ9893','2020-03-30 15:18:00',4),(35,'PQZ9893','2020-03-30 15:19:00',5),(36,'PQZ9893','2020-03-30 15:19:00',4),(37,'PQZ9893','2020-03-30 15:20:00',4),(38,'PQZ9893','2020-03-30 15:20:00',4),(39,'PQZ9893','2020-03-30 15:21:00',5),(40,'PQZ9893','2020-03-30 15:22:00',5),(41,'PQZ9893','2020-03-30 15:23:00',4),(42,'PQZ9893','2020-03-30 15:24:00',5),(43,'PQZ9893','2020-03-30 15:25:00',4),(44,'PQZ9893','2020-03-30 15:25:00',4),(45,'PQZ9893','2020-03-30 17:21:00',4),(47,'ABM2092','2020-04-06 14:54:41',5),(48,'ABM2092','2020-04-06 14:55:09',8),(49,'ABM2092','2020-04-06 15:01:17',5),(50,'ABM2092','2020-04-06 15:03:32',8),(51,'ABM2092','2020-04-06 15:05:27',5),(52,'ABM2092','2020-04-06 15:05:56',5),(53,'ABM2092','2020-04-09 14:30:00',5),(54,'ABM2092','2020-04-09 14:33:00',5),(55,'ABM2092','2020-04-09 14:33:00',5),(56,'ABM2092','2020-04-09 14:37:00',5),(57,'ABM2092','2020-04-09 14:38:00',5),(58,'ABM2092','2020-04-09 14:39:00',8),(59,'ABM2092','2020-04-09 14:38:00',5),(60,'ABM2092','2020-04-17 14:24:42',8),(61,'ABM2092','2020-04-17 14:25:13',8),(62,'ABM2092','2020-04-17 14:28:36',5),(63,'ABM2092','2020-04-17 14:29:14',8),(64,'ABM2092','2020-04-17 14:34:34',5),(65,'ABM2092','2020-04-17 14:36:01',5),(66,'ABM2092','2020-04-17 14:36:30',8),(67,'ABM2092','2020-04-17 14:40:55',5),(68,'ABM2092','2020-04-17 14:41:31',8),(69,'ABM2092','2020-04-17 14:42:32',5),(70,'ABM2092','2020-04-17 14:43:09',8),(71,'ABM2092','2020-04-17 14:43:40',5),(72,'ABM2092','2020-04-17 14:44:04',8),(73,'ABM2092','2020-04-17 14:55:43',5),(74,'ABM2092','2020-04-17 14:55:56',5),(75,'ABM2092','2020-04-17 14:57:47',5),(76,'ABM2092','2020-04-17 14:58:27',8),(77,'ABM2092','2020-04-17 14:59:46',5),(78,'ABM2092','2020-04-17 15:00:33',8),(79,'ABM2092','2020-04-17 15:07:13',5),(80,'ABM2092','2020-04-17 15:07:48',8),(81,'ABM2092','2020-04-17 15:55:51',5),(82,'ABM2092','2020-04-17 15:56:18',8),(83,'ABM2092','2020-04-17 15:56:45',5),(84,'ABM2092','2020-04-17 15:57:20',8),(85,'ABM2092','2020-04-17 15:59:10',5),(86,'ABM2092','2020-04-17 15:59:48',8),(87,'FGH3321','2020-04-17 16:17:22',5),(88,'FGH3321','2020-04-17 16:18:14',8),(89,'FGH3321','2020-04-17 16:51:01',5),(90,'FGH3321','2020-04-17 16:51:41',8),(91,'FGH3321','2020-04-17 17:01:17',8),(92,'FGH3321','2020-04-17 17:02:36',8),(93,'FGH3321','2020-04-17 17:55:50',8),(94,'FGH3321','2020-04-17 17:56:55',8),(95,'FGH3321','2020-04-17 18:00:01',8),(96,'FGH3321','2020-04-17 18:00:53',8),(97,'FGH3321','2020-04-17 18:02:12',8),(98,'FGH3321','2020-04-17 18:02:53',8),(99,'FGH3321','2020-04-17 18:05:54',8),(100,'FGH3321','2020-04-17 18:06:46',8),(101,'FGH3321','2020-04-17 18:11:06',8),(102,'FGH3321','2020-04-17 18:46:16',8),(103,'FGH3321','2020-04-17 18:46:28',8),(104,'FGH3321','2020-04-17 18:47:12',8),(105,'FGH3321','2020-04-17 18:49:00',5),(106,'FGH3321','2020-04-17 18:49:27',8),(107,'FGH3321','2020-04-17 18:49:52',5),(108,'FGH3321','2020-04-17 18:50:20',5),(109,'FGH3321','2020-04-17 18:50:50',8),(110,'FGH3321','2020-04-17 18:51:23',8),(111,'FGH3321','2020-04-17 18:51:49',5),(112,'FGH3321','2020-04-17 18:52:04',5),(113,'FGH3321','2020-04-17 18:52:23',8),(114,'FGH3321','2020-04-17 18:53:32',5),(115,'FGH3321','2020-04-17 18:54:38',8),(116,'FGH3321','2020-04-17 18:54:48',5),(117,'FGH3321','2020-04-17 19:02:09',5),(118,'FGH3321','2020-04-17 19:02:31',8),(119,'FGH3321','2020-04-17 19:03:27',5),(120,'FGH3321','2020-04-17 19:05:03',8),(121,'FGH3321','2020-04-17 19:05:16',5),(122,'FGH3321','2020-04-20 12:43:26',5),(123,'FGH3321','2020-04-20 12:43:58',5),(124,'FGH3321','2020-04-20 12:44:59',5),(125,'FGH3321','2020-04-20 12:45:20',5),(126,'FGH3321','2020-04-20 12:46:58',5),(127,'FGH3321','2020-04-20 12:47:13',5),(128,'FGH3321','2020-04-20 12:48:05',5),(129,'FGH3321','2020-04-20 12:55:45',5),(130,'FGH3321','2020-04-20 12:56:15',5),(131,'FGH3321','2020-04-20 12:56:54',5),(132,'FGH3321','2020-04-20 12:56:59',5),(133,'FGH3321','2020-04-20 12:57:05',5),(134,'FGH3321','2020-04-20 14:52:15',5),(135,'FGH3321','2020-04-20 15:01:43',5),(136,'FGH3321','2020-04-20 15:03:41',5),(137,'FGH3321','2020-04-20 15:04:57',5),(138,'FGH3321','2020-04-20 15:05:27',5),(139,'FGH3321','2020-04-20 15:08:22',5),(140,'FGH3321','2020-04-20 15:17:42',5),(141,'FGH3321','2020-04-20 15:19:59',5),(142,'FGH3321','2020-04-20 15:21:33',5),(143,'FGH3321','2020-04-20 15:34:26',5),(144,'FGH3321','2020-04-20 15:34:55',8),(145,'FGH3321','2020-04-20 15:35:45',5),(146,'FGH3321','2020-04-20 15:44:03',5),(147,'FGH3321','2020-04-20 15:45:15',5),(148,'FGH3321','2020-04-20 15:47:39',5),(149,'FGH3321','2020-04-20 16:05:58',5),(150,'FGH3321','2020-04-20 16:07:49',5),(151,'FGH3321','2020-04-20 16:12:13',5),(152,'FGH3321','2020-04-20 16:13:16',5),(153,'FGH3321','2020-04-20 16:16:03',5),(154,'FGH3321','2020-04-20 16:16:32',5),(155,'FGH3321','2020-04-20 16:19:05',5),(156,'FGH3321','2020-04-20 16:21:13',5),(157,'FGH3321','2020-04-20 16:31:36',5),(158,'FGH3321','2020-04-09 14:39:00',8),(159,'FGH3321','2020-04-20 16:39:44',5),(160,'FGH3321','2020-04-09 14:39:00',8),(161,'FGH3321','2020-04-20 16:47:11',5),(162,'FGH3321','2020-04-20 16:51:39',5),(163,'FGH3321','2020-04-20 16:52:55',5),(164,'FGH3321','2020-04-20 16:55:16',5),(165,'FGH3321','2020-04-20 16:55:29',8),(166,'FGH3321','2020-04-20 16:55:51',5),(167,'PQJ7777','2020-04-09 14:39:00',8),(168,'PQJ7777','2020-04-09 14:39:00',8),(169,'FGH3321','2020-04-20 17:09:44',5),(170,'PQJ7777','2020-04-09 14:39:00',8),(171,'PQJ7777','2020-04-09 14:39:00',8),(172,'PQJ7777','2020-04-09 14:39:00',8),(173,'PQJ7777','2020-04-09 14:39:00',8),(174,'PQJ7777','2020-04-09 14:39:00',8),(175,'FGH3321','2020-04-20 17:19:50',5),(176,'FGH3321','2020-04-20 17:38:23',5),(177,'FGH3321','2020-04-20 17:51:13',5),(178,'FGH3321','2020-04-20 17:54:06',5),(179,'FGH3321','2020-04-20 17:55:53',8),(180,'FGH3321','2020-04-20 17:56:20',5),(181,'FGH3321','2020-04-20 17:57:30',5),(182,'FGH3321','2020-04-20 17:58:28',5),(183,'FGH3321','2020-04-20 18:01:26',5),(184,'FGH3321','2020-04-20 18:07:18',5),(185,'FGH3321','2020-04-20 18:07:24',8),(186,'FGH3321','2020-04-20 18:10:51',8),(187,'FGH3321','2020-04-20 18:12:32',5),(188,'PQJ7777','2020-04-09 14:39:00',8),(189,'FGH3321','2020-04-20 18:17:40',5),(190,'FGH3321','2020-04-20 18:19:50',8),(191,'FGH3321','2020-04-20 18:21:08',5),(192,'FGH3321','2020-04-20 18:26:04',8),(193,'FGH3321','2020-04-20 18:26:14',5),(194,'FGH3321','2020-04-20 18:29:01',8),(195,'FGH3321','2020-04-20 18:29:09',5),(196,'FGH3321','2020-04-20 18:34:02',8),(197,'FGH3321','2020-04-20 18:34:08',5),(198,'FGH3321','2020-04-20 18:37:59',8),(199,'FGH3321','2020-04-20 18:38:19',5),(200,'FGH3321','2020-04-20 18:39:51',5),(201,'FGH3321','2020-04-20 18:40:25',8),(202,'FGH3321','2020-04-20 18:41:00',8),(203,'FGH3321','2020-04-20 18:41:19',5),(204,'FGH3321','2020-04-20 18:43:07',5),(205,'FGH3321','2020-04-20 18:43:43',8),(206,'FGH3321','2020-04-20 21:55:33',5),(207,'FGH3321','2020-04-22 09:50:58',5),(208,'FGH3321','2020-04-22 09:51:41',5),(209,'FGH3321','2020-04-22 09:52:21',5),(210,'FGH3321','2020-04-22 09:52:58',5),(211,'FGH3321','2020-04-22 09:53:27',8),(212,'FGH3321','2020-04-22 09:56:20',5),(213,'FGH3321','2020-04-22 09:56:39',8),(214,'FGH3321','2020-04-22 09:58:40',8),(215,'FGH3321','2020-04-22 10:00:31',8),(216,'FGH3321','2020-04-22 10:02:22',8),(217,'FGH3321','2020-04-22 10:03:41',8),(218,'FGH3321','2020-04-22 10:04:19',8),(219,'FGH3321','2020-04-22 10:09:14',8),(220,'FGH3321','2020-04-22 10:11:33',8),(221,'FGH3321','2020-04-22 10:13:12',8),(222,'FGH3321','2020-04-22 10:14:08',8),(223,'FGH3321','2020-04-22 10:15:54',8),(224,'FGH3321','2020-04-22 10:18:38',8),(225,'FGH3321','2020-04-22 10:19:12',8),(226,'FGH3321','2020-04-22 10:19:38',8),(227,'FGH3321','2020-04-22 10:21:36',8),(228,'FGH3321','2020-04-22 10:22:09',8),(229,'FGH3321','2020-04-22 11:04:55',8),(230,'FGH3321','2020-04-22 11:05:11',8),(231,'FGH3321','2020-04-22 11:06:02',8),(232,'FGH3321','2020-04-22 11:06:23',8),(233,'FGH3321','2020-04-22 11:11:43',8),(234,'ABM2092','2020-04-09 14:38:00',5),(235,'ABM2092','2020-04-22 12:32:50',5),(236,'ABM2092','2020-04-22 12:33:29',5),(237,'ABM2092','2020-04-22 12:33:49',5),(238,'ABM2092','2020-04-22 12:35:53',5),(239,'ABM2092','2020-04-22 12:36:04',5),(240,'ABM2092','2020-04-22 12:36:37',5),(241,'ABM2092','2020-04-22 14:22:40',5),(242,'ABM2092','2020-04-22 14:23:15',5),(243,'ABM2092','2020-04-22 14:23:38',8),(244,'ABM2092','2020-04-22 14:24:54',8),(245,'ABM2092','2020-04-22 14:25:11',8),(246,'ABM2092','2020-04-22 14:31:03',8),(247,'ABM2092','2020-04-22 14:32:07',8),(248,'ABM2092','2020-04-22 14:49:56',5),(249,'ABM2092','2020-04-22 14:50:16',8),(250,'ABM2092','2020-04-22 14:51:24',5),(251,'ABM2092','2020-04-22 15:01:55',5),(252,'ABM2092','2020-04-22 15:02:12',8);
/*!40000 ALTER TABLE `lpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2017_01_30_080147_create_grupo_lancamentos_table',1),(2,'2017_01_30_080149_create_tipo_lancamentos_table',1),(3,'2017_01_30_080150_create_tipo_inadimplencias_table',1),(4,'2017_01_30_080212_create_lancamentos_table',1),(5,'2017_01_30_080213_create_lancamento_recorrentes_table',1),(6,'2017_01_30_080216_create_dados_cheques_table',1),(7,'2017_01_30_080217_create_formulas_table',1),(8,'2017_01_30_090223_create_grupo_calculo',1),(9,'2017_01_30_090312_create_condominio_configuracoes',1),(10,'2017_01_30_092333_create_pre_lancamentos_table',1),(11,'2017_01_30_101456_create_lancamentos_estimados_table',1),(12,'2017_01_30_135848_create_grupo_calculo_imoveis_table',1),(13,'2017_01_30_154417_create_situacao_inadimplencias_table',1),(14,'2017_01_30_171820_create_bancos_table',1),(15,'2017_01_30_171821_create_conta_bancarias_table',1),(16,'2017_01_30_171822_create_layout_remessas_table',1),(17,'2017_01_30_171823_create_layout_retornos_table',1),(18,'2017_01_30_171824_create_carteiras_table',1),(19,'2017_01_30_171825_create_configuracao_carteiras_table',1),(20,'2017_01_30_171826_create_lancamento_avulsos_table',1),(21,'2017_01_30_171826_create_recebimentos_table',1),(22,'2017_01_30_171829_create_transferencias_table',1),(23,'2017_01_30_171833_create_movimentacaos_table',1),(24,'2017_01_30_171834_create_receitas_table',1),(25,'2017_01_30_173444_create_informativo_table',1),(26,'2017_01_30_193813_create_unidade_produtos_table',1),(27,'2017_01_30_193817_create_grupo_produtos_table',1),(28,'2017_01_30_193821_create_produtos_table',1),(29,'2017_01_30_193826_create_departamentos_table',1),(30,'2017_01_30_193831_create_feriados_table',1),(31,'2017_01_30_194413_create_receita_calculos_table',1),(32,'2017_01_30_202550_create_lancamento_taxas_table',1),(33,'2017_01_30_202622_create_lancamento_fundo_table',1),(34,'2017_01_30_210127_create_contas_receber_table',1),(35,'2017_01_31_154121_create_lancamentos_contas_receber',1),(36,'2017_01_31_180726_create_recebimento_parcelas',1),(37,'2017_01_31_180727_create_parcela_cheques',1),(38,'2017_01_31_180728_create_parcela_boletos',1),(39,'2017_01_31_180729_create_baixas_table',1),(40,'2017_01_31_192713_create_recebimento_lancamentos',1),(41,'2017_02_07_154549_create_lancamento_agendar_table',1),(42,'2017_02_07_154550_create_parcela_pagar_table',1),(43,'2017_03_03_160931_set_id_lancamento_agendar_on_delete_on_parcela_pagar_table',1),(44,'2017_03_07_160505_create_acrescimo_pagar_table',1),(45,'2017_03_08_144254_alter_numero_comprovante_parcela_pagar_table',1),(46,'2017_03_09_152846_set_id_lancamento_agendar_on_delete_acrescimo_pagar_table',1),(47,'2017_03_10_183346_add_incluir_soma_acrescimo_pagar_table',1),(48,'2017_03_11_142417_alter_parcela_pagar_table',1),(49,'2017_03_11_144805_add_numero_cheque_parcela_pagar_table',1),(50,'2017_03_14_103057_create_estimados_table',1),(51,'2017_03_15_161952_alter_numero_nf_lancamento_agendar_table',1),(52,'2017_03_17_163545_create_log_processos_table',1),(53,'2017_03_23_103728_add_email_enviado_parcela_boleto_table',1),(54,'2017_04_03_102513_add_id_remessa_configuracao_carteiras_table',1),(55,'2017_04_07_105542_alter_descricao_tipo_lancamento_table',1),(56,'2017_04_26_144357_add_id_empresa_lancamento_avulso_table',1),(57,'2017_04_26_145321_alter_id_imovel_lancamento_avulsos_table',1),(58,'2017_04_26_155030_add_id_empresa_recebimentos_table',1),(59,'2017_04_26_171016_add_id_empresa_contas_receber_table',1),(60,'2017_04_26_171320_alter_id_imovel_contas_receber_table',1),(61,'2017_04_27_160604_alter_nosso_numero_parcela_boletos_table',1),(62,'2017_04_27_173718_create_arquivo_retornos_table',1),(63,'2017_04_27_173749_create_titulos_processados_table',1),(64,'2017_05_02_161559_add_situacao_inadimplencia_recebimento_parcelas_table',1),(65,'2017_05_03_164059_add_numero_controle_parcela_boletos_table',1),(66,'2017_05_03_174011_add_nosso_numero_boleto_parcela_boletos_table',1),(67,'2017_05_09_162248_alter_id_banco_parcela_cheques_table',1),(68,'2017_05_09_170114_create_recebimento_acordo_table',1),(69,'2017_05_09_181533_alter_titulos_processados_table',1),(70,'2017_05_10_180126_create_acordos_table',1),(71,'2017_05_11_141924_create_tipo_documentos_table',1),(72,'2017_05_16_133123_add_id_tipo_documento_lancamento_agendar',1),(73,'2017_05_17_135613_add_tipo_cobranca_lancamento_avulsos',1),(74,'2017_05_17_145024_alter_especie_doc_parcela_boletos',1),(75,'2017_05_19_143934_create_carta_cobrancas_table',1),(76,'2017_05_23_164658_create_registro_cobrancas_table',1),(77,'2017_05_25_134409_create_quitacao_documentos_table',1),(78,'2017_05_29_170014_create_lancamento_antigos_table',1),(79,'2017_05_29_171149_create_lancamento_antigo_lancamentos_table',1),(80,'2017_05_29_184003_add_categoria_lancamentos_table',1),(81,'2017_05_31_123251_add_valor_total_lancamento_antigos',1),(82,'2017_06_01_160946_create_send_emails_table',1),(83,'2017_06_06_160148_drop_menssagem_send_emails_table',1),(84,'2017_06_08_104633_drop_columns_recebimento_table',1),(85,'2017_06_08_105455_add_columns_recebimento_parcelas_table',1),(86,'2017_06_08_105525_add_columns_contas_receber_table',1),(87,'2017_06_12_162349_add_adicional_observacao_recebimento_parcelas_table',1),(88,'2017_06_13_090512_add_columns_contas_receber',1),(89,'2017_06_13_091247_add_columns_recebimento_parcelas',1),(90,'2017_06_14_153039_alter_column_categoria_lancamentos_table',1),(91,'2017_06_14_170642_add_column_valor_original_contas_receber',1),(92,'2017_06_14_173754_add_column_data_vencimento_original_parcela_boletos_table',1),(93,'2017_06_16_171714_add_valor_origem_parcela_boletos_table',1),(94,'2017_06_30_095833_drop_columns_acordos',1),(95,'2017_06_30_112333_drop_table_recebimento_acordos',1),(96,'2017_06_30_112519_create_acordo_parcelas_negociadas_table',1),(97,'2017_07_02_231903_add_column_id_imovel_acordos_table',1),(98,'2017_07_04_193826_update_produtos_table',1),(99,'2017_07_04_193827_alter_quantidade_min_produtos_table',1),(100,'2017_07_04_193827_update_produtos_quantidade_table',1),(101,'2017_07_05_193821_create_area_table',1),(102,'2017_07_05_193823_create_colunas_table',1),(103,'2017_07_05_193824_create_sequencia_table',1),(104,'2017_07_05_193825_create_rua_table',1),(105,'2017_07_05_193826_create_niveis_table',1),(106,'2017_07_07_193826_create_imagem_produtos_table',1),(107,'2017_07_07_193827_create_aprovador_table',1),(108,'2017_07_13_193827_create_pedido_table',1),(109,'2017_07_13_193828_create_item_pedido_table',1),(110,'2017_07_27_193828_create_fornecedor_pedido_table',1),(111,'2017_07_27_193927_update_fornecedor_pedidos_table',1),(112,'2017_07_27_194028_create_item_fornecedor_pedido_table',1),(113,'2017_07_31_194127_update_fornecedor_pedidos_status_table',1),(114,'2017_08_02_194327_update_produtos_niveis_table',1),(115,'2017_08_09_173438_add_deleted_at_parcela_boletos_table',1),(116,'2017_08_09_180208_add_deleted_at_recebimento_parcelas_table',1),(117,'2017_08_10_092437_add_delete_at_contas_receber_table',1),(118,'2017_08_30_094853_alter_image_informativo_table',1),(119,'2017_09_01_193927_alter_pedidos_estimativa_table',1),(120,'2017_09_01_193931_alter_fornecedor_pedidos_campos_valores_table',1),(121,'2017_09_06_193826_alter_grupos_table',1),(122,'2017_09_06_193831_alter_produtos_table_add_observacoes',1),(123,'2017_09_11_193831_alter_pedidos_table_change_status',1),(124,'2017_09_21_152451_alter_valores_titulos_processados_table',1),(125,'2017_09_27_101520_add_columns_mes_ano_pre_lancamento',1),(126,'2017_09_28_100724_drop_column_data_expiracao_lancamento_recorrentes',1),(127,'2017_09_28_100751_create_columns_lancamento_recorrentes',1),(128,'2017_09_29_111857_alter_column_fixo_to_rateio_lancamento_recorrentes',1),(129,'2017_10_03_173808_add_forma_pagamento_origem_parcela_pagar',1),(130,'2017_10_04_142403_create_patrimonios_table',1),(131,'2017_10_04_145444_create_patrimonios_manutencoes_table',1),(132,'2017_10_04_150653_create_patrimonios_baixas_table',1),(133,'2017_10_04_151223_create_patrimonios_historicos_table',1),(134,'2017_10_13_110106_add_column_fixo_lancamento_recorrente',1),(135,'2017_10_17_180807_alter_column_id_conta_bancaria_configuracao_carteira_table',1),(136,'2017_10_19_160008_alter_column_id_situacao_inadimplencia_recebimento_parcelas_table',1),(137,'2017_10_22_012902_create_patrimonios_apolices_table',1),(138,'2017_10_22_012933_create_patrimonios_apolices_patrimonios_table',1),(139,'2017_10_27_180450_add_valor_titulo_origem_titulos_processados_table',1),(140,'2017_11_17_110649_create_qntAtual_produto',1),(141,'2017_11_20_152433_create_estoque_movimentacao',1),(142,'2017_11_20_155708_create_estoque_movimentacao_produto',1),(143,'2017_11_23_175221_add_descricao_lancamento_antigos_table',1),(144,'2017_11_24_094743_create_fluxo_caixa_table',1),(145,'2017_11_27_103217_add_id_lancamento_agendar_to_pedidos_table',1),(146,'2017_11_27_134922_add_column_img_bancos_table',1),(147,'2017_11_28_175212_add_and_alter_columns_conta_bancarias_table',1),(148,'2017_11_29_172129_add_status_parcela_boleto_table',1),(149,'2017_11_29_173513_add_nosso_numero_origem_parcela_boleto_table',1),(150,'2017_12_11_111220_alter_collun_imagem_produtos',1),(151,'2017_12_14_114115_add_colums_receita_table',1),(152,'2017_12_14_162005_add_colums_recebimento_parcelas_table',1),(153,'2017_12_14_162511_add_colums_valores_contas_receber_table',1),(154,'2017_12_18_115312_alter_collun_observacoes_produtos_table',1),(155,'2017_12_21_102316_add_column_data_saldo_inicial_conta_bancarias',1),(156,'2018_01_11_160005_alter_column_previsao_retorno_patimonios_manutencoes_table',1),(157,'2018_01_17_144125_add_column_referente_fluxo_caixa_table',1),(158,'2018_01_18_162128_add_index_key_fluxo_caixa_table',1),(159,'2018_05_11_151800_create_solicitacoes_table',1),(160,'2018_05_11_154029_add_column_id_solicitacao_pedidos_table',1),(161,'2018_05_14_141508_alter_pedidos_table',1),(162,'2018_05_18_100750_add_columns_pedidos_table',1),(163,'2018_06_01_152338_add_column_motivo_negado_pedidos_table',1),(164,'2018_06_05_113050_alter_column_tipo_aprovadors_table',1),(165,'2018_06_11_000756_adf_column_email_aprovadors_table',1),(166,'2018_07_23_165709_add_valor_percentual_pre_lancamento_table',1),(167,'2018_11_28_163735_add_dt_pagamento_titulos_processado_table',1),(168,'2018_08_21_173157_create_conta_recebimentos_table',2),(169,'2018_08_22_104843_alter_foreign_key_id_recebimento',2),(170,'2018_08_23_110909_delete_columns_recebimento_parcelas',2),(171,'2018_08_27_140736_add_column_parcela_num_to_parcela_boletos_table',2),(172,'2018_08_29_161356_add_column_updated_at_parcela_boletos',2),(173,'2018_09_21_101758_alter_email_empresa_table',2),(174,'2018_09_21_104248_add_column_id_empresa_send_emails_table',2),(175,'2018_10_04_103542_add_column_periodo_competencia_alter_column_tipo_apuracao_table_condominio_configuracoes',2),(176,'2018_11_28_153123_add_column_fatura_der_tipo_lancamentos_table',2),(177,'2020_05_13_000351_update_dados_cheques_table',2),(178,'2020_05_13_001021_update_pre_lancamentos_table',2),(179,'2020_05_13_001337_update_conta_bancarias_table',2),(180,'2020_05_13_001844_update_transferencias_table',2),(181,'2020_05_13_002219_update_movimentacaos_table',2),(182,'2020_05_13_002604_update_baixas_table',2),(183,'2020_05_13_003801_update_lancamentos_table',2),(184,'2020_05_13_004056_update_grupo_calculo_table',2),(185,'2020_05_13_004343_update_lancamentos_estimados_table',2),(186,'2020_05_13_004503_update_receitas_table',2),(187,'2020_05_13_004702_update_receita_calculos_table',2),(188,'2020_05_13_005829_update_contas_receber_table',2),(189,'2020_05_13_010107_update_recebimento_parcelas_table',2),(190,'2020_05_13_010244_update_parcela_boletos_table',2),(191,'2020_05_13_010518_update_lancamento_agendar_table',2),(192,'2020_05_13_010645_update_parcela_pagar_table',2),(193,'2020_05_13_010833_update_acrescimo_pagar_table',2),(194,'2020_05_13_011825_update_estimados_table',2),(195,'2020_05_13_011957_update_titulos_processados_table',2),(196,'2020_05_13_012904_update_acordos_table',2),(197,'2020_05_13_013210_update_lancamento_antigos_table',2),(198,'2020_05_13_223512_update_patrimonios_table',2),(199,'2020_05_13_223855_update_patrimonios_manutencoes_table',2),(200,'2020_05_14_230315_update_patrimonios_baixas_table',2),(201,'2020_05_14_230631_update_patrimonios_apolices_table',2),(202,'2020_05_14_230903_update_estoque_movimentacao_table',2),(203,'2020_05_14_231010_update_estoque_movimentacao_produto_table',2),(204,'2020_05_14_231137_update_fluxo_caixa_table',2),(205,'2020_05_17_214950_update_tipo_lancamentos_table',2),(206,'2020_05_17_215058_update_lancamento_recorrentes_table',2),(207,'2020_05_17_215136_update_condominio_configuracoes_table',2),(208,'2020_05_17_220018_update_atual_produtos_table',2),(209,'2020_05_17_220356_update_pedidos_table',2),(210,'2020_05_17_220510_update_item_pedidos_table',2),(211,'2020_05_17_220608_update_atual_fornecedor_pedidos_table',2),(212,'2020_05_17_221206_update_conta_recebimentos_table',2),(213,'2020_05_17_222921_update_informativo_table',2),(214,'2020_05_26_024830_drop_recebimentos_table',2),(215,'2020_05_26_024906_drop_contas_receber_table',2),(216,'2020_05_31_170129_drop_lancamentos_contas_receber_table',2),(217,'2020_06_02_011944_drop_recebimento_lancamentos_table',2),(218,'2020_06_22_003034_rename_column_id_recebimento_acordos_table',2),(219,'2020_07_16_232540_create_boletos_lancamentos_table',2),(220,'2020_08_27_001758_add_column_descricao_conta_recebimentos_table',2),(221,'2020_10_05_232946_create_centro_custos_table',2),(222,'2020_10_05_233408_add_id_centro_custo_to_lancamentos_table',2),(223,'2020_10_06_161209_add_permanente_to_lancamentos_table',2),(224,'2020_10_13_160319_create_creditos_table',2),(225,'2020_10_13_160410_add_motivo_cancelamento_to_recebimento_parcelas_table',2),(226,'2020_10_13_173615_add_data_cancelamento_to_recebimento_parcelas_table',2),(227,'2020_10_21_011008_add_column_gerenciamento_arvore_centro_custos_receitas_table',2),(228,'2020_10_27_164937_add_id_centro_custo_pre_lancamentos_table',2),(229,'2020_10_27_165030_add_id_centro_custo_lancamentos_recorrentes_table',2),(230,'2020_11_10_140815_add_columns_plano_contas_pai_tipo_lancamentos_table',2),(231,'2020_11_11_161811_add_column_gerenciamento_arvore_plano_contas_receitas_table',2),(232,'2020_11_12_173347_drop_column_id_grupolancamento_lancamentos_estimados_table',2),(233,'2020_11_12_181246_drop_column_id_grupolancamento_estimados_table',2),(234,'2020_11_13_165103_drop_grupo_lancamentos_table',2),(235,'2020_11_19_143102_create_plano_contas_table',2),(236,'2020_11_19_143125_rename_tipo_lancamentos_to_contas_table',2),(237,'2020_11_19_143140_create_contas_especiais_table',2),(238,'2020_11_20_142211_update_id_tipolancamento_estimados_table',2),(239,'2020_11_20_150018_update_id_tipolancamento_lancamentos_estimados_table',2),(240,'2020_11_20_150229_update_id_tipo_lancamento_lancamento_agendar_table',2),(241,'2020_11_20_150531_update_idtipo_lancamento_lancamentos_table',2),(242,'2020_11_20_151502_update_all_contas_receitas_table',2),(243,'2020_11_20_154925_update_id_tipo_lancamento_acrescimo_pagar_table',2),(244,'2020_11_20_155226_update_all_contas_grupo_calculo_table',2),(245,'2020_11_25_163409_drop_gerenciamento_arvore_plano_contas_receitas_table',2),(246,'2020_11_25_174937_add_softdeletes_centro_custos_table',2),(247,'2020_12_07_164245_add_id_plano_contas_to_lancamento_recorrentes_table',2),(248,'2020_12_07_185213_add_id_contas_to_pre_lancamentos_table',2),(249,'2020_12_10_154657_add_column_id_centro_custo_to_lancamento_agendar_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulo_sistema`
--

DROP TABLE IF EXISTS `modulo_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulo_sistema` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_categoria` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulo_sistema`
--

LOCK TABLES `modulo_sistema` WRITE;
/*!40000 ALTER TABLE `modulo_sistema` DISABLE KEYS */;
INSERT INTO `modulo_sistema` VALUES (1,'cadastro','Cadastro','p'),(3,'cadastro_morador','Cadastro Morador','s'),(4,'cadastro_temporario','Cadastro Temporário','s'),(5,'cadastro_permanente','Cadastro Permanente','s'),(7,'cadastro_veiculo','Cadastro Veiculo','s'),(9,'cadastro_animal','Cadastro Animal','s'),(11,'cadastro_imovel','Cadastro Imóvel','s'),(13,'cadastro_empresa','Cadastro Empresa','s'),(15,'relatorio','Relatório','p'),(17,'relatorio_pessoa','Relatorio Pessoa','s'),(19,'relatorio_proprietario','Relatorio Proprietario','s'),(21,'relatorio_imovel','Relatorio Imóvel','s'),(23,'relatorio_liberacao','Relatorio Liberação','s'),(25,'relatorio_entrada_saida','Relatório Entradas e Saidas','s'),(27,'relatorio_veiculo','Relatorio Veiculo','s'),(29,'relatorio_panico','Relatório Pânico','s'),(31,'relaorio_avancado','Relatorio Avançado','s'),(33,'sistema','Sistema','p'),(35,'sistema_usuario','Usuário','s'),(37,'sistema_equipamento','Equipamento','s'),(39,'sistema_configuracao','Configuração','s'),(41,'sistema_categoria_usuario','Categoria Usuário','s'),(43,'cadastro_digital','Cadastro de Digital','s'),(45,'portaria','Modulo Portaria','p'),(47,'admin','Modulo Administrativo','p'),(49,'sistema_condominio','Dados do Condomínio','s'),(51,'cadastro_ramo_atividade','Ramo de Atividade','s'),(53,'sistema_configuracao','Configuração do Sistema','s'),(54,'acesso_portal','Acesso ao módulo Portal','p'),(55,'acesso_financeiro','Acesso ao Sistema Financeiro','p'),(56,'contasReceber','Contas a Receber','p'),(57,'RecbLancAvul','Lançamento Avulso','s'),(58,'RecbPreLanc','Pré-lançamentos','s'),(59,'RecbLancReco','Lançamentos recorrentes','s'),(60,'RecbSimuCalcReceita','Simulação e cálculo','s'),(61,'RecbManual','Recebimento Manual','s'),(62,'RecbAuto','Recebimento automático','s'),(63,'RecbConsArqRet','Consulta de arquivo retorno','s'),(64,'contasPagar','Contas a Pagar','p'),(65,'CPEstimados','Lançamentos estimados Aprovados','s'),(66,'CPLancamentos','Lançamentos','s'),(67,'CPPagamentos','Pagamentos','s'),(68,'BancoCaixa','Bancos/Fluxo','p'),(69,'BncCxFluxo','Fluxo de Caixa','s'),(70,'BncCxContas','Contas bancárias','s'),(71,'cadastrosConfig','Cadastros/Configurações Financeiro','p'),(72,'CadGrupLanc','Grupo de conta','s'),(73,'CadTipoLanc','Plano de conta','s'),(74,'CadConfigCond','Configuração condominio','s'),(75,'CadConfigReceit','Configuração receita','s'),(76,'cadastrosInadimplencia','Config Inadimplência','p'),(77,'CadTipoInad','Tipo inadimplência','s'),(78,'CadSitInad','Situação Inadimplência','s'),(79,'CadDept','Departamento','s'),(80,'CadInfo','Informativo','s'),(81,'cadastrosEstoque','Cadastros Estoque','p'),(82,'ComprasCadProduto','Produtos','s'),(83,'ComprasCadGrupo','Grupo produtos','s'),(84,'ComprasCadUnidade','Unidades','s'),(85,'ComprasCadArea','Áreas','s'),(86,'ComprasCadRua','Ruas','s'),(87,'ComprasCadColuna','Colunas','s'),(88,'ComprasCadNivel','Níveis','s'),(89,'ComprasCadSequencia','Sequências','s'),(90,'relatoriosFinanceiro','Relatórios Financeiros','p'),(91,'relContasReceber','Relatórios Contas a Receber','p'),(92,'RelTitProv','Relatórios Títulos provisionados','s'),(93,'RelTitReceb','Relatório Títulos recebidos','s'),(94,'relContasPagar','Relatórios Contas a pagar','p'),(95,'RelContSint','Relatório Contas a pagar Sintético','s'),(96,'RelContAnal','Relatório Contas a pagar Analítico','s'),(97,'RelInadimplencia','Relatório Inadimplência','p'),(98,'RelInadAcord','Relatório Acordos','s'),(99,'RelInad','Relatório Inadimplentes','s'),(100,'RelInadAnal','Relatório Inadimplentes Analítico','s'),(101,'RelPrevReal','Previsão Realizado','p'),(102,'inadimplencia','Inadimplência','p'),(103,'InadClassi','Classificar inadimplentes','s'),(104,'acordo','Acordos','p'),(105,'InadSimuNego','Simular e negociar acordo','s'),(106,'InadAcordEfet','Acordos Efetuados','s'),(107,'modelos','Modelos','p'),(108,'InadModeCartaCobr','Modelo Carta Cobrança','s'),(109,'InadModeCartaQuit','Modelo Carta Quitação','s'),(110,'enviosInadimplencia','Envio Inadimplência','p'),(111,'InadEnvCartCobr','Envio Carta Cobrança','s'),(112,'InadEnvCartaQuit','Envio Carta Quitação','s'),(113,'compras','Compras','p'),(114,'ComprasAprovador','Aprovadores','s'),(115,'ComprasPedido','Pedidos','s'),(116,'patrimonio','Patrimônio','p'),(117,'PatrimonioBens','Bens patrimoniais','s'),(118,'PatrimonioManutencao','Patrimônio Manutenção','s'),(119,'PatrimonioBaixa','Patrimônio Baixa','s'),(120,'PatrimonioApolice','Patrimônio Apólice','s'),(121,'estoque','Estoque','p'),(122,'estoqueEstoque','Estoque Estoque','s'),(123,'estoqueMovimentacoes','Estoque Movimentações','s'),(124,'notificacoes','Notificações','p'),(125,'NotfEnvEmail','Enviar e-mail','s'),(126,'CadGrupCalc','Grupo de cálculo','s'),(127,'CPCadEstimar','Estimar Lançamentos','s'),(128,'CPDetalEstimado','Detalhes Lançamento Estimado','s'),(129,'CPLancamentosCompra','Provisionar Pedidos Aprovados','s'),(130,'integracoes','Integrações','p'),(131,'arquivoContabil','Arquivo Contábil','s'),(132,'ComprasSolicitacoes','Solicitações de compra','s'),(133,'ComprasPainel','Painel de Aprovações','s'),(134,'ComprasProvisionar','Provisionar Compras','s'),(135,'academia','Academia','p'),(136,'auditoria','Acessos no sistema (auditoria)','p'),(137,'rastreio','Rastreio de Pessoas','p'),(138,'cadastro_localidade','Cadastro de Localidades','s'),(139,'clube','Clube','p'),(140,'adesao','Adesão','s'),(141,'compraConvites','Comprar Convites','s'),(142,'tiposConvites','Tipos de Convite','s'),(143,'saldoHistorico','Saldo e Histórico','s'),(144,'reserva','Reservas','p'),(145,'reservaLocal','Locais Reserváveis','s'),(146,'reservaCalendario','Calendário de Reservas','s'),(147,'reservaAprovacao','Aprovações Pendentes','s');
/*!40000 ALTER TABLE `modulo_sistema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacaos`
--

DROP TABLE IF EXISTS `movimentacaos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movimentacaos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iddepositante` int(10) unsigned NOT NULL,
  `iddepositario` int(10) unsigned NOT NULL,
  `data` date NOT NULL,
  `valor` decimal(15,2) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movimentacaos_iddepositante_foreign` (`iddepositante`),
  KEY `movimentacaos_iddepositario_foreign` (`iddepositario`),
  CONSTRAINT `movimentacaos_iddepositante_foreign` FOREIGN KEY (`iddepositante`) REFERENCES `conta_bancarias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `movimentacaos_iddepositario_foreign` FOREIGN KEY (`iddepositario`) REFERENCES `conta_bancarias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacaos`
--

LOCK TABLES `movimentacaos` WRITE;
/*!40000 ALTER TABLE `movimentacaos` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimentacaos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivels`
--

DROP TABLE IF EXISTS `nivels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nivels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nivels_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivels`
--

LOCK TABLES `nivels` WRITE;
/*!40000 ALTER TABLE `nivels` DISABLE KEYS */;
/*!40000 ALTER TABLE `nivels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs_pessoa_entrada_saida`
--

DROP TABLE IF EXISTS `obs_pessoa_entrada_saida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs_pessoa_entrada_saida` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_imovel` int(10) unsigned NOT NULL,
  `id_pessoa` int(10) unsigned NOT NULL,
  `sentido` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `data_hora` datetime NOT NULL,
  `msg` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_atendente` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs_pessoa_entrada_saida`
--

LOCK TABLES `obs_pessoa_entrada_saida` WRITE;
/*!40000 ALTER TABLE `obs_pessoa_entrada_saida` DISABLE KEYS */;
/*!40000 ALTER TABLE `obs_pessoa_entrada_saida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocorrencia`
--

DROP TABLE IF EXISTS `ocorrencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ocorrencia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_hora_criacao` datetime NOT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `status` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'a',
  `descricao` text COLLATE utf8_unicode_ci NOT NULL,
  `id_pessoa_funcionario` int(10) unsigned NOT NULL,
  `excluida` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `data_hora_exclusao` datetime DEFAULT NULL,
  `id_pessoa_exclusao` int(10) unsigned DEFAULT NULL,
  `data_hora_fechamento` datetime DEFAULT NULL,
  `id_pessoa_fechamento` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocorrencia`
--

LOCK TABLES `ocorrencia` WRITE;
/*!40000 ALTER TABLE `ocorrencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocorrencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcela_boletos`
--

DROP TABLE IF EXISTS `parcela_boletos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parcela_boletos` (
  `id_parcela` int(10) unsigned NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_vencimento_origem` date DEFAULT NULL,
  `percentualmulta` decimal(15,2) NOT NULL,
  `percentualjuros` decimal(15,2) NOT NULL,
  `juros_apos` int(11) NOT NULL,
  `dias_protesto` tinyint(1) NOT NULL,
  `nosso_numero` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `numero_documento` bigint(20) NOT NULL,
  `parcela_num` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `situacao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `agrupado` tinyint(1) NOT NULL,
  `aceite` tinyint(1) NOT NULL,
  `especie_doc` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `file_remessa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_enviado` tinyint(1) NOT NULL DEFAULT 0,
  `numero_controler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nosso_numero_boleto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `nosso_numero_origem` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_parcela`),
  CONSTRAINT `parcela_boletos_id_parcela_foreign` FOREIGN KEY (`id_parcela`) REFERENCES `recebimento_parcelas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcela_boletos`
--

LOCK TABLES `parcela_boletos` WRITE;
/*!40000 ALTER TABLE `parcela_boletos` DISABLE KEYS */;
/*!40000 ALTER TABLE `parcela_boletos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcela_cheques`
--

DROP TABLE IF EXISTS `parcela_cheques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parcela_cheques` (
  `id_parcela` int(10) unsigned NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_emissao` date NOT NULL,
  `data_predatado` date DEFAULT NULL,
  `codigo_banco` int(10) unsigned NOT NULL,
  `agencia` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `numero_cheque` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_parcela`),
  KEY `parcela_cheques_id_banco_foreign` (`codigo_banco`),
  CONSTRAINT `parcela_cheques_id_parcela_foreign` FOREIGN KEY (`id_parcela`) REFERENCES `recebimento_parcelas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcela_cheques`
--

LOCK TABLES `parcela_cheques` WRITE;
/*!40000 ALTER TABLE `parcela_cheques` DISABLE KEYS */;
/*!40000 ALTER TABLE `parcela_cheques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcela_pagar`
--

DROP TABLE IF EXISTS `parcela_pagar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parcela_pagar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_lancamento_agendar` int(10) unsigned NOT NULL,
  `id_conta_bancaria` int(10) unsigned NOT NULL,
  `data_base` date NOT NULL,
  `valor_pago` decimal(15,2) NOT NULL,
  `tipo_operacao` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Débito, Provisão ou Cancelado',
  `forma_pagamento` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Dinheiro, Depósito, Boleto, Cheque, TED ou DOC',
  `forma_pagamento_origem` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Dinheiro, Depósito, Boleto e Cheque',
  `data_compensacao` date DEFAULT NULL,
  `data_pagamento` date DEFAULT NULL,
  `valor_abatimento` decimal(15,2) DEFAULT 0.00,
  `numero_comprovante` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `numero_cheque` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parcela_pagar_id_conta_bancaria_foreign` (`id_conta_bancaria`),
  KEY `parcela_pagar_id_lancamento_agendar_foreign` (`id_lancamento_agendar`),
  CONSTRAINT `parcela_pagar_id_conta_bancaria_foreign` FOREIGN KEY (`id_conta_bancaria`) REFERENCES `conta_bancarias` (`id`),
  CONSTRAINT `parcela_pagar_id_lancamento_agendar_foreign` FOREIGN KEY (`id_lancamento_agendar`) REFERENCES `lancamento_agendar` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcela_pagar`
--

LOCK TABLES `parcela_pagar` WRITE;
/*!40000 ALTER TABLE `parcela_pagar` DISABLE KEYS */;
/*!40000 ALTER TABLE `parcela_pagar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrimonios`
--

DROP TABLE IF EXISTS `patrimonios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrimonios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_produto` int(10) unsigned NOT NULL,
  `numero` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `serie` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descricao_garantia` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `fim_garantia` date DEFAULT NULL,
  `tipo_lancamento` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_incorporacao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_incorporacao` date DEFAULT NULL,
  `data_compra` date DEFAULT NULL,
  `valor` decimal(15,2) DEFAULT 0.00,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `numero_nota_fiscal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_departamento` int(10) unsigned NOT NULL,
  `observacoes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patrimonios_id_produto_foreign` (`id_produto`),
  KEY `patrimonios_id_empresa_foreign` (`id_empresa`),
  KEY `patrimonios_id_departamento_foreign` (`id_departamento`),
  CONSTRAINT `patrimonios_id_departamento_foreign` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id`),
  CONSTRAINT `patrimonios_id_empresa_foreign` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  CONSTRAINT `patrimonios_id_produto_foreign` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrimonios`
--

LOCK TABLES `patrimonios` WRITE;
/*!40000 ALTER TABLE `patrimonios` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrimonios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrimonios_apolices`
--

DROP TABLE IF EXISTS `patrimonios_apolices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrimonios_apolices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_empresa` int(10) unsigned NOT NULL,
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `numero` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data_inicio` date NOT NULL,
  `data_final` date NOT NULL,
  `valor_franquia` decimal(15,2) NOT NULL,
  `valor_premio` decimal(15,2) NOT NULL,
  `descricao_valores` text COLLATE utf8_unicode_ci NOT NULL,
  `motivo_cancelamento` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patrimonios_apolices_id_empresa_foreign` (`id_empresa`),
  CONSTRAINT `patrimonios_apolices_id_empresa_foreign` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrimonios_apolices`
--

LOCK TABLES `patrimonios_apolices` WRITE;
/*!40000 ALTER TABLE `patrimonios_apolices` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrimonios_apolices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrimonios_apolices_patrimonios`
--

DROP TABLE IF EXISTS `patrimonios_apolices_patrimonios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrimonios_apolices_patrimonios` (
  `id_apolice` int(10) unsigned NOT NULL,
  `id_patrimonio` int(10) unsigned NOT NULL,
  KEY `patrimonios_apolices_patrimonios_id_apolice_foreign` (`id_apolice`),
  KEY `patrimonios_apolices_patrimonios_id_patrimonio_foreign` (`id_patrimonio`),
  CONSTRAINT `patrimonios_apolices_patrimonios_id_apolice_foreign` FOREIGN KEY (`id_apolice`) REFERENCES `patrimonios_apolices` (`id`),
  CONSTRAINT `patrimonios_apolices_patrimonios_id_patrimonio_foreign` FOREIGN KEY (`id_patrimonio`) REFERENCES `patrimonios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrimonios_apolices_patrimonios`
--

LOCK TABLES `patrimonios_apolices_patrimonios` WRITE;
/*!40000 ALTER TABLE `patrimonios_apolices_patrimonios` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrimonios_apolices_patrimonios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrimonios_baixas`
--

DROP TABLE IF EXISTS `patrimonios_baixas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrimonios_baixas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_patrimonio` int(10) unsigned NOT NULL,
  `data` date NOT NULL,
  `tipo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `situacao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nota_fiscal_saida` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `destinatario` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `motivo` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `valor` decimal(15,2) NOT NULL,
  `motivo_revogacao` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patrimonios_baixas_id_patrimonio_foreign` (`id_patrimonio`),
  CONSTRAINT `patrimonios_baixas_id_patrimonio_foreign` FOREIGN KEY (`id_patrimonio`) REFERENCES `patrimonios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrimonios_baixas`
--

LOCK TABLES `patrimonios_baixas` WRITE;
/*!40000 ALTER TABLE `patrimonios_baixas` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrimonios_baixas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrimonios_historicos`
--

DROP TABLE IF EXISTS `patrimonios_historicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrimonios_historicos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_patrimonio` int(10) unsigned NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `data_hora` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patrimonios_historicos_id_patrimonio_foreign` (`id_patrimonio`),
  KEY `patrimonios_historicos_id_usuario_foreign` (`id_usuario`),
  CONSTRAINT `patrimonios_historicos_id_patrimonio_foreign` FOREIGN KEY (`id_patrimonio`) REFERENCES `patrimonios` (`id`),
  CONSTRAINT `patrimonios_historicos_id_usuario_foreign` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrimonios_historicos`
--

LOCK TABLES `patrimonios_historicos` WRITE;
/*!40000 ALTER TABLE `patrimonios_historicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrimonios_historicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrimonios_manutencoes`
--

DROP TABLE IF EXISTS `patrimonios_manutencoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrimonios_manutencoes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_patrimonio` int(10) unsigned NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `motivo` text COLLATE utf8_unicode_ci NOT NULL,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `data_saida` date NOT NULL,
  `previsao_retorno` date DEFAULT NULL,
  `data_retorno` date DEFAULT NULL,
  `valor_orcamento` decimal(15,2) DEFAULT 0.00,
  `valor_pago` decimal(15,2) DEFAULT 0.00,
  `fim_garantia` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patrimonios_manutencoes_id_patrimonio_foreign` (`id_patrimonio`),
  KEY `patrimonios_manutencoes_id_usuario_foreign` (`id_usuario`),
  KEY `patrimonios_manutencoes_id_empresa_foreign` (`id_empresa`),
  CONSTRAINT `patrimonios_manutencoes_id_empresa_foreign` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  CONSTRAINT `patrimonios_manutencoes_id_patrimonio_foreign` FOREIGN KEY (`id_patrimonio`) REFERENCES `patrimonios` (`id`),
  CONSTRAINT `patrimonios_manutencoes_id_usuario_foreign` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrimonios_manutencoes`
--

LOCK TABLES `patrimonios_manutencoes` WRITE;
/*!40000 ALTER TABLE `patrimonios_manutencoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrimonios_manutencoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `requerente` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descricao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `departamento` smallint(5) unsigned NOT NULL,
  `expectativa_entrega` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expectativa_valor` double(18,2) DEFAULT NULL,
  `solicitado_id` int(11) NOT NULL,
  `status` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Pendente, Em Aberto, Em cotação, Aprovação da compra, Compra aprovada ou Cancelado',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_lancamento_agendar` int(10) unsigned DEFAULT NULL,
  `id_solicitacao` int(11) DEFAULT NULL,
  `solicitacao` tinyint(3) unsigned DEFAULT NULL,
  `motivo_negado` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pedidos_id_lancamento_agendar_foreign` (`id_lancamento_agendar`),
  CONSTRAINT `pedidos_id_lancamento_agendar_foreign` FOREIGN KEY (`id_lancamento_agendar`) REFERENCES `lancamento_agendar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodo_validade_liberacao`
--

DROP TABLE IF EXISTS `periodo_validade_liberacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodo_validade_liberacao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `periodo` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_final` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodo_validade_liberacao`
--

LOCK TABLES `periodo_validade_liberacao` WRITE;
/*!40000 ALTER TABLE `periodo_validade_liberacao` DISABLE KEYS */;
INSERT INTO `periodo_validade_liberacao` VALUES (1,'Manhã','07:00:00','11:59:00'),(2,'Tarde','12:00:00','18:59:00'),(3,'Noite','19:00:00','06:59:00'),(4,'Diurno','07:00:00','18:59:00'),(5,'Noturno','19:00:00','06:59:00');
/*!40000 ALTER TABLE `periodo_validade_liberacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permanencia_prestador`
--

DROP TABLE IF EXISTS `permanencia_prestador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permanencia_prestador` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_entrada` int(10) unsigned NOT NULL,
  `vencimento_permanencia` datetime NOT NULL,
  `id_usuario_atendente` int(10) unsigned NOT NULL,
  `id_portaria` int(10) unsigned NOT NULL,
  `data_hora` datetime NOT NULL,
  `ignorar_permanencia` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `I_IGNORA_E_VENCIMENTO` (`ignorar_permanencia`,`vencimento_permanencia`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permanencia_prestador`
--

LOCK TABLES `permanencia_prestador` WRITE;
/*!40000 ALTER TABLE `permanencia_prestador` DISABLE KEYS */;
INSERT INTO `permanencia_prestador` VALUES (1,66,'2019-12-12 15:30:00',1,0,'2019-12-12 15:27:25','n'),(2,67,'2019-12-12 15:30:00',1,0,'2019-12-12 15:27:26','n'),(3,68,'2019-12-12 15:30:00',1,0,'2019-12-12 15:27:26','n'),(4,429,'2020-04-20 12:00:00',1,1,'2020-04-20 10:49:07','n'),(5,582,'2020-06-05 16:52:00',1,1,'2020-06-05 16:51:06','n'),(6,583,'2020-06-05 16:53:00',1,1,'2020-06-05 16:51:38','n'),(7,584,'2020-06-05 16:54:00',1,1,'2020-06-05 16:52:59','n');
/*!40000 ALTER TABLE `permanencia_prestador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissao_categoria`
--

DROP TABLE IF EXISTS `permissao_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissao_categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria_usuario` int(11) NOT NULL DEFAULT 0,
  `id_modulo` int(11) NOT NULL DEFAULT 0,
  `visualizar` int(10) unsigned DEFAULT 0,
  `inserir` int(10) unsigned DEFAULT 0,
  `editar` int(10) unsigned DEFAULT 0,
  `excluir` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `I__CATEGORIA_USUARIO` (`id_categoria_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=348 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissao_categoria`
--

LOCK TABLES `permissao_categoria` WRITE;
/*!40000 ALTER TABLE `permissao_categoria` DISABLE KEYS */;
INSERT INTO `permissao_categoria` VALUES (85,15,1,1,0,0,0),(87,15,3,1,1,1,1),(89,15,5,1,1,1,1),(91,15,7,1,1,1,1),(93,15,9,1,1,1,1),(95,15,11,1,1,1,1),(97,15,13,1,1,1,1),(99,15,15,1,0,0,0),(101,15,17,1,1,1,1),(103,15,19,1,1,1,1),(105,15,21,1,1,1,1),(107,15,23,1,1,1,1),(109,15,25,1,1,1,1),(111,15,27,1,1,1,1),(113,15,29,1,1,1,1),(115,15,31,1,1,1,1),(117,15,33,1,0,0,0),(119,15,35,1,1,1,1),(121,15,37,1,0,0,0),(123,15,39,1,0,0,0),(125,15,41,1,1,1,1),(127,15,43,1,1,1,1),(129,15,45,1,0,0,0),(131,15,47,1,0,0,0),(181,15,59,1,1,1,1),(183,15,51,1,1,1,1),(185,15,53,1,0,0,0),(186,15,54,0,0,0,0),(187,18,1,0,0,0,0),(188,18,3,0,0,0,0),(189,18,5,0,0,0,0),(190,18,7,0,0,0,0),(191,18,9,0,0,0,0),(192,18,11,0,0,0,0),(193,18,13,0,0,0,0),(194,18,15,0,0,0,0),(195,18,17,0,0,0,0),(196,18,19,0,0,0,0),(197,18,21,0,0,0,0),(198,18,23,0,0,0,0),(199,18,25,0,0,0,0),(200,18,27,0,0,0,0),(201,18,29,0,0,0,0),(202,18,31,0,0,0,0),(203,18,33,0,0,0,0),(204,18,35,0,0,0,0),(205,18,37,0,0,0,0),(206,18,39,0,0,0,0),(207,18,41,0,0,0,0),(208,18,43,0,0,0,0),(209,18,45,1,0,0,0),(210,18,47,0,0,0,0),(211,18,49,0,0,0,0),(212,18,51,0,0,0,0),(213,18,53,0,0,0,0),(214,16,1,1,0,0,0),(215,16,3,1,1,1,1),(216,16,5,1,1,1,1),(217,16,7,1,1,1,1),(218,16,9,1,1,1,1),(219,16,11,1,1,1,1),(220,16,13,1,1,1,1),(221,16,15,1,0,0,0),(222,16,17,1,1,1,1),(223,16,19,1,1,1,1),(224,16,21,1,1,1,1),(225,16,23,1,1,1,1),(226,16,25,1,1,1,1),(227,16,27,1,1,1,1),(228,16,29,1,1,1,1),(229,16,31,1,1,1,1),(230,16,33,1,0,0,0),(231,16,35,1,1,1,1),(232,16,37,1,1,1,1),(233,16,39,1,1,1,1),(234,16,41,1,1,1,1),(235,16,43,1,1,1,1),(236,16,45,1,0,0,0),(237,16,47,1,0,0,0),(238,16,49,1,1,1,1),(239,16,51,1,1,1,1),(240,16,53,1,1,1,1),(241,17,1,1,0,0,0),(242,17,3,1,1,1,1),(243,17,5,1,1,1,1),(244,17,7,1,1,1,1),(245,17,9,1,1,1,1),(246,17,11,1,1,1,1),(247,17,13,1,1,1,1),(248,17,15,1,0,0,0),(249,17,17,1,1,1,1),(250,17,19,1,1,1,1),(251,17,21,1,1,1,1),(252,17,23,1,1,1,1),(253,17,25,1,1,1,1),(254,17,27,1,1,1,1),(255,17,29,1,1,1,1),(256,17,31,1,1,1,1),(257,17,33,1,0,0,0),(258,17,35,1,1,1,1),(259,17,37,1,1,1,1),(260,17,39,1,0,0,0),(261,17,41,1,1,1,1),(262,17,43,1,1,1,1),(263,17,45,1,0,0,0),(264,17,47,1,0,0,0),(265,17,49,1,1,1,1),(266,17,51,1,1,1,1),(267,17,53,1,1,1,1),(268,17,54,1,1,1,1),(269,18,54,0,0,0,0),(270,16,54,1,1,1,1),(271,20,55,1,1,1,1),(272,20,56,1,1,1,1),(273,20,57,1,1,1,1),(274,20,58,1,1,1,1),(275,20,59,1,1,1,1),(276,20,60,1,1,1,1),(277,20,61,1,1,1,1),(278,20,62,1,1,1,1),(279,20,63,1,1,1,1),(280,20,64,1,1,1,1),(281,20,65,1,1,1,1),(282,20,66,1,1,1,1),(283,20,67,1,1,1,1),(284,20,68,1,1,1,1),(285,20,69,1,1,1,1),(286,20,70,1,1,1,1),(287,20,71,1,1,1,1),(288,20,72,1,1,1,1),(289,20,73,1,1,1,1),(290,20,74,1,1,1,1),(291,20,75,1,1,1,1),(292,20,76,1,1,1,1),(293,20,77,1,1,1,1),(294,20,78,1,1,1,1),(295,20,79,1,1,1,1),(296,20,80,1,1,1,1),(297,20,81,1,1,1,1),(298,20,82,1,1,1,1),(299,20,83,1,1,1,1),(300,20,84,1,1,1,1),(301,20,85,1,1,1,1),(302,20,86,1,1,1,1),(303,20,87,1,1,1,1),(304,20,88,1,1,1,1),(305,20,89,1,1,1,1),(306,20,90,1,1,1,1),(307,20,91,1,1,1,1),(308,20,92,1,1,1,1),(309,20,93,1,1,1,1),(310,20,94,1,1,1,1),(311,20,95,1,1,1,1),(312,20,96,1,1,1,1),(313,20,97,1,1,1,1),(314,20,98,1,1,1,1),(315,20,99,1,1,1,1),(316,20,100,1,1,1,1),(317,20,101,1,1,1,1),(318,20,102,1,1,1,1),(319,20,103,1,1,1,1),(320,20,104,1,1,1,1),(321,20,105,1,1,1,1),(322,20,106,1,1,1,1),(323,20,107,1,1,1,1),(324,20,108,1,1,1,1),(325,20,109,1,1,1,1),(326,20,110,1,1,1,1),(327,20,111,1,1,1,1),(328,20,112,1,1,1,1),(329,20,113,1,1,1,1),(330,20,114,1,1,1,1),(331,20,115,1,1,1,1),(332,20,116,1,1,1,1),(333,20,117,1,1,1,1),(334,20,118,1,1,1,1),(335,20,119,1,1,1,1),(336,20,120,1,1,1,1),(337,20,121,1,1,1,1),(338,20,122,1,1,1,1),(339,20,123,1,1,1,1),(340,20,124,1,1,1,1),(341,20,125,1,1,1,1),(342,20,126,1,1,1,1),(343,20,127,1,1,1,1),(344,20,128,1,1,1,1),(345,20,129,1,1,1,1),(346,20,130,1,1,1,1),(347,20,131,1,1,1,1);
/*!40000 ALTER TABLE `permissao_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissao_usuario`
--

DROP TABLE IF EXISTS `permissao_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissao_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) unsigned NOT NULL,
  `id_modulo` int(10) unsigned NOT NULL,
  `visualizar` int(10) unsigned NOT NULL DEFAULT 0,
  `inserir` int(10) unsigned NOT NULL DEFAULT 0,
  `editar` int(10) unsigned NOT NULL DEFAULT 0,
  `excluir` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `I_USUARIO_MODULO` (`id_usuario`,`id_modulo`)
) ENGINE=InnoDB AUTO_INCREMENT=973 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissao_usuario`
--

LOCK TABLES `permissao_usuario` WRITE;
/*!40000 ALTER TABLE `permissao_usuario` DISABLE KEYS */;
INSERT INTO `permissao_usuario` VALUES (686,1,1,1,0,0,0),(687,1,3,1,1,1,1),(688,1,5,1,1,1,1),(689,1,7,1,1,1,1),(690,1,9,1,1,1,1),(691,1,11,1,1,1,1),(692,1,13,1,1,1,1),(693,1,15,1,0,0,0),(694,1,17,1,1,1,1),(695,1,19,1,1,1,1),(696,1,21,1,1,1,1),(697,1,23,1,1,1,1),(698,1,25,1,1,1,1),(699,1,27,1,1,1,1),(700,1,29,1,1,1,1),(701,1,31,1,1,1,1),(702,1,33,1,0,0,0),(703,1,35,1,1,1,1),(704,1,37,1,1,1,1),(705,1,39,1,1,1,1),(706,1,41,1,1,1,1),(707,1,43,1,1,1,1),(708,1,45,1,0,0,0),(709,1,47,1,0,0,0),(710,1,49,1,1,1,1),(711,1,51,1,1,1,1),(712,1,53,1,1,1,1),(713,1,54,1,0,0,0),(714,2,1,1,0,0,0),(715,2,3,1,0,0,0),(716,2,5,1,0,0,0),(717,2,7,1,0,0,0),(718,2,9,1,1,1,1),(719,2,11,1,1,1,1),(720,2,13,1,1,1,1),(721,2,15,1,0,0,0),(722,2,17,1,1,1,1),(723,2,19,1,1,1,1),(724,2,21,1,1,1,1),(725,2,23,1,1,1,1),(726,2,25,1,1,1,1),(727,2,27,1,1,1,1),(728,2,29,1,1,1,1),(729,2,31,1,1,1,1),(730,2,33,1,0,0,0),(731,2,35,1,1,1,1),(732,2,37,1,1,1,1),(733,2,39,1,1,1,1),(734,2,41,1,1,1,1),(735,2,43,1,1,1,1),(736,2,45,1,0,0,0),(737,2,47,1,0,0,0),(738,2,49,1,1,1,1),(739,2,51,1,1,1,1),(740,2,53,1,1,1,1),(741,2,54,1,1,1,1),(742,2,55,1,0,0,0),(743,2,56,1,0,0,0),(744,2,57,1,1,1,1),(745,2,58,1,1,1,0),(746,2,59,0,0,0,0),(747,2,60,0,0,0,0),(748,2,61,0,0,0,0),(749,2,62,0,0,0,0),(750,2,63,0,0,0,0),(751,2,64,0,0,0,0),(752,2,65,0,0,0,0),(753,2,66,0,0,0,0),(754,2,67,0,0,0,0),(755,2,68,0,0,0,0),(756,2,69,0,0,0,0),(757,2,70,0,0,0,0),(758,2,71,0,0,0,0),(759,2,72,0,0,0,0),(760,2,73,0,0,0,0),(761,2,74,0,0,0,0),(762,2,75,0,0,0,0),(763,2,76,0,0,0,0),(764,2,77,0,0,0,0),(765,2,78,0,0,0,0),(766,2,79,0,0,0,0),(767,2,80,0,0,0,0),(768,2,81,0,0,0,0),(769,2,82,0,0,0,0),(770,2,83,0,0,0,0),(771,2,84,0,0,0,0),(772,2,85,0,0,0,0),(773,2,86,0,0,0,0),(774,2,87,0,0,0,0),(775,2,88,0,0,0,0),(776,2,89,0,0,0,0),(777,2,90,0,0,0,0),(778,2,91,0,0,0,0),(779,2,92,0,0,0,0),(780,2,93,0,0,0,0),(781,2,94,0,0,0,0),(782,2,95,0,0,0,0),(783,2,96,0,0,0,0),(784,2,97,0,0,0,0),(785,2,98,0,0,0,0),(786,2,99,0,0,0,0),(787,2,100,0,0,0,0),(788,2,101,0,0,0,0),(789,2,102,0,0,0,0),(790,2,103,0,0,0,0),(791,2,104,0,0,0,0),(792,2,105,0,0,0,0),(793,2,106,0,0,0,0),(794,2,107,0,0,0,0),(795,2,108,0,0,0,0),(796,2,109,0,0,0,0),(797,2,110,0,0,0,0),(798,2,111,0,0,0,0),(799,2,112,0,0,0,0),(800,2,113,0,0,0,0),(801,2,114,0,0,0,0),(802,2,115,0,0,0,0),(803,2,116,0,0,0,0),(804,2,117,0,0,0,0),(805,2,118,0,0,0,0),(806,2,119,0,0,0,0),(807,2,120,0,0,0,0),(808,2,121,0,0,0,0),(809,2,122,0,0,0,0),(810,2,123,0,0,0,0),(811,2,124,0,0,0,0),(812,2,125,0,0,0,0),(813,2,126,0,0,0,0),(814,2,127,0,0,0,0),(815,2,128,0,0,0,0),(816,2,129,0,0,0,0),(817,2,130,0,0,0,0),(818,2,131,0,0,0,0),(819,2,132,0,0,0,0),(820,2,133,0,0,0,0),(821,2,134,0,0,0,0),(822,2,135,0,0,0,0),(823,3,1,1,0,0,0),(824,3,3,1,1,1,1),(825,3,5,1,1,1,1),(826,3,7,1,1,1,1),(827,3,9,1,1,1,1),(828,3,11,1,1,1,1),(829,3,13,1,1,1,1),(830,3,15,1,0,0,0),(831,3,17,1,1,1,1),(832,3,19,1,1,1,1),(833,3,21,1,1,1,1),(834,3,23,1,1,1,1),(835,3,25,1,1,1,1),(836,3,27,1,1,1,1),(837,3,29,1,1,1,1),(838,3,31,1,1,1,1),(839,3,33,1,0,0,0),(840,3,35,1,1,1,1),(841,3,37,1,0,0,0),(842,3,39,1,0,0,0),(843,3,41,1,1,1,1),(844,3,43,1,1,1,1),(845,3,45,1,0,0,0),(846,3,47,1,0,0,0),(847,3,59,1,1,1,1),(848,3,51,1,1,1,1),(849,3,53,1,0,0,0),(850,3,54,0,0,0,0),(851,1,55,1,0,0,0),(852,1,56,1,0,0,0),(853,1,57,1,1,1,1),(854,1,58,1,1,1,1),(855,1,59,1,1,1,1),(856,1,60,1,1,1,1),(857,1,61,1,1,1,1),(858,1,62,1,1,1,1),(859,1,63,1,1,1,1),(860,1,64,1,0,0,0),(861,1,65,1,1,1,1),(862,1,66,1,1,1,1),(863,1,67,1,1,1,1),(864,1,68,1,0,0,0),(865,1,69,1,1,1,1),(866,1,70,1,1,1,1),(867,1,71,1,0,0,0),(868,1,72,1,1,1,1),(869,1,73,1,1,1,1),(870,1,74,1,1,1,1),(871,1,75,1,1,1,1),(872,1,76,1,0,0,0),(873,1,77,1,1,1,1),(874,1,78,1,1,1,1),(875,1,79,1,1,1,1),(876,1,80,1,1,1,1),(877,1,81,1,0,0,0),(878,1,82,1,1,1,1),(879,1,83,1,1,1,1),(880,1,84,1,1,1,1),(881,1,85,1,1,1,1),(882,1,86,1,1,1,1),(883,1,87,1,1,1,1),(884,1,88,1,1,1,1),(885,1,89,1,1,1,1),(886,1,90,1,0,0,0),(887,1,91,1,0,0,0),(888,1,92,1,1,1,1),(889,1,93,1,1,1,1),(890,1,94,1,0,0,0),(891,1,95,1,1,1,1),(892,1,96,1,1,1,1),(893,1,97,1,0,0,0),(894,1,98,1,1,1,1),(895,1,99,1,1,1,1),(896,1,100,1,1,1,1),(897,1,101,1,0,0,0),(898,1,102,1,0,0,0),(899,1,103,1,1,1,1),(900,1,104,1,0,0,0),(901,1,105,1,1,1,1),(902,1,106,1,1,1,1),(903,1,107,1,0,0,0),(904,1,108,1,1,1,1),(905,1,109,1,1,1,1),(906,1,110,1,0,0,0),(907,1,111,1,1,1,1),(908,1,112,1,1,1,1),(909,1,113,1,0,0,0),(910,1,114,1,1,1,1),(911,1,115,1,1,1,1),(912,1,116,1,0,0,0),(913,1,117,1,1,1,1),(914,1,118,1,1,1,1),(915,1,119,1,1,1,1),(916,1,120,1,1,1,1),(917,1,121,1,0,0,0),(918,1,122,1,1,1,1),(919,1,123,1,1,1,1),(920,1,124,1,0,0,0),(921,1,125,1,1,1,1),(922,1,126,1,1,1,1),(923,1,127,1,1,1,1),(924,1,128,1,1,1,1),(925,1,129,1,1,1,1),(926,1,130,1,0,0,0),(927,1,131,1,1,1,1),(928,1,132,1,1,1,1),(929,1,133,1,1,1,1),(930,1,134,1,1,1,1),(931,1,135,1,0,0,0),(932,1,136,1,0,0,0),(933,4,1,1,0,0,0),(934,4,3,1,1,1,1),(935,4,5,1,1,1,1),(936,4,7,1,1,1,1),(937,4,9,1,1,1,1),(938,4,11,1,1,1,1),(939,4,13,1,1,1,1),(940,4,15,1,0,0,0),(941,4,17,1,1,1,1),(942,4,19,1,1,1,1),(943,4,21,1,1,1,1),(944,4,23,1,1,1,1),(945,4,25,1,1,1,1),(946,4,27,1,1,1,1),(947,4,29,1,1,1,1),(948,4,31,1,1,1,1),(949,4,33,1,0,0,0),(950,4,35,1,1,1,1),(951,4,37,1,1,1,1),(952,4,39,1,1,1,1),(953,4,41,1,1,1,1),(954,4,43,1,1,1,1),(955,4,45,1,0,0,0),(956,4,47,1,0,0,0),(957,4,49,1,1,1,1),(958,4,51,1,1,1,1),(959,4,53,1,1,1,1),(960,4,54,1,1,1,1),(961,1,4,1,1,1,1),(962,1,137,1,0,0,0),(963,1,138,1,1,1,1),(964,1,139,1,0,0,0),(965,1,140,1,1,1,1),(966,1,141,1,1,1,1),(967,1,142,1,1,1,1),(968,1,143,1,1,1,1),(969,1,144,1,0,0,0),(970,1,145,1,1,1,1),(971,1,146,1,1,1,1),(972,1,147,1,1,1,1);
/*!40000 ALTER TABLE `permissao_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cpf` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_nascimento` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mae` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pai` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apresenta_mensagem_entrada` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mensagem` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obs_seguranca` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_cnh` int(10) unsigned DEFAULT NULL,
  `id_usuario_atendente` int(10) unsigned DEFAULT NULL,
  `tipo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 've = visitante/ pe=prestador/ f = funcionario/ m = mordor/ fa = familiares e amigos/ pp = prestador permanente\r\n',
  `url_foto` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rg` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_doc_frente` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_doc_verso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ultima_alteracao` datetime DEFAULT NULL,
  `tel1` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ramal` int(11) DEFAULT NULL,
  `tel2` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pessoa_permanente` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `outro_documento` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_outro_documento` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orgao_expeditor` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cel3` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cel4` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_endereco_pessoa` int(11) DEFAULT NULL,
  `email_pessoa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agrupar_titulos` tinyint(1) DEFAULT 0,
  `id_externo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_2` (`nome`,`pessoa_permanente`,`tipo`),
  KEY `index_3` (`outro_documento`,`pessoa_permanente`,`tipo`),
  KEY `index_4` (`nome`,`tipo`),
  KEY `index_5` (`outro_documento`,`tipo`),
  KEY `index_6` (`tel1`,`tel2`),
  KEY `Index_7` (`id`,`tipo`),
  KEY `Index_8` (`cpf`),
  KEY `Index_9` (`rg`),
  KEY `Index_10` (`outro_documento`),
  KEY `id_endereco_pessoa` (`id_endereco_pessoa`),
  CONSTRAINT `pessoa_ibfk_1` FOREIGN KEY (`id_endereco_pessoa`) REFERENCES `endereco` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'LETÍCIA','50979523168','2017-05-15 20:53:00','1970-11-08','m','Lilian da Silva Alves','CONDOMINIO','n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/602d263832b0d.jpeg',NULL,NULL,NULL,'2021-02-17 11:20:40','6232753415',NULL,'6299802593','s','1990054',NULL,'RG','62985246609',NULL,NULL,NULL,0,NULL),(2,'ALAN VOZ DIGITAL','83828285821','2019-11-25 21:22:02','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5ddc540a13a72.jpeg',NULL,NULL,NULL,'2020-02-04 12:07:31',NULL,NULL,'62991057275','s','wsd2e',NULL,'2DSD','62985246609',NULL,NULL,NULL,0,NULL),(3,'RAFAEL GONZAGA GONÇALVES','03404718160','2019-11-25 22:25:26','1992-07-22','m','Rafael','Gonçalves','n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/6021aff4c7400.jpeg',NULL,NULL,NULL,'2021-02-08 18:41:01',NULL,NULL,'62984169089','s','5410848',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(4,'JADERSON A. FERREIRA','55455604082','2019-11-26 10:42:48','1999-01-01','m','Maria','Jose','n',NULL,NULL,1,NULL,'m','upload/img/pessoa/5fca3d5a029f6.jpeg',NULL,NULL,NULL,'2020-12-28 09:57:10','6243290099',NULL,'62991057275','s','43292',NULL,'SSP','62999483848','62938372788',NULL,NULL,0,34),(5,'VILMA ALMEIDA','12693956021','2019-11-26 17:01:53','1976-08-01','f','Maria',NULL,'n',NULL,NULL,0,1,'p','upload/img/pessoa/5ddd68915ec2d.jpeg',NULL,NULL,NULL,'2020-03-11 12:09:08',NULL,NULL,'62991050000','n','459392',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(6,'JOSE PEDRO','75480378058','2019-11-26 17:06:04','1999-09-19','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-03-10 17:52:27',NULL,NULL,'62938828187','s','38281',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(7,'JOAO VITOR','85732820027','2019-11-28 14:05:25','1986-02-15','m','Marcia',NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2021-03-01 16:02:19',NULL,NULL,'62991057275','s','12312313',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(8,'ROBERTO MIRANDA','62685365095','2019-11-29 16:50:51','1992-07-22','m','trrwrw',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-17 14:49:29','6299999999',NULL,NULL,'n','542125',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(9,'MARIA','41576335046','2019-12-02 16:49:22','1981-10-01','f','Nene',NULL,'n',NULL,'Ira entre só ela mesma.',2,1,'v',NULL,NULL,NULL,NULL,'2020-07-06 15:07:57','62910939282',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(10,'JOÃO UBER','85722348023','2019-12-02 16:56:05','2000-01-01','m','TELMA',NULL,'n',NULL,'Uber carro gol',3,4,'p','upload/img/pessoa/16069121115fc7886f206b9.jpeg',NULL,'upload/img/pessoa/16069121115fc7886f1eb60.jpeg',NULL,'2020-12-02 09:29:11','62999105399',NULL,'62999999999','n','1231313',NULL,'CNH',NULL,NULL,NULL,NULL,0,NULL),(11,'RAFAEL','49794648078','2019-12-02 17:09:16','2009-01-01','m','Dalva',NULL,'n',NULL,'Entrega',4,NULL,'p',NULL,NULL,NULL,NULL,'2019-12-02 15:09:16','62438827273',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(12,'ROBERTO CARLOS','76174184005','2019-12-02 17:15:49','1992-07-22','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5e60fad302f9c.jpeg',NULL,NULL,NULL,'2021-03-01 16:08:54',NULL,NULL,'62991057275','s','5412256',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(13,'JUAKIM','35447162327','2019-12-02 19:21:53','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,1,'a','upload/img/pessoa/5de5726114b3f.jpeg',NULL,NULL,NULL,'2020-03-11 11:49:50',NULL,NULL,'23232323232','n','asd22d',NULL,'2D',NULL,NULL,NULL,NULL,0,NULL),(14,'PESSOA 1',NULL,'2019-12-03 20:12:30','2000-05-05','m','m',NULL,'n',NULL,NULL,5,1,'v',NULL,NULL,NULL,NULL,'2019-12-03 18:12:30','44444444444',NULL,NULL,'n','trh543',NULL,'STH',NULL,NULL,NULL,NULL,0,NULL),(15,'PESSOA 2',NULL,'2019-12-03 20:12:31','2003-03-03','m','n',NULL,'n',NULL,NULL,6,1,'v',NULL,NULL,NULL,NULL,'2019-12-03 18:12:31','33333333333',NULL,NULL,'n','dfgbhfyjh',NULL,'TYJETY',NULL,NULL,NULL,NULL,0,NULL),(16,'PESSOA 3','54278951167','2019-12-03 20:12:32','1999-09-09','m','kj',NULL,'n',NULL,NULL,7,1,'v',NULL,NULL,NULL,NULL,'2019-12-03 18:12:32','67456745674',NULL,NULL,'n','54278951167',NULL,'CPF',NULL,NULL,NULL,NULL,0,NULL),(17,'TESTE',NULL,'2019-12-03 20:15:08','2000-01-01','m','m',NULL,'n',NULL,NULL,8,1,'v',NULL,NULL,NULL,NULL,'2019-12-03 18:15:08','67464674657',NULL,NULL,'n','opuh098',NULL,'KJHG',NULL,NULL,NULL,NULL,0,NULL),(18,'ASDSAD',NULL,'2019-12-04 11:46:01','2000-12-22','m','ADADSD',NULL,'n',NULL,NULL,9,4,'v',NULL,NULL,NULL,NULL,'2020-12-07 09:27:11','12322132321',NULL,'33333333333','n','teste',NULL,'TESTE',NULL,NULL,NULL,NULL,0,NULL),(19,'BRUNO MOURA','04311617127','2019-12-04 11:50:52','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5fc8ddc2d8b4d.jpeg',NULL,NULL,NULL,'2021-02-25 16:12:09','6243290099',NULL,'62985246609','s','as56d4',NULL,'6SD6S6',NULL,NULL,NULL,NULL,0,NULL),(20,'SHHS','85225648258','2019-12-04 11:52:05','2000-12-12','m','sdad',NULL,'n',NULL,NULL,10,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 09:52:05','62655656666',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(21,'MARIO','94995611029','2019-12-04 11:59:52','1989-01-01','m','MARIA',NULL,'n',NULL,'My teste',11,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:20:02','62938484378',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(22,'RAFAEL',NULL,'2019-12-04 12:22:09','2000-05-05','m','m',NULL,'n',NULL,NULL,12,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:22:09','55555555555',NULL,NULL,'n','ergerg',NULL,'RGERG',NULL,NULL,NULL,NULL,0,NULL),(23,'HTYHTYH',NULL,'2019-12-04 12:24:03','2000-09-06','m','m',NULL,'n',NULL,NULL,13,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:24:03','44444444444',NULL,NULL,'n','tyhtyhy',NULL,'TYH',NULL,NULL,NULL,NULL,0,NULL),(24,'TESTE',NULL,'2019-12-04 12:25:23','2000-08-08','m','nm',NULL,'n',NULL,NULL,14,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:25:23','45643645643',NULL,NULL,'n','e3t43',NULL,'RGWER',NULL,NULL,NULL,NULL,0,NULL),(25,'RAFAEL BORGES','75749518370','2019-12-04 12:32:00','2000-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5fc780203b1dd.jpeg',NULL,NULL,NULL,'2020-12-23 19:07:47',NULL,NULL,'62985246609','s','sd9f8h',NULL,'SD',NULL,NULL,NULL,NULL,0,NULL),(26,'JOAO','14450594959','2019-12-04 12:32:42','1991-06-13','m','sadsad',NULL,'n',NULL,NULL,18,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:32:59','62662666565',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(27,'JOAQUIM','66548251520','2019-12-04 12:32:43','2000-12-11','f','6s6d5',NULL,'n',NULL,NULL,19,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:33:00','62626266662',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(28,'PESSOAL LEGAL',NULL,'2019-12-04 12:32:52','2000-09-09','m','n',NULL,'n',NULL,NULL,17,4,'v',NULL,NULL,NULL,NULL,'2020-12-02 16:12:00','55555555555',NULL,'99999999999','n','1234',NULL,'W45H5',NULL,NULL,NULL,NULL,0,NULL),(29,'SDASDSA','51644627612','2019-12-04 12:33:00','1909-12-12','m','asdad',NULL,'n',NULL,NULL,20,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:33:00','36626226262',NULL,NULL,'n','sdsad2',NULL,'SDS',NULL,NULL,NULL,NULL,0,NULL),(30,'PESSOA 1',NULL,'2019-12-04 12:53:24','2000-12-12','m','4546456',NULL,'n',NULL,NULL,21,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:53:24','12312312313',NULL,NULL,'n','pessoa1',NULL,'1',NULL,NULL,NULL,NULL,0,NULL),(31,'PESSOA 2',NULL,'2019-12-04 12:53:25','2000-12-21','f','2sa2d1',NULL,'n',NULL,NULL,22,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:53:25','3212212121',NULL,NULL,'n','pessoa2',NULL,'2',NULL,NULL,NULL,NULL,0,NULL),(32,'PESSOA 3',NULL,'2019-12-04 12:53:25','1999-11-12','f','56sd',NULL,'n',NULL,NULL,23,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 10:53:25','32323223333',NULL,NULL,'n','pessoa 3',NULL,'3',NULL,NULL,NULL,NULL,0,NULL),(33,'PESSOA 4',NULL,'2019-12-04 13:06:51','2000-12-12','m','132123',NULL,'n',NULL,NULL,24,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 11:06:51','62986566566',NULL,NULL,'n','pessoa4',NULL,'4',NULL,NULL,NULL,NULL,0,NULL),(34,'PESSOA 5',NULL,'2019-12-04 13:06:52','2000-12-12','m','2122',NULL,'n',NULL,NULL,25,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 11:06:52','65566545456',NULL,NULL,'n','pessoa5',NULL,'5',NULL,NULL,NULL,NULL,0,NULL),(35,'PESSOA 6','71678269956','2019-12-04 13:10:39','2000-12-12','m','21s2d',NULL,'n',NULL,NULL,26,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 11:10:39','62626666262',NULL,NULL,'n','pessoa6',NULL,'6',NULL,NULL,NULL,NULL,0,NULL),(36,'PESSOA 7','53900620784','2019-12-04 13:10:40','2000-12-12','m','sd4d54',NULL,'n',NULL,NULL,27,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 11:10:40','32163616665',NULL,NULL,'n','pessoa7',NULL,'7',NULL,NULL,NULL,NULL,0,NULL),(37,'ASDASDS','99919172928','2019-12-04 17:59:08','2000-12-12','m','0000000000',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 15:59:08','12121212121',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(38,'BADASDAS','62765012717','2019-12-04 18:01:43','2000-12-12','m','asdasdsa',NULL,'n',NULL,NULL,28,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 16:01:43','12121211212',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(40,'ASDASDSA','70666483310','2019-12-04 18:03:51','2000-12-12','m','202d0',NULL,'n',NULL,NULL,29,1,'v',NULL,NULL,NULL,NULL,'2019-12-04 16:03:51','62986565145',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(41,'ASSADASDASD','02746045400','2019-12-04 19:39:02','2000-12-12','m','0000',NULL,'n',NULL,NULL,30,1,'v','upload/img/pessoa/5de81966b662f.jpeg',NULL,NULL,NULL,'2019-12-04 17:39:02','12231232132',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(42,'DDASDASD','67176281629','2019-12-04 19:39:03','2000-12-12','m','000000',NULL,'n',NULL,NULL,31,1,'v','upload/img/pessoa/5de81967b66ca.jpeg',NULL,NULL,NULL,'2019-12-04 17:39:03','11212121121',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(43,'PESSOA 1',NULL,'2019-12-06 11:49:02','2000-05-05','m','n',NULL,'n',NULL,NULL,32,1,'v','upload/img/pessoa/5dea4e3e73b66.jpeg',NULL,NULL,NULL,'2019-12-06 09:49:02','45635634563',NULL,NULL,'n','erg345',NULL,'WRETGH',NULL,NULL,NULL,NULL,0,NULL),(44,'PESSOA 2',NULL,'2019-12-06 11:49:03','2000-01-01','m','m',NULL,'n',NULL,NULL,33,1,'v','upload/img/pessoa/5dea4e3f382f3.jpeg',NULL,NULL,NULL,'2019-12-06 09:49:03','45635643563',NULL,NULL,'n','45t45t',NULL,'435T35',NULL,NULL,NULL,NULL,0,NULL),(45,'EDUARDO','14708465785','2019-12-11 14:38:11','1111-11-11','m',NULL,NULL,'n',NULL,NULL,0,NULL,'m','upload/img/pessoa/5df10d63ebdd3.jpeg',NULL,NULL,NULL,'2019-12-11 12:38:12',NULL,NULL,'62985246609','s','asdasd',NULL,'22323',NULL,NULL,NULL,NULL,0,NULL),(46,'CPF DO BRUNO','04311617127','2019-12-12 12:13:24','2000-10-22','m','ASDAS',NULL,'n',NULL,NULL,34,1,'p',NULL,NULL,NULL,NULL,'2020-05-18 17:29:54','11111111111',NULL,NULL,'n','04311617127',NULL,'CPF',NULL,NULL,NULL,NULL,0,NULL),(47,'CPF DO BRUNO 2','04311617127','2019-12-12 12:16:36','2000-01-13','f','tres',NULL,'n',NULL,NULL,85,1,'v',NULL,NULL,NULL,NULL,'2020-12-10 12:09:51','33333333333',NULL,'23323333333','n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(48,'BRUNO 4',NULL,'2019-12-12 12:19:22','2004-04-14','m','4',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-12 10:19:22','44444444444',NULL,NULL,'n','as56d4',NULL,'6SD6S6',NULL,NULL,NULL,NULL,0,NULL),(49,'BRUNO 5 ALTERADO','04311617127','2019-12-12 12:22:23','2005-05-15','m','ASDAD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 17:15:20','55555555555',NULL,NULL,'n','04311617127',NULL,'CPF',NULL,NULL,NULL,NULL,0,NULL),(50,'VISITANTE','97653472001','2019-12-12 17:24:41','2001-11-11','m','11',NULL,'n',NULL,NULL,39,1,'v',NULL,NULL,NULL,NULL,'2019-12-12 15:27:21','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(51,'PRESTADOR','35371040498','2019-12-12 17:25:07','2002-12-22','m','2',NULL,'n',NULL,NULL,40,1,'p',NULL,NULL,NULL,NULL,'2019-12-12 15:27:22','22222222222',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(52,'TAXI','22363628039','2019-12-12 17:25:07','2003-03-13','m','4',NULL,'n',NULL,NULL,41,1,'p',NULL,NULL,NULL,NULL,'2019-12-12 15:27:22','33333333333',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(53,'ENTREGAS','38833731847','2019-12-12 17:25:21','2004-04-14','m','4',NULL,'n',NULL,NULL,42,1,'p',NULL,NULL,NULL,NULL,'2019-12-12 15:27:22','44444444444',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(54,'PESSOA SEM CPF',NULL,'2019-12-12 20:20:38','1991-11-11','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5df2af3ad008b.jpeg',NULL,NULL,NULL,'2021-03-01 16:09:45',NULL,NULL,'62985246609','s','asd5d65',NULL,'5SD',NULL,NULL,NULL,NULL,0,NULL),(55,'DAVI','34816247190','2019-12-13 10:41:40','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2020-01-24 11:58:16',NULL,NULL,'62985246609','s','asdd22',NULL,'3333',NULL,NULL,NULL,NULL,0,NULL),(56,'VISITANTE PRE CADASTRADO','34874551025','2019-12-13 12:26:40','2000-12-12','m','Sjsj',NULL,'n',NULL,'Hahaa',NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 10:26:40','49949494979',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(57,'VISITANTE','18202476356','2019-12-13 12:27:01','2000-11-11','m','654SD5',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 17:32:59','21231222323',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(58,'PREATDOR 2','25245126575','2019-12-13 13:21:16','1955-11-11','m','55',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2019-12-13 11:21:16','66565666666',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(59,'PREATDOR','66597183703','2019-12-13 13:21:30','1955-12-12','m','Sjd',NULL,'s',NULL,'Muito baderneiro. Ficar de olho.',NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 11:26:41','62987646464',NULL,NULL,'n','66597183703',NULL,'CPF',NULL,NULL,NULL,NULL,0,NULL),(60,'JDE','47391768073','2019-12-13 16:09:39','2001-01-01','m','MARIA',NULL,'n',NULL,'>>> teste',43,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 14:34:13','63721737237',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(61,'ANA','92173196006','2019-12-13 18:24:22','1983-10-23','f','MARIA',NULL,'n',NULL,'Mais uma observação',44,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 16:24:22','62939392882',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(62,'OUTRO CADASTRO','04311617127','2019-12-13 19:12:36','2000-11-11','m','5',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 17:12:36','63545656465',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(63,'P1','73223934650','2019-12-13 20:00:08','2000-11-11','m','1',NULL,'n',NULL,NULL,45,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 18:00:08','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(64,'ASDADDA','73223934650','2019-12-13 20:00:39','2000-11-11','m','52165',NULL,'n',NULL,NULL,46,1,'v',NULL,NULL,NULL,NULL,'2019-12-13 18:00:39','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(65,'ASDSAD2','65917001960','2019-12-16 11:07:53','2000-11-11','m','21d',NULL,'n',NULL,NULL,47,1,'v',NULL,NULL,NULL,NULL,'2019-12-16 09:07:53','21122112121',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(66,'ANDROID AND APPLE','72146505095','2019-12-16 12:03:32','2000-01-01','m',NULL,NULL,'n',NULL,NULL,48,NULL,'m',NULL,NULL,NULL,NULL,'2019-12-16 10:03:32',NULL,NULL,'62991057275','s','112311',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(67,'JADER','49659380038','2019-12-16 14:02:05','2000-01-01','m','maria',NULL,'n',NULL,NULL,49,1,'v',NULL,NULL,NULL,NULL,'2019-12-16 12:02:05','62938273728',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(68,'TESTE','63814875001','2019-12-16 14:03:15','2000-01-01','m','Ana',NULL,'n',NULL,NULL,50,NULL,'p',NULL,NULL,NULL,NULL,'2019-12-16 12:03:15','62373273772',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(69,'TESTE ENT','25883904041','2019-12-16 14:04:12','2000-01-01','m','Joana',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2019-12-16 12:04:12','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(70,'MY UBER','07601175006','2019-12-16 14:05:23','2000-01-01','m','Hebe',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2019-12-16 12:05:23','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(71,'MARLUCI',NULL,'2019-12-17 14:06:21','2000-01-01','m','n',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-17 12:06:21','46445645645',NULL,NULL,'n','ty5445y',NULL,'YHJY',NULL,NULL,NULL,NULL,0,NULL),(72,'BRUNO2','60626455154','2019-12-17 19:42:41','2002-10-22','f','2',NULL,'n',NULL,NULL,51,1,'v','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 17:52:30','22222222222',NULL,NULL,'n','doc',NULL,'NHE',NULL,NULL,NULL,NULL,0,NULL),(73,'ASDASD','48462443180','2019-12-17 19:58:24','1999-11-11','m','1',NULL,'n',NULL,NULL,NULL,1,'v','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 17:59:33','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(74,'ADASDASD','33763841423','2019-12-17 19:58:30','2000-11-11','f','A',NULL,'n',NULL,NULL,NULL,1,'p','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 17:59:33','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(75,'ASDASDD','28118737322','2019-12-17 19:58:30','2000-11-11','m','SADAS',NULL,'n',NULL,NULL,NULL,1,'v','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 17:59:33','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(76,'ASDSADSAASD','83271561281','2019-12-17 20:09:40','2000-11-11','m','sD',NULL,'n',NULL,NULL,NULL,1,'v','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 18:09:40','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(77,'ASDASDAS','13458631100','2019-12-17 20:09:41','1999-12-12','f','9999',NULL,'n',NULL,NULL,NULL,1,'v','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 18:09:41','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(78,'SDSDSDDS','37080769744','2019-12-17 20:09:41','2000-11-11','f','AAA',NULL,'n',NULL,NULL,NULL,1,'v','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 18:09:41','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(79,'ADASD','71524741760','2019-12-17 20:54:43','1999-11-11','m','995',NULL,'n',NULL,NULL,NULL,1,'v','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 18:54:43','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(80,'SDSDS','27586224919','2019-12-17 20:54:44','2000-11-11','m','2000',NULL,'n',NULL,NULL,NULL,NULL,'p','img/avatar.jpg',NULL,NULL,NULL,'2019-12-17 18:54:44','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(81,'HSHS','83845675144','2019-12-18 12:05:39','2000-12-12','m','A',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-18 10:05:39','12121212121',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(82,'DDD','71268014320','2019-12-18 19:33:56','2000-11-11','m','a',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-18 17:33:56','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(83,'JSJS2','60952181797','2019-12-19 13:38:44','2000-12-12','m','asddd',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-19 11:38:44','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(84,'KKKKK','30737103450','2019-12-19 13:40:01','1999-11-11','m','656',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-19 11:41:36','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(85,'HOJE É AMANHA','44217384254','2019-12-19 14:11:47','2000-12-12','m','222',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-19 12:11:47','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(86,'HOJE','62710820684','2019-12-19 14:12:10','2000-12-12','m','a',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-19 12:12:10','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(87,'SABADO','55807578678','2019-12-19 14:16:00','2000-11-11','m','aaa',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-19 12:16:00','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(88,'PAULO VITOR NUNES DO NASCIMENTO','','2019-12-19 14:22:13','1989-05-09','m','MARIA',NULL,'n',NULL,'teste',52,1,'v','upload/img/pessoa/15767699055dfb99719a679.jpeg',NULL,'upload/img/pessoa/15767712105dfb9e8ab3039.jpeg',NULL,'2019-12-19 13:00:11','62999999999',NULL,NULL,'n','123123123',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(89,'FF','96815939014','2019-12-20 11:52:39','2000-01-01','m','maria',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2019-12-20 09:52:39','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(90,'ANDERSON COSTA UZER','81666112879','2020-01-08 18:15:35','1991-12-18','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2020-04-15 18:03:32',NULL,NULL,'62985094441','s','816661',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(91,'VOZ DIGITAL','48764462706','2020-01-11 10:45:00','1111-11-11','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2020-01-11 08:45:00',NULL,NULL,'62985246609','s','asdasdas',NULL,'DSDSDSDDS',NULL,NULL,NULL,NULL,0,NULL),(92,'JOANA','60893496073','2020-01-30 16:58:19','2000-01-01','f','Teste',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-03 16:20:08','62991057275',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(93,'MARCIO','24258835099','2020-01-30 17:10:23','1988-12-10','m','Joana',NULL,'n',NULL,'Liberação pelo web.',NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-03 14:54:22','62991057275',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(94,'MARIA','82148097032','2020-02-03 14:15:06','2000-01-01','f','NENE',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-07-06 15:07:04','62991057272',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(95,'FLAVIA','96898398024','2020-02-03 17:12:59','2000-01-01','f','RAQUEL',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-27 16:01:45','62991057275',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(96,'LAURA','48625975054','2020-02-03 18:18:39','2000-01-01','f','BIA',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-02 11:09:55','62991057275',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(97,'ANTONIO','17258060022','2020-02-03 19:04:34','2000-01-01','m','Ynes',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-03 17:04:34','62991057275',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(98,'IGOR','79480062062','2020-02-03 19:13:14','2000-01-01','m','JORGE',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-29 18:24:07','62991057275',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(99,'TESTE APP','35836316767','2020-02-04 12:03:48','2000-11-11','m','aaa',NULL,'n',NULL,'Teste',NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-04 10:15:27','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(100,'TESTE PORTARIA','42410097006','2020-02-04 12:05:46','2000-11-11','m','ASDAD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-28 09:00:29','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(101,'PRESTADOR','04185769202','2020-02-04 12:30:21','2000-12-12','f','ASDD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-29 09:44:36','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(102,'TAXI','20766386104','2020-02-04 12:31:53','2000-12-12','f','sddd',NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-02-05 14:50:50','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(103,'TSSG','47716878115','2020-02-04 12:32:33','2000-12-12','m','asd',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-02-04 10:32:33','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(104,'JSJS','42151851737','2020-02-04 12:54:21','2000-11-11','m','asASD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-04 10:54:21','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(105,'ZÉ','13715527625','2020-02-04 12:59:06','2000-12-12','m','ssss',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-05 14:50:32','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(106,'PESSOA NORMAL','22783612100','2020-02-04 14:35:05','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5e398f29c049b.jpeg',NULL,NULL,NULL,'2021-03-01 16:10:30',NULL,NULL,'62985246609','s','6545656',NULL,'32545',NULL,NULL,NULL,NULL,0,NULL),(107,'6','63745308107','2020-02-04 17:12:29','2000-12-12','f','asdsad',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-04 15:12:29','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(108,'ALEXANDRE','55346324372','2020-02-04 17:19:28','1111-11-11','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2020-02-04 15:19:28',NULL,NULL,'62982572666','s','asdsad22',NULL,'SDSD',NULL,NULL,NULL,NULL,0,NULL),(109,'HENRIQUE FALONI','34053418097','2020-02-14 10:22:20','1969-12-31','m',NULL,NULL,'n',NULL,NULL,53,NULL,'m','upload/img/pessoa/5e4682ec26e7e.jpeg',NULL,NULL,NULL,'2020-11-09 15:46:25','6296060606',5,'62060606060','s','340.534.180-97',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,109),(110,'GUSTAVO','03353291016','2020-02-17 12:24:06','2000-01-01','m','DALVA',NULL,'n',NULL,NULL,80,1,'v',NULL,NULL,NULL,NULL,'2020-09-04 11:31:00','62991057274',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(111,'JOANA PEREIRA SOUZA','15351747065','2020-02-17 14:01:22','1992-01-01','f','JOANA SOUZA',NULL,'n',NULL,NULL,54,1,'v',NULL,NULL,NULL,NULL,'2020-03-17 10:54:42','62999999999',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(112,'SDF','15762277909','2020-02-17 21:49:39','2000-05-05','m','m',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-17 18:49:39','43534534534',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(113,'GESICA','65054811095','2020-02-21 12:35:34','2000-01-01','f','TESTE',NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-04-29 18:25:35','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(114,'JOAO CABEÇÃO','02855517010','2020-02-21 14:09:09','1990-10-10','m','Mariazinha','Tadeu','n',NULL,NULL,55,1,'p',NULL,NULL,NULL,NULL,'2020-03-03 11:37:50',NULL,NULL,'62966666666','s','252525',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(115,'FABIO NASCIMENTO','36298252061','2020-02-28 11:50:39','2000-01-01','m','MARIA',NULL,'n',NULL,'Uber vai entrar em minha casa.',84,1,'p',NULL,NULL,NULL,NULL,'2020-11-26 14:46:01','00000000000',NULL,'62999999999','n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(116,'RONALDO','75039751052','2020-02-28 13:43:49','2000-01-01','m','MARIA',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-27 16:18:53','62928818288',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(117,'ASDASDASD','74597661433','2020-02-28 13:46:14','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5e5919a69da59.jpeg',NULL,NULL,NULL,'2020-11-30 17:49:21',NULL,NULL,'62985246609','s','asdsad22ddddd',NULL,'2222',NULL,NULL,NULL,NULL,0,NULL),(118,'DNDNND','69328826128','2020-02-28 14:07:16','2000-11-11','m','asdsad',NULL,'n',NULL,NULL,56,1,'v',NULL,NULL,NULL,NULL,'2020-02-28 11:07:16','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(119,'ENTREGUISTA','52657102301','2020-02-28 14:10:23','2000-12-12','f','ASD',NULL,'n',NULL,NULL,57,1,'p',NULL,NULL,NULL,NULL,'2020-04-28 08:54:48','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(120,'ASSOCIADO TESTE','53828962084','2020-02-28 14:16:15','1950-01-01','m','cigana madalena','cigano sem nome','n',NULL,NULL,58,NULL,'m','upload/img/pessoa/5e5920afd6d71.jpeg',NULL,NULL,NULL,'2020-06-16 16:26:00',NULL,NULL,'62999999999','s','010101',NULL,'BINARIO',NULL,NULL,NULL,NULL,0,NULL),(121,'ADSDD','13236464186','2020-02-28 14:46:13','2000-02-11','m','222',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-28 11:49:47','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(122,'TAX','57960539731','2020-02-28 14:48:08','2000-11-11','m','aasd',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-02-28 11:48:08','21566666666',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(123,'LIB PELO PORTARIA','21611157072','2020-02-28 15:02:47','2000-01-01','m','Maria',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-02-28 12:02:47','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(124,'TADEU ERNESTO','55512739115','2020-02-28 19:34:15','1990-12-09','m','maria tereza',NULL,'n',NULL,'uber',59,NULL,'p',NULL,NULL,NULL,NULL,'2020-02-28 16:34:52','62955555555',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(125,'YURI SOUSA','32768248762','2020-02-28 19:38:04','1990-05-09','m','JOAQUINA RODRIGUES',NULL,'n',NULL,NULL,60,NULL,'p',NULL,NULL,NULL,NULL,'2020-02-28 16:38:15','62954649696',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(126,'TESTE FOTO TEMP','14248598248','2020-03-02 17:11:49','1980-01-01','m','UZER',NULL,'n',NULL,NULL,61,1,'v','upload/img/pessoa/15831691045e5d3e50c7a10.jpeg',NULL,NULL,NULL,'2020-03-02 14:16:24','62999999999',NULL,NULL,'n','598248',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(127,'HOMER SIMPSON','87317741990','2020-03-03 13:33:00','1111-11-11','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5e5e5c8c8b413.jpeg',NULL,NULL,NULL,'2020-03-03 10:33:00',NULL,NULL,'62985246609','s','asdddd222',NULL,'2222',NULL,NULL,NULL,NULL,0,NULL),(128,'PORTARIA','83645055720','2020-03-03 13:50:15','2000-11-11','m','SADASD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-03 14:02:41','11122122222',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(129,'OTA PESSOA','15418342088','2020-03-03 13:56:51','2000-11-11','m','sdasd',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-03 10:58:37','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(130,'OTA PESSOA 2','88089751008','2020-03-03 14:01:46','2000-11-11','m','1qasdasdsad',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-18 11:00:36','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(131,'ASSOCIADO','84781292780','2020-03-03 14:13:57','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2020-07-10 11:35:00',NULL,NULL,'62985246609','s','ddsdssd',NULL,'22DSD',NULL,NULL,NULL,NULL,0,NULL),(132,'MORADOR1','40021383642','2020-03-03 14:18:47','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2021-03-01 16:07:51',NULL,NULL,'62985246609','s','3rrrr233',NULL,'222',NULL,NULL,NULL,NULL,0,NULL),(133,'MORADOR2','67691466579','2020-03-03 14:33:07','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5e5e6aa3ba769.jpeg',NULL,NULL,NULL,'2021-03-01 16:07:36',NULL,NULL,'62985246609','s','ad2er333',NULL,'WWW',NULL,NULL,NULL,NULL,0,NULL),(134,'DJJD','77441675898','2020-03-03 17:47:35','2000-11-11','m','1111',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-03 14:47:35','11111111111',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(135,'PLACA','30095278028','2020-03-04 12:28:32','2000-10-10','m','maria',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-03-04 09:28:32','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(136,'ZEZIM2','54549575859','2020-03-05 19:22:31','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5ebaff038c5cd.jpeg',NULL,NULL,NULL,'2021-03-01 16:07:20',NULL,NULL,'62985246609','s','asdsadd',NULL,'DDDDS',NULL,NULL,NULL,NULL,0,NULL),(137,'SEDGFSDF','36717167467','2020-03-10 18:43:57','2000-05-05','m','m',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-10 15:43:57','45642356356',NULL,NULL,'n','sdferg4',NULL,'SGHE5R',NULL,NULL,NULL,NULL,0,NULL),(138,'REGINA FAMILIAR/AMIGO','92373340011','2020-03-11 17:34:47','2000-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,1,'a',NULL,NULL,NULL,NULL,'2020-04-29 09:01:33',NULL,NULL,'62991057275','s','123432665',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(139,'HENRIQUE','05623139078','2020-03-11 18:11:11','2000-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p','upload/img/pessoa/6021b42c0d43d.jpeg',NULL,NULL,NULL,'2021-02-09 13:16:45',NULL,NULL,'62991057275','s','232764',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(140,'ROBERTO DINAMITE','71514712032','2020-03-16 13:45:37','1998-01-01','m','Joana',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-16 11:00:30','62999999999',NULL,NULL,'n','84559',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(141,'JULIA ROBERTA DINIZ','50479391033','2020-03-16 15:19:39','1998-01-01','m','Helena Souza Diniz',NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-03-16 12:24:10','62999999999',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(142,'ROBERTO ANTHONY JOSÉ BRITO','86822899626','2020-03-16 20:02:36','1985-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2020-03-16 17:02:36',NULL,NULL,'62984169089','s','512564',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(143,'RAFAEL ALEXANDRE DRUMOND','74423709694','2020-03-16 20:16:31','1971-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2021-03-01 16:06:49',NULL,NULL,'62985246609','s','87125',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(144,'ROBERTO CARLOS',NULL,'2020-03-17 13:35:21',NULL,'m',NULL,NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-17 10:35:21',NULL,NULL,NULL,'n','125432',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(145,'FELIPE MARIO',NULL,'2020-03-17 13:40:21',NULL,'m',NULL,NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-17 10:40:21',NULL,NULL,NULL,'n','1545678',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(146,'FELIPE MARIANO',NULL,'2020-03-17 13:41:01',NULL,'m',NULL,NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-17 10:41:01',NULL,NULL,NULL,'n','124558',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(147,'MARCELA GONZAGA',NULL,'2020-03-17 13:43:53','1969-12-31','m',NULL,NULL,'n',NULL,NULL,64,1,'p',NULL,NULL,NULL,NULL,'2020-03-17 15:27:07',NULL,NULL,NULL,'n','1215265',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(148,'CARLOS AUGUSTO SOUZA',NULL,'2020-03-17 13:44:25','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-03-17 14:51:12',NULL,NULL,NULL,'n','7854121',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(149,'JOAQUIM DA SILVA CAMARGO',NULL,'2020-03-17 13:46:28','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-03-17 14:51:44',NULL,NULL,NULL,'n','1264859',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(150,'PAULO HENRIQUE',NULL,'2020-03-17 13:48:47',NULL,'m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-03-17 10:48:47',NULL,NULL,NULL,'n','2326581',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(151,'JULIANO SOUZA',NULL,'2020-03-17 13:49:48',NULL,'m',NULL,NULL,'n',NULL,NULL,62,NULL,'p',NULL,NULL,NULL,NULL,'2020-03-17 10:50:27',NULL,NULL,NULL,'n','04524',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(152,'CAROLINA',NULL,'2020-03-17 13:53:09','1969-12-31','f',NULL,NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-03-17 14:56:25',NULL,NULL,NULL,'n','7459895',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(153,'MARCELO',NULL,'2020-03-17 13:53:48',NULL,'m',NULL,NULL,'n',NULL,NULL,63,NULL,'p',NULL,NULL,NULL,NULL,'2020-03-17 10:54:04',NULL,NULL,NULL,'n','74858',NULL,'SSPO',NULL,NULL,NULL,NULL,0,NULL),(154,'WEIDHER NERES',NULL,'2020-03-17 13:54:24','1969-12-31','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-03-17 14:55:08',NULL,NULL,NULL,'n','522665',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(155,'HENRIQUE UZER','17199022166','2020-04-15 21:01:21','1980-12-12','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2020-04-15 18:01:21',NULL,NULL,'62981972742','s','17199022',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(156,'PAULO VITOR UZER','10135104106','2020-04-15 21:02:59','1981-11-11','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5fc7f2de5d90e.jpeg',NULL,NULL,NULL,'2020-12-08 14:49:31',NULL,NULL,'62992914481','s','10135104',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(157,'RONALDO UZER','14282768665','2020-04-15 21:07:41','1982-10-10','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-12-15 10:28:23',NULL,NULL,'62992981141','s','14282768',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(158,'GAWERG',NULL,'2020-04-17 19:15:50',NULL,'m',NULL,NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-17 16:15:50',NULL,NULL,NULL,'n','adrfgarga',NULL,'ARGAWER',NULL,NULL,NULL,NULL,0,NULL),(159,'NAYARA','02546713140','2020-04-20 13:47:10',NULL,'f',NULL,NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-04-20 10:47:10',NULL,NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(160,'ADSDD','53355054194','2020-04-27 20:23:54',NULL,'m',NULL,NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-27 17:25:44',NULL,NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(161,'VISITANTE','32125239809','2020-04-28 11:55:25',NULL,'m',NULL,NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-04-28 08:58:28',NULL,NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(162,'GUSTAVO GOMES','19946891026','2020-04-28 13:25:22','1969-12-31','m',NULL,NULL,'n',NULL,NULL,65,1,'v',NULL,NULL,NULL,NULL,'2020-04-30 11:53:55',NULL,NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(163,'JOÃO MORAES','23321167530','2020-04-29 18:08:32','2000-12-12','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5ea9c71c02d48.jpeg',NULL,NULL,NULL,'2020-09-11 15:56:33',NULL,NULL,'62985246609','s','233233',NULL,'44443',NULL,NULL,NULL,NULL,0,47),(164,'MARIELLE MORAES','25585611704','2020-04-29 18:18:21','2000-12-12','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5ea9c4ed4610a.jpeg',NULL,NULL,NULL,'2020-11-09 15:44:20',NULL,NULL,'62985246609','s','asdd',NULL,'D2D',NULL,NULL,NULL,NULL,0,164),(165,'FERNANDO MORAES','62982401444','2020-04-29 18:19:34','2000-12-12','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5ea9c53648835.jpeg',NULL,NULL,NULL,'2021-03-01 16:00:31',NULL,NULL,'62985246609','s','dd2d',NULL,'D2D2222',NULL,NULL,NULL,NULL,0,NULL),(166,'ROBERTO ALMEIDA','48971028394','2020-04-29 18:21:15','2000-11-11','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p','upload/img/pessoa/5ea9c59baaf88.jpeg',NULL,NULL,NULL,'2020-12-02 10:22:58',NULL,NULL,'62222222222','s','32rdd',NULL,'SD2345',NULL,NULL,NULL,NULL,0,NULL),(167,'ROSA MORAES',NULL,'2020-04-29 18:22:35','2000-12-12','m',NULL,NULL,'n',NULL,NULL,NULL,4,'a','upload/img/pessoa/5ea9c5eb0a658.jpeg',NULL,NULL,NULL,'2020-12-07 16:06:41',NULL,NULL,'62666666666','s','4234444',NULL,'3SDD',NULL,NULL,NULL,NULL,0,NULL),(168,'TESTE ENTRADA','67078355130','2020-05-11 21:41:49','2000-05-05','m','m',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-05-11 18:41:49','56345634563',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(169,'ASDSAD','52738644538','2020-05-13 21:04:34','2000-12-12','m','5ASDSAD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-05-13 18:27:27','62988999998',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(170,'ASDSAD','21337246484','2020-05-29 15:59:01','2000-12-12','m','ASDASDD',NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-05-29 12:59:16','23213231321',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(171,'SADASSAD','27747379315','2020-06-05 17:35:27','2000-12-12','m','asdsd',NULL,'n',NULL,NULL,66,1,'p',NULL,NULL,NULL,NULL,'2020-06-05 14:37:03','62622666262',NULL,NULL,'n','asasdasd',NULL,'DASD',NULL,NULL,NULL,NULL,0,NULL),(172,'ENTREGADOR','84471676660','2020-06-05 22:42:27','2000-05-05','m','M',NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-06-05 16:51:35','54334533452',NULL,NULL,'n','asdfasd',NULL,'ASDF',NULL,NULL,NULL,NULL,0,NULL),(173,'TAXI','62456635396','2020-06-05 19:50:52','2000-05-05','m','m',NULL,'n',NULL,NULL,67,NULL,'p',NULL,NULL,NULL,NULL,'2020-06-05 16:51:06','34545345234',NULL,NULL,'n','tghwerg',NULL,'ERGER',NULL,NULL,NULL,NULL,0,NULL),(174,'PRESTADOR','72916785108','2020-06-05 19:52:55','2000-05-05','m','m',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-06-05 16:52:55','45243535345',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(175,'NATHALIA MENDES','42220462560','2020-06-08 13:39:58','1998-07-12','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m','upload/img/pessoa/5f48f6f8b429f.jpeg',NULL,NULL,NULL,'2020-11-09 15:47:25',NULL,NULL,'62982491816','s','23242',NULL,'34242',NULL,NULL,NULL,NULL,0,175),(176,'IFOOD','32726786200','2020-06-08 13:44:47','2000-12-12','f','23asdasd',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-06-08 10:44:47','12323323333',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(177,'MEU VISITANTE','12471462006','2020-06-08 18:39:43','2000-01-01','m','Maria',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-06-08 15:39:43','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(178,'VEICULO VISITANTE','82784266516','2020-06-09 18:37:45','2000-12-21','m','aaa',NULL,'n',NULL,NULL,68,1,'v',NULL,NULL,NULL,NULL,'2020-06-09 15:38:06','62626626262',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(179,'ENTREGADOR DE PLACA','63497653462','2020-06-09 18:44:59','2000-12-12','f','asdsad',NULL,'n',NULL,NULL,69,NULL,'p','upload/img/pessoa/15917282995edfd8ab362a7.jpeg',NULL,NULL,NULL,'2020-06-09 15:45:08','23232323232',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(180,'JSJSS','85374605593','2020-06-09 18:53:59','2000-12-12','m','20000',NULL,'n',NULL,NULL,70,NULL,'p','upload/img/pessoa/15917288395edfdac7a1526.jpeg',NULL,NULL,NULL,'2020-06-09 15:54:25','62956555555',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(181,'JSJ','74827548579','2020-06-09 19:00:57','2000-12-12','m','aaa',NULL,'n',NULL,NULL,71,NULL,'p','upload/img/pessoa/15917292575edfdc6980183.jpeg',NULL,NULL,NULL,'2020-06-09 16:01:02','62662662626',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(187,'TESTE TEL','22529055068','2020-06-09 19:28:51','2000-01-01','m','Maria',NULL,'n',NULL,'Telefone esta no form',NULL,1,'v',NULL,NULL,NULL,NULL,'2020-06-09 16:28:51','62991057275',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(188,'EU TESTE','47493291004','2020-06-09 19:42:11','2000-05-05','m','g',NULL,'n',NULL,NULL,72,1,'v',NULL,NULL,NULL,NULL,'2020-06-09 16:42:11','34643564563',NULL,NULL,'n','wf3',NULL,'3F3',NULL,NULL,NULL,NULL,0,NULL),(189,'HERBERT RICHERS','47841033257','2020-06-09 20:28:33','2000-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-11-26 15:40:17',NULL,NULL,'43676746574','s','rgys4',NULL,'SDFHG',NULL,NULL,NULL,NULL,0,NULL),(190,'TESTE','12886504009','2020-06-16 17:13:56','2000-01-01','m','Maria',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-06-16 14:13:56','00000000000',NULL,NULL,'n','ewoqeqe',NULL,'EQEE',NULL,NULL,NULL,NULL,0,NULL),(191,'HENRRIQUE','70094126186','2020-06-16 17:23:17','1921-01-01','m','MARIA',NULL,'n',NULL,NULL,73,1,'v',NULL,NULL,NULL,NULL,'2020-07-06 17:53:54','62999999999',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(192,'MORADOR',NULL,'2020-06-16 19:24:42','1992-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2021-03-01 15:59:58',NULL,NULL,'62999999999','s','1256256',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(193,'LIBERAÇÃO VÁRIOS IMÓVEIS','56503602944','2020-06-22 20:02:22','2000-05-05','m','M',NULL,'n',NULL,NULL,74,1,'v',NULL,NULL,NULL,NULL,'2020-06-22 17:06:53','87687678678',NULL,NULL,'n','ga43w',NULL,'ARG34',NULL,NULL,NULL,NULL,0,NULL),(194,'FDGHDGF','05076264437','2020-06-23 18:15:52','2000-02-02','m','hj',NULL,'n',NULL,NULL,75,1,'v',NULL,NULL,NULL,NULL,'2020-06-23 15:15:52','31313212312',NULL,NULL,'n','dfghdfg',NULL,'DFG',NULL,NULL,NULL,NULL,0,NULL),(195,'TESTE2','14526268127','2020-06-29 21:07:05','2000-10-10','m','LJKH',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-06-29 18:12:28','53615646645',NULL,NULL,'n','fghgh',NULL,'DFGHDGFH',NULL,NULL,NULL,NULL,0,NULL),(196,'ENTREGAS','14342796694','2020-06-29 21:21:57','2000-10-10','m','2df',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-06-29 18:21:57','65556545645',NULL,NULL,'n','fdgsdfg',NULL,'FDGFDG',NULL,NULL,NULL,NULL,0,NULL),(197,'ENTREGAS',NULL,'2020-06-30 20:26:22','2000-06-06','m','rtyjry',NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-06-30 17:26:22','65465456465',NULL,NULL,'n','dyth56',NULL,'DTEYHJ',NULL,NULL,NULL,NULL,0,NULL),(198,'JOAO ENTREGADOR',NULL,'2020-06-30 20:32:10','2000-05-05','m','SDF',NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2020-07-01 16:52:41','65656546665',NULL,NULL,'n','dfrg43',NULL,'ERGEWR',NULL,NULL,NULL,NULL,0,NULL),(199,'TYUK',NULL,'2020-06-30 20:43:57','2000-05-05','m','lkj',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-06-30 17:43:57','65456464564',NULL,NULL,'n','yukt',NULL,'KUKTUK',NULL,NULL,NULL,NULL,0,NULL),(200,'TESTE','21451220014','2020-07-01 18:16:56','1945-10-25','m',NULL,NULL,'n','oque',NULL,76,NULL,'m',NULL,NULL,NULL,NULL,'2020-11-30 17:29:34',NULL,NULL,'11955555555','s','214.512.200-15',NULL,'SSP',NULL,NULL,NULL,NULL,0,NULL),(201,'EEEEEEEEEEEEE',NULL,'2020-07-06 18:11:44','2000-01-01','m','kjh',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-07-06 15:11:44','65465454565',NULL,NULL,'n','efessdvsd',NULL,'SDVDS',NULL,NULL,NULL,NULL,0,NULL),(202,'ATENDENTE','62740225709','2020-07-07 12:53:48','2000-05-05','m',NULL,NULL,'n',NULL,NULL,NULL,1,'f',NULL,NULL,NULL,NULL,'2020-11-26 15:35:35',NULL,NULL,'98416514651','s','disfg87g',NULL,'8GUIJ',NULL,NULL,NULL,NULL,0,NULL),(203,'VISITANTE','40346673038','2020-07-08 15:18:10','2000-01-01','m','MARIA',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-09-08 14:33:46','62998433030',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(205,'TESTE PRO TAMBORE 1 08072020','19120870493','2020-07-08 19:44:05','1991-12-18','m','UZER',NULL,'n',NULL,NULL,77,1,'v',NULL,NULL,NULL,NULL,'2020-07-08 16:50:20','62985094441',NULL,NULL,'n','20870493',NULL,'SSPGO',NULL,NULL,NULL,NULL,0,NULL),(206,'LIB. TEMPORARIO','32462797050','2020-07-09 14:29:04','2000-01-01','m','MARIA',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-07-27 16:10:03','62991505087',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(207,'ARLINDO','64811153103','2020-07-10 16:30:04','2000-12-12','m','ASDASD',NULL,'n',NULL,NULL,78,1,'v',NULL,NULL,NULL,NULL,'2020-10-06 09:23:32','33262622626',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(208,'JOAO UZER','26414150118','2020-07-14 17:18:24','1990-05-09','m','MARIA',NULL,'n',NULL,NULL,79,1,'v',NULL,NULL,NULL,NULL,'2020-10-06 09:23:15','62999999999',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(209,'RAFAEL TESTE','85711779290','2020-07-23 14:11:11','2000-10-10','m','m',NULL,'n',NULL,'Obs de teste',81,1,'v',NULL,NULL,NULL,NULL,'2020-07-23 11:11:15','62989865322',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(211,'DOC TESTE',NULL,'2020-07-23 15:32:34','2000-01-01','m','N',NULL,'n',NULL,NULL,82,NULL,'p',NULL,NULL,NULL,NULL,'2020-07-23 12:33:01','32165841654',NULL,NULL,'n','778899',NULL,'JHG',NULL,NULL,NULL,NULL,0,NULL),(212,'VISITANTE TESTE','96440965093','2020-07-23 19:36:50','2000-01-01','m','Maria',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-07-23 16:36:50','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(213,'MEU VISITANTE','02061640095','2020-07-30 20:03:45','2000-01-01','m','MARIA',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-09-08 14:43:38','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(214,'NOVO VISIT','76687192027','2020-07-31 12:52:29','2001-01-01','m','MARIA',NULL,'n',NULL,NULL,83,1,'v',NULL,NULL,NULL,NULL,'2020-09-08 14:27:36','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(215,'TESTE VISIT','79863781070','2020-09-08 19:01:17','2000-01-01','m','MARIA',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-09-18 08:20:59','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(216,'LEONARO HIROSHI YOKOY HAYAKAWA','04823012100','2020-09-11 18:47:14','2000-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'m',NULL,NULL,NULL,NULL,'2021-03-01 15:59:24',NULL,NULL,'62985658985','s','ergw45',NULL,'SSED',NULL,NULL,NULL,NULL,0,2123),(217,'JOANA DA SILVA','04792492025','2020-10-15 17:16:25','2000-01-01','f','Maria',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-15 14:16:25','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(218,'MAIS UM TESTE','43245206070','2020-10-15 17:17:38','2005-01-01','f','Silva',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-15 14:17:38','00000000000',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(219,'FERNANDA SILVA','96746635414','2020-10-16 20:21:19','2000-12-12','f','asdad',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-16 17:21:19','12121212121',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(220,'CLEUNICE ALMEIDA','85228832203','2020-10-16 20:22:04','2000-12-12','f','asdsad',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-16 17:22:04','12121212121',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(221,'GUSTAVO CAVALCANTI','77222536280','2020-10-16 20:22:53','2000-12-12','m','ASDAD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-16 17:22:53','51454545545',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(222,'ALESSANDRO GONZAGA','51406081620','2020-10-16 20:23:27','2000-12-12','m','ASDASD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-16 17:23:27','12121222222',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(223,'BRUNO MOURA','82723313301','2020-10-16 20:24:00','2000-12-12','m','ASDSAD',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-16 17:24:00','12001212212',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(224,'JOAQUIM','93978200449','2020-10-16 20:43:14','2000-12-12','m','21211',NULL,'n',NULL,'Vão vir alguns amigos juntos',NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-16 17:43:14','12121221221',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(225,'ASDASD','88191677350','2020-10-20 18:50:01','2000-11-11','m','gfdfq',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-10-20 15:52:45','62999999999',NULL,NULL,'n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(226,'JOAQUIM','47467562284','2020-12-02 13:17:36','1991-06-13','m',NULL,NULL,'n',NULL,NULL,NULL,NULL,'p',NULL,NULL,NULL,NULL,'2020-12-02 10:17:36',NULL,NULL,'62985656555','n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(227,'TESTE NOVO','77102337086','2020-12-02 13:43:17','2000-01-01','m','MARIA',NULL,'n',NULL,NULL,NULL,1,'v',NULL,NULL,NULL,NULL,'2020-12-02 10:50:00',NULL,NULL,'00000000000','n',NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL),(228,'GENTE BOA',NULL,'2020-12-07 18:44:48','1995-01-01','m','mae','pai','n',NULL,NULL,0,4,'a','upload/img/pessoa/5fce782099cc6.jpeg',NULL,NULL,NULL,'2020-12-09 09:21:36',NULL,NULL,'62999995555','s','genteboarg',NULL,'GBRG',NULL,NULL,NULL,NULL,0,NULL),(229,'TESTE PRESTADOR',NULL,'2021-01-14 18:58:11','2000-01-01','m',NULL,NULL,'n',NULL,NULL,NULL,1,'p',NULL,NULL,NULL,NULL,'2021-01-14 16:11:54',NULL,NULL,'62654564646','n','abcd',NULL,'SDFG',NULL,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa_esporadica`
--

DROP TABLE IF EXISTS `pessoa_esporadica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa_esporadica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(11) NOT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `tipo_servico` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empresa` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_2` (`id_pessoa`),
  KEY `Index_3` (`empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_esporadica`
--

LOCK TABLES `pessoa_esporadica` WRITE;
/*!40000 ALTER TABLE `pessoa_esporadica` DISABLE KEYS */;
INSERT INTO `pessoa_esporadica` VALUES (1,9,NULL,NULL,NULL,NULL),(2,10,NULL,'Entregador',NULL,'uber'),(3,11,NULL,'Entregador',NULL,'Big lar'),(4,14,NULL,NULL,NULL,NULL),(5,15,NULL,NULL,NULL,NULL),(6,16,NULL,NULL,NULL,NULL),(7,17,NULL,NULL,NULL,NULL),(8,18,NULL,NULL,NULL,NULL),(9,20,NULL,NULL,NULL,NULL),(10,21,NULL,NULL,NULL,NULL),(11,22,NULL,NULL,NULL,NULL),(12,23,NULL,NULL,NULL,NULL),(13,24,NULL,NULL,NULL,NULL),(14,26,NULL,NULL,NULL,NULL),(15,27,NULL,NULL,NULL,NULL),(16,28,NULL,NULL,NULL,NULL),(17,29,NULL,NULL,NULL,NULL),(18,30,NULL,NULL,NULL,NULL),(19,31,NULL,NULL,NULL,NULL),(20,32,NULL,NULL,NULL,NULL),(21,33,NULL,NULL,NULL,NULL),(22,34,NULL,NULL,NULL,NULL),(23,35,NULL,NULL,NULL,NULL),(24,36,NULL,NULL,NULL,NULL),(25,37,NULL,NULL,NULL,NULL),(26,38,NULL,NULL,NULL,NULL),(27,40,NULL,NULL,NULL,NULL),(28,41,NULL,NULL,NULL,NULL),(29,42,NULL,NULL,NULL,NULL),(30,43,NULL,NULL,NULL,NULL),(31,44,NULL,NULL,NULL,NULL),(32,46,NULL,'Motorista',NULL,'Taxi/Uber'),(33,47,NULL,NULL,NULL,NULL),(34,48,NULL,NULL,NULL,NULL),(35,49,NULL,NULL,NULL,NULL),(36,50,NULL,NULL,NULL,NULL),(37,51,NULL,'cargo',NULL,'empresa'),(38,52,NULL,'Motorista',NULL,'Taxi/Uber'),(39,53,NULL,'Entregador',NULL,'entregas'),(40,56,NULL,NULL,NULL,NULL),(41,57,NULL,NULL,NULL,NULL),(42,58,NULL,'Sjjs',NULL,'Jwj'),(43,59,NULL,NULL,NULL,NULL),(44,60,NULL,NULL,NULL,NULL),(45,61,NULL,NULL,NULL,NULL),(46,62,NULL,NULL,NULL,NULL),(47,63,NULL,NULL,NULL,NULL),(48,64,NULL,NULL,NULL,NULL),(49,65,NULL,NULL,NULL,NULL),(50,67,NULL,NULL,NULL,NULL),(51,68,NULL,'Teste',NULL,'Teste'),(52,69,NULL,'Entregador',NULL,'Locarga'),(53,70,NULL,'Motorista',NULL,'Taxi/Uber'),(54,71,NULL,NULL,NULL,NULL),(55,72,NULL,NULL,NULL,NULL),(56,73,NULL,NULL,NULL,NULL),(57,74,NULL,'asdasd',NULL,'asdsad'),(58,75,NULL,NULL,NULL,NULL),(59,76,NULL,NULL,NULL,NULL),(60,19,NULL,NULL,NULL,NULL),(61,77,NULL,NULL,NULL,NULL),(62,78,NULL,NULL,NULL,NULL),(63,79,NULL,NULL,NULL,NULL),(64,80,NULL,'222',NULL,'222'),(65,81,NULL,NULL,NULL,NULL),(66,82,NULL,NULL,NULL,NULL),(67,83,NULL,NULL,NULL,NULL),(68,84,NULL,NULL,NULL,NULL),(69,85,NULL,NULL,NULL,NULL),(70,86,NULL,NULL,NULL,NULL),(71,87,NULL,NULL,NULL,NULL),(72,88,NULL,'Motorista',NULL,'Taxi/Uber'),(73,89,NULL,NULL,NULL,NULL),(74,92,NULL,NULL,NULL,NULL),(75,93,NULL,NULL,NULL,NULL),(76,94,NULL,NULL,NULL,NULL),(77,95,NULL,NULL,NULL,NULL),(78,96,NULL,NULL,NULL,NULL),(79,97,NULL,NULL,NULL,NULL),(80,98,NULL,NULL,NULL,NULL),(81,99,NULL,NULL,NULL,NULL),(82,100,NULL,NULL,NULL,NULL),(83,101,NULL,'Motorista',NULL,'Taxi/Uber'),(84,102,NULL,'Motorista',NULL,'Taxi/Uber'),(85,103,NULL,'Entregador',NULL,'Sjks'),(86,104,NULL,NULL,NULL,NULL),(87,105,NULL,NULL,NULL,NULL),(88,107,NULL,NULL,NULL,NULL),(89,106,NULL,NULL,NULL,NULL),(90,3,NULL,NULL,NULL,NULL),(91,110,NULL,'empresa',NULL,'empresa'),(92,111,NULL,NULL,NULL,NULL),(93,8,NULL,NULL,NULL,NULL),(94,112,NULL,NULL,NULL,NULL),(95,13,NULL,NULL,NULL,NULL),(96,113,NULL,'Gerente',NULL,'Adm'),(97,114,NULL,NULL,NULL,NULL),(98,115,NULL,'Motorista',NULL,'Taxi/Uber'),(99,116,NULL,NULL,NULL,NULL),(100,118,NULL,NULL,NULL,NULL),(101,119,NULL,'Entregador',NULL,'Anan'),(102,121,NULL,NULL,NULL,NULL),(103,122,NULL,'Motorista',NULL,'Taxi/Uber'),(104,123,NULL,NULL,NULL,NULL),(105,124,NULL,'Motorista',NULL,'Taxi/Uber'),(106,125,NULL,'Motorista',NULL,'Taxi/Uber'),(107,126,NULL,NULL,NULL,NULL),(108,128,NULL,NULL,NULL,NULL),(109,129,NULL,NULL,NULL,NULL),(110,130,NULL,NULL,NULL,NULL),(111,134,NULL,NULL,NULL,NULL),(112,135,NULL,'Motorista',NULL,'Taxi/Uber'),(113,137,NULL,NULL,NULL,NULL),(114,140,NULL,NULL,NULL,NULL),(115,141,NULL,'Motorista',NULL,'Taxi/Uber'),(116,144,NULL,NULL,NULL,NULL),(117,145,NULL,NULL,NULL,NULL),(118,146,NULL,NULL,NULL,NULL),(119,147,NULL,'Motorista',NULL,'Taxi/Uber'),(120,148,NULL,NULL,NULL,NULL),(121,149,NULL,'Piscineiro',NULL,'Global Piscinas'),(122,150,NULL,'Entregador',NULL,'IFOOD'),(123,151,NULL,'Motorista',NULL,'Taxi/Uber'),(124,152,NULL,'Entregador',NULL,'Ifood'),(125,153,NULL,'Motorista',NULL,'Taxi/Uber'),(126,154,NULL,'Gerente comercial',NULL,'Vaneli'),(127,158,NULL,NULL,NULL,NULL),(128,159,NULL,'executiva de vendas',NULL,'uzer'),(129,160,NULL,NULL,NULL,NULL),(130,161,NULL,NULL,NULL,NULL),(131,162,NULL,NULL,NULL,NULL),(132,168,NULL,NULL,NULL,NULL),(133,169,NULL,'dasdsad',NULL,'adasda'),(134,170,NULL,'dasdasd',NULL,'asdas'),(135,171,NULL,'sadsd',NULL,'asdsaddad'),(136,172,NULL,'Entregador',NULL,'adfvdfsf'),(137,173,NULL,'Motorista',NULL,'Taxi/Uber'),(138,174,NULL,'dfgsdf',NULL,'dfgs'),(139,176,NULL,'Entregador',NULL,'Ifood'),(140,177,NULL,NULL,NULL,NULL),(141,178,NULL,NULL,NULL,NULL),(142,179,NULL,'Entregador',NULL,'Djd'),(143,180,NULL,'Jdjd',NULL,'Keke'),(144,181,NULL,'Motorista',NULL,'Taxi/Uber'),(145,187,NULL,NULL,NULL,NULL),(146,188,NULL,NULL,NULL,NULL),(147,190,NULL,NULL,NULL,NULL),(148,191,NULL,NULL,NULL,NULL),(149,193,NULL,NULL,NULL,NULL),(150,194,NULL,NULL,NULL,NULL),(151,195,NULL,NULL,NULL,NULL),(152,196,NULL,'Entregador',NULL,'fdgdfg'),(153,197,NULL,'Entregador',NULL,'tryjrytjy'),(154,198,NULL,'hgjfgh',NULL,'hgj'),(155,199,NULL,NULL,NULL,NULL),(156,201,NULL,NULL,NULL,NULL),(157,203,NULL,NULL,NULL,NULL),(158,205,NULL,NULL,NULL,NULL),(159,206,NULL,NULL,NULL,NULL),(160,207,NULL,'hahaha',NULL,'hahah'),(161,208,NULL,'cargo',NULL,'empresa'),(162,209,NULL,NULL,NULL,NULL),(163,210,NULL,NULL,NULL,NULL),(164,211,NULL,'sô',NULL,'uai'),(165,212,NULL,NULL,NULL,NULL),(166,213,NULL,NULL,NULL,NULL),(167,214,NULL,NULL,NULL,NULL),(168,215,NULL,NULL,NULL,NULL),(169,217,NULL,NULL,NULL,NULL),(170,218,NULL,NULL,NULL,NULL),(171,219,NULL,NULL,NULL,NULL),(172,220,NULL,NULL,NULL,NULL),(173,221,NULL,NULL,NULL,NULL),(174,222,NULL,NULL,NULL,NULL),(175,223,NULL,NULL,NULL,NULL),(176,224,NULL,NULL,NULL,NULL),(177,225,NULL,NULL,NULL,NULL),(178,226,NULL,'teste',NULL,'teste'),(179,227,NULL,NULL,NULL,NULL),(180,229,NULL,'gsfg',NULL,'dfgsfgsf');
/*!40000 ALTER TABLE `pessoa_esporadica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa_permanente`
--

DROP TABLE IF EXISTS `pessoa_permanente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa_permanente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(11) NOT NULL,
  `codigo` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pai` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nacionalidade` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `naturalidade` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profissao` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ativo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_imovel` int(11) DEFAULT 0,
  `ultima_atualizacao` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `senha` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `grau_parentesco` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permitir_liberacao` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `associado` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chefe_imediato` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_empresa` int(11) DEFAULT 0,
  `data_vencimento` date DEFAULT NULL,
  `categoria` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_servico` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permitir_cad_permanente` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permitir_acesso_toten` char(1) COLLATE utf8_unicode_ci DEFAULT 's',
  `acesso_somente_sua_localidade` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
  `id_pessoa_autorizante` int(10) unsigned DEFAULT NULL,
  `id_endereco` int(10) unsigned DEFAULT NULL,
  `end_secundario_correspondencia` char(255) COLLATE utf8_unicode_ci DEFAULT 'n',
  `email_alternativo` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modificado_em` timestamp NULL DEFAULT current_timestamp(),
  `morador_prestador` varchar(2) COLLATE utf8_unicode_ci DEFAULT '0',
  `especialidade` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permitir_acesso_historico` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `I_ID_PESSOA` (`id_pessoa`),
  KEY `I_ATIVO` (`ativo`),
  KEY `I_CODIGO` (`codigo`),
  KEY `I_ID_IMOVEL` (`id_imovel`),
  KEY `I_PESSOA_ATIVO_IMOVEL` (`id_pessoa`,`ativo`,`id_imovel`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_permanente`
--

LOCK TABLES `pessoa_permanente` WRITE;
/*!40000 ALTER TABLE `pessoa_permanente` DISABLE KEYS */;
INSERT INTO `pessoa_permanente` VALUES (1,1,'99999','CONDOMINIO','Brasileiro','Goiania','Empresario','suporte01@uzer.com.br','s',3,NULL,NULL,NULL,NULL,'s','s','0',0,NULL,NULL,NULL,NULL,'s','n',NULL,NULL,'n','adm@condominio.com','2019-11-25 19:45:36',NULL,NULL,1),(2,2,'2515',NULL,NULL,NULL,NULL,'alan.medeiros@vozdigital.com.br','s',3,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,2,'n',NULL,'2019-11-25 21:22:02','0',NULL,1),(3,3,'1522','Gonçalves',NULL,NULL,NULL,'rafael.gonzaga@uzer.com.br','s',1,NULL,NULL,NULL,'titular','s','s',NULL,0,NULL,'inquilino',NULL,NULL,'s','n',NULL,NULL,'n',NULL,'2019-11-25 22:25:26',NULL,NULL,1),(4,4,'100','Jose',NULL,NULL,'Teste','jaderson@uzer.com.br','s',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,3,'n',NULL,'2019-11-26 10:42:48','0',NULL,1),(5,5,'1001',NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1969-12-31',NULL,'Empregada',NULL,'s','n',NULL,4,'n',NULL,'2019-11-26 17:01:53','0',NULL,0),(6,6,'1002',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1969-12-31',NULL,'Encanador',NULL,'n','n',NULL,5,'n',NULL,'2019-11-26 17:06:05','0',NULL,0),(7,7,'1003',NULL,NULL,NULL,NULL,'joao@uzer.com.br','s',3,NULL,NULL,NULL,'amigo(a)','s','n',NULL,0,NULL,NULL,NULL,NULL,'n','n',25,NULL,'n','joao@uzer.com.br','2019-11-28 14:05:25',NULL,NULL,0),(8,8,'1010',NULL,NULL,NULL,NULL,'email@email.com','n',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1969-12-31',NULL,NULL,NULL,'s','n',NULL,7,'n','email@email.com','2019-11-29 16:50:51','0',NULL,0),(9,12,'1859',NULL,NULL,NULL,NULL,'rb@uzer.com.br','s',3,NULL,NULL,NULL,'cunhado(a)','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',25,NULL,'n',NULL,'2019-12-02 17:15:49',NULL,NULL,0),(10,13,'1414',NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,NULL,NULL,'afilhado(a)',NULL,'n',NULL,0,NULL,NULL,NULL,NULL,'n','n',NULL,8,'n',NULL,'2019-12-02 19:21:53','0',NULL,0),(11,19,'1313',NULL,NULL,NULL,NULL,'bruno.moura@uzer.com.br','s',14,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,NULL,'s','n',NULL,11,'n','bruno.moura@uzer.com.br','2019-12-04 11:50:52',NULL,NULL,1),(12,25,'1090',NULL,NULL,NULL,NULL,'borges@uzer.com.br','s',3,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,12,'n',NULL,'2019-12-04 12:32:00','0',NULL,0),(13,45,'8951',NULL,NULL,NULL,NULL,'cobrancaetecnologia@ara1.com.br','s',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,NULL,NULL,NULL,'2019-12-11 14:38:12','0',NULL,0),(14,54,'6453',NULL,NULL,NULL,NULL,'sem@cpf.com','s',1,NULL,NULL,NULL,'afilhado(a)','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',19,14,'n',NULL,'2019-12-12 20:20:38',NULL,NULL,0),(15,55,'6565',NULL,NULL,NULL,NULL,'comunicacao@ara1.com.br','n',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,16,'n','comunicacao@ara1.com.br','2019-12-13 10:41:40','0',NULL,0),(16,66,'120',NULL,NULL,NULL,NULL,'apple@apple.com.br','s',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,17,'n','apple@apple.com.br','2019-12-16 12:03:32','0',NULL,0),(17,90,'121',NULL,NULL,NULL,NULL,'anderson.athleticgo@gmail.com','s',10,NULL,NULL,NULL,'afilhado(a)','s','s',NULL,0,NULL,'inquilino',NULL,'s','s','n',NULL,NULL,'n',NULL,'2020-01-08 18:15:35','0',NULL,0),(18,91,'3355',NULL,NULL,NULL,NULL,'voz@digital.com','s',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,18,'n','voz@digital.com','2020-01-11 10:45:00','0',NULL,0),(19,106,'1112',NULL,NULL,NULL,NULL,'pessoa@uzer.com.br','s',3,NULL,NULL,NULL,'afilhado(a)','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',19,NULL,'n',NULL,'2020-02-04 14:35:05',NULL,NULL,0),(20,108,'1329',NULL,NULL,NULL,NULL,'alexandre@uzer.com.br','s',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,19,'n','alexandre@uzer.com.br','2020-02-04 17:19:28','0',NULL,0),(21,109,'123',NULL,NULL,NULL,NULL,'teste@gmail.com','s',8,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,NULL,'n','teste@gmail.com','2020-02-14 10:22:20','0',NULL,0),(22,114,'1515','Tadeu',NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1969-12-31',NULL,NULL,NULL,'n','n',NULL,20,'n',NULL,'2020-02-21 14:09:10','0',NULL,0),(23,117,'1314',NULL,NULL,NULL,NULL,'a1@teste.com.br','n',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,NULL,'n',NULL,'2020-02-28 13:46:14','0',NULL,0),(24,120,'9000','cigano sem nome',NULL,'cigano','cantor','cigano@cigano.com','s',9,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,21,'n','cigano@cigano.com','2020-02-28 14:16:15','0',NULL,0),(25,127,'985',NULL,NULL,NULL,NULL,'homer@teste.com.br','s',5,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,22,'n','homer@teste.com.br','2020-03-03 13:33:00','0',NULL,0),(26,131,'886',NULL,NULL,NULL,NULL,'associado@teste.com.br','s',14,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,NULL,'n',NULL,'2020-03-03 14:13:57','0',NULL,1),(27,132,'887',NULL,NULL,NULL,NULL,'morador@teste.com.br','s',5,NULL,NULL,NULL,'compadre','s','s',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',NULL,NULL,'n',NULL,'2020-03-03 14:18:47',NULL,NULL,0),(28,133,'888',NULL,NULL,NULL,NULL,'morador2@teste.com.br','s',5,NULL,NULL,NULL,'compadre','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',131,NULL,'n',NULL,'2020-03-03 14:33:07',NULL,NULL,0),(29,136,'889',NULL,NULL,NULL,NULL,'zezim@teste.com','s',1,NULL,NULL,NULL,'afilhado(a)','s','n',NULL,0,NULL,'inquilino',NULL,NULL,'s','n',4,24,'n',NULL,'2020-03-05 19:22:31',NULL,NULL,0),(30,138,'1004',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,'companheiro(a)',NULL,'n',NULL,0,NULL,NULL,NULL,NULL,'n','n',NULL,25,'n',NULL,'2020-03-11 17:34:47','0',NULL,0),(31,139,'1005',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1970-01-01',NULL,NULL,NULL,'s','n',NULL,26,'n',NULL,'2020-03-11 18:11:12','0',NULL,0),(32,142,'1025',NULL,NULL,NULL,NULL,'roberto1@gmail.com.br','s',3,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,NULL,NULL,NULL,'2020-03-16 20:02:36','0',NULL,0),(33,143,'1026',NULL,NULL,NULL,NULL,'rafaelad@gmail.com.br','s',14,NULL,NULL,NULL,'filho(a)','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',19,NULL,'n',NULL,'2020-03-16 20:16:31',NULL,NULL,0),(34,155,'255',NULL,NULL,NULL,NULL,'henrique@uzer.com.br','s',11,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,27,'n','henrique@uzer.com.br','2020-04-15 21:01:21','0',NULL,0),(35,156,'310',NULL,NULL,NULL,NULL,'paulovitor@uzer.com.br','s',9,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,NULL,'n','paulovitor@uzer.com.br','2020-04-15 21:02:59','0',NULL,1),(36,157,'4510',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1969-12-31',NULL,'ENTREGADOR',NULL,'s','n',NULL,28,'n',NULL,'2020-04-15 21:07:41','0','personal',0),(37,163,'1122',NULL,NULL,NULL,NULL,'joao.moraes@email.com','s',13,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,30,'n','joao.moraes@email.com','2020-04-29 18:08:32','0',NULL,1),(38,164,'1123',NULL,NULL,NULL,NULL,'marielle.moraes@email.com','s',13,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,NULL,'n',NULL,'2020-04-29 18:18:21','0',NULL,1),(39,165,'1124',NULL,NULL,NULL,NULL,'fernando.moraes@email.com','s',14,NULL,NULL,NULL,'filho(a)','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',19,NULL,'n',NULL,'2020-04-29 18:19:34',NULL,NULL,0),(40,166,'1125',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1969-12-31',NULL,NULL,NULL,'n','n',NULL,31,'n',NULL,'2020-04-29 18:21:15','0',NULL,0),(41,167,'1126',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,'mãe',NULL,'n',NULL,0,NULL,NULL,NULL,NULL,'s','n',NULL,32,'n',NULL,'2020-04-29 18:22:35','0',NULL,0),(42,175,'2170',NULL,NULL,NULL,NULL,'nathalia.mendes@uzer.com.br','s',1,NULL,NULL,NULL,NULL,'s','s',NULL,0,NULL,NULL,NULL,'s','s','n',NULL,33,'n','nathalia.mendes@uzer.com.br','2020-06-08 13:39:58','0',NULL,0),(43,189,'051',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,NULL,'1969-12-31',NULL,NULL,NULL,'n','n',NULL,34,'n',NULL,'2020-06-09 20:28:33','0',NULL,0),(44,192,'9698',NULL,NULL,NULL,NULL,NULL,'s',9,NULL,NULL,NULL,'filho(a)','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',156,NULL,'n',NULL,'2020-06-16 19:24:42',NULL,NULL,0),(45,200,'5555',NULL,NULL,NULL,NULL,'teste@teste.com','n',1,NULL,NULL,NULL,'inquilino','s','s',NULL,0,NULL,'inquilino',NULL,'s','s','n',NULL,35,'n',NULL,'2020-07-01 18:16:56','0',NULL,0),(46,202,'321654',NULL,NULL,NULL,NULL,NULL,'s',NULL,NULL,NULL,NULL,NULL,NULL,'n',NULL,0,NULL,NULL,NULL,NULL,'n','n',NULL,36,'n',NULL,'2020-07-07 12:53:48','0',NULL,0),(47,216,'2180',NULL,NULL,NULL,NULL,NULL,'s',13,NULL,NULL,NULL,'filho(a)','s','n',NULL,0,NULL,'proprietario',NULL,NULL,'s','n',163,NULL,'n',NULL,'2020-09-11 18:47:14',NULL,NULL,0),(48,228,'959697','pai','JAMAICA','JAMAICA',NULL,NULL,'s',NULL,NULL,NULL,NULL,'compadre',NULL,'n',NULL,0,NULL,NULL,NULL,NULL,'s','n',NULL,37,'n',NULL,'2020-12-07 18:44:41','0',NULL,0);
/*!40000 ALTER TABLE `pessoa_permanente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoas_grupos_permanentes`
--

DROP TABLE IF EXISTS `pessoas_grupos_permanentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoas_grupos_permanentes` (
  `id_pessoa` int(11) NOT NULL,
  `id_grupo_permanente` int(11) unsigned NOT NULL,
  KEY `id_pessoa` (`id_pessoa`),
  KEY `id_grupo_permanente` (`id_grupo_permanente`),
  CONSTRAINT `pessoas_grupos_permanentes_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa_permanente` (`id_pessoa`),
  CONSTRAINT `pessoas_grupos_permanentes_ibfk_2` FOREIGN KEY (`id_grupo_permanente`) REFERENCES `grupo_permanente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoas_grupos_permanentes`
--

LOCK TABLES `pessoas_grupos_permanentes` WRITE;
/*!40000 ALTER TABLE `pessoas_grupos_permanentes` DISABLE KEYS */;
/*!40000 ALTER TABLE `pessoas_grupos_permanentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phinxlog`
--

DROP TABLE IF EXISTS `phinxlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phinxlog` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phinxlog`
--

LOCK TABLES `phinxlog` WRITE;
/*!40000 ALTER TABLE `phinxlog` DISABLE KEYS */;
INSERT INTO `phinxlog` VALUES (20170619123149,'CreateCondominioTable','2019-11-25 19:45:30','2019-11-25 19:45:31'),(20170619123151,'CreateConfiguracaoSistemaTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123154,'CreateControleLoginTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123157,'CreateDigitalTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123158,'CreateDispositivoTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123161,'CreateEmpresaTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123162,'CreateEnderecoTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123164,'CreateEntradaTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123167,'CreateFerramentaEntradaTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123168,'CreateFerramentaSaidaTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123169,'CreateFerramentaTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123174,'CreateGrupoPermanenteTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123176,'CreateImovelAgregadoTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123177,'CreateImovelEntradaTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123178,'CreateImovelPermanenteTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123179,'CreateImovelTable','2019-11-25 19:45:31','2019-11-25 19:45:31'),(20170619123191,'CreateLiberacaoTable','2019-11-25 19:45:31','2019-11-25 19:45:32'),(20170619123192,'CreateListaConvidadosTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123193,'CreateLocalidadesTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123194,'CreateModuloSistemaTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123196,'CreateOcorrenciaTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123201,'CreatePeriodoValidadeLiberacaoTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123202,'CreatePermanenciaPrestadorTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123203,'CreatePermissaoCategoriaTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123204,'CreatePermissaoUsuarioTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123205,'CreatePessoaEsporadicaTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123206,'CreatePessoaPermanenteTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123207,'CreatePessoaTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123208,'CreatePortariaTable','2019-11-25 19:45:32','2019-11-25 19:45:32'),(20170619123216,'CreateSaidaTable','2019-11-25 19:45:32','2019-11-25 19:45:33'),(20170619123217,'CreateSituacaoImoveisTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123222,'CreateTipoCredencialAcessoTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123226,'CreateTotenTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123229,'CreateUsuarioTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123230,'CreateValidadeAcessoPermanenteTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123231,'CreateValidadeLiberacaoTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123232,'CreateVeiculoTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123233,'CreateAcessoLocalidadeTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123234,'CreateAcessoTotenTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123236,'CreateAdvertenciaTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123237,'CreateAnimalTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123239,'CreateAtividadeOcorrenciaTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123242,'CreateCameraTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123244,'CreateCategoriaUsuarioTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170619123245,'CreateCnhTable','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170620191108,'AlterConfiguracaoSistemaTabel','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170621115522,'AlterConfiguracaoSistemaHorario','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170629202429,'InsertDadosIniciais','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170703115719,'AlterConfiguracaoSistemaTempoLiberacoes','2019-11-25 19:45:33','2019-11-25 19:45:33'),(20170703143321,'AlterPessoasAddPai','2019-11-25 19:45:33','2019-11-25 19:45:34'),(20170705184524,'AlterTemporarioVariosImoveis','2019-11-25 19:45:34','2019-11-25 19:45:34'),(20170719173214,'AddListaFerramentas','2019-11-25 19:45:34','2019-11-25 19:45:34'),(20170810132111,'AlterAcessoToten','2019-11-25 19:45:34','2019-11-25 19:45:34'),(20170810132532,'CreateCatraca','2019-11-25 19:45:34','2019-11-25 19:45:34'),(20170814130220,'AddModuloPortal','2019-11-25 19:45:34','2019-11-25 19:45:34'),(20170822140121,'CorrecaoLiberacaoCamposExclusao','2019-11-25 19:45:34','2019-11-25 19:45:34'),(20170822185433,'AddRamalTabelaPessoa','2019-11-25 19:45:34','2019-11-25 19:45:35'),(20170925141938,'AlterLiberacaoAddTipoPrestador','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20171006181739,'AlterCpfPessoa','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20171013134010,'CreateEmergenciasTable','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20171117165704,'AlterImovelEntradaTable','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20171129121742,'CreateRamoAtividadeEmpresa','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20171212124510,'AlterImoveisTable','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20171222110534,'AlterPessoaPermanenteCampoChefeImediato','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20171226185915,'AlterTotenAdicionarCampoIp','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20180205105009,'AlterConfigSistemaCamposObrigatorios','2019-11-25 19:45:35','2019-11-25 19:45:35'),(20180219122703,'AlterLiberacaoTable','2019-11-25 19:45:35','2019-11-25 19:45:36'),(20180302123908,'ModulosFinanceirosePermissoes','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180309144555,'CreateAcessoLogin','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180319165029,'AlterTotenTable','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180319169312,'AlterCatracaTable','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180323135321,'AlterPessoaTableDataModify','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180327121207,'AddTotenSincronismoTable','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180405145429,'AddIndexAcessoToten','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180418190739,'AlterImovelTable','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180420175949,'AlterPessoaPermanenteTable','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180507144717,'AlterTotenTableAcesso','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180509164331,'InertNovosModulosPermissoesFinanceiro','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180720184503,'InsertModulosSistemaFinanceiro','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180814151123,'AlterCameraVincularTotem','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180814165154,'AlterTotenAddTipo','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180921223550,'AlterCatracaAddSentido','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180921224433,'AlterCatracaAddTipo','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20180928192846,'AlterAddQtdCaracterCartaoVisitante','2019-11-25 19:45:36','2019-11-25 19:45:36'),(20181001140433,'AlterTotenCorrigirDefinicaoCampos','2019-11-25 19:45:36','2019-11-25 19:45:37'),(20181001153046,'AlterCatracaCorrigirDefinicaoCampos','2019-11-25 19:45:37','2019-11-25 19:45:38'),(20181128230909,'CreateLprTable','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20181220162352,'AlterAddMoradorPrestador','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20181220165016,'AlterAddCampoPrestadorImovelPermanente','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20190109163616,'CreateTerminais','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20190115202410,'AddNovosCamposImovel','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20190117220053,'AddIdExternoPessoa','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20190117223602,'AlterNomePessoa','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20190129153322,'CreateTerminaisSincronismos','2019-11-25 19:45:38','2019-11-25 19:45:38'),(20190204133340,'AlterTerminaisTable','2019-11-25 19:45:38','2019-11-25 19:45:39'),(20190211174928,'AlterTableDigital','2019-11-25 19:45:39','2019-11-25 19:45:39'),(20190215135428,'AlterQtdCaracterOutroDocumento','2019-11-25 19:45:39','2019-11-25 19:45:39'),(20190218144609,'CreateTipoLote','2019-11-25 19:45:39','2019-11-25 19:45:39'),(20190218174133,'AberturaPorBotoeira','2019-11-25 19:45:39','2019-11-25 19:45:39'),(20190219131427,'AddBotoeiraConfiguracaoSistema','2019-11-25 19:45:39','2019-11-25 19:45:39'),(20190220180202,'UpdateColumnsImovel','2019-11-25 19:45:39','2019-11-25 19:45:40'),(20190222194634,'AlterIncluirAreaImovelAgragado','2019-11-25 19:45:40','2019-11-25 19:45:40'),(20190225185640,'AlterDigitalCampoFormatoTemplate','2019-11-25 19:45:40','2019-11-25 19:45:40'),(20190325135720,'AlterTotenCamposAcessoPorCodigoeBiometria','2019-11-25 19:45:40','2019-11-25 19:45:40'),(20190326131529,'CriaIndexVarius','2019-11-25 19:45:40','2019-11-25 19:45:40'),(20190328193340,'AlterTerminaisAddCredenciaisAceitas','2019-11-25 19:45:40','2019-11-25 19:45:40'),(20190401180845,'AlterCorrigeTipoColunas','2019-11-25 19:45:40','2019-11-25 19:45:41'),(20190401202804,'AddIndexVariasTabelas','2019-11-25 19:45:41','2019-11-25 19:45:41'),(20190408131035,'CreateIndexIdImovelTableImovelLiberacao','2019-11-25 19:45:41','2019-11-25 19:45:41'),(20190408131106,'CreateIndexIdImovelTablePessoaPermanente','2019-11-25 19:45:41','2019-11-25 19:45:41'),(20190409213148,'AddImovelImoveisAgregadosDeletados','2019-11-25 19:45:41','2019-11-25 19:45:41'),(20190514190421,'CreateNovoIndexImovelEntrada','2019-11-25 19:45:41','2019-11-25 19:45:41'),(20190520153144,'AlterTerminaisAddDirecao','2019-11-25 19:45:41','2019-11-25 19:45:41'),(20190521172701,'AlterPessoaPermanentePermissaoAcessoToten','2019-11-25 19:45:41','2019-11-25 19:45:42'),(20190522122924,'InsertPermanenteAcademiaConfig','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190523201056,'AddCampoEspecialidades','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190528135349,'AddModuloAcademia','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190529195224,'CreateAcademia','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190605122024,'AddCampoAcademiaValidadeDeAcesso','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190624121632,'AlterTipoParentescoPessoaPermanente','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190625142744,'AlterAcessoTotenAddLpr','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190703144515,'AlterPermanenteAcademiaConfig','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190723144207,'AlterAddPossuiAcademiaConfiguracaoSistema','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190724171008,'AlterAddCamposAcademia','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190730173152,'AlterAddCameraDocumentoConfiguracaoSistema','2019-11-25 19:45:42','2019-11-25 19:45:42'),(20190830134615,'AlterPessoaFotoDocumento','2019-11-25 19:45:42','2019-11-25 19:45:43'),(20190830135131,'AlterCnhFotoCnh','2019-11-25 19:45:43','2019-11-25 19:45:43'),(20190902173731,'AlterTotenAddCameraDocumento','2019-11-25 19:45:43','2019-11-25 19:45:43'),(20190902192846,'AlterLiberacaoAddCnhFotosDocumento','2019-11-25 19:45:43','2019-11-25 19:45:43'),(20190919131203,'AddIndexLiberacaoListaFesta','2019-11-25 19:45:43','2019-11-25 19:45:43'),(20190920205642,'AlterAddIndexPessoaPermanente','2019-11-25 19:45:43','2019-11-25 19:45:43'),(20190920212140,'AddIndexValidadeAcessoPermanente','2019-11-25 19:45:43','2019-11-25 19:45:43'),(20191001203554,'AddIdLiberacaoGrupoLiberacao','2019-11-28 16:00:37','2019-11-28 16:00:37'),(20191008135538,'AlterTipoColunasConfiguracaoSistemaTable','2019-11-28 16:00:37','2019-11-28 16:00:38'),(20191010182705,'AddVeiculoLiberacao','2019-11-28 16:00:38','2019-11-28 16:00:39'),(20191016121057,'AddCpfFilipetaConfiguracaoSistema','2019-11-28 16:00:39','2019-11-28 16:00:39'),(20191023125045,'AddEntradaComAcompanhantes','2019-11-28 16:00:39','2019-11-28 16:00:39'),(20191127135932,'AddSaidaAutomaticaVisitanteConfiguracaoSistema','2019-11-29 20:07:52','2019-11-29 20:07:52'),(20191129195529,'CreateGrupoEntradaSaidaTable','2019-12-03 14:45:04','2019-12-03 14:45:05'),(20191202212036,'AddIndexIdLiberacaoEntradaTable','2019-12-03 14:45:05','2019-12-03 14:45:05'),(20191213132031,'AlterRenameColunmUrlRgFrenteToUrlDocFrenteTablePessoa','2019-12-17 11:41:48','2019-12-17 11:41:49'),(20200128123728,'AddColumnAcessaHistoricoPessoaPermanenteTable','2020-01-28 12:36:21','2020-01-28 12:36:21'),(20200206191305,'UltimaPortariaLogada','2020-02-17 13:54:21','2020-02-17 13:54:21'),(20200316151910,'CorrigeParentesco','2020-03-27 04:10:56','2020-03-27 04:10:56'),(20200330192314,'CorrigeImovelEntradaLiberacao','2020-04-16 12:23:33','2020-04-16 12:23:33'),(20200403210407,'AlterConfiguracaoSistema','2020-07-10 22:16:30','2020-07-10 22:16:31'),(20200408135708,'AddColunmFastPassVeiculoTable','2020-04-16 12:23:33','2020-04-16 12:23:35'),(20200408195006,'AddIndexPessoaVeiculoTable','2020-04-16 12:23:35','2020-04-16 12:23:35'),(20200408201912,'TodosVeiculosMoradoresFastPass','2020-04-16 12:23:35','2020-04-16 12:23:35'),(20200416170136,'CreateLogAuditoriaTable','2020-05-11 18:58:53','2020-05-11 18:58:53'),(20200423144740,'AddAuditoriaModuloSistemaTable','2020-05-11 18:58:53','2020-05-11 18:58:53'),(20200504143808,'AddAcessoVisitanteToten','2020-07-10 22:16:31','2020-07-10 22:16:31'),(20200504144202,'AddCamposCamera','2020-07-10 22:16:31','2020-07-10 22:16:32'),(20200513141732,'AddColumnsAcademiaFinanceiroAtestadoConfigTable','2020-06-09 17:56:48','2020-06-09 17:56:48'),(20200518175400,'AddColumnInstrucoesConfiguracaoSistemaTable','2020-06-09 17:56:48','2020-06-09 17:56:49'),(20200528130730,'AlterColumnDadosLogAuditoriaTable','2020-06-09 17:56:49','2020-06-09 17:56:49'),(20200615135351,'AlterConfiguracaoSistemaAddControleFacial','2020-07-29 13:00:30','2020-07-29 13:00:31'),(20200624144241,'AddColumnTipoVeiculoTableVeiculo','2020-06-24 19:18:50','2020-06-24 19:18:51'),(20200624144259,'AddColumnTipoVeiculoTableLiberacao','2020-06-24 19:18:51','2020-06-24 19:18:52'),(20200629204344,'AlterPessoaTableColumnSexoMascDefault','2020-06-29 20:49:17','2020-06-29 20:49:18'),(20200701212718,'AddColumnExpressaTableLiberacao','2020-07-10 22:16:32','2020-07-10 22:16:33'),(20200702180734,'CreateRastreadorTable','2020-11-10 20:52:20','2020-11-10 20:52:20'),(20200703130626,'AddColumnPlacafilipetaTableConfiguracaoSistema','2020-07-10 22:16:33','2020-07-10 22:16:33'),(20200706123511,'AddColumnLatLngCondominioTable','2020-11-10 20:52:20','2020-11-10 20:52:20'),(20200706123803,'AddColumnLatLngPortariaTable','2020-11-10 20:52:20','2020-11-10 20:52:21'),(20200706123813,'AddColumnLatLngImovelTable','2020-11-10 20:52:21','2020-11-10 20:52:22'),(20200706183447,'AlteraNomeColunaIdPessoaTableLogAudiroria','2020-07-10 22:16:33','2020-07-10 22:16:33'),(20200707141147,'AddIndexIdUserTableLogAuditoria','2020-07-10 22:16:33','2020-07-10 22:16:33'),(20200709122743,'AddColumnExigirPlacaTableConguracaoSistema','2020-07-10 22:16:34','2020-07-10 22:16:34'),(20200715184010,'AddColumnVoltarTelaIniTableConfiguracaoSistema','2020-07-23 14:45:50','2020-07-23 14:45:51'),(20200720204621,'CreatePessoasGruposPermanentesTable','2020-07-23 14:45:51','2020-07-23 14:45:51'),(20200720204628,'CreateTotensGruposPermanentesTable','2020-07-23 14:45:51','2020-07-23 14:45:51'),(20200722140739,'AddColumnTiposSincronizadosTotenTable','2020-07-29 13:00:31','2020-07-29 13:00:31'),(20200731154812,'AddIndexAcademiaTable','2020-11-10 20:52:22','2020-11-10 20:52:22'),(20200807201029,'AlterConfiguracaoSistemarAddPossuiRastreio','2020-11-10 20:52:22','2020-11-10 20:52:22'),(20200811211331,'CreateRastreadorEntradaSaidaTable','2020-11-10 20:52:22','2020-11-10 20:52:22'),(20200811211712,'AddIdRastreadorTabelaEntrada','2020-11-10 20:52:22','2020-11-10 20:52:23'),(20200818130241,'CreateModuloCadastroTemporario','2020-11-26 14:49:14','2020-11-26 14:49:14'),(20200818211224,'AddRastreioModuloSistemaTable','2020-11-10 20:52:23','2020-11-10 20:52:23'),(20201106140308,'AddPlacaEntrada','2020-11-10 20:52:23','2020-11-10 20:52:23'),(20201109124654,'AddPlacaSaida','2020-11-10 20:52:23','2020-11-10 20:52:24'),(20201125142805,'NovoBancoAuditoria','2020-11-26 14:49:14','2020-11-26 14:49:15'),(20201126195032,'AddModuloCadastroLocalidade','2021-02-05 17:46:40','2021-02-05 17:46:40'),(20201130191951,'AlterLocalidadesRemoveCreatedAt','2021-02-05 17:46:40','2021-02-05 17:46:40'),(20201130192144,'AlterLocalidadesRemoveUpdatedAt','2021-02-05 17:46:40','2021-02-05 17:46:41'),(20201130192232,'AlterLocalidadesChangeSoftdeleted','2021-02-05 17:46:41','2021-02-05 17:46:41'),(20201130192319,'AlterLocalidadesAddRowVersion','2021-02-05 17:46:41','2021-02-05 17:46:41'),(20201203134424,'AlterLocalidadesAddIdExterno','2021-02-05 17:46:41','2021-02-05 17:46:42'),(20201204185737,'AlterColumnIdExternoObsImovelTabel','2021-02-05 17:46:42','2021-02-05 17:46:43'),(20201204190225,'CreateTipoPerfilTable','2021-02-05 17:46:43','2021-02-05 17:46:43'),(20201204191243,'AddColunasImovelPermanente','2021-02-05 17:46:43','2021-02-05 17:46:45'),(20201209134331,'AlterTipoColunaImovelPrincipalExcluidoTableImovelPermanente','2021-02-05 17:46:45','2021-02-05 17:46:46'),(20201209142528,'AddColumnResponsavelIdAutorizanteTabelImovelPermanente','2021-02-05 17:46:46','2021-02-05 17:46:47'),(20201214125039,'AddColumnGrauParentescoImovelPermanente','2021-02-05 17:46:47','2021-02-05 17:46:47'),(20201214125741,'CreateClubeTable','2021-02-05 17:46:47','2021-02-05 17:46:47'),(20201214170453,'CreateCessaoUsoTable','2021-02-05 17:46:47','2021-02-05 17:46:47'),(20201214170528,'CreateCessaoUsoClubeTable','2021-02-05 17:46:47','2021-02-05 17:46:48'),(20201215130250,'CreateTipoConvitesTable','2021-02-05 17:46:48','2021-02-05 17:46:48'),(20201215130359,'CreateComprasConvitesTable','2021-02-05 17:46:48','2021-02-05 17:46:48'),(20201215130413,'CreateCompraConvitesTipos','2021-02-05 17:46:48','2021-02-05 17:46:48'),(20201228203137,'AddPermitirLiberacaoEntradaAssociadoConfiguracoSistema','2021-02-05 17:46:48','2021-02-05 17:46:49'),(20210107143146,'AddIdLocalidadePortaria','2021-02-05 17:46:49','2021-02-05 17:46:49'),(20210114014052,'CreatePortariaTipoCredencialAcessoTable','2021-02-05 17:46:49','2021-02-05 17:46:50'),(20210114191525,'CreateSaldoTipoConvitesTable','2021-02-05 17:46:50','2021-02-05 17:46:50'),(20210114191651,'CreateTipoConviteMovimentacoesTable','2021-02-05 17:46:50','2021-02-05 17:46:50'),(20210115141613,'AddColumnClubeSaldoTableLiberacao','2021-02-05 17:46:50','2021-02-05 17:46:52'),(20210115194507,'AlterPessoaTable','2021-02-05 17:46:52','2021-02-05 17:46:54'),(20210123221931,'AlterTotenAddUrlConfig','2021-02-05 17:46:54','2021-02-05 17:46:54'),(20210124222348,'AlterTipoConviteMovimentacoes','2021-02-05 17:46:54','2021-02-05 17:46:55'),(20210125184405,'AddColumnQuantidadePorDireito','2021-02-05 17:46:55','2021-02-05 17:46:55'),(20210126195941,'AddDataHoraTipoConviteMovimentacoes','2021-02-05 17:46:55','2021-02-05 17:46:55'),(20210127145530,'AddPermissoesModuloClube','2021-02-05 17:46:55','2021-02-05 17:46:55'),(20210127175746,'AddColumnAcessoSomenteSuaLocalidadePessoaPermanente','2021-02-05 17:46:55','2021-02-05 17:46:56'),(20210128140739,'UpdateAlterModuloRelatorioCracha','2021-02-05 17:46:56','2021-02-05 17:46:56'),(20210203133722,'AlterCessaoUsoTable','2021-02-09 00:56:44','2021-02-09 00:56:44'),(20210203194151,'AlterTipoCounaSolicitarValidacaoPortariaTipoCredencialAcesso','2021-02-05 17:46:56','2021-02-05 17:46:56'),(20210205172000,'CreateFinanceiroClubeTable','2021-02-09 00:56:44','2021-02-09 00:56:44'),(20210205210707,'CreateObsPessoaEntradaSaidaTable','2021-02-09 00:56:44','2021-02-09 00:56:45');
/*!40000 ALTER TABLE `phinxlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plano_contas`
--

DROP TABLE IF EXISTS `plano_contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plano_contas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Descrição do plano de contas',
  `situacao` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Situação do plano de contas',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plano_contas_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plano_contas`
--

LOCK TABLES `plano_contas` WRITE;
/*!40000 ALTER TABLE `plano_contas` DISABLE KEYS */;
/*!40000 ALTER TABLE `plano_contas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portaria`
--

DROP TABLE IF EXISTS `portaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portaria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descricao` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL,
  `tipo` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_localidade` int(10) unsigned DEFAULT NULL,
  `last_open_update` datetime DEFAULT NULL,
  `latitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_localidade` (`id_localidade`),
  CONSTRAINT `portaria_ibfk_1` FOREIGN KEY (`id_localidade`) REFERENCES `localidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portaria`
--

LOCK TABLES `portaria` WRITE;
/*!40000 ALTER TABLE `portaria` DISABLE KEYS */;
INSERT INTO `portaria` VALUES (1,'Portaria principal','Portaria principal','2016-06-28 11:24:24','social',NULL,'2020-12-09 14:47:35',NULL,NULL),(2,'Portaria de Servico','Portaria de Servico','2021-02-09 13:20:24','servico',NULL,'2021-02-09 17:21:58',NULL,NULL);
/*!40000 ALTER TABLE `portaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portaria_tipo_credencial_acesso`
--

DROP TABLE IF EXISTS `portaria_tipo_credencial_acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portaria_tipo_credencial_acesso` (
  `id_portaria` int(11) NOT NULL,
  `id_tipo_credencial_acesso` int(10) unsigned NOT NULL,
  `solicitar_validacao` varchar(10) NOT NULL,
  PRIMARY KEY (`id_portaria`,`id_tipo_credencial_acesso`),
  KEY `id_tipo_credencial_acesso` (`id_tipo_credencial_acesso`),
  CONSTRAINT `portaria_tipo_credencial_acesso_ibfk_1` FOREIGN KEY (`id_portaria`) REFERENCES `portaria` (`id`),
  CONSTRAINT `portaria_tipo_credencial_acesso_ibfk_2` FOREIGN KEY (`id_tipo_credencial_acesso`) REFERENCES `tipo_credencial_acesso` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portaria_tipo_credencial_acesso`
--

LOCK TABLES `portaria_tipo_credencial_acesso` WRITE;
/*!40000 ALTER TABLE `portaria_tipo_credencial_acesso` DISABLE KEYS */;
INSERT INTO `portaria_tipo_credencial_acesso` VALUES (1,1,'s'),(1,2,'n'),(1,3,'s'),(1,4,'s'),(1,5,'n'),(2,1,'s'),(2,2,'n'),(2,3,'s'),(2,4,'afp'),(2,5,'n');
/*!40000 ALTER TABLE `portaria_tipo_credencial_acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pre_lancamentos`
--

DROP TABLE IF EXISTS `pre_lancamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pre_lancamentos` (
  `id_lancamento` int(10) unsigned NOT NULL,
  `idimovel` int(10) unsigned NOT NULL,
  `observacao` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancelamento` tinyint(1) NOT NULL DEFAULT 0,
  `valor_desconto` decimal(15,2) NOT NULL DEFAULT 0.00,
  `descricao_desconto` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mes` tinyint(4) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `valor_percentual` tinyint(1) DEFAULT NULL,
  `id_centro_custo` int(10) unsigned DEFAULT NULL COMMENT 'ID Centro de custo',
  `id_conta` int(10) unsigned DEFAULT NULL COMMENT 'ID Plano de Contas',
  PRIMARY KEY (`id_lancamento`),
  KEY `pre_lancamentos_idimovel_foreign` (`idimovel`),
  KEY `pre_lancamentos_id_centro_custo_foreign` (`id_centro_custo`),
  KEY `pre_lancamentos_id_conta_foreign` (`id_conta`),
  CONSTRAINT `pre_lancamentos_id_centro_custo_foreign` FOREIGN KEY (`id_centro_custo`) REFERENCES `centro_custos` (`id`),
  CONSTRAINT `pre_lancamentos_id_conta_foreign` FOREIGN KEY (`id_conta`) REFERENCES `contas` (`id`),
  CONSTRAINT `pre_lancamentos_id_lancamento_foreign` FOREIGN KEY (`id_lancamento`) REFERENCES `lancamentos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pre_lancamentos_idimovel_foreign` FOREIGN KEY (`idimovel`) REFERENCES `imovel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pre_lancamentos`
--

LOCK TABLES `pre_lancamentos` WRITE;
/*!40000 ALTER TABLE `pre_lancamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pre_lancamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produtos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idunidade_produto` int(10) unsigned NOT NULL,
  `idgrupo_produto` int(10) unsigned NOT NULL,
  `referencia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `quantidade_minima` int(11) DEFAULT NULL,
  `quantidade_maxima` int(11) DEFAULT NULL,
  `origem` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '0XX – NACIONAL, 1XX – ESTRANGEIRA IMPORTAÇÃO DIRETA, 2XX – ESTRANGEIRA ADQUIRIDA NO MERCADO INTERNO',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `idarea` int(10) unsigned DEFAULT NULL,
  `idcolunas` int(10) unsigned DEFAULT NULL,
  `idsequencia` int(10) unsigned DEFAULT NULL,
  `idrua` int(10) unsigned DEFAULT NULL,
  `idniveis` int(10) unsigned DEFAULT NULL,
  `observacoes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantidade_atual` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `produtos_referencia_unique` (`referencia`),
  KEY `produtos_idunidade_produto_foreign` (`idunidade_produto`),
  KEY `produtos_idgrupo_produto_foreign` (`idgrupo_produto`),
  KEY `produtos_idarea_foreign` (`idarea`),
  KEY `produtos_idcolunas_foreign` (`idcolunas`),
  KEY `produtos_idniveis_foreign` (`idniveis`),
  KEY `produtos_idrua_foreign` (`idrua`),
  KEY `produtos_idsequencia_foreign` (`idsequencia`),
  CONSTRAINT `produtos_idarea_foreign` FOREIGN KEY (`idarea`) REFERENCES `areas` (`id`),
  CONSTRAINT `produtos_idcolunas_foreign` FOREIGN KEY (`idcolunas`) REFERENCES `colunas` (`id`),
  CONSTRAINT `produtos_idgrupo_produto_foreign` FOREIGN KEY (`idgrupo_produto`) REFERENCES `grupo_produtos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `produtos_idniveis_foreign` FOREIGN KEY (`idniveis`) REFERENCES `nivels` (`id`),
  CONSTRAINT `produtos_idrua_foreign` FOREIGN KEY (`idrua`) REFERENCES `ruas` (`id`),
  CONSTRAINT `produtos_idsequencia_foreign` FOREIGN KEY (`idsequencia`) REFERENCES `sequencias` (`id`),
  CONSTRAINT `produtos_idunidade_produto_foreign` FOREIGN KEY (`idunidade_produto`) REFERENCES `unidade_produtos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quitacao_documentos`
--

DROP TABLE IF EXISTS `quitacao_documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quitacao_documentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `conteudo` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quitacao_documentos`
--

LOCK TABLES `quitacao_documentos` WRITE;
/*!40000 ALTER TABLE `quitacao_documentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `quitacao_documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramo_atividade_empresa`
--

DROP TABLE IF EXISTS `ramo_atividade_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ramo_atividade_empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramo_atividade_empresa`
--

LOCK TABLES `ramo_atividade_empresa` WRITE;
/*!40000 ALTER TABLE `ramo_atividade_empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `ramo_atividade_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rastreador`
--

DROP TABLE IF EXISTS `rastreador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rastreador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `id_portaria` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `id_portaria` (`id_portaria`),
  CONSTRAINT `rastreador_ibfk_1` FOREIGN KEY (`id_portaria`) REFERENCES `portaria` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rastreador`
--

LOCK TABLES `rastreador` WRITE;
/*!40000 ALTER TABLE `rastreador` DISABLE KEYS */;
/*!40000 ALTER TABLE `rastreador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rastreador_entrada_saida`
--

DROP TABLE IF EXISTS `rastreador_entrada_saida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rastreador_entrada_saida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_rastreador` int(11) NOT NULL,
  `id_entrada` int(11) NOT NULL,
  `data_entrada` datetime NOT NULL,
  `data_saida` datetime DEFAULT NULL,
  `link_acompanhamento` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_rastreador` (`id_rastreador`),
  KEY `id_entrada` (`id_entrada`),
  CONSTRAINT `rastreador_entrada_saida_ibfk_1` FOREIGN KEY (`id_rastreador`) REFERENCES `rastreador` (`id`),
  CONSTRAINT `rastreador_entrada_saida_ibfk_2` FOREIGN KEY (`id_entrada`) REFERENCES `entrada` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rastreador_entrada_saida`
--

LOCK TABLES `rastreador_entrada_saida` WRITE;
/*!40000 ALTER TABLE `rastreador_entrada_saida` DISABLE KEYS */;
/*!40000 ALTER TABLE `rastreador_entrada_saida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recebimento_parcelas`
--

DROP TABLE IF EXISTS `recebimento_parcelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recebimento_parcelas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `valor` decimal(15,2) NOT NULL,
  `valor_origem` decimal(15,2) NOT NULL DEFAULT 0.00,
  `id_conta_recebimento` int(10) unsigned NOT NULL,
  `id_situacao_inadimplencia` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `valor_recebido` decimal(15,2) NOT NULL DEFAULT 0.00,
  `forma_pagamento` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'DINHEIRO, CHEQUE ou TITULO',
  `data_compensado` date DEFAULT NULL,
  `data_recebimento` date DEFAULT NULL,
  `observacao` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `motivo_cancelamento` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Texto do motivo de cancelamento de recebimentos de parcelas de boletos.',
  `data_cancelamento` date DEFAULT NULL COMMENT 'Data de cancelamento de recebimentos de parcelas de boletos.',
  PRIMARY KEY (`id`),
  KEY `recebimento_parcelas_id_situacao_inadimplencia_foreign` (`id_situacao_inadimplencia`),
  KEY `recebimento_parcelas_id_conta_recebimento_foreign` (`id_conta_recebimento`),
  CONSTRAINT `recebimento_parcelas_id_conta_recebimento_foreign` FOREIGN KEY (`id_conta_recebimento`) REFERENCES `conta_recebimentos` (`id`),
  CONSTRAINT `recebimento_parcelas_id_situacao_inadimplencia_foreign` FOREIGN KEY (`id_situacao_inadimplencia`) REFERENCES `situacao_inadimplencias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recebimento_parcelas`
--

LOCK TABLES `recebimento_parcelas` WRITE;
/*!40000 ALTER TABLE `recebimento_parcelas` DISABLE KEYS */;
/*!40000 ALTER TABLE `recebimento_parcelas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receita_calculos`
--

DROP TABLE IF EXISTS `receita_calculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receita_calculos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_calculo` date NOT NULL,
  `data_vencimento` date NOT NULL,
  `total_despesas_apurada` decimal(15,2) NOT NULL,
  `area_total_apurada` decimal(15,2) NOT NULL,
  `total_imoveis` int(11) NOT NULL,
  `fracao_ideal_rateio` decimal(15,2) NOT NULL,
  `tipo_apuracao` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `percentual_juros` decimal(15,2) NOT NULL,
  `percentual_multa` decimal(15,2) NOT NULL,
  `percentual_fundo_reserva` decimal(15,2) NOT NULL,
  `termo_aprovacao` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receita_calculos`
--

LOCK TABLES `receita_calculos` WRITE;
/*!40000 ALTER TABLE `receita_calculos` DISABLE KEYS */;
/*!40000 ALTER TABLE `receita_calculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receitas`
--

DROP TABLE IF EXISTS `receitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receitas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `percentualmulta` decimal(15,2) NOT NULL,
  `percentualjuros` decimal(15,2) NOT NULL,
  `modalidadejuro` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Juros Composto ou Juros Simples',
  `periodicidadedojuro` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Ano, Mês, Dia, Semestre, Trimestre ou Quadrimestre',
  `incidircorrecao` tinyint(1) NOT NULL,
  `indicecorrecao` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'IGMP, IGPDI, INPC ouIPCA',
  `visualizarinstrucao` tinyint(1) NOT NULL,
  `instrucaosacado` text COLLATE utf8_unicode_ci NOT NULL,
  `localdepagamento` text COLLATE utf8_unicode_ci NOT NULL,
  `anexarprestacaodecontas` tinyint(1) NOT NULL,
  `mesprestacaodeconta` int(11) NOT NULL,
  `versoboleto` tinyint(1) NOT NULL,
  `tempoinadimplencia` int(11) NOT NULL,
  `valortolerancia` decimal(15,2) NOT NULL,
  `id_configuracao_carteira` int(10) unsigned NOT NULL,
  `id_conta_multa` int(10) unsigned NOT NULL,
  `id_conta_juros` int(10) unsigned NOT NULL,
  `id_conta_correcao` int(10) unsigned NOT NULL,
  `id_conta_custas_adicionais` int(10) unsigned NOT NULL,
  `id_conta_desconto` int(10) unsigned NOT NULL,
  `id_tipoinadimplenciapadrao` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_conta_abatimento` int(10) unsigned NOT NULL DEFAULT 1,
  `id_conta_juridico` int(10) unsigned NOT NULL DEFAULT 1,
  `gerenciamento_arvore_centro_custos` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'S' COMMENT 'Flag de sistema para selecionar gerenciamento em formato árvore dos centros de custo.',
  PRIMARY KEY (`id`),
  KEY `receitas_id_configuracao_carteira_foreign` (`id_configuracao_carteira`),
  KEY `receitas_id_tipoinadimplenciapadrao_foreign` (`id_tipoinadimplenciapadrao`),
  KEY `receitas_id_conta_abatimento_foreign` (`id_conta_abatimento`),
  KEY `receitas_id_conta_correcao_foreign` (`id_conta_correcao`),
  KEY `receitas_id_conta_custas_adicionais_foreign` (`id_conta_custas_adicionais`),
  KEY `receitas_id_conta_desconto_foreign` (`id_conta_desconto`),
  KEY `receitas_id_conta_juridico_foreign` (`id_conta_juridico`),
  KEY `receitas_id_conta_juros_foreign` (`id_conta_juros`),
  KEY `receitas_id_conta_multa_foreign` (`id_conta_multa`),
  CONSTRAINT `receitas_id_configuracao_carteira_foreign` FOREIGN KEY (`id_configuracao_carteira`) REFERENCES `configuracao_carteiras` (`id`),
  CONSTRAINT `receitas_id_conta_abatimento_foreign` FOREIGN KEY (`id_conta_abatimento`) REFERENCES `contas` (`id`),
  CONSTRAINT `receitas_id_conta_correcao_foreign` FOREIGN KEY (`id_conta_correcao`) REFERENCES `contas` (`id`),
  CONSTRAINT `receitas_id_conta_custas_adicionais_foreign` FOREIGN KEY (`id_conta_custas_adicionais`) REFERENCES `contas` (`id`),
  CONSTRAINT `receitas_id_conta_desconto_foreign` FOREIGN KEY (`id_conta_desconto`) REFERENCES `contas` (`id`),
  CONSTRAINT `receitas_id_conta_juridico_foreign` FOREIGN KEY (`id_conta_juridico`) REFERENCES `contas` (`id`),
  CONSTRAINT `receitas_id_conta_juros_foreign` FOREIGN KEY (`id_conta_juros`) REFERENCES `contas` (`id`),
  CONSTRAINT `receitas_id_conta_multa_foreign` FOREIGN KEY (`id_conta_multa`) REFERENCES `contas` (`id`),
  CONSTRAINT `receitas_id_tipoinadimplenciapadrao_foreign` FOREIGN KEY (`id_tipoinadimplenciapadrao`) REFERENCES `tipo_inadimplencias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receitas`
--

LOCK TABLES `receitas` WRITE;
/*!40000 ALTER TABLE `receitas` DISABLE KEYS */;
INSERT INTO `receitas` VALUES (1,1.00,1.00,'Juros Composto','Mês',1,'IGMP',1,'Cobrar multa de $MULTA e juros de $JUROS ao mês. Não receber após o dia $DATA_VENCIMENTO.','PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO',1,1,0,4,0.00,1,3,4,5,6,7,1,'2021-02-09 23:01:19','2021-02-09 23:01:19',8,9,'S');
/*!40000 ALTER TABLE `receitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_cobrancas`
--

DROP TABLE IF EXISTS `registro_cobrancas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registro_cobrancas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_boleto` int(10) unsigned NOT NULL,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `id_imovel` int(10) unsigned DEFAULT NULL,
  `endereco` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nome` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `modelo` tinyint(4) NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_envio` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_cobrancas`
--

LOCK TABLES `registro_cobrancas` WRITE;
/*!40000 ALTER TABLE `registro_cobrancas` DISABLE KEYS */;
/*!40000 ALTER TABLE `registro_cobrancas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ruas`
--

DROP TABLE IF EXISTS `ruas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ruas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ruas_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruas`
--

LOCK TABLES `ruas` WRITE;
/*!40000 ALTER TABLE `ruas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ruas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saida`
--

DROP TABLE IF EXISTS `saida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(11) NOT NULL,
  `data_hora_saida` datetime DEFAULT NULL,
  `id_entrada` int(11) DEFAULT NULL,
  `id_usuario_atendente` int(10) unsigned DEFAULT NULL,
  `id_acesso_toten` int(10) unsigned DEFAULT NULL,
  `id_portaria` int(10) unsigned DEFAULT NULL,
  `id_imovel_acesso` int(10) unsigned DEFAULT NULL,
  `obs` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `placa` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_1` (`id_portaria`,`data_hora_saida`,`id_entrada`),
  KEY `Index_5` (`data_hora_saida`,`id_portaria`),
  KEY `index_3` (`id_pessoa`),
  KEY `index_4` (`id_entrada`),
  KEY `index_2` (`id_portaria`)
) ENGINE=InnoDB AUTO_INCREMENT=857 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saida`
--

LOCK TABLES `saida` WRITE;
/*!40000 ALTER TABLE `saida` DISABLE KEYS */;
INSERT INTO `saida` VALUES (1,5,'2019-11-29 12:17:36',2,NULL,5,1,NULL,NULL,NULL),(2,5,'2019-11-29 12:18:34',3,1,NULL,1,NULL,NULL,NULL),(3,5,'2019-11-29 12:19:08',4,1,NULL,1,NULL,NULL,NULL),(4,5,'2019-11-29 12:29:36',7,NULL,12,1,NULL,NULL,NULL),(5,8,'2019-11-29 15:10:55',8,NULL,18,1,NULL,NULL,NULL),(6,8,'2019-11-29 15:11:53',10,NULL,21,1,NULL,NULL,NULL),(7,8,'2019-11-29 15:13:54',11,NULL,26,1,NULL,NULL,NULL),(8,8,'2019-11-29 15:16:00',12,NULL,31,1,NULL,NULL,NULL),(9,8,'2019-11-29 15:16:58',16,NULL,36,1,NULL,NULL,NULL),(10,8,'2019-11-29 15:30:38',17,NULL,38,1,NULL,NULL,NULL),(11,8,'2019-11-29 16:01:31',19,NULL,42,1,NULL,NULL,NULL),(12,5,'2019-12-02 13:51:58',25,1,NULL,0,NULL,NULL,NULL),(13,5,'2019-12-02 14:14:47',26,1,NULL,0,NULL,NULL,NULL),(14,9,'2019-12-02 14:51:15',27,1,NULL,0,NULL,NULL,NULL),(15,10,'2019-12-02 14:57:08',28,1,NULL,0,NULL,NULL,NULL),(16,11,'2019-12-02 15:09:48',29,1,NULL,0,NULL,NULL,NULL),(17,5,'2019-12-04 08:58:43',34,1,NULL,0,NULL,NULL,NULL),(18,18,'2019-12-04 09:46:25',35,1,NULL,0,NULL,NULL,NULL),(19,20,'2019-12-04 09:52:21',36,1,NULL,0,NULL,NULL,NULL),(20,21,'2019-12-04 10:18:01',37,1,NULL,0,NULL,NULL,NULL),(21,26,'2019-12-04 10:39:30',40,1,NULL,0,NULL,NULL,NULL),(22,27,'2019-12-04 10:39:30',41,1,NULL,0,NULL,NULL,NULL),(23,29,'2019-12-04 10:40:33',42,1,NULL,0,NULL,NULL,NULL),(24,30,'2019-12-04 10:57:16',43,1,NULL,0,NULL,NULL,NULL),(25,32,'2019-12-04 10:59:20',45,1,NULL,0,NULL,NULL,NULL),(26,31,'2019-12-04 11:04:45',44,1,NULL,0,NULL,NULL,NULL),(27,33,'2019-12-04 11:08:34',46,1,NULL,0,NULL,NULL,NULL),(28,34,'2019-12-04 11:11:10',47,1,NULL,0,NULL,NULL,NULL),(29,35,'2019-12-04 11:30:02',48,1,NULL,0,NULL,NULL,NULL),(30,36,'2019-12-04 11:30:02',49,1,NULL,0,NULL,NULL,NULL),(31,37,'2019-12-04 15:59:21',50,1,NULL,0,NULL,NULL,NULL),(32,43,'2019-12-06 09:49:49',53,1,NULL,1,NULL,NULL,NULL),(33,3,'2019-12-09 18:05:46',55,1,NULL,1,1,NULL,NULL),(34,6,'2019-12-10 17:32:49',57,1,NULL,0,NULL,NULL,NULL),(35,6,'2019-12-10 17:33:16',58,1,NULL,0,NULL,NULL,NULL),(36,5,'2019-12-10 17:38:57',59,1,NULL,0,NULL,NULL,NULL),(37,46,'2019-12-12 10:13:32',61,1,NULL,0,NULL,NULL,NULL),(38,47,'2019-12-12 10:16:42',62,1,NULL,0,NULL,NULL,NULL),(39,48,'2019-12-12 10:19:29',63,1,NULL,0,NULL,NULL,NULL),(40,49,'2019-12-12 10:22:29',64,1,NULL,0,NULL,NULL,NULL),(41,52,'2019-12-12 15:53:50',67,1,NULL,0,NULL,NULL,NULL),(42,50,'2019-12-12 15:58:00',65,1,NULL,0,NULL,NULL,NULL),(43,51,'2019-12-12 15:58:00',66,1,NULL,0,NULL,NULL,NULL),(44,53,'2019-12-12 15:58:00',68,1,NULL,0,NULL,NULL,NULL),(45,6,'2019-12-13 09:04:58',69,1,NULL,0,NULL,NULL,NULL),(46,56,'2019-12-13 10:26:46',71,1,NULL,0,NULL,NULL,NULL),(47,57,'2019-12-13 10:27:07',72,1,NULL,0,NULL,NULL,NULL),(48,58,'2019-12-13 11:21:38',73,1,NULL,0,NULL,NULL,NULL),(49,59,'2019-12-13 11:21:42',74,1,NULL,0,NULL,NULL,NULL),(50,59,'2019-12-13 11:24:07',75,1,NULL,0,NULL,NULL,NULL),(51,59,'2019-12-13 11:26:51',76,1,NULL,0,NULL,NULL,NULL),(52,60,'2019-12-13 14:10:05',77,1,NULL,0,NULL,NULL,NULL),(53,60,'2019-12-13 14:15:43',78,1,NULL,0,NULL,NULL,NULL),(54,60,'2019-12-13 14:34:31',79,1,NULL,0,NULL,NULL,NULL),(55,10,'2019-12-13 16:25:15',80,1,NULL,1,NULL,NULL,NULL),(56,62,'2019-12-13 17:12:43',82,1,NULL,0,NULL,NULL,NULL),(57,49,'2019-12-13 17:15:26',83,1,NULL,0,NULL,NULL,NULL),(58,65,'2019-12-16 09:07:59',84,1,NULL,0,NULL,NULL,NULL),(59,67,'2019-12-16 12:02:19',85,1,NULL,0,NULL,NULL,NULL),(60,68,'2019-12-16 12:03:32',86,1,NULL,0,NULL,NULL,NULL),(61,69,'2019-12-16 12:04:29',87,1,NULL,0,NULL,NULL,NULL),(62,70,'2019-12-16 12:05:41',88,1,NULL,0,NULL,NULL,NULL),(63,72,'2019-12-17 17:42:50',89,1,NULL,0,NULL,NULL,NULL),(64,72,'2019-12-17 17:46:31',90,1,NULL,0,NULL,NULL,NULL),(65,72,'2019-12-17 17:47:06',91,1,NULL,0,NULL,NULL,NULL),(66,72,'2019-12-17 17:47:11',92,1,NULL,0,NULL,NULL,NULL),(67,72,'2019-12-17 17:52:37',93,1,NULL,0,NULL,NULL,NULL),(68,76,'2019-12-17 18:14:17',94,1,NULL,0,NULL,NULL,NULL),(69,19,'2019-12-17 18:14:17',95,1,NULL,0,1,NULL,NULL),(70,77,'2019-12-17 18:14:17',96,1,NULL,0,NULL,NULL,NULL),(71,78,'2019-12-17 18:14:17',97,1,NULL,0,NULL,NULL,NULL),(72,6,'2019-12-17 18:15:46',70,1,NULL,0,NULL,NULL,NULL),(73,6,'2019-12-17 18:17:33',98,1,NULL,0,NULL,NULL,NULL),(74,79,'2019-12-17 18:55:01',99,1,NULL,0,NULL,NULL,NULL),(75,19,'2019-12-17 18:55:01',100,1,NULL,0,1,NULL,NULL),(76,81,'2019-12-18 10:05:58',102,1,NULL,0,NULL,NULL,NULL),(77,82,'2019-12-18 17:34:00',103,1,NULL,0,NULL,NULL,NULL),(78,86,'2019-12-19 12:12:16',106,1,NULL,0,NULL,NULL,NULL),(79,88,'2019-12-19 12:34:04',107,1,NULL,0,NULL,NULL,NULL),(80,88,'2019-12-19 12:37:31',108,1,NULL,0,NULL,NULL,NULL),(81,88,'2019-12-19 12:38:35',109,1,NULL,0,NULL,NULL,NULL),(82,88,'2019-12-19 13:00:21',110,1,NULL,0,NULL,NULL,NULL),(87,4,'2020-01-27 11:44:40',112,1,NULL,0,1,NULL,NULL),(88,4,'2020-01-27 18:37:13',112,1,NULL,0,1,NULL,NULL),(89,4,'2020-01-27 18:37:28',112,1,NULL,0,1,NULL,NULL),(90,4,'2020-01-27 18:37:37',112,1,NULL,0,1,NULL,NULL),(91,4,'2020-01-27 18:37:54',113,1,NULL,0,1,NULL,NULL),(92,12,'2020-01-30 11:42:46',114,1,NULL,0,1,NULL,NULL),(93,92,'2020-01-30 14:58:52',115,1,NULL,0,NULL,NULL,NULL),(94,93,'2020-01-30 15:10:49',116,1,NULL,0,NULL,NULL,NULL),(95,92,'2020-01-30 15:18:30',117,1,NULL,0,NULL,NULL,NULL),(96,19,'2020-01-31 18:06:45',118,1,NULL,0,1,NULL,NULL),(97,94,'2020-02-03 12:15:57',119,1,NULL,0,NULL,NULL,NULL),(98,93,'2020-02-03 14:54:51',120,1,NULL,0,NULL,NULL,NULL),(99,96,'2020-02-03 16:19:04',122,1,NULL,0,NULL,NULL,NULL),(100,92,'2020-02-03 16:20:27',123,1,NULL,0,NULL,NULL,NULL),(101,96,'2020-02-03 17:03:09',124,1,NULL,0,NULL,NULL,NULL),(102,97,'2020-02-03 17:05:12',125,1,NULL,0,NULL,NULL,NULL),(103,98,'2020-02-03 17:13:57',126,1,NULL,0,NULL,NULL,NULL),(104,100,'2020-02-04 10:06:10',128,1,NULL,0,NULL,NULL,NULL),(105,99,'2020-02-04 10:15:38',127,1,NULL,0,NULL,NULL,NULL),(106,100,'2020-02-04 10:18:24',130,1,NULL,0,NULL,NULL,NULL),(107,100,'2020-02-04 10:20:14',131,1,NULL,0,NULL,NULL,NULL),(108,101,'2020-02-04 10:30:30',133,1,NULL,0,NULL,NULL,NULL),(109,105,'2020-02-04 10:59:11',136,1,NULL,0,NULL,NULL,NULL),(110,2,'2020-02-04 11:59:01',138,1,NULL,0,2,NULL,NULL),(111,2,'2020-02-04 11:59:05',138,1,NULL,0,2,NULL,NULL),(112,6,'2020-02-04 12:00:44',140,1,NULL,0,NULL,NULL,NULL),(113,2,'2020-02-04 12:05:16',139,1,NULL,0,2,NULL,NULL),(114,2,'2020-02-04 12:09:41',142,1,NULL,0,3,NULL,NULL),(115,107,'2020-02-04 15:12:37',143,1,NULL,0,NULL,NULL,NULL),(116,105,'2020-02-05 14:48:54',144,1,NULL,0,NULL,NULL,NULL),(117,105,'2020-02-05 14:50:24',145,1,NULL,0,NULL,NULL,NULL),(118,105,'2020-02-05 14:50:44',146,1,NULL,0,NULL,NULL,NULL),(119,102,'2020-02-05 14:50:59',134,1,NULL,0,NULL,NULL,NULL),(120,98,'2020-02-05 16:59:27',149,1,NULL,0,NULL,NULL,NULL),(121,109,'2020-02-14 08:24:55',151,1,NULL,0,3,NULL,NULL),(122,109,'2020-02-14 08:42:25',152,1,NULL,0,8,NULL,NULL),(123,110,'2020-02-17 09:26:19',153,1,NULL,0,NULL,NULL,NULL),(124,111,'2020-02-17 11:02:07',155,1,NULL,1,NULL,NULL,NULL),(125,4,'2020-02-17 15:01:49',158,1,NULL,0,1,NULL,NULL),(126,13,'2020-02-19 09:17:15',159,1,NULL,0,NULL,NULL,NULL),(127,13,'2020-02-19 09:23:47',160,1,NULL,0,NULL,NULL,NULL),(128,113,'2020-02-21 09:40:39',161,1,NULL,0,NULL,NULL,NULL),(129,114,'2020-02-21 11:33:03',164,1,NULL,0,NULL,NULL,NULL),(130,114,'2020-02-21 11:44:19',163,1,NULL,0,NULL,NULL,NULL),(131,4,'2020-02-28 08:43:27',167,1,NULL,0,1,NULL,NULL),(132,115,'2020-02-28 08:54:44',168,1,NULL,0,NULL,NULL,NULL),(133,12,'2020-02-28 09:11:52',169,1,NULL,0,1,NULL,NULL),(134,116,'2020-02-28 10:46:26',170,1,NULL,0,NULL,NULL,NULL),(135,116,'2020-02-28 10:54:21',171,1,NULL,0,NULL,NULL,NULL),(136,114,'2020-02-28 11:19:27',174,1,NULL,0,NULL,'saiu',NULL),(137,121,'2020-02-28 11:46:28',175,1,NULL,1,NULL,NULL,NULL),(138,122,'2020-02-28 11:48:16',177,1,NULL,1,NULL,NULL,NULL),(139,121,'2020-02-28 11:49:57',176,1,NULL,1,NULL,NULL,NULL),(140,126,'2020-03-02 14:12:08',181,1,NULL,0,NULL,NULL,NULL),(141,126,'2020-03-02 14:13:18',182,1,NULL,0,NULL,NULL,NULL),(142,126,'2020-03-02 14:16:49',183,1,NULL,1,NULL,NULL,NULL),(143,128,'2020-03-03 10:52:10',184,1,NULL,0,NULL,NULL,NULL),(144,128,'2020-03-03 10:53:39',185,1,NULL,0,NULL,NULL,NULL),(145,129,'2020-03-03 10:56:58',186,1,NULL,0,NULL,NULL,NULL),(146,129,'2020-03-03 11:01:53',187,1,NULL,0,NULL,NULL,NULL),(147,130,'2020-03-03 11:01:56',188,1,NULL,0,NULL,NULL,NULL),(148,128,'2020-03-03 14:02:49',189,1,NULL,0,NULL,NULL,NULL),(149,135,'2020-03-04 09:29:32',191,1,NULL,0,NULL,NULL,NULL),(150,138,'2020-03-11 15:05:26',192,1,NULL,0,NULL,NULL,NULL),(151,139,'2020-03-12 14:03:34',193,1,NULL,0,NULL,NULL,NULL),(152,140,'2020-03-16 10:46:27',194,1,NULL,1,NULL,NULL,NULL),(153,140,'2020-03-16 10:58:56',195,1,NULL,1,NULL,NULL,NULL),(154,140,'2020-03-16 11:00:17',196,1,NULL,1,NULL,NULL,NULL),(155,140,'2020-03-16 11:02:10',197,1,NULL,1,NULL,NULL,NULL),(156,54,'2020-03-16 12:02:37',206,1,NULL,1,1,NULL,NULL),(157,139,'2020-03-16 12:03:28',205,1,NULL,1,NULL,NULL,NULL),(158,141,'2020-03-16 12:21:44',211,1,NULL,1,NULL,NULL,NULL),(159,141,'2020-03-16 12:22:49',212,1,NULL,1,NULL,NULL,NULL),(160,141,'2020-03-16 12:23:33',213,1,NULL,1,NULL,NULL,NULL),(161,149,'2020-03-17 10:47:14',221,1,NULL,0,NULL,NULL,NULL),(162,111,'2020-03-17 10:54:53',156,1,NULL,0,NULL,NULL,NULL),(163,111,'2020-03-17 13:04:40',228,1,NULL,0,NULL,NULL,NULL),(164,154,'2020-03-17 13:04:44',227,1,NULL,0,NULL,NULL,NULL),(165,153,'2020-03-17 13:05:04',226,1,NULL,0,NULL,NULL,NULL),(166,152,'2020-03-17 13:05:35',225,1,NULL,0,NULL,NULL,NULL),(167,151,'2020-03-17 13:11:15',224,1,NULL,0,NULL,NULL,NULL),(168,150,'2020-03-17 13:11:37',223,1,NULL,0,NULL,NULL,NULL),(169,4,'2020-03-17 13:12:04',201,1,NULL,0,1,NULL,NULL),(170,149,'2020-03-17 13:12:23',222,1,NULL,0,NULL,NULL,NULL),(171,146,'2020-03-17 13:13:34',218,1,NULL,0,NULL,NULL,NULL),(172,147,'2020-03-17 13:13:41',219,1,NULL,0,NULL,NULL,NULL),(173,148,'2020-03-17 13:13:46',220,1,NULL,0,NULL,NULL,NULL),(174,4,'2020-03-17 13:14:23',201,1,NULL,0,1,NULL,NULL),(175,147,'2020-03-17 14:53:30',232,1,NULL,0,NULL,NULL,NULL),(176,147,'2020-03-17 14:58:29',233,1,NULL,0,NULL,NULL,NULL),(177,147,'2020-03-17 15:21:25',236,1,NULL,0,NULL,NULL,NULL),(178,147,'2020-03-17 15:26:35',237,1,NULL,0,NULL,NULL,NULL),(179,3,'2020-03-27 00:47:06',302,1,NULL,1,1,NULL,NULL),(180,3,'2020-03-27 01:36:36',334,1,NULL,1,1,NULL,NULL),(181,3,'2020-03-27 01:36:37',334,1,NULL,1,1,NULL,NULL),(182,3,'2020-03-27 01:38:31',334,1,NULL,1,1,NULL,NULL),(183,3,'2020-03-27 01:49:38',343,1,NULL,1,1,NULL,NULL),(184,3,'2020-03-27 01:49:54',344,1,NULL,1,1,NULL,NULL),(185,3,'2020-03-27 02:06:58',345,1,NULL,1,1,NULL,NULL),(186,3,'2020-03-27 02:08:04',346,1,NULL,1,1,NULL,NULL),(187,3,'2020-03-27 18:17:05',353,1,NULL,1,1,NULL,NULL),(188,3,'2020-03-27 18:21:20',354,1,NULL,1,1,NULL,NULL),(189,3,'2020-03-27 18:45:56',NULL,NULL,6,1,1,NULL,NULL),(190,3,'2020-03-27 18:48:47',NULL,NULL,2,1,1,NULL,NULL),(191,3,'2020-03-28 18:16:40',NULL,NULL,1,1,1,NULL,NULL),(192,3,'2020-03-28 18:21:18',NULL,NULL,1,1,1,NULL,NULL),(193,4,'2020-03-28 18:26:22',NULL,NULL,3,1,1,NULL,NULL),(194,4,'2020-03-28 18:28:55',NULL,NULL,1,1,1,NULL,NULL),(195,4,'2020-03-28 18:30:29',NULL,NULL,2,1,1,NULL,NULL),(196,4,'2020-03-28 18:32:37',NULL,NULL,3,1,1,NULL,NULL),(197,4,'2020-03-28 18:38:20',NULL,NULL,4,1,1,NULL,NULL),(198,4,'2020-03-28 18:39:05',NULL,NULL,5,1,1,NULL,NULL),(199,3,'2020-03-28 18:43:08',NULL,NULL,6,1,1,NULL,NULL),(200,3,'2020-03-28 18:55:15',NULL,NULL,7,1,1,NULL,NULL),(201,3,'2020-03-29 22:40:09',NULL,NULL,11,1,1,NULL,NULL),(202,3,'2020-03-29 22:46:31',NULL,NULL,9,1,1,NULL,NULL),(203,3,'2020-03-30 00:12:50',NULL,NULL,12,1,1,NULL,NULL),(204,3,'2020-03-30 00:25:48',NULL,NULL,16,1,1,NULL,NULL),(205,3,'2020-03-30 01:28:47',NULL,NULL,22,1,1,NULL,NULL),(206,3,'2020-03-30 01:30:22',NULL,NULL,23,1,1,NULL,NULL),(207,3,'2020-03-30 01:33:09',NULL,NULL,24,1,1,NULL,NULL),(208,3,'2020-03-30 01:34:42',NULL,NULL,26,1,1,NULL,NULL),(209,3,'2020-03-30 01:35:55',NULL,NULL,27,1,1,NULL,NULL),(210,3,'2020-03-30 01:37:11',NULL,NULL,29,1,1,NULL,NULL),(211,3,'2020-03-30 01:38:23',NULL,NULL,28,1,1,NULL,NULL),(212,3,'2020-03-30 01:39:40',NULL,NULL,30,1,1,NULL,NULL),(213,3,'2020-03-30 01:49:46',NULL,NULL,33,1,1,NULL,NULL),(214,3,'2020-03-30 01:51:59',NULL,NULL,34,1,1,NULL,NULL),(215,3,'2020-03-30 01:52:49',NULL,NULL,35,1,1,NULL,NULL),(216,3,'2020-03-30 01:59:24',NULL,NULL,39,1,1,NULL,NULL),(217,1,'2020-03-30 02:55:47',NULL,NULL,58,1,3,NULL,NULL),(218,1,'2020-03-30 13:52:26',NULL,NULL,75,1,3,NULL,NULL),(219,1,'2020-03-30 13:54:23',NULL,NULL,77,1,3,NULL,NULL),(220,1,'2020-03-30 13:56:47',NULL,NULL,81,1,3,NULL,NULL),(221,3,'2020-03-30 13:59:00',NULL,NULL,83,1,1,NULL,NULL),(222,4,'2020-03-30 14:57:52',NULL,NULL,3,1,1,NULL,NULL),(223,4,'2020-03-30 15:00:13',NULL,NULL,5,1,1,NULL,NULL),(224,4,'2020-03-30 15:01:24',NULL,NULL,7,1,1,NULL,NULL),(225,3,'2020-03-30 15:04:17',NULL,NULL,10,1,1,NULL,NULL),(226,4,'2020-03-30 15:07:13',NULL,NULL,14,1,1,NULL,NULL),(227,4,'2020-03-30 15:08:45',NULL,NULL,16,1,1,NULL,NULL),(228,4,'2020-03-30 15:09:40',NULL,NULL,18,1,1,NULL,NULL),(229,4,'2020-03-30 15:10:24',NULL,NULL,20,1,1,NULL,NULL),(230,4,'2020-03-30 15:14:11',NULL,NULL,24,1,1,NULL,NULL),(231,4,'2020-03-30 15:14:32',NULL,NULL,25,1,1,NULL,NULL),(232,4,'2020-03-30 15:15:15',NULL,NULL,27,1,1,NULL,NULL),(233,3,'2020-03-30 15:15:56',NULL,NULL,29,1,1,NULL,NULL),(234,4,'2020-03-30 15:16:08',NULL,NULL,30,1,1,NULL,NULL),(235,4,'2020-03-30 15:17:12',NULL,NULL,32,1,1,NULL,NULL),(236,4,'2020-03-30 15:17:48',NULL,NULL,34,1,1,NULL,NULL),(237,3,'2020-03-30 15:21:14',NULL,NULL,39,1,1,NULL,NULL),(238,4,'2020-03-30 15:21:59',NULL,NULL,40,1,1,NULL,NULL),(239,4,'2020-03-30 15:24:05',NULL,NULL,42,1,1,NULL,NULL),(240,95,'2020-04-02 11:02:14',121,1,NULL,2,NULL,NULL,NULL),(241,95,'2020-04-02 11:09:36',390,1,NULL,2,NULL,NULL,NULL),(242,96,'2020-04-02 13:44:48',391,1,NULL,2,NULL,NULL,NULL),(243,21,'2020-04-02 13:45:19',38,1,NULL,2,NULL,NULL,NULL),(244,116,'2020-04-02 13:46:22',392,1,NULL,2,NULL,NULL,NULL),(245,110,'2020-04-02 13:47:19',154,1,NULL,2,NULL,NULL,NULL),(246,3,'2020-04-06 14:55:10',NULL,NULL,155,1,1,NULL,NULL),(247,3,'2020-04-06 15:03:32',NULL,NULL,158,1,1,NULL,NULL),(248,3,'2020-04-06 15:06:22',NULL,NULL,162,1,1,NULL,NULL),(249,3,'2020-04-09 14:38:44',NULL,NULL,266,1,1,NULL,NULL),(250,157,'2020-04-15 18:11:21',403,1,NULL,1,NULL,NULL,NULL),(251,157,'2020-04-15 18:11:47',404,1,NULL,1,NULL,NULL,NULL),(252,157,'2020-04-16 14:39:20',405,1,NULL,1,NULL,NULL,NULL),(253,3,'2020-04-17 14:25:14',NULL,NULL,332,1,1,NULL,NULL),(254,3,'2020-04-17 14:35:27',NULL,NULL,338,1,1,NULL,NULL),(255,3,'2020-04-17 14:40:04',NULL,NULL,341,1,1,NULL,NULL),(256,3,'2020-04-17 14:41:31',NULL,NULL,2,1,1,NULL,NULL),(257,3,'2020-04-17 14:43:09',NULL,NULL,5,1,1,NULL,NULL),(258,3,'2020-04-17 14:51:52',NULL,NULL,9,1,1,NULL,NULL),(259,3,'2020-04-17 14:58:37',NULL,NULL,3,1,1,NULL,NULL),(260,3,'2020-04-17 15:00:42',NULL,NULL,6,1,1,NULL,NULL),(261,3,'2020-04-17 15:56:18',NULL,NULL,3,1,1,NULL,NULL),(262,3,'2020-04-17 15:57:26',NULL,NULL,6,1,1,NULL,NULL),(263,3,'2020-04-17 15:59:55',NULL,NULL,9,1,1,NULL,NULL),(264,4,'2020-04-17 16:18:21',NULL,NULL,12,1,1,NULL,NULL),(265,4,'2020-04-17 16:51:48',NULL,NULL,22,1,1,NULL,NULL),(266,4,'2020-04-17 17:01:18',NULL,NULL,25,1,1,NULL,NULL),(267,4,'2020-04-17 17:02:38',NULL,NULL,27,1,1,NULL,NULL),(268,4,'2020-04-17 17:55:52',NULL,NULL,43,1,1,NULL,NULL),(269,4,'2020-04-17 17:56:58',NULL,NULL,44,1,1,NULL,NULL),(270,4,'2020-04-17 18:00:05',NULL,NULL,46,1,1,NULL,NULL),(271,4,'2020-04-17 18:01:00',NULL,NULL,47,1,1,NULL,NULL),(272,4,'2020-04-17 18:03:00',NULL,NULL,51,1,1,NULL,NULL),(273,4,'2020-04-17 18:05:56',NULL,NULL,53,1,1,NULL,NULL),(274,4,'2020-04-17 18:06:47',NULL,NULL,54,1,1,NULL,NULL),(275,4,'2020-04-17 18:11:15',NULL,NULL,56,1,1,NULL,NULL),(276,4,'2020-04-17 18:46:16',NULL,NULL,67,1,1,NULL,NULL),(277,4,'2020-04-17 18:46:33',NULL,NULL,68,1,1,NULL,NULL),(278,4,'2020-04-17 18:47:14',NULL,NULL,69,1,1,NULL,NULL),(279,4,'2020-04-17 18:49:29',NULL,NULL,72,1,1,NULL,NULL),(280,4,'2020-04-17 18:50:50',NULL,NULL,76,1,1,NULL,NULL),(281,4,'2020-04-17 18:51:23',NULL,NULL,77,1,1,NULL,NULL),(282,4,'2020-04-17 18:52:23',NULL,NULL,80,1,1,NULL,NULL),(283,4,'2020-04-17 18:54:39',NULL,NULL,82,1,1,NULL,NULL),(284,4,'2020-04-17 19:02:32',NULL,NULL,86,1,1,NULL,NULL),(285,4,'2020-04-17 19:05:04',NULL,NULL,89,1,1,NULL,NULL),(286,159,'2020-04-20 10:49:56',429,1,NULL,1,NULL,NULL,NULL),(287,157,'2020-04-20 11:35:06',430,1,NULL,1,NULL,NULL,NULL),(288,157,'2020-04-20 11:36:02',431,1,NULL,1,NULL,NULL,NULL),(289,157,'2020-04-20 11:39:50',433,1,NULL,1,NULL,NULL,NULL),(290,4,'2020-04-20 18:11:05',NULL,NULL,153,1,1,NULL,NULL),(291,4,'2020-04-20 18:41:00',NULL,NULL,168,1,1,NULL,NULL),(292,4,'2020-04-20 18:43:50',NULL,NULL,171,1,1,NULL,NULL),(293,4,'2020-04-22 09:53:32',NULL,NULL,190,1,1,NULL,NULL),(294,4,'2020-04-22 09:56:42',NULL,NULL,193,1,1,NULL,NULL),(295,4,'2020-04-22 09:58:41',NULL,NULL,194,1,1,NULL,NULL),(296,4,'2020-04-22 10:00:42',NULL,NULL,195,1,1,NULL,NULL),(297,4,'2020-04-22 10:02:30',NULL,NULL,196,1,1,NULL,NULL),(298,4,'2020-04-22 10:03:46',NULL,NULL,197,1,1,NULL,NULL),(299,4,'2020-04-22 10:04:24',NULL,NULL,200,1,1,NULL,NULL),(300,4,'2020-04-22 10:09:18',NULL,NULL,201,1,1,NULL,NULL),(301,4,'2020-04-22 10:11:33',NULL,NULL,202,1,1,NULL,NULL),(302,4,'2020-04-22 10:13:13',NULL,NULL,203,1,1,NULL,NULL),(303,4,'2020-04-22 10:14:13',NULL,NULL,204,1,1,NULL,NULL),(304,4,'2020-04-22 10:15:59',NULL,NULL,206,1,1,NULL,NULL),(305,4,'2020-04-22 10:18:40',NULL,NULL,219,1,1,NULL,NULL),(306,4,'2020-04-22 10:19:12',NULL,NULL,220,1,1,NULL,NULL),(307,4,'2020-04-22 10:19:38',NULL,NULL,221,1,1,NULL,NULL),(308,4,'2020-04-22 10:21:39',NULL,NULL,230,1,1,NULL,NULL),(309,4,'2020-04-22 10:22:09',NULL,NULL,232,1,1,NULL,NULL),(310,4,'2020-04-22 11:04:56',NULL,NULL,261,1,1,NULL,NULL),(311,4,'2020-04-22 11:05:16',NULL,NULL,262,1,1,NULL,NULL),(312,4,'2020-04-22 11:06:03',NULL,NULL,263,1,1,NULL,NULL),(313,4,'2020-04-22 11:06:27',NULL,NULL,264,1,1,NULL,NULL),(314,4,'2020-04-22 11:11:43',NULL,NULL,266,1,1,NULL,NULL),(315,3,'2020-04-22 14:24:55',NULL,NULL,275,1,1,NULL,NULL),(316,3,'2020-04-22 14:31:04',NULL,NULL,277,1,1,NULL,NULL),(317,3,'2020-04-22 14:32:00',NULL,NULL,278,1,1,NULL,NULL),(318,3,'2020-04-22 14:50:22',NULL,NULL,280,1,1,NULL,NULL),(319,3,'2020-04-22 15:02:05',NULL,NULL,286,1,1,NULL,NULL),(320,94,'2020-04-27 15:58:20',454,1,NULL,0,NULL,NULL,NULL),(321,95,'2020-04-27 16:02:30',455,1,NULL,0,NULL,NULL,NULL),(322,116,'2020-04-27 16:20:27',456,1,NULL,0,NULL,NULL,NULL),(323,139,'2020-04-27 16:50:22',207,1,NULL,0,NULL,NULL,NULL),(324,139,'2020-04-27 16:52:00',457,1,NULL,0,NULL,NULL,NULL),(325,12,'2020-04-27 17:01:26',458,1,NULL,0,1,NULL,NULL),(326,113,'2020-04-27 17:14:06',459,1,NULL,0,NULL,NULL,NULL),(327,139,'2020-04-27 17:18:39',460,1,NULL,0,NULL,NULL,NULL),(328,160,'2020-04-27 17:24:20',462,1,NULL,0,NULL,NULL,NULL),(329,160,'2020-04-27 17:24:35',463,1,NULL,0,NULL,NULL,NULL),(330,138,'2020-04-27 17:24:46',461,1,NULL,0,NULL,NULL,NULL),(331,138,'2020-04-27 17:24:50',461,1,NULL,0,NULL,NULL,NULL),(332,138,'2020-04-27 17:24:58',461,1,NULL,0,NULL,NULL,NULL),(333,138,'2020-04-27 17:25:18',461,1,NULL,0,NULL,NULL,NULL),(334,138,'2020-04-27 17:25:20',461,1,NULL,0,NULL,NULL,NULL),(335,138,'2020-04-27 17:25:21',461,1,NULL,0,NULL,NULL,NULL),(336,160,'2020-04-27 17:25:54',464,1,NULL,0,NULL,NULL,NULL),(337,138,'2020-04-27 17:25:58',461,1,NULL,0,NULL,NULL,NULL),(338,138,'2020-04-27 17:25:59',461,1,NULL,0,NULL,NULL,NULL),(339,138,'2020-04-27 17:25:59',461,1,NULL,0,NULL,NULL,NULL),(340,138,'2020-04-27 17:26:00',461,1,NULL,0,NULL,NULL,NULL),(341,138,'2020-04-27 17:26:04',461,1,NULL,0,NULL,NULL,NULL),(342,138,'2020-04-27 17:26:06',461,1,NULL,0,NULL,NULL,NULL),(343,138,'2020-04-27 17:26:14',461,1,NULL,0,NULL,NULL,NULL),(344,138,'2020-04-27 17:26:15',461,1,NULL,0,NULL,NULL,NULL),(345,138,'2020-04-27 17:26:18',461,1,NULL,0,NULL,'wqeqwe',NULL),(346,138,'2020-04-27 17:26:19',461,1,NULL,0,NULL,'wqeqwe',NULL),(347,138,'2020-04-27 17:26:19',461,1,NULL,0,NULL,'wqeqwe',NULL),(348,138,'2020-04-27 17:26:19',461,1,NULL,0,NULL,'wqeqwe',NULL),(349,138,'2020-04-27 17:28:03',465,1,NULL,0,NULL,NULL,NULL),(350,12,'2020-04-27 17:49:50',468,1,NULL,0,1,NULL,NULL),(351,110,'2020-04-27 17:49:59',393,1,NULL,0,NULL,NULL,NULL),(352,12,'2020-04-27 17:51:18',469,1,NULL,0,1,NULL,NULL),(353,54,'2020-04-27 17:51:45',470,1,NULL,0,1,NULL,NULL),(354,54,'2020-04-27 17:52:00',471,1,NULL,0,1,NULL,NULL),(355,139,'2020-04-27 17:53:28',472,1,NULL,0,NULL,NULL,NULL),(356,139,'2020-04-27 17:55:31',473,1,NULL,0,NULL,NULL,NULL),(357,138,'2020-04-27 17:56:04',474,1,NULL,0,NULL,NULL,NULL),(358,138,'2020-04-27 17:56:07',474,1,NULL,0,NULL,NULL,NULL),(359,138,'2020-04-27 17:56:12',474,1,NULL,0,NULL,NULL,NULL),(360,119,'2020-04-28 08:55:03',173,1,NULL,0,NULL,NULL,NULL),(361,119,'2020-04-28 08:55:12',477,1,NULL,0,NULL,NULL,NULL),(362,161,'2020-04-28 08:55:31',478,1,NULL,0,NULL,NULL,NULL),(363,101,'2020-04-28 08:56:48',479,1,NULL,0,NULL,NULL,NULL),(364,161,'2020-04-28 08:57:14',480,1,NULL,0,NULL,NULL,NULL),(365,101,'2020-04-28 08:58:21',481,1,NULL,0,NULL,NULL,NULL),(366,161,'2020-04-28 08:58:34',482,1,NULL,0,NULL,NULL,NULL),(367,101,'2020-04-28 09:00:19',483,1,NULL,0,NULL,NULL,NULL),(368,100,'2020-04-28 09:00:37',132,1,NULL,0,NULL,NULL,NULL),(369,100,'2020-04-28 09:00:43',484,1,NULL,0,NULL,NULL,NULL),(370,101,'2020-04-28 09:10:51',486,1,NULL,0,NULL,NULL,NULL),(371,94,'2020-04-28 09:11:14',485,1,NULL,0,NULL,NULL,NULL),(372,101,'2020-04-28 09:12:55',487,1,NULL,0,NULL,NULL,NULL),(373,101,'2020-04-28 09:14:18',488,1,NULL,0,NULL,NULL,NULL),(374,101,'2020-04-28 09:17:12',489,1,NULL,0,NULL,NULL,NULL),(375,101,'2020-04-28 09:23:58',490,1,NULL,0,NULL,NULL,NULL),(376,101,'2020-04-28 09:25:00',491,1,NULL,0,NULL,NULL,NULL),(377,101,'2020-04-28 09:25:52',492,1,NULL,0,NULL,NULL,NULL),(378,101,'2020-04-28 09:27:11',493,1,NULL,0,NULL,NULL,NULL),(379,101,'2020-04-28 09:29:11',494,1,NULL,0,NULL,NULL,NULL),(380,101,'2020-04-28 09:29:31',495,1,NULL,0,NULL,NULL,NULL),(381,101,'2020-04-28 09:31:39',496,1,NULL,0,NULL,NULL,NULL),(382,101,'2020-04-28 09:32:24',497,1,NULL,0,NULL,NULL,NULL),(383,101,'2020-04-28 09:35:33',498,1,NULL,0,NULL,NULL,NULL),(384,101,'2020-04-28 09:37:59',499,1,NULL,0,NULL,NULL,NULL),(385,4,'2020-04-28 09:39:55',501,1,NULL,0,1,NULL,NULL),(386,138,'2020-04-28 09:44:11',502,1,NULL,0,NULL,NULL,NULL),(387,138,'2020-04-28 09:44:17',502,1,NULL,0,NULL,NULL,NULL),(388,162,'2020-04-28 10:26:28',503,1,NULL,1,NULL,NULL,NULL),(389,162,'2020-04-28 10:29:54',504,1,NULL,1,NULL,NULL,NULL),(390,162,'2020-04-28 11:09:08',505,1,NULL,1,NULL,NULL,NULL),(391,162,'2020-04-28 11:12:13',506,1,NULL,1,NULL,NULL,NULL),(392,162,'2020-04-28 14:48:12',507,1,NULL,1,NULL,NULL,NULL),(393,162,'2020-04-28 15:26:22',508,1,NULL,1,NULL,NULL,NULL),(394,162,'2020-04-28 15:31:36',509,1,NULL,1,NULL,NULL,NULL),(395,3,'2020-04-28 15:32:11',510,1,NULL,1,1,NULL,NULL),(396,19,'2020-04-28 15:32:51',511,1,NULL,1,3,NULL,NULL),(397,4,'2020-04-28 15:33:24',512,1,NULL,1,1,NULL,NULL),(398,101,'2020-04-28 15:52:31',513,1,NULL,1,NULL,NULL,NULL),(399,101,'2020-04-28 15:55:43',514,1,NULL,1,NULL,NULL,NULL),(400,106,'2020-04-28 15:57:17',148,1,NULL,1,3,NULL,NULL),(401,106,'2020-04-28 15:57:24',515,1,NULL,1,3,NULL,NULL),(402,162,'2020-04-28 15:57:56',516,1,NULL,1,NULL,NULL,NULL),(403,7,'2020-04-28 16:02:22',517,1,NULL,1,3,NULL,NULL),(404,45,'2020-04-28 16:02:50',518,1,NULL,1,1,NULL,NULL),(405,12,'2020-04-28 16:05:28',520,1,NULL,1,1,NULL,NULL),(406,139,'2020-04-28 16:10:35',521,1,NULL,1,NULL,NULL,NULL),(407,6,'2020-04-28 16:11:15',522,1,NULL,1,NULL,NULL,NULL),(408,138,'2020-04-28 16:23:59',524,1,NULL,1,NULL,NULL,NULL),(409,138,'2020-04-28 16:39:41',524,1,NULL,1,NULL,NULL,NULL),(410,101,'2020-04-29 08:28:22',525,1,NULL,1,NULL,NULL,NULL),(411,101,'2020-04-29 08:28:39',526,1,NULL,1,NULL,NULL,NULL),(412,101,'2020-04-29 08:29:59',527,1,NULL,1,NULL,NULL,NULL),(413,101,'2020-04-29 08:30:15',528,1,NULL,1,NULL,NULL,NULL),(414,101,'2020-04-29 08:30:55',529,1,NULL,1,NULL,NULL,NULL),(415,101,'2020-04-29 08:31:09',530,1,NULL,1,NULL,NULL,NULL),(416,101,'2020-04-29 08:43:11',531,1,NULL,1,NULL,NULL,NULL),(417,101,'2020-04-29 08:49:06',532,1,NULL,1,NULL,NULL,NULL),(418,101,'2020-04-29 08:50:39',533,1,NULL,1,NULL,NULL,NULL),(419,2,'2020-04-29 09:01:57',142,1,NULL,1,3,NULL,NULL),(420,138,'2020-04-29 09:02:41',535,1,NULL,1,NULL,NULL,NULL),(421,19,'2020-04-29 09:04:21',511,1,NULL,1,1,NULL,NULL),(422,138,'2020-04-29 09:05:15',535,1,NULL,1,NULL,NULL,NULL),(423,7,'2020-04-29 09:06:43',537,1,NULL,1,3,NULL,NULL),(424,7,'2020-04-29 09:13:24',538,1,NULL,1,3,NULL,NULL),(425,138,'2020-04-29 09:15:18',539,1,NULL,1,NULL,NULL,NULL),(426,139,'2020-04-29 09:17:00',536,1,NULL,1,NULL,NULL,NULL),(427,139,'2020-04-29 09:17:14',540,1,NULL,1,NULL,NULL,NULL),(428,138,'2020-04-29 09:19:03',541,1,NULL,1,NULL,NULL,NULL),(429,6,'2020-04-29 09:31:47',544,1,NULL,1,NULL,NULL,NULL),(430,138,'2020-04-29 09:31:51',543,1,NULL,1,NULL,NULL,NULL),(431,7,'2020-04-29 09:32:04',542,1,NULL,1,3,NULL,NULL),(432,101,'2020-04-29 09:36:10',548,1,NULL,1,NULL,NULL,NULL),(433,101,'2020-04-29 09:36:21',549,1,NULL,1,NULL,NULL,NULL),(434,101,'2020-04-29 09:36:34',550,1,NULL,1,NULL,NULL,NULL),(435,101,'2020-04-29 09:36:51',551,1,NULL,1,NULL,NULL,NULL),(436,101,'2020-04-29 09:40:00',552,1,NULL,1,NULL,NULL,NULL),(437,101,'2020-04-29 09:40:15',553,1,NULL,1,NULL,NULL,NULL),(438,101,'2020-04-29 09:40:25',554,1,NULL,1,NULL,NULL,NULL),(439,101,'2020-04-29 09:40:37',555,1,NULL,1,NULL,NULL,NULL),(440,101,'2020-04-29 09:42:08',556,1,NULL,1,NULL,NULL,NULL),(441,101,'2020-04-29 09:42:19',557,1,NULL,1,NULL,NULL,NULL),(442,101,'2020-04-29 09:42:31',558,1,NULL,1,NULL,NULL,NULL),(443,101,'2020-04-29 09:42:45',559,1,NULL,1,NULL,NULL,NULL),(444,101,'2020-04-29 09:44:42',560,1,NULL,1,NULL,NULL,NULL),(445,163,'2020-04-29 17:25:30',561,1,NULL,1,13,NULL,NULL),(446,163,'2020-04-29 17:26:30',562,1,NULL,1,13,NULL,NULL),(447,3,'2020-04-29 18:25:21',510,1,NULL,1,1,NULL,NULL),(448,162,'2020-04-29 19:22:34',565,1,NULL,1,NULL,NULL,NULL),(449,162,'2020-04-29 19:23:07',568,1,NULL,1,NULL,NULL,NULL),(450,162,'2020-04-30 10:33:40',569,1,NULL,1,NULL,NULL,NULL),(451,3,'2020-04-30 10:34:32',572,1,NULL,1,1,NULL,NULL),(452,169,'2020-05-13 18:27:35',574,1,NULL,1,NULL,NULL,NULL),(453,166,'2020-05-22 11:50:46',576,1,NULL,0,NULL,NULL,NULL),(454,166,'2020-05-22 11:53:17',577,1,NULL,0,NULL,NULL,NULL),(455,139,'2020-05-22 11:56:43',578,1,NULL,0,NULL,NULL,NULL),(456,171,'2020-06-05 14:36:09',579,1,NULL,0,NULL,NULL,NULL),(457,171,'2020-06-05 14:36:53',580,1,NULL,0,NULL,NULL,NULL),(458,171,'2020-06-05 14:38:46',581,1,NULL,0,NULL,NULL,NULL),(459,4,'2020-06-09 09:27:51',587,1,NULL,1,1,NULL,NULL),(460,19,'2020-06-09 15:28:27',588,1,NULL,1,1,NULL,NULL),(461,187,'2020-06-09 16:29:23',594,1,NULL,1,NULL,NULL,NULL),(462,3,'2020-06-16 14:12:33',595,1,NULL,1,1,NULL,NULL),(463,190,'2020-06-16 14:16:46',596,1,NULL,1,NULL,NULL,NULL),(464,191,'2020-06-16 14:24:45',599,1,NULL,1,NULL,NULL,NULL),(465,191,'2020-06-16 14:34:40',600,1,NULL,1,NULL,NULL,NULL),(466,191,'2020-06-16 14:44:25',601,1,NULL,1,NULL,NULL,NULL),(467,94,'2020-06-16 14:45:52',570,1,NULL,1,NULL,NULL,NULL),(468,191,'2020-06-16 14:46:37',602,1,NULL,1,NULL,NULL,NULL),(469,191,'2020-06-16 14:47:45',604,1,NULL,1,NULL,NULL,NULL),(470,12,'2020-06-26 17:17:47',607,1,NULL,0,1,NULL,NULL),(471,12,'2020-06-26 17:18:42',607,1,NULL,0,1,NULL,NULL),(472,110,'2020-06-26 17:18:47',598,1,NULL,0,NULL,NULL,NULL),(473,12,'2020-06-26 17:19:16',607,1,NULL,0,1,NULL,NULL),(474,110,'2020-06-26 17:21:05',608,1,NULL,0,NULL,NULL,NULL),(475,12,'2020-06-26 17:25:41',609,1,NULL,0,1,NULL,NULL),(476,110,'2020-06-26 17:27:22',610,1,NULL,0,NULL,NULL,NULL),(477,110,'2020-06-26 17:36:10',612,1,NULL,0,NULL,NULL,NULL),(478,110,'2020-06-26 17:41:23',613,1,NULL,0,NULL,NULL,NULL),(479,110,'2020-06-26 17:41:52',614,1,NULL,0,NULL,NULL,NULL),(480,110,'2020-06-26 17:56:13',615,1,NULL,0,NULL,NULL,NULL),(481,10,'2020-06-30 16:13:22',81,1,NULL,1,NULL,NULL,NULL),(482,197,'2020-06-30 17:27:52',621,1,NULL,1,NULL,NULL,NULL),(483,198,'2020-07-01 09:48:35',622,1,NULL,0,NULL,NULL,NULL),(484,10,'2020-07-01 10:42:30',626,1,NULL,1,NULL,NULL,NULL),(485,10,'2020-07-01 10:42:40',624,1,NULL,1,NULL,NULL,NULL),(486,10,'2020-07-01 10:42:40',625,1,NULL,1,NULL,NULL,NULL),(487,189,'2020-07-01 15:49:22',620,1,NULL,0,NULL,NULL,NULL),(488,189,'2020-07-06 09:49:49',627,1,NULL,1,NULL,NULL,NULL),(489,158,'2020-07-06 15:11:55',419,1,NULL,1,NULL,NULL,NULL),(490,191,'2020-07-06 17:23:24',630,1,NULL,1,NULL,NULL,NULL),(491,191,'2020-07-06 17:52:26',605,1,NULL,1,NULL,NULL,NULL),(492,203,'2020-07-08 12:31:35',632,1,NULL,0,NULL,NULL,NULL),(493,19,'2020-07-08 15:00:09',634,1,NULL,0,1,NULL,NULL),(494,3,'2020-07-08 15:18:02',595,1,NULL,0,1,NULL,NULL),(495,4,'2020-07-08 15:46:11',597,1,NULL,0,1,NULL,NULL),(496,138,'2020-07-08 16:26:11',639,1,NULL,0,NULL,NULL,NULL),(497,138,'2020-07-08 16:26:51',639,1,NULL,0,NULL,NULL,NULL),(498,205,'2020-07-08 16:44:38',644,1,NULL,1,NULL,NULL,NULL),(499,12,'2020-07-08 18:13:09',649,1,NULL,0,1,NULL,NULL),(500,12,'2020-07-08 18:13:11',649,1,NULL,0,1,NULL,NULL),(501,12,'2020-07-08 18:13:15',649,1,NULL,0,1,NULL,NULL),(502,12,'2020-07-08 18:13:50',649,1,NULL,0,1,NULL,NULL),(503,12,'2020-07-08 18:14:04',649,1,NULL,0,1,NULL,NULL),(504,189,'2020-07-08 18:23:55',635,1,NULL,0,NULL,NULL,NULL),(505,138,'2020-07-08 18:26:52',659,1,NULL,0,NULL,NULL,NULL),(506,138,'2020-07-08 18:26:56',659,1,NULL,0,NULL,NULL,NULL),(507,12,'2020-07-08 18:31:34',657,1,NULL,0,1,NULL,NULL),(508,12,'2020-07-08 18:31:56',657,1,NULL,0,1,NULL,NULL),(509,12,'2020-07-08 18:32:18',657,1,NULL,0,1,NULL,NULL),(510,138,'2020-07-08 18:32:54',660,1,NULL,0,NULL,NULL,NULL),(511,166,'2020-07-10 13:19:26',668,1,NULL,1,NULL,NULL,NULL),(512,167,'2020-07-10 13:20:02',667,1,NULL,1,NULL,NULL,NULL),(513,167,'2020-07-10 13:20:52',669,1,NULL,1,NULL,NULL,NULL),(514,166,'2020-07-10 13:21:30',670,1,NULL,1,NULL,NULL,NULL),(515,165,'2020-07-10 13:26:30',671,1,NULL,1,14,NULL,NULL),(516,207,'2020-07-10 13:30:33',672,1,NULL,1,NULL,NULL,NULL),(517,207,'2020-07-10 13:32:45',673,1,NULL,1,NULL,NULL,NULL),(518,207,'2020-07-10 13:35:56',674,1,NULL,1,NULL,NULL,NULL),(519,207,'2020-07-10 13:36:55',675,1,NULL,1,NULL,NULL,NULL),(520,165,'2020-07-10 13:37:21',676,1,NULL,1,14,NULL,NULL),(521,167,'2020-07-10 13:42:23',677,1,NULL,1,NULL,NULL,NULL),(522,166,'2020-07-10 13:43:30',678,1,NULL,1,NULL,NULL,NULL),(523,143,'2020-07-10 13:44:53',679,1,NULL,1,14,NULL,NULL),(524,19,'2020-07-10 13:45:10',680,1,NULL,1,14,NULL,NULL),(525,19,'2020-07-10 13:46:13',681,1,NULL,1,14,NULL,NULL),(526,143,'2020-07-10 13:46:29',682,1,NULL,1,14,NULL,NULL),(527,19,'2020-07-10 14:01:26',683,1,NULL,1,14,NULL,NULL),(528,131,'2020-07-10 14:04:56',684,1,NULL,1,14,NULL,NULL),(529,131,'2020-07-10 14:06:20',685,1,NULL,1,14,NULL,NULL),(530,131,'2020-07-10 14:07:14',686,1,NULL,1,14,NULL,NULL),(531,131,'2020-07-10 14:09:14',687,1,NULL,1,14,NULL,NULL),(532,143,'2020-07-10 14:12:21',688,1,NULL,1,14,NULL,NULL),(533,167,'2020-07-10 14:13:41',689,1,NULL,1,NULL,NULL,NULL),(534,166,'2020-07-10 14:14:36',690,1,NULL,1,NULL,NULL,NULL),(535,207,'2020-07-10 14:19:53',691,1,NULL,1,NULL,NULL,NULL),(536,207,'2020-07-10 14:22:41',692,1,NULL,1,NULL,NULL,NULL),(537,207,'2020-07-10 14:24:21',693,1,NULL,1,NULL,NULL,NULL),(538,207,'2020-07-10 14:27:29',694,1,NULL,1,NULL,NULL,NULL),(539,207,'2020-07-10 14:29:36',695,1,NULL,1,NULL,NULL,NULL),(540,207,'2020-07-10 14:30:05',696,1,NULL,1,NULL,NULL,NULL),(541,207,'2020-07-10 14:34:42',697,1,NULL,1,NULL,NULL,NULL),(542,207,'2020-07-10 14:35:00',698,1,NULL,1,NULL,NULL,NULL),(543,207,'2020-07-10 14:39:02',699,1,NULL,1,NULL,NULL,NULL),(544,207,'2020-07-10 14:39:45',700,1,NULL,1,NULL,NULL,NULL),(545,207,'2020-07-10 14:41:01',701,1,NULL,1,NULL,NULL,NULL),(546,207,'2020-07-10 14:42:38',702,1,NULL,1,NULL,NULL,NULL),(547,207,'2020-07-10 14:43:06',703,1,NULL,1,NULL,NULL,NULL),(548,207,'2020-07-10 14:45:22',704,1,NULL,1,NULL,NULL,NULL),(549,207,'2020-07-10 14:45:47',705,1,NULL,1,NULL,NULL,NULL),(550,19,'2020-07-10 14:50:21',708,1,NULL,1,14,NULL,NULL),(551,131,'2020-07-10 14:50:52',709,1,NULL,1,14,NULL,NULL),(552,143,'2020-07-10 14:51:30',710,1,NULL,1,14,NULL,NULL),(553,166,'2020-07-10 14:52:20',711,1,NULL,1,NULL,NULL,NULL),(554,167,'2020-07-10 14:52:36',689,1,NULL,1,NULL,NULL,NULL),(555,167,'2020-07-10 14:52:52',712,1,NULL,1,NULL,NULL,NULL),(556,207,'2020-07-10 14:54:03',713,1,NULL,1,NULL,NULL,NULL),(557,207,'2020-07-10 14:54:36',714,1,NULL,1,NULL,NULL,NULL),(558,207,'2020-07-10 14:56:01',715,1,NULL,1,NULL,NULL,NULL),(559,207,'2020-07-10 14:56:19',716,1,NULL,1,NULL,NULL,NULL),(560,207,'2020-07-10 14:58:05',717,1,NULL,1,NULL,NULL,NULL),(561,207,'2020-07-10 14:58:20',718,1,NULL,1,NULL,NULL,NULL),(562,207,'2020-07-10 14:59:00',719,1,NULL,1,NULL,NULL,NULL),(563,207,'2020-07-10 15:01:12',720,1,NULL,1,NULL,NULL,NULL),(564,207,'2020-07-10 15:01:22',721,1,NULL,1,NULL,NULL,NULL),(565,207,'2020-07-10 15:01:59',722,1,NULL,1,NULL,NULL,NULL),(566,207,'2020-07-10 15:05:41',723,1,NULL,1,NULL,NULL,NULL),(567,207,'2020-07-10 15:05:48',724,1,NULL,1,NULL,NULL,NULL),(568,12,'2020-07-10 17:28:01',725,1,NULL,1,1,NULL,NULL),(569,3,'2020-07-10 17:31:45',643,1,NULL,1,1,NULL,NULL),(570,3,'2020-07-10 17:33:18',643,1,NULL,1,1,NULL,NULL),(571,3,'2020-07-10 17:35:54',643,1,NULL,1,1,NULL,NULL),(572,12,'2020-07-10 17:37:10',725,1,NULL,1,1,NULL,NULL),(573,12,'2020-07-10 17:44:26',725,1,NULL,1,1,NULL,NULL),(574,12,'2020-07-10 17:46:11',725,1,NULL,1,1,NULL,NULL),(575,12,'2020-07-10 17:54:40',725,1,NULL,1,1,NULL,NULL),(576,12,'2020-07-10 18:04:54',725,1,NULL,1,1,NULL,NULL),(577,12,'2020-07-10 18:05:13',725,1,NULL,1,1,NULL,NULL),(578,207,'2020-07-14 15:59:18',728,1,NULL,1,NULL,NULL,NULL),(579,207,'2020-07-14 16:07:57',729,1,NULL,1,NULL,NULL,NULL),(580,207,'2020-07-14 16:13:49',730,1,NULL,1,NULL,NULL,NULL),(581,3,'2020-07-14 16:49:49',731,1,NULL,1,1,NULL,NULL),(582,3,'2020-07-14 16:51:52',731,1,NULL,1,1,NULL,NULL),(583,12,'2020-07-14 17:21:03',734,1,NULL,1,1,NULL,NULL),(584,212,'2020-07-23 16:49:17',740,1,NULL,1,NULL,NULL,NULL),(585,136,'2020-07-23 17:29:12',747,1,NULL,1,1,NULL,NULL),(586,206,'2020-07-27 16:09:18',748,1,NULL,1,NULL,NULL,NULL),(587,207,'2020-07-28 17:36:57',750,1,NULL,0,NULL,NULL,NULL),(588,207,'2020-07-29 09:02:51',752,1,NULL,0,NULL,NULL,NULL),(589,207,'2020-07-29 09:05:34',753,1,NULL,0,NULL,NULL,NULL),(590,167,'2020-07-29 09:39:41',762,1,NULL,0,NULL,NULL,NULL),(591,166,'2020-07-29 09:39:49',763,1,NULL,0,NULL,NULL,NULL),(592,165,'2020-07-29 09:40:31',759,1,NULL,0,14,NULL,NULL),(593,143,'2020-07-29 09:40:43',760,1,NULL,0,14,NULL,NULL),(594,131,'2020-07-29 09:41:02',761,1,NULL,0,14,NULL,NULL),(595,143,'2020-07-29 09:42:29',764,1,NULL,0,14,NULL,NULL),(596,207,'2020-07-29 09:43:25',765,1,NULL,0,NULL,NULL,NULL),(597,207,'2020-07-29 09:43:59',766,1,NULL,0,NULL,NULL,NULL),(598,207,'2020-07-29 09:45:44',767,1,NULL,0,NULL,NULL,NULL),(599,207,'2020-07-29 09:46:07',768,1,NULL,0,NULL,NULL,NULL),(600,207,'2020-07-29 09:48:54',769,1,NULL,0,NULL,NULL,NULL),(601,207,'2020-07-29 09:49:27',770,1,NULL,0,NULL,NULL,NULL),(602,207,'2020-07-29 09:51:08',771,1,NULL,0,NULL,NULL,NULL),(603,207,'2020-07-29 09:51:41',772,1,NULL,0,NULL,NULL,NULL),(604,165,'2020-07-29 09:53:22',773,1,NULL,0,14,NULL,NULL),(605,131,'2020-07-29 09:54:11',774,1,NULL,0,14,NULL,NULL),(606,143,'2020-07-29 09:55:17',775,1,NULL,0,14,NULL,NULL),(607,166,'2020-07-29 09:56:05',776,1,NULL,0,NULL,NULL,NULL),(608,167,'2020-07-29 09:56:18',777,1,NULL,0,NULL,NULL,NULL),(609,167,'2020-07-29 09:56:26',777,1,NULL,0,NULL,NULL,NULL),(610,167,'2020-07-29 09:56:29',777,1,NULL,0,NULL,NULL,NULL),(611,167,'2020-07-29 09:56:39',777,1,NULL,0,NULL,NULL,NULL),(612,167,'2020-07-29 09:57:39',780,1,NULL,0,NULL,NULL,NULL),(613,207,'2020-07-29 10:15:47',782,1,NULL,0,NULL,NULL,NULL),(614,207,'2020-07-29 10:16:46',783,1,NULL,0,NULL,NULL,NULL),(615,207,'2020-07-29 10:20:47',784,1,NULL,0,NULL,NULL,NULL),(616,207,'2020-07-29 10:22:03',785,1,NULL,0,NULL,NULL,NULL),(617,207,'2020-07-29 10:25:50',786,1,NULL,0,NULL,NULL,NULL),(618,207,'2020-07-29 10:27:23',787,1,NULL,0,NULL,NULL,NULL),(619,207,'2020-07-29 10:28:19',788,1,NULL,0,NULL,NULL,NULL),(620,165,'2020-07-29 10:30:07',773,1,NULL,0,14,NULL,NULL),(621,110,'2020-07-29 11:35:42',616,1,NULL,1,NULL,NULL,NULL),(622,3,'2020-07-29 11:45:17',790,1,NULL,1,1,NULL,NULL),(623,3,'2020-07-29 11:52:33',790,1,NULL,1,1,NULL,NULL),(624,207,'2020-07-29 15:42:33',793,1,NULL,0,NULL,NULL,NULL),(625,207,'2020-07-29 15:43:56',794,1,NULL,0,NULL,NULL,NULL),(626,207,'2020-07-29 15:44:49',795,1,NULL,0,NULL,NULL,NULL),(627,207,'2020-07-29 15:45:46',796,1,NULL,0,NULL,NULL,NULL),(628,207,'2020-07-29 15:46:49',797,1,NULL,0,NULL,NULL,NULL),(629,207,'2020-07-29 15:47:55',798,1,NULL,0,NULL,NULL,NULL),(630,207,'2020-07-29 15:51:20',799,1,NULL,0,NULL,NULL,NULL),(631,19,'2020-07-29 17:33:48',800,1,NULL,0,14,NULL,NULL),(632,131,'2020-07-29 17:34:31',801,1,NULL,0,14,NULL,NULL),(633,131,'2020-07-29 17:36:07',802,1,NULL,0,14,NULL,NULL),(634,143,'2020-07-29 17:36:52',803,1,NULL,0,14,NULL,NULL),(635,166,'2020-07-29 17:37:35',805,1,NULL,0,NULL,NULL,NULL),(636,167,'2020-07-29 17:37:41',804,1,NULL,0,NULL,NULL,NULL),(637,207,'2020-07-29 17:38:28',806,1,NULL,0,NULL,NULL,NULL),(638,207,'2020-07-29 17:38:47',807,1,NULL,0,NULL,NULL,NULL),(639,207,'2020-07-29 17:40:41',808,1,NULL,0,NULL,NULL,NULL),(640,207,'2020-07-29 17:41:10',809,1,NULL,0,NULL,NULL,NULL),(641,207,'2020-07-29 17:42:04',810,1,NULL,0,NULL,NULL,NULL),(642,207,'2020-07-29 17:45:31',811,1,NULL,0,NULL,NULL,NULL),(643,207,'2020-07-29 17:46:42',812,1,NULL,0,NULL,NULL,NULL),(644,207,'2020-07-30 09:01:31',813,1,NULL,0,NULL,NULL,NULL),(645,207,'2020-07-30 09:02:35',814,1,NULL,0,NULL,NULL,NULL),(646,207,'2020-07-30 09:03:02',815,1,NULL,0,NULL,NULL,NULL),(647,207,'2020-07-30 09:03:44',816,1,NULL,0,NULL,NULL,NULL),(648,207,'2020-07-30 09:04:01',817,1,NULL,0,NULL,NULL,NULL),(649,207,'2020-07-30 09:04:35',818,1,NULL,0,NULL,NULL,NULL),(650,19,'2020-07-30 09:06:16',819,1,NULL,0,14,NULL,NULL),(651,143,'2020-07-30 09:06:35',820,1,NULL,0,14,NULL,NULL),(652,165,'2020-07-30 09:06:48',821,1,NULL,0,14,NULL,NULL),(653,167,'2020-07-30 09:07:06',822,1,NULL,0,NULL,NULL,NULL),(654,166,'2020-07-30 09:07:25',823,1,NULL,0,NULL,NULL,NULL),(655,207,'2020-07-30 09:08:06',824,1,NULL,0,NULL,NULL,NULL),(656,207,'2020-07-30 09:08:20',825,1,NULL,0,NULL,NULL,NULL),(657,207,'2020-07-30 09:09:58',826,1,NULL,0,NULL,NULL,NULL),(658,206,'2020-07-30 17:04:10',749,1,NULL,0,NULL,NULL,NULL),(659,213,'2020-07-30 17:10:02',827,1,NULL,0,NULL,NULL,NULL),(660,213,'2020-07-30 17:18:31',828,1,NULL,0,NULL,NULL,NULL),(661,213,'2020-07-30 17:28:05',829,1,NULL,0,NULL,NULL,NULL),(662,110,'2020-07-30 17:37:53',791,1,NULL,0,NULL,NULL,NULL),(663,214,'2020-07-31 10:13:44',831,1,NULL,0,NULL,NULL,NULL),(664,207,'2020-08-03 17:29:36',833,1,NULL,0,NULL,NULL,NULL),(665,207,'2020-08-03 17:31:26',834,1,NULL,0,NULL,NULL,NULL),(666,207,'2020-08-03 17:32:52',835,1,NULL,0,NULL,NULL,NULL),(667,207,'2020-08-03 17:36:55',836,1,NULL,0,NULL,NULL,NULL),(668,207,'2020-08-03 17:45:19',837,1,NULL,0,NULL,NULL,NULL),(669,207,'2020-08-03 17:46:41',838,1,NULL,0,NULL,NULL,NULL),(670,207,'2020-08-03 17:47:07',839,1,NULL,0,NULL,NULL,NULL),(671,207,'2020-08-03 17:47:38',840,1,NULL,0,NULL,NULL,NULL),(672,207,'2020-08-03 17:48:21',841,1,NULL,0,NULL,NULL,NULL),(673,19,'2020-08-03 17:49:48',842,1,NULL,0,14,NULL,NULL),(674,131,'2020-08-03 17:50:35',843,1,NULL,0,14,NULL,NULL),(675,19,'2020-08-21 15:04:10',845,1,NULL,0,14,NULL,NULL),(676,19,'2020-08-21 15:04:15',845,1,NULL,0,14,NULL,NULL),(677,19,'2020-08-21 15:04:16',845,1,NULL,0,14,NULL,NULL),(678,19,'2020-08-21 15:04:28',846,1,NULL,0,14,NULL,NULL),(679,110,'2020-09-03 17:19:52',830,1,NULL,0,NULL,NULL,NULL),(680,3,'2020-09-04 09:42:30',848,1,NULL,0,1,NULL,NULL),(681,110,'2020-09-04 09:43:39',847,1,NULL,0,NULL,NULL,NULL),(682,110,'2020-09-04 09:44:26',850,1,NULL,0,NULL,NULL,NULL),(683,110,'2020-09-04 09:52:47',851,1,NULL,0,NULL,NULL,NULL),(684,110,'2020-09-04 10:36:28',852,1,NULL,1,NULL,NULL,NULL),(685,110,'2020-09-04 10:45:26',853,1,NULL,1,NULL,NULL,NULL),(686,110,'2020-09-04 10:46:10',854,1,NULL,1,NULL,NULL,NULL),(687,110,'2020-09-04 11:21:43',855,1,NULL,1,NULL,NULL,NULL),(688,110,'2020-09-04 11:47:36',856,1,NULL,1,NULL,NULL,NULL),(689,214,'2020-09-08 14:26:01',832,1,NULL,1,NULL,NULL,NULL),(690,214,'2020-09-08 14:33:39',857,1,NULL,1,NULL,NULL,NULL),(691,203,'2020-09-08 14:43:51',858,1,NULL,1,NULL,NULL,NULL),(692,213,'2020-09-08 14:57:33',859,1,NULL,1,NULL,NULL,NULL),(693,206,'2020-09-08 16:01:43',662,1,NULL,1,NULL,NULL,NULL),(694,215,'2020-09-18 08:27:29',863,1,NULL,1,NULL,NULL,NULL),(695,208,'2020-09-21 14:56:13',727,1,NULL,1,NULL,NULL,NULL),(696,208,'2020-09-21 14:56:40',864,1,NULL,1,NULL,NULL,NULL),(697,19,'2020-09-25 10:31:25',865,1,NULL,1,14,NULL,NULL),(698,167,'2020-09-25 10:32:24',866,1,NULL,1,NULL,NULL,NULL),(699,166,'2020-09-25 10:33:20',844,1,NULL,1,NULL,NULL,NULL),(700,165,'2020-09-25 10:33:47',867,1,NULL,1,14,NULL,NULL),(701,217,'2020-10-15 14:16:42',871,1,NULL,1,NULL,NULL,NULL),(702,218,'2020-10-15 14:17:54',872,1,NULL,1,NULL,NULL,NULL),(703,219,'2020-10-16 17:21:37',873,1,NULL,1,NULL,NULL,NULL),(704,220,'2020-10-16 17:22:12',874,1,NULL,1,NULL,NULL,NULL),(705,221,'2020-10-16 17:23:02',875,1,NULL,1,NULL,NULL,NULL),(706,223,'2020-10-16 17:24:05',877,1,NULL,1,NULL,NULL,NULL),(707,225,'2020-10-20 15:50:52',879,1,NULL,1,NULL,NULL,NULL),(708,225,'2020-10-20 15:52:05',880,1,NULL,1,NULL,NULL,NULL),(709,166,'2020-10-23 14:03:45',882,1,NULL,1,NULL,NULL,NULL),(710,166,'2020-10-23 14:34:09',883,1,NULL,1,NULL,NULL,NULL),(711,19,'2020-12-02 10:19:04',904,1,NULL,1,14,NULL,NULL),(712,10,'2020-12-02 10:29:47',905,4,NULL,0,NULL,NULL,NULL),(713,18,'2020-12-02 10:36:40',906,4,NULL,0,NULL,NULL,NULL),(714,18,'2020-12-02 10:37:55',907,4,NULL,0,NULL,NULL,NULL),(715,166,'2020-12-02 10:42:00',884,1,NULL,1,NULL,NULL,NULL),(716,166,'2020-12-02 10:42:57',909,1,NULL,1,NULL,NULL,NULL),(717,227,'2020-12-02 10:48:02',910,1,NULL,0,NULL,NULL,NULL),(718,28,'2020-12-02 10:59:36',912,4,NULL,0,NULL,NULL,NULL),(719,227,'2020-12-02 11:00:48',911,4,NULL,0,NULL,NULL,NULL),(720,166,'2020-12-02 11:09:11',915,1,NULL,1,NULL,NULL,NULL),(721,28,'2020-12-02 11:44:38',913,4,NULL,0,NULL,NULL,NULL),(722,28,'2020-12-02 11:44:38',917,4,NULL,0,NULL,NULL,NULL),(723,28,'2020-12-02 11:45:47',918,4,NULL,0,NULL,NULL,NULL),(724,28,'2020-12-02 11:53:20',919,4,NULL,0,NULL,NULL,NULL),(725,28,'2020-12-02 12:24:51',920,4,NULL,0,NULL,NULL,NULL),(726,28,'2020-12-02 12:25:49',922,4,NULL,0,NULL,NULL,NULL),(727,28,'2020-12-02 12:27:25',923,4,NULL,0,NULL,NULL,NULL),(728,28,'2020-12-02 12:31:25',925,4,NULL,0,NULL,NULL,NULL),(729,166,'2020-12-02 12:35:24',921,1,NULL,1,NULL,NULL,NULL),(730,226,'2020-12-02 12:37:11',903,1,NULL,1,NULL,NULL,NULL),(731,28,'2020-12-02 14:37:42',926,4,NULL,0,NULL,NULL,NULL),(732,28,'2020-12-02 14:39:31',928,4,NULL,0,NULL,NULL,NULL),(733,28,'2020-12-02 16:15:11',929,4,NULL,0,NULL,NULL,NULL),(734,28,'2020-12-02 16:19:11',930,4,NULL,0,NULL,NULL,NULL),(735,18,'2020-12-07 09:27:33',908,4,NULL,0,NULL,NULL,NULL),(736,18,'2020-12-07 09:32:28',933,4,NULL,0,NULL,NULL,NULL),(737,192,'2020-12-07 09:33:52',935,4,NULL,0,9,NULL,NULL),(738,192,'2020-12-07 09:34:10',935,4,NULL,0,9,NULL,NULL),(739,192,'2020-12-07 09:34:25',935,4,NULL,0,9,NULL,NULL),(740,192,'2020-12-07 10:08:14',NULL,NULL,369,1,9,NULL,NULL),(741,192,'2020-12-07 11:08:57',936,4,NULL,1,9,NULL,NULL),(742,192,'2020-12-07 11:24:08',NULL,NULL,371,1,9,NULL,NULL),(743,192,'2020-12-07 11:26:18',NULL,NULL,372,1,9,NULL,NULL),(744,192,'2020-12-07 13:47:55',936,NULL,373,1,9,NULL,NULL),(745,192,'2020-12-07 13:59:12',936,NULL,374,1,9,NULL,NULL),(746,192,'2020-12-07 13:59:45',936,NULL,375,1,9,NULL,NULL),(747,192,'2020-12-07 14:07:43',936,NULL,377,1,9,NULL,NULL),(748,192,'2020-12-07 14:43:55',936,NULL,381,1,9,NULL,NULL),(749,192,'2020-12-07 15:09:46',936,NULL,383,1,9,NULL,NULL),(750,192,'2020-12-07 15:11:53',936,NULL,384,1,9,NULL,NULL),(751,157,'2020-12-07 15:15:48',434,4,386,1,NULL,NULL,NULL),(752,157,'2020-12-07 15:18:25',937,4,388,1,NULL,NULL,NULL),(753,157,'2020-12-07 15:24:08',938,4,391,1,NULL,NULL,NULL),(754,157,'2020-12-07 15:25:55',939,4,392,1,NULL,NULL,NULL),(755,157,'2020-12-07 15:27:46',940,4,395,1,NULL,NULL,NULL),(756,157,'2020-12-07 15:29:22',941,4,396,1,NULL,NULL,NULL),(757,192,'2020-12-07 15:30:46',936,NULL,397,1,9,NULL,NULL),(758,192,'2020-12-07 15:33:56',936,NULL,398,1,9,NULL,NULL),(759,192,'2020-12-07 15:35:25',936,NULL,399,1,9,NULL,NULL),(760,192,'2020-12-07 15:36:51',936,NULL,400,1,9,NULL,NULL),(761,192,'2020-12-07 15:37:21',936,NULL,401,1,9,NULL,NULL),(762,157,'2020-12-07 15:38:37',942,4,402,1,NULL,NULL,NULL),(763,157,'2020-12-07 15:39:11',943,4,NULL,1,NULL,NULL,NULL),(764,157,'2020-12-07 15:40:19',944,4,NULL,1,NULL,NULL,NULL),(765,228,'2020-12-07 15:45:14',NULL,NULL,403,1,NULL,NULL,NULL),(766,228,'2020-12-07 15:50:16',NULL,NULL,404,1,NULL,NULL,NULL),(767,228,'2020-12-07 15:50:42',NULL,NULL,405,1,NULL,NULL,NULL),(768,228,'2020-12-07 15:51:18',NULL,NULL,406,1,NULL,NULL,NULL),(769,228,'2020-12-07 15:53:00',NULL,NULL,407,1,NULL,NULL,NULL),(770,228,'2020-12-07 15:55:06',NULL,NULL,408,1,NULL,NULL,NULL),(771,228,'2020-12-07 15:56:31',NULL,NULL,409,1,NULL,NULL,NULL),(772,228,'2020-12-07 15:58:50',NULL,NULL,411,1,NULL,NULL,NULL),(773,228,'2020-12-07 15:59:16',NULL,NULL,412,1,NULL,NULL,NULL),(774,228,'2020-12-07 15:59:40',NULL,NULL,414,1,NULL,NULL,NULL),(775,228,'2020-12-07 16:01:11',NULL,NULL,415,1,NULL,NULL,NULL),(776,167,'2020-12-07 16:07:09',866,NULL,416,1,NULL,NULL,NULL),(777,167,'2020-12-07 16:07:33',866,NULL,417,1,NULL,NULL,NULL),(778,167,'2020-12-07 16:08:00',945,NULL,418,1,NULL,NULL,NULL),(779,167,'2020-12-07 16:08:26',945,NULL,419,1,NULL,NULL,NULL),(780,228,'2020-12-07 16:09:35',946,NULL,420,1,NULL,NULL,NULL),(781,120,'2020-12-07 16:14:29',934,NULL,422,1,9,NULL,NULL),(782,156,'2020-12-07 18:12:05',NULL,NULL,433,1,9,NULL,NULL),(783,156,'2020-12-07 18:12:50',NULL,NULL,435,1,9,NULL,NULL),(784,156,'2020-12-07 18:12:59',NULL,NULL,436,1,9,NULL,NULL),(785,157,'2020-12-07 17:15:23',947,4,439,1,NULL,NULL,NULL),(786,157,'2020-12-07 17:16:25',948,4,440,1,NULL,NULL,NULL),(787,156,'2020-12-07 17:21:01',902,4,NULL,1,9,NULL,NULL),(788,156,'2020-12-07 18:21:15',NULL,NULL,447,1,9,NULL,NULL),(789,156,'2020-12-07 18:21:20',NULL,NULL,448,1,9,NULL,NULL),(790,228,'2020-12-07 17:34:16',946,NULL,452,1,NULL,NULL,NULL),(791,228,'2020-12-07 17:42:00',946,NULL,453,1,NULL,NULL,NULL),(792,155,'2020-12-07 17:42:36',NULL,NULL,455,1,11,NULL,NULL),(793,155,'2020-12-07 17:44:19',NULL,NULL,456,1,11,NULL,NULL),(794,228,'2020-12-07 17:44:27',946,NULL,457,1,NULL,NULL,NULL),(795,157,'2020-12-07 18:46:28',950,NULL,458,1,NULL,NULL,NULL),(796,156,'2020-12-07 17:48:28',NULL,NULL,459,1,9,NULL,NULL),(797,157,'2020-12-07 17:49:59',951,NULL,461,1,NULL,NULL,NULL),(798,156,'2020-12-08 10:02:02',NULL,NULL,465,1,9,NULL,NULL),(799,228,'2020-12-08 10:03:36',946,NULL,466,1,NULL,NULL,NULL),(800,157,'2020-12-08 11:05:23',952,NULL,467,1,NULL,NULL,NULL),(801,228,'2020-12-08 11:06:33',946,NULL,468,1,NULL,NULL,NULL),(802,156,'2020-12-08 11:06:41',NULL,NULL,469,1,9,NULL,NULL),(803,156,'2020-12-08 10:07:31',NULL,NULL,470,1,9,NULL,NULL),(804,228,'2020-12-08 10:08:08',NULL,NULL,471,1,NULL,NULL,NULL),(805,156,'2020-12-08 10:08:27',NULL,NULL,472,1,9,NULL,NULL),(806,228,'2020-12-08 10:08:39',NULL,NULL,473,1,NULL,NULL,NULL),(807,228,'2020-12-08 10:08:59',NULL,NULL,474,1,NULL,NULL,NULL),(808,228,'2020-12-08 10:09:26',NULL,NULL,475,1,NULL,NULL,NULL),(809,156,'2020-12-08 10:09:48',NULL,NULL,476,1,9,NULL,NULL),(810,156,'2020-12-08 10:17:07',949,NULL,477,1,9,NULL,NULL),(811,156,'2020-12-08 10:18:28',949,NULL,478,1,9,NULL,NULL),(812,156,'2020-12-08 10:21:10',949,NULL,479,1,9,NULL,NULL),(813,156,'2020-12-08 10:24:30',949,NULL,480,1,9,NULL,NULL),(814,156,'2020-12-08 10:24:39',949,NULL,481,1,9,NULL,NULL),(815,228,'2020-12-08 10:27:17',946,NULL,482,1,NULL,NULL,NULL),(816,228,'2020-12-08 10:28:55',946,NULL,483,1,NULL,NULL,NULL),(817,156,'2020-12-08 10:29:03',949,NULL,484,1,9,NULL,NULL),(818,228,'2020-12-08 10:56:39',946,NULL,491,1,NULL,NULL,NULL),(819,157,'2020-12-08 11:25:04',955,NULL,493,1,NULL,NULL,NULL),(820,157,'2020-12-08 11:27:07',956,NULL,495,1,NULL,NULL,NULL),(821,157,'2020-12-08 11:28:54',957,NULL,497,1,NULL,NULL,NULL),(822,157,'2020-12-08 11:31:22',958,NULL,500,1,NULL,NULL,NULL),(823,157,'2020-12-08 11:31:43',959,NULL,502,1,NULL,NULL,NULL),(824,156,'2020-12-08 16:33:52',968,NULL,587,1,9,NULL,NULL),(825,156,'2020-12-08 17:54:22',988,NULL,640,1,9,NULL,NULL),(826,156,'2020-12-08 17:54:32',988,NULL,641,1,9,NULL,NULL),(827,156,'2020-12-09 07:58:55',993,NULL,647,1,9,NULL,NULL),(828,156,'2020-12-09 07:59:01',993,NULL,648,1,9,NULL,NULL),(829,157,'2020-12-09 09:00:41',992,NULL,649,1,NULL,NULL,NULL),(830,156,'2020-12-09 09:01:07',993,NULL,651,1,9,NULL,NULL),(831,228,'2020-12-09 09:01:20',991,NULL,652,1,NULL,NULL,NULL),(832,157,'2020-12-09 09:14:05',994,NULL,654,1,NULL,NULL,NULL),(833,157,'2020-12-09 09:15:28',995,NULL,657,1,NULL,NULL,NULL),(834,228,'2020-12-09 09:24:41',997,NULL,661,1,NULL,NULL,NULL),(835,157,'2020-12-09 09:26:34',999,NULL,664,1,NULL,NULL,NULL),(836,157,'2020-12-09 09:33:14',1000,NULL,669,1,NULL,NULL,NULL),(837,157,'2020-12-09 09:35:01',1001,NULL,670,1,NULL,NULL,NULL),(838,157,'2020-12-09 09:37:08',1002,NULL,671,1,NULL,NULL,NULL),(839,157,'2020-12-09 09:39:19',1003,NULL,674,1,NULL,NULL,NULL),(840,157,'2020-12-09 09:40:26',1004,NULL,675,1,NULL,NULL,NULL),(841,157,'2020-12-09 09:41:00',1005,NULL,677,1,NULL,NULL,NULL),(842,157,'2020-12-09 09:41:53',1006,4,NULL,0,NULL,NULL,NULL),(843,228,'2020-12-09 09:57:49',1007,4,NULL,1,NULL,NULL,NULL),(844,228,'2020-12-09 10:00:00',1010,NULL,682,1,NULL,NULL,NULL),(845,228,'2020-12-09 10:00:51',1011,NULL,685,1,NULL,NULL,NULL),(846,156,'2020-12-09 10:01:04',1012,NULL,686,1,9,NULL,NULL),(847,156,'2020-12-09 10:01:36',1013,4,NULL,1,9,NULL,NULL),(848,228,'2020-12-09 10:02:12',1014,4,NULL,1,NULL,NULL,NULL),(849,157,'2020-12-09 10:02:42',1015,4,NULL,1,NULL,NULL,NULL),(850,157,'2020-12-09 10:03:04',1016,NULL,688,1,NULL,NULL,NULL),(851,156,'2020-12-09 10:26:13',1013,NULL,690,1,9,NULL,NULL),(852,156,'2020-12-09 13:07:45',1013,NULL,691,1,9,NULL,NULL),(853,156,'2020-12-11 15:58:20',1013,NULL,697,1,9,NULL,NULL),(854,156,'2020-12-11 16:20:30',1013,NULL,698,1,9,NULL,NULL),(855,189,'2021-01-14 15:55:41',658,1,NULL,0,NULL,NULL,NULL),(856,229,'2021-01-14 16:01:28',1021,1,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `saida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saldo_tipo_convites`
--

DROP TABLE IF EXISTS `saldo_tipo_convites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saldo_tipo_convites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cessao_uso` int(11) NOT NULL,
  `id_tipo_convite` int(11) NOT NULL,
  `saldo` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_cessao_uso` (`id_cessao_uso`),
  KEY `id_tipo_convite` (`id_tipo_convite`),
  CONSTRAINT `saldo_tipo_convites_ibfk_1` FOREIGN KEY (`id_cessao_uso`) REFERENCES `cessao_uso` (`id`),
  CONSTRAINT `saldo_tipo_convites_ibfk_2` FOREIGN KEY (`id_tipo_convite`) REFERENCES `tipo_convites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saldo_tipo_convites`
--

LOCK TABLES `saldo_tipo_convites` WRITE;
/*!40000 ALTER TABLE `saldo_tipo_convites` DISABLE KEYS */;
/*!40000 ALTER TABLE `saldo_tipo_convites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `send_emails`
--

DROP TABLE IF EXISTS `send_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `send_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pessoa` int(10) unsigned DEFAULT NULL,
  `id_empresa` int(10) unsigned DEFAULT NULL,
  `email_enviado` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `send_emails`
--

LOCK TABLES `send_emails` WRITE;
/*!40000 ALTER TABLE `send_emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `send_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequencias`
--

DROP TABLE IF EXISTS `sequencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequencias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sequencias_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequencias`
--

LOCK TABLES `sequencias` WRITE;
/*!40000 ALTER TABLE `sequencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situacao_imoveis`
--

DROP TABLE IF EXISTS `situacao_imoveis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situacao_imoveis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `percentual_desconto` decimal(11,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `softdeleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacao_imoveis`
--

LOCK TABLES `situacao_imoveis` WRITE;
/*!40000 ALTER TABLE `situacao_imoveis` DISABLE KEYS */;
INSERT INTO `situacao_imoveis` VALUES (1,'Habitado',NULL,'2016-09-29 13:53:00','2016-09-29 13:53:00',0),(3,'Nao Habitado',NULL,'2016-09-29 13:53:01','2016-09-29 13:53:01',0),(5,'Obra Definitiva',NULL,'2016-09-29 13:53:02','2016-09-29 13:53:02',0),(7,'Obra Parada',NULL,'2016-09-29 13:53:03','2016-09-29 13:53:03',0),(9,'Terreno',NULL,'2016-09-29 13:53:04','2016-09-29 13:53:04',0),(10,'Mureta',NULL,'2016-10-26 14:38:00','2016-10-26 14:38:00',0),(11,'Obra Provisoria',NULL,'2016-10-26 14:38:00','2016-10-26 14:38:00',0),(12,'Habitado/Em Reforma',NULL,'2016-10-26 14:38:00','2016-10-26 14:38:00',0),(13,'Obra Bloqueada',NULL,'2016-10-26 14:38:00','2016-10-26 14:38:00',0),(14,'Nao Habitado/Em Reforma',NULL,'2017-03-07 22:27:00','2017-03-07 22:27:00',0);
/*!40000 ALTER TABLE `situacao_imoveis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situacao_inadimplencias`
--

DROP TABLE IF EXISTS `situacao_inadimplencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situacao_inadimplencias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idtipo_inadimplencia` int(10) unsigned NOT NULL,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `situacao_inadimplencias_descricao_unique` (`descricao`),
  KEY `situacao_inadimplencias_idtipo_inadimplencia_foreign` (`idtipo_inadimplencia`),
  CONSTRAINT `situacao_inadimplencias_idtipo_inadimplencia_foreign` FOREIGN KEY (`idtipo_inadimplencia`) REFERENCES `tipo_inadimplencias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacao_inadimplencias`
--

LOCK TABLES `situacao_inadimplencias` WRITE;
/*!40000 ALTER TABLE `situacao_inadimplencias` DISABLE KEYS */;
INSERT INTO `situacao_inadimplencias` VALUES (1,1,'INTERNA',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17');
/*!40000 ALTER TABLE `situacao_inadimplencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitacoes`
--

DROP TABLE IF EXISTS `solicitacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solicitacoes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `requerente` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `departamento` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_pedido` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `solicitacoes_id_pedido_foreign` (`id_pedido`),
  CONSTRAINT `solicitacoes_id_pedido_foreign` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitacoes`
--

LOCK TABLES `solicitacoes` WRITE;
/*!40000 ALTER TABLE `solicitacoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `solicitacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminais`
--

DROP TABLE IF EXISTS `terminais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(32) NOT NULL COMMENT 'CatracaNeokoros3',
  `descricao` varchar(32) NOT NULL,
  `id_portaria` int(11) NOT NULL,
  `direcao` int(11) NOT NULL DEFAULT 0 COMMENT '0|1',
  `sentido` varchar(8) DEFAULT NULL COMMENT 'entrada|saida',
  `ip` varchar(40) NOT NULL,
  `porta` int(11) unsigned DEFAULT NULL,
  `serie` varchar(16) DEFAULT NULL,
  `database` int(11) NOT NULL COMMENT '0|1 - indica se dados serão sincronizados com esse terminal',
  `credenciais_aceitas` int(11) NOT NULL DEFAULT 3 COMMENT '1 - codigo, 2 - validar codigo na portaria, 4 - cartao visitante; ou soma dos anteriores.',
  PRIMARY KEY (`id`),
  KEY `id_portaria` (`id_portaria`),
  CONSTRAINT `terminais_ibfk_1` FOREIGN KEY (`id_portaria`) REFERENCES `portaria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminais`
--

LOCK TABLES `terminais` WRITE;
/*!40000 ALTER TABLE `terminais` DISABLE KEYS */;
INSERT INTO `terminais` VALUES (1,'NeokorosCatraca3','catraca 1',1,0,'[NULL]','192.168.10.50',NULL,'3:0:0:29',0,4);
/*!40000 ALTER TABLE `terminais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminais_sincronismo`
--

DROP TABLE IF EXISTS `terminais_sincronismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminais_sincronismo` (
  `id_terminal` int(11) NOT NULL,
  `id_pessoa_permanente` int(11) NOT NULL,
  KEY `id_terminal` (`id_terminal`),
  KEY `id_pessoa_permanente` (`id_pessoa_permanente`),
  CONSTRAINT `terminais_sincronismo_ibfk_1` FOREIGN KEY (`id_terminal`) REFERENCES `terminais` (`id`),
  CONSTRAINT `terminais_sincronismo_ibfk_2` FOREIGN KEY (`id_pessoa_permanente`) REFERENCES `pessoa_permanente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminais_sincronismo`
--

LOCK TABLES `terminais_sincronismo` WRITE;
/*!40000 ALTER TABLE `terminais_sincronismo` DISABLE KEYS */;
/*!40000 ALTER TABLE `terminais_sincronismo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_convite_movimentacoes`
--

DROP TABLE IF EXISTS `tipo_convite_movimentacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_convite_movimentacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cessao_uso` int(11) NOT NULL,
  `id_tipo_convite` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `operacao` char(1) NOT NULL,
  `origem` varchar(255) NOT NULL,
  `id_convidado` int(10) unsigned DEFAULT NULL,
  `id_responsavel` int(10) unsigned DEFAULT NULL,
  `id_operador` int(11) DEFAULT NULL,
  `data_hora` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cessao_uso` (`id_cessao_uso`),
  KEY `id_tipo_convite` (`id_tipo_convite`),
  KEY `id_convidado` (`id_convidado`),
  KEY `id_responsavel` (`id_responsavel`),
  KEY `id_operador` (`id_operador`),
  CONSTRAINT `tipo_convite_movimentacoes_ibfk_1` FOREIGN KEY (`id_cessao_uso`) REFERENCES `cessao_uso` (`id`),
  CONSTRAINT `tipo_convite_movimentacoes_ibfk_2` FOREIGN KEY (`id_tipo_convite`) REFERENCES `tipo_convites` (`id`),
  CONSTRAINT `tipo_convite_movimentacoes_ibfk_3` FOREIGN KEY (`id_convidado`) REFERENCES `pessoa` (`id`),
  CONSTRAINT `tipo_convite_movimentacoes_ibfk_4` FOREIGN KEY (`id_responsavel`) REFERENCES `pessoa` (`id`),
  CONSTRAINT `tipo_convite_movimentacoes_ibfk_5` FOREIGN KEY (`id_operador`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_convite_movimentacoes`
--

LOCK TABLES `tipo_convite_movimentacoes` WRITE;
/*!40000 ALTER TABLE `tipo_convite_movimentacoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_convite_movimentacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_convites`
--

DROP TABLE IF EXISTS `tipo_convites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_convites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(20) NOT NULL,
  `valor` float NOT NULL,
  `por_direito` char(1) DEFAULT 'n',
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  `created` timestamp NULL DEFAULT current_timestamp(),
  `updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `quantidade_por_direito` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_convites`
--

LOCK TABLES `tipo_convites` WRITE;
/*!40000 ALTER TABLE `tipo_convites` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_convites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_credencial_acesso`
--

DROP TABLE IF EXISTS `tipo_credencial_acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_credencial_acesso` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ativo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `solicitar_validacao_portaria` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_credencial_acesso`
--

LOCK TABLES `tipo_credencial_acesso` WRITE;
/*!40000 ALTER TABLE `tipo_credencial_acesso` DISABLE KEYS */;
INSERT INTO `tipo_credencial_acesso` VALUES (1,'codigo','s','s'),(2,'digital','s','n'),(3,'rfid','n','s'),(4,'facial','s','s'),(5,'lpr','s','n');
/*!40000 ALTER TABLE `tipo_credencial_acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_documentos`
--

DROP TABLE IF EXISTS `tipo_documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_documentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_documentos`
--

LOCK TABLES `tipo_documentos` WRITE;
/*!40000 ALTER TABLE `tipo_documentos` DISABLE KEYS */;
INSERT INTO `tipo_documentos` VALUES (1,'NOTA FISCAL','2021-02-09 23:01:20','2021-02-09 23:01:20'),(2,'BOLETO','2021-02-09 23:01:20','2021-02-09 23:01:20'),(3,'RECIBO','2021-02-09 23:01:20','2021-02-09 23:01:20'),(4,'DARF','2021-02-09 23:01:20','2021-02-09 23:01:20'),(5,'TITULO','2021-02-09 23:01:20','2021-02-09 23:01:20');
/*!40000 ALTER TABLE `tipo_documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_inadimplencias`
--

DROP TABLE IF EXISTS `tipo_inadimplencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_inadimplencias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tipo_inadimplencias_descricao_unique` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_inadimplencias`
--

LOCK TABLES `tipo_inadimplencias` WRITE;
/*!40000 ALTER TABLE `tipo_inadimplencias` DISABLE KEYS */;
INSERT INTO `tipo_inadimplencias` VALUES (1,'Administrativo',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17'),(2,'Jurídico',NULL,'2021-02-09 23:01:17','2021-02-09 23:01:17');
/*!40000 ALTER TABLE `tipo_inadimplencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_lote`
--

DROP TABLE IF EXISTS `tipo_lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_lote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_lote`
--

LOCK TABLES `tipo_lote` WRITE;
/*!40000 ALTER TABLE `tipo_lote` DISABLE KEYS */;
INSERT INTO `tipo_lote` VALUES (1,'padrao',NULL,NULL);
/*!40000 ALTER TABLE `tipo_lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_perfil`
--

DROP TABLE IF EXISTS `tipo_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_perfil` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_perfil`
--

LOCK TABLES `tipo_perfil` WRITE;
/*!40000 ALTER TABLE `tipo_perfil` DISABLE KEYS */;
INSERT INTO `tipo_perfil` VALUES (1,'Associado'),(2,'Morador'),(3,'Inquilino'),(4,'Preposto');
/*!40000 ALTER TABLE `tipo_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titulos_processados`
--

DROP TABLE IF EXISTS `titulos_processados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titulos_processados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nosso_numero` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `numero_documento` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero_controle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ocorrencia` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ocorrencia_tipo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc_ocorrencia` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dt_ocorrencia` date DEFAULT NULL,
  `dt_vencimento` date DEFAULT NULL,
  `dt_pagamento` date DEFAULT NULL,
  `dt_credito` date DEFAULT NULL,
  `valor` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_tarifa` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_iof` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_abatimento` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_mora` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_multa` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `valor_desconto` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_recebido` decimal(15,2) NOT NULL DEFAULT 0.00,
  `recebimento` tinyint(1) NOT NULL DEFAULT 0,
  `id_arquivo_retorno` int(10) unsigned NOT NULL,
  `error` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `valor_juros_calculado` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_multa_calculado` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_total_calculado` decimal(15,2) NOT NULL DEFAULT 0.00,
  `valor_titulo_origem` decimal(15,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `titulos_processados_id_arquivo_retorno_foreign` (`id_arquivo_retorno`),
  CONSTRAINT `titulos_processados_id_arquivo_retorno_foreign` FOREIGN KEY (`id_arquivo_retorno`) REFERENCES `arquivo_retornos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titulos_processados`
--

LOCK TABLES `titulos_processados` WRITE;
/*!40000 ALTER TABLE `titulos_processados` DISABLE KEYS */;
/*!40000 ALTER TABLE `titulos_processados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toten`
--

DROP TABLE IF EXISTS `toten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toten` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(16) DEFAULT NULL COMMENT 'uzerway, java, morpho',
  `descricao` varchar(32) NOT NULL,
  `id_portaria` int(11) DEFAULT NULL,
  `codigo_autenticacao` varchar(16) DEFAULT NULL,
  `sentido` varchar(8) DEFAULT NULL,
  `ip` varchar(40) DEFAULT NULL,
  `porta` int(10) unsigned DEFAULT NULL,
  `acesso_por_codigo` varchar(1) DEFAULT NULL,
  `acesso_por_biometria` varchar(1) DEFAULT NULL,
  `url_config` varchar(255) DEFAULT NULL,
  `url_camera` varchar(255) DEFAULT NULL,
  `url_camera_documento` varchar(255) DEFAULT NULL,
  `id_equipamento_vinculado` int(11) DEFAULT NULL,
  `acesso_visitante` tinyint(1) NOT NULL DEFAULT 0,
  `tipos_sincronizados` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_PORTARIA` (`id_portaria`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toten`
--

LOCK TABLES `toten` WRITE;
/*!40000 ALTER TABLE `toten` DISABLE KEYS */;
INSERT INTO `toten` VALUES (1,'facial','Totem entrada',1,'101010','entrada','192.168.15.28',11028,'1','D',NULL,'http://192.168.10.80/Streaming/channels/102/preview','http://192.168.10.80/Streaming/channels/102/preview',NULL,0,NULL),(7,'morphowave','Totem saida - suporte',1,'202020','saida','192.168.10.55',11028,NULL,'D',NULL,'http://192.168.40.15/cgi-bin/mjpg/video.cgi&subtype=2',NULL,NULL,0,NULL),(9,NULL,'Totem saida visitantes',1,'303030','saida',NULL,NULL,'1','1',NULL,'http://192.168.40.18/cgi-bin/mjpg/video.cgi&subtype=2',NULL,NULL,0,NULL),(10,NULL,'Totem Entrada Visitantes',1,'404040','entrada',NULL,NULL,'1','1',NULL,'http://192.168.40.19/cgi-bin/mjpg/video.cgi&subtype=2',NULL,NULL,0,NULL),(11,'hikvision','Totem Entrada',2,'505050','entrada','192.168.10.68',11068,NULL,NULL,'http://downloads.bioacesso.net/Facial/Configuracao/hikvision-online.json',NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `toten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toten_sincronismo`
--

DROP TABLE IF EXISTS `toten_sincronismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toten_sincronismo` (
  `id_toten` int(10) unsigned NOT NULL,
  `id_pessoa_permanente` int(11) NOT NULL,
  KEY `id_toten` (`id_toten`),
  KEY `id_pessoa_permanente` (`id_pessoa_permanente`),
  CONSTRAINT `toten_sincronismo_ibfk_2` FOREIGN KEY (`id_pessoa_permanente`) REFERENCES `pessoa_permanente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toten_sincronismo`
--

LOCK TABLES `toten_sincronismo` WRITE;
/*!40000 ALTER TABLE `toten_sincronismo` DISABLE KEYS */;
INSERT INTO `toten_sincronismo` VALUES (1,9),(7,9),(9,9),(10,9),(1,9),(7,9),(9,9),(10,9),(1,9),(7,9),(9,9),(10,9),(1,9),(7,9),(9,9),(10,9),(1,9),(7,9),(9,9),(10,9),(1,10),(7,10),(9,10),(10,10),(1,11),(7,11),(9,11),(10,11),(1,12),(7,12),(9,12),(10,12),(1,13),(7,13),(9,13),(10,13),(1,14),(7,14),(9,14),(10,14),(1,15),(7,15),(9,15),(10,15),(1,16),(7,16),(9,16),(10,16),(1,17),(7,17),(9,17),(10,17),(1,18),(7,18),(9,18),(10,18),(1,7),(7,7),(9,7),(10,7),(1,15),(7,15),(9,15),(10,15),(1,8),(7,8),(9,8),(10,8),(1,19),(7,19),(9,19),(10,19),(1,20),(7,20),(9,20),(10,20),(1,7),(7,7),(9,7),(10,7),(1,21),(7,21),(9,21),(10,21),(1,22),(7,22),(9,22),(10,22),(1,23),(7,23),(9,23),(10,23),(1,24),(7,24),(9,24),(10,24),(1,25),(7,25),(9,25),(10,25),(1,26),(7,26),(9,26),(10,26),(1,27),(7,27),(9,27),(10,27),(1,28),(7,28),(9,28),(10,28),(1,29),(7,29),(9,29),(10,29),(1,10),(7,10),(9,10),(10,10),(1,5),(7,5),(9,5),(10,5),(1,30),(7,30),(9,30),(10,30),(1,31),(7,31),(9,31),(10,31),(1,32),(7,32),(9,32),(10,32),(1,33),(7,33),(9,33),(10,33),(1,34),(7,34),(9,34),(10,34),(1,35),(7,35),(9,35),(10,35),(1,36),(7,36),(9,36),(10,36),(1,37),(7,37),(9,37),(10,37),(1,38),(7,38),(9,38),(10,38),(1,39),(7,39),(9,39),(10,39),(1,40),(7,40),(9,40),(10,40),(1,41),(7,41),(9,41),(10,41),(1,42),(7,42),(9,42),(10,42),(1,43),(7,43),(9,43),(10,43),(1,44),(7,44),(9,44),(10,44),(1,45),(7,45),(9,45),(10,45);
/*!40000 ALTER TABLE `toten_sincronismo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `totens_grupos_permanentes`
--

DROP TABLE IF EXISTS `totens_grupos_permanentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `totens_grupos_permanentes` (
  `id_toten` int(11) NOT NULL,
  `id_grupo_permanente` int(11) unsigned NOT NULL,
  KEY `id_toten` (`id_toten`),
  KEY `id_grupo_permanente` (`id_grupo_permanente`),
  CONSTRAINT `totens_grupos_permanentes_ibfk_1` FOREIGN KEY (`id_toten`) REFERENCES `toten` (`id`),
  CONSTRAINT `totens_grupos_permanentes_ibfk_2` FOREIGN KEY (`id_grupo_permanente`) REFERENCES `grupo_permanente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `totens_grupos_permanentes`
--

LOCK TABLES `totens_grupos_permanentes` WRITE;
/*!40000 ALTER TABLE `totens_grupos_permanentes` DISABLE KEYS */;
/*!40000 ALTER TABLE `totens_grupos_permanentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencias`
--

DROP TABLE IF EXISTS `transferencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferencias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iddepositante` int(10) unsigned NOT NULL,
  `iddepositario` int(10) unsigned NOT NULL,
  `data` date NOT NULL,
  `valor` decimal(15,2) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transferencias_iddepositante_foreign` (`iddepositante`),
  KEY `transferencias_iddepositario_foreign` (`iddepositario`),
  CONSTRAINT `transferencias_iddepositante_foreign` FOREIGN KEY (`iddepositante`) REFERENCES `conta_bancarias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transferencias_iddepositario_foreign` FOREIGN KEY (`iddepositario`) REFERENCES `conta_bancarias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencias`
--

LOCK TABLES `transferencias` WRITE;
/*!40000 ALTER TABLE `transferencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ultima_portaria_logada`
--

DROP TABLE IF EXISTS `ultima_portaria_logada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ultima_portaria_logada` (
  `id_usuario` int(11) NOT NULL,
  `id_portaria` int(11) NOT NULL,
  `ultimo_ip` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ultima_portaria_logada`
--

LOCK TABLES `ultima_portaria_logada` WRITE;
/*!40000 ALTER TABLE `ultima_portaria_logada` DISABLE KEYS */;
INSERT INTO `ultima_portaria_logada` VALUES (1,0,'192.168.10.212','2021-02-26 16:33:36'),(3,0,'192.168.10.14','2020-07-07 09:55:09'),(4,1,'::1','2020-12-09 09:56:54');
/*!40000 ALTER TABLE `ultima_portaria_logada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_produtos`
--

DROP TABLE IF EXISTS `unidade_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidade_produtos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unidade_produtos_descricao_unique` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_produtos`
--

LOCK TABLES `unidade_produtos` WRITE;
/*!40000 ALTER TABLE `unidade_produtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `unidade_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pessoa_funcionario` int(11) DEFAULT NULL,
  `senha` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_categoria` int(11) NOT NULL,
  `ativo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL,
  `login` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,1,'bioacesso@admin',16,'s','2021-02-26 15:39:23','administrador'),(2,91,'12345678',16,'s','2020-02-12 16:52:43','vozdigital'),(3,202,'12345678',15,'s','2020-07-07 09:54:25','atend'),(4,156,'123',16,'s','2020-12-01 16:46:27','pv');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validade_acesso_permanente`
--

DROP TABLE IF EXISTS `validade_acesso_permanente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validade_acesso_permanente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_inicio` date DEFAULT NULL,
  `data_final` date DEFAULT NULL,
  `seg` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ter` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qua` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qui` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sab` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dom` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_periodo_liberacao` int(11) DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_final` time DEFAULT NULL,
  `todos_dias` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dia_todo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `acesso_expira` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `somente_portaria_servico` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_pessoa` int(10) unsigned DEFAULT NULL,
  `id_pessoa_autorizante` int(10) unsigned NOT NULL,
  `id_imovel` int(10) unsigned NOT NULL,
  `permitir_liberacao` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `permitir_cad_permanente` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `ativo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `acesso_academia` tinyint(1) NOT NULL DEFAULT 0,
  `softdeleted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_ID_PESSOA` (`id_pessoa`),
  KEY `I_ID_IMOVEL` (`id_imovel`),
  KEY `I_PESSOA_IMOVEL` (`id_pessoa`,`id_imovel`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validade_acesso_permanente`
--

LOCK TABLES `validade_acesso_permanente` WRITE;
/*!40000 ALTER TABLE `validade_acesso_permanente` DISABLE KEYS */;
INSERT INTO `validade_acesso_permanente` VALUES (1,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',5,4,1,'s','s','s',0,0,'2019-11-26 17:01:53','2020-03-11 15:09:08'),(2,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',6,4,1,'n','n','s',0,1,'2019-11-26 17:06:05','2020-01-24 13:57:45'),(3,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',5,2,2,'s','s','s',0,0,'2019-11-27 12:33:02','2020-03-11 15:09:08'),(4,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',7,4,1,'n','n','s',0,1,'2019-11-28 14:05:25','2020-01-24 13:47:55'),(5,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',8,4,1,'s','s','s',0,0,'2019-11-29 16:50:51','2020-01-24 13:58:48'),(6,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',8,5,2,'n','n','s',0,0,'2019-11-29 17:09:54','2020-01-24 13:58:48'),(7,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',13,1,2,'n','n','s',0,0,'2019-12-02 19:21:53','2020-03-11 14:49:50'),(8,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',6,25,3,'s','s','s',0,0,'2019-12-13 10:56:55','2020-03-10 20:52:27'),(10,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',7,4,1,'n','n','s',0,1,'2020-01-24 19:36:03','2020-01-24 19:37:14'),(11,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',6,2,2,'s','s','s',0,0,'2020-02-04 13:52:37','2020-03-10 20:52:27'),(12,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',114,109,8,'s','s','s',0,0,'2020-02-21 14:09:10','2020-03-03 14:37:50'),(13,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',114,66,1,'n','n','s',0,1,'2020-02-21 14:32:45','2020-02-21 14:38:24'),(14,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',114,132,5,'n','n','s',0,0,'2020-03-03 14:37:50','2020-03-03 14:37:50'),(15,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',13,131,5,'n','n','s',0,0,'2020-03-03 14:38:04','2020-03-11 14:49:50'),(16,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',138,4,1,'s','s','s',0,0,'2020-03-11 17:34:48','2020-04-29 12:01:33'),(17,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',139,4,1,'n','n','s',0,1,'2020-03-11 18:11:12','2020-06-03 23:56:49'),(18,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',157,90,10,'s','s','s',0,0,'2020-04-15 21:07:41','2020-12-15 13:28:23'),(19,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',157,156,9,'n','n','s',0,0,'2020-04-15 21:07:41','2020-12-15 13:28:23'),(20,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',157,155,11,'n','n','s',0,0,'2020-04-15 21:07:41','2020-12-15 13:28:23'),(21,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',138,2,3,'s','s','s',0,0,'2020-04-28 19:13:07','2020-04-29 12:01:33'),(22,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',166,19,14,'s','s','s',0,0,'2020-04-29 18:21:15','2020-12-02 13:22:58'),(23,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',167,19,14,'s','n','s',0,0,'2020-04-29 18:22:35','2020-12-07 19:06:41'),(24,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','s',139,2,3,'s','s','s',0,0,'2020-06-03 23:56:49','2021-02-09 16:16:45'),(25,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',189,1,3,'s','s','s',0,0,'2020-06-09 20:28:33','2020-11-26 18:40:17'),(26,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',189,4,1,'s','s','s',0,0,'2020-06-25 15:02:47','2020-11-26 18:40:17'),(27,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',202,1,3,'s','s','s',0,0,'2020-07-07 12:53:48','2020-11-26 18:35:35'),(28,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',166,164,13,'s','s','s',0,0,'2020-12-02 13:22:58','2020-12-02 13:22:58'),(29,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',228,156,9,'s','s','s',0,0,'2020-12-07 18:44:48','2020-12-09 12:21:36'),(30,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',167,156,9,'s','s','s',0,0,'2020-12-07 19:06:41','2020-12-07 19:06:41'),(31,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',228,1,3,'s','s','s',0,0,'2020-12-09 12:21:36','2020-12-09 12:21:36'),(32,NULL,NULL,'s','s','s','s','s','s','s',NULL,'00:00:00','23:59:59','s','s','n','n',157,1,3,'s','s','s',0,0,'2020-12-09 12:22:00','2020-12-15 13:28:23');
/*!40000 ALTER TABLE `validade_acesso_permanente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validade_liberacao`
--

DROP TABLE IF EXISTS `validade_liberacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validade_liberacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_inicio` date DEFAULT NULL,
  `data_final` date DEFAULT NULL,
  `seg` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ter` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qua` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qui` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sab` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dom` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_periodo_liberacao` int(11) DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_final` time DEFAULT NULL,
  `somente_hoje` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dia_todo` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_2` (`data_inicio`,`data_final`),
  KEY `I_DATA_FINAL` (`data_final`)
) ENGINE=InnoDB AUTO_INCREMENT=1630 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validade_liberacao`
--

LOCK TABLES `validade_liberacao` WRITE;
/*!40000 ALTER TABLE `validade_liberacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `validade_liberacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculo`
--

DROP TABLE IF EXISTS `veiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `veiculo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placa` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cor` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marca` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_veiculo` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_pessoa` int(11) NOT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL,
  `confirmacao_cadastro` enum('s','n','p') COLLATE utf8_unicode_ci NOT NULL DEFAULT 's',
  PRIMARY KEY (`id`),
  KEY `IDX_ID_PESSOA` (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculo`
--

LOCK TABLES `veiculo` WRITE;
/*!40000 ALTER TABLE `veiculo` DISABLE KEYS */;
INSERT INTO `veiculo` VALUES (4,'12343gf','branco','GOl',NULL,10,'2020-12-02 10:29:10','n'),(5,'54hfdkk','branco','gol',NULL,11,'2019-12-02 15:09:40','n'),(6,'adsadsa','asdasd','asd',NULL,30,'2019-12-04 10:55:11','n'),(7,'ABCAS65','654','a6s5465',NULL,1,'2021-02-17 12:20:40','s'),(8,'3333333','preto','gol',NULL,70,'2019-12-16 12:05:32','n'),(9,'nky2705','preta','suzuki',NULL,88,'2019-12-19 13:00:23','n'),(12,'GFG7tew','branco','Gol',NULL,94,'2020-02-03 12:15:45','n'),(13,'KSK1a34','sddsd','2e3dwdad',NULL,102,'2020-02-05 14:51:01','n'),(16,'PQJ7777','Preta','Mercedea',NULL,108,'2020-02-04 15:27:36','s'),(37,'NVR1515','preto','Fusca',NULL,109,'2020-02-14 08:32:08','s'),(40,'PQP5J96','preto','gol',NULL,114,'2020-03-03 11:37:50','n'),(41,'kpf0999','branco','Gol',NULL,115,'2020-11-26 15:46:01','n'),(42,'byi0000','preto','gol',NULL,116,'2020-02-28 10:44:12','n'),(43,'KSK2344','asdsd','dasd',NULL,119,'2020-02-28 11:10:30','n'),(44,'ADN1334','ddsd','adsd',NULL,122,'2020-02-28 11:48:12','n'),(45,'prq9j89','preto','Voyage',NULL,124,'2020-02-28 16:34:52','n'),(46,'prq8i88','PRETA','gol',NULL,125,'2020-02-28 16:38:15','n'),(47,'AHD2WWW','Xndj','Djdj',NULL,127,'2020-03-03 12:01:29','s'),(48,'JSSJSJS','Zjdjdj','Zjjsj',NULL,127,'2020-03-03 14:12:04','s'),(49,'ABAHSGG','Usuais','Hajejjekkkjwj',NULL,127,'2020-03-03 18:49:13','s'),(50,'bio2e33','red','gol',NULL,135,'2020-03-04 09:28:45','n'),(52,'nlk2258','branco','Fiesta',NULL,141,'2020-03-16 12:24:19','n'),(53,'nlk2258','preto','GOl',NULL,151,'2020-03-17 10:50:27','n'),(54,'NKL5434','Preto','Hb20',NULL,153,'2020-03-17 10:54:04','n'),(55,'nlk2258','Preto','Gol',NULL,147,'2020-03-17 15:27:07','n'),(56,'abc1234','asdasdsad','323233',NULL,130,'2020-03-18 11:00:52','n'),(62,'PQZ9893','Cinza','Corolla',NULL,1,'2021-02-17 12:20:40','s'),(64,'ABM2092','Branca','BMW',NULL,3,'2021-02-08 21:41:08','s'),(65,'jjj1111','gaf','dgfdgsdf',NULL,158,'2020-04-17 16:16:10','n'),(66,'PQJ7777','gsdfg','dfgvfd',NULL,136,'2021-03-01 16:07:20','n'),(103,'FFSDDDF','Dfgg','Ccgg',NULL,4,'2020-12-28 09:57:10','s'),(104,'JSJSKSK','Ejjsjs','Kekeks',NULL,19,'2021-02-25 16:12:09','s'),(105,'SJSKMSS','Skks','Memek',NULL,19,'2021-02-25 16:12:09','s'),(106,'NLK2258','Preto','Hb20',NULL,162,'2020-04-30 10:33:48','s'),(107,'adssada','sad','asd',NULL,101,'2020-04-29 09:44:37','n'),(108,'WQEQEQE','Preto','Gol Volks',NULL,4,'2020-12-28 09:57:10','p'),(112,'ASDAD23','sadad','asdsad',NULL,4,'2020-12-28 09:57:10','p'),(113,'4454554','asd','45s4d',NULL,171,'2020-06-05 14:36:28','s'),(114,'ergerge','gerg','rgwer',NULL,173,'2020-06-05 16:51:05','p'),(115,'JSJSKSK','sdsd','adasd',NULL,163,'2020-09-11 15:56:33','p'),(116,'JSJSKSK','sadsd','sdasdasd',NULL,136,'2021-03-01 16:07:20','p'),(118,'JSJSKSK','sssss','asddd',NULL,166,'2020-12-02 10:22:58','p'),(119,'JSJSKSK','adadasds','asasdadsad',NULL,178,'2020-06-09 15:38:06','p'),(120,'JSJSksk','ssdsd','sdd',NULL,179,'2020-06-09 15:45:08','p'),(121,'JSJSksk','dsdasdasd','asdasdsad',NULL,180,'2020-06-09 15:54:24','p'),(122,'JSJSksk','dadsd','dsdasds',NULL,181,'2020-06-09 16:01:02','p'),(126,'abc1010','th','ths',NULL,195,'2020-06-29 18:09:03','s'),(127,'abc1010','tht','thth',NULL,196,'2020-06-29 18:22:01','s'),(128,'WWWWWWW','dfgsdfg','sdfgvs',NULL,165,'2021-03-01 16:00:31','s'),(130,'wwwwwww','serg','arfgrg',NULL,197,'2020-06-30 17:26:42','s'),(131,'wwwwwww','sdgf','sdfgsf',NULL,198,'2020-06-30 17:32:16','s'),(132,'ABC1234','teste','teste',NULL,189,'2020-11-26 15:40:17','s'),(133,'BBB0000','branco','vw',NULL,167,'2020-12-07 16:06:41','s'),(134,'ABC1234','gsfd','dsfgsdf',NULL,202,'2020-11-26 15:35:35','s'),(135,'as12a3s','asdasd','asdasd',NULL,207,'2020-10-06 09:23:32','s'),(136,'bioaabb','red','golf',NULL,209,'2020-07-23 11:11:15','s'),(137,'sdkrguf','prata','lexus',NULL,211,'2020-07-23 12:33:01','s'),(138,'1asdasd','verde','gol/braNCO',NULL,214,'2020-09-08 14:27:36','s'),(139,'nlk2215','preto','hb20',NULL,110,'2020-09-04 11:31:00','s'),(140,'LDC5240','Branco','Gol/Volkswagen ',NULL,175,'2020-10-16 11:13:57','s'),(141,'21E3211','e12e','2e12',NULL,4,'2020-12-28 09:57:10','p'),(142,'EEWDDDD','qweqe','eqwewq',NULL,4,'2020-12-28 09:57:10','p'),(143,'NKY2705','Preta','Yes suzuky',NULL,156,'2020-12-08 14:49:31','s');
/*!40000 ALTER TABLE `veiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'bioacesso_portaria'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-01 16:12:34