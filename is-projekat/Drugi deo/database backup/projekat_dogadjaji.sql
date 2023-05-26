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
-- Table structure for table `dogadjaji`
--

DROP TABLE IF EXISTS `dogadjaji`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dogadjaji` (
  `id` int(11) NOT NULL,
  `idKorisnika` int(11) DEFAULT NULL,
  `opis` varchar(45) DEFAULT NULL,
  `iznos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dogjdjajkorisnk_idx` (`idKorisnika`),
  CONSTRAINT `dogjdjajkorisnk` FOREIGN KEY (`idKorisnika`) REFERENCES `korisnici` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dogadjaji`
--

LOCK TABLES `dogadjaji` WRITE;
/*!40000 ALTER TABLE `dogadjaji` DISABLE KEYS */;
INSERT INTO `dogadjaji` VALUES (1,4,'Uplata interneta',5),(2,7,'Uplata interneta',4),(3,7,'Uplata interneta',4),(4,7,'Uplata interneta',4),(5,7,'Uplata interneta',4),(6,14,'Uplata interneta',4),(7,8,'Uplata minuta (min)',4),(8,8,'Uplata poruka (broj poruka)',5),(9,8,'Uplata interneta (GB)',7),(10,8,'Uplata na racun (din)',20),(11,10,'Sklapanje ugovora',11),(12,17,'Sklapanje ugovora',1501),(13,17,'Uplata na racun (din)',1000),(14,17,'Uplata poruka (broj poruka)',5),(15,10,'Sklapanje ugovora',2),(16,4,'Sklapanje ugovora',1),(17,4,'Uplata minuta (min)',12),(18,4,'Uplata minuta (min)',12),(19,9,'Uplata interneta (GB)',4),(20,2,'Uplata interneta (GB)',10),(21,19,'Uplata minuta (min)',4),(22,19,'Uplata poruka (broj poruka)',5),(23,19,'Uplata interneta (GB)',19),(24,20,'Sklapanje ugovora',1502),(25,20,'Uplata na racun (din)',1000),(26,20,'Uplata minuta (min)',12),(27,20,'Uplata interneta (GB)',7),(28,21,'Sklapanje ugovora',1502),(29,21,'Uplata na racun (din)',1000),(30,21,'Uplata minuta (min)',12),(31,22,'Sklapanje ugovora',1502),(32,22,'Uplata na racun (din)',1000),(33,22,'Uplata minuta (min)',22),(34,22,'Uplata interneta (GB)',4),(35,23,'Sklapanje ugovora',11),(36,23,'Uplata minuta (min)',40),(37,23,'Uplata interneta (GB)',100),(38,23,'Uplata interneta (GB)',100),(39,23,'Uplata poruka (broj poruka)',1000),(40,23,'Uplata na racun (din)',1000),(41,23,'Uplata interneta (GB)',100),(42,24,'Sklapanje ugovora',1502),(43,24,'Uplata na racun (din)',1000),(44,24,'Uplata minuta (min)',12),(45,24,'Uplata poruka (broj poruka)',12),(46,24,'Uplata interneta (GB)',12),(47,25,'Sklapanje ugovora',1502),(48,25,'Uplata na racun (din)',1000),(49,25,'Uplata poruka (broj poruka)',22),(50,25,'Uplata minuta (min)',25),(51,25,'Uplata interneta (GB)',100),(52,26,'Sklapanje ugovora',1502),(53,26,'Uplata na racun (din)',1000),(54,26,'Uplata minuta (min)',12),(55,26,'Uplata poruka (broj poruka)',23);
/*!40000 ALTER TABLE `dogadjaji` ENABLE KEYS */;
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
