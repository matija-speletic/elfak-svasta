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
-- Table structure for table `uredjaj`
--

DROP TABLE IF EXISTS `uredjaj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uredjaj` (
  `id` int(11) NOT NULL,
  `proizvodjac` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `cena` int(11) DEFAULT NULL,
  `memorija` varchar(45) DEFAULT NULL,
  `cpu` varchar(45) DEFAULT NULL,
  `kamera` varchar(45) DEFAULT NULL,
  `kolicina` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uredjaj`
--

LOCK TABLES `uredjaj` WRITE;
/*!40000 ALTER TABLE `uredjaj` DISABLE KEYS */;
INSERT INTO `uredjaj` VALUES (0,'bez','uredjaja',0,' ',' ',' ',0),(1,'samsung','a72',570,'ram 4gb','snapdragon xx','wide+telephoto',4),(2,'apple','iphone 13',1500,'8gb ram, 256gb ufs','m1','12mp',1),(3,'apple','iphone 13',9,'8gb ram, 256gb ufs','m1','12mp',6),(4,'sgr','rgr',100,'srg','gr','wreg',5),(10,'samsung','galaxy s22',1200,'8gb',' Exynos 2200','22mpx',8);
/*!40000 ALTER TABLE `uredjaj` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-17 19:43:13
