-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: projekat
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `ugovor`
--

DROP TABLE IF EXISTS `ugovor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ugovor` (
  `id` int(11) NOT NULL,
  `datum` datetime DEFAULT NULL,
  `idKorisnika` int(11) DEFAULT NULL,
  `idPaketa` int(11) DEFAULT NULL,
  `idUredjaja` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ugovorKorisnik_idx` (`idKorisnika`),
  KEY `ugovorPaket_idx` (`idPaketa`),
  KEY `ugovorUredjaj_idx` (`idUredjaja`),
  CONSTRAINT `ugovorKorisnik` FOREIGN KEY (`idKorisnika`) REFERENCES `korisnici` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ugovorPaket` FOREIGN KEY (`idPaketa`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ugovorUredjaj` FOREIGN KEY (`idUredjaja`) REFERENCES `uredjaj` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ugovor`
--

LOCK TABLES `ugovor` WRITE;
/*!40000 ALTER TABLE `ugovor` DISABLE KEYS */;
INSERT INTO `ugovor` VALUES (1,'2022-04-29 00:48:04',2,2,1),(2,'2022-05-14 00:35:06',4,777,1),(3,'2022-05-14 00:35:30',7,2,2),(4,'2022-05-14 00:37:13',7,2,2),(11,'2022-05-14 00:48:53',8,2,0),(12,'2022-05-14 00:49:18',8,2,0),(13,'2022-05-14 01:09:42',10,777,3),(14,'2022-05-15 15:17:40',17,2,2),(15,'2022-05-15 15:28:33',10,2,1),(16,'2022-05-15 15:29:32',10,2,1),(17,'2022-05-15 18:42:12',4,2,0),(18,'2022-05-16 01:04:54',20,777,2),(19,'2022-05-16 12:36:52',21,777,2),(20,'2022-05-16 12:39:46',22,777,2),(21,'2022-05-16 12:47:03',23,777,3),(22,'2022-05-16 16:07:58',24,777,2),(23,'2022-05-17 13:19:00',25,777,2),(24,'2022-05-17 13:37:26',26,777,2);
/*!40000 ALTER TABLE `ugovor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-17 19:43:14
