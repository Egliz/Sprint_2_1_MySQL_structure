CREATE DATABASE  IF NOT EXISTS `glasses_store` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `glasses_store`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: glasses_store
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id_address` int NOT NULL AUTO_INCREMENT,
  `street` varchar(45) NOT NULL,
  `number` int NOT NULL,
  `floor` int DEFAULT NULL,
  `door` varchar(45) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `postal_code` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`id_address`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Carrer Mallorca',120,2,'1A','Barcelona','08036','Spain'),(2,'Carrer Valencia',45,1,'2B','Barcelona','08015','Spain'),(3,'Carrer Arago',78,NULL,NULL,'Barcelona','08015','Spain'),(4,'Carrer Girona',30,3,'1A','Barcelona','08009','Spain'),(5,'Avinguda Diagonal',250,2,'2A','Barcelona','08013','Spain'),(6,'Carrer Marina',90,1,'1B','Barcelona','08018','Spain'),(7,'Carrer Mallorca',120,2,'1A','Barcelona','08036','Spain'),(8,'Carrer Valencia',45,1,'2B','Barcelona','08015','Spain'),(9,'Carrer Arago',78,NULL,NULL,'Barcelona','08015','Spain'),(10,'Carrer Girona',30,3,'1A','Barcelona','08009','Spain'),(11,'Avinguda Diagonal',250,2,'2A','Barcelona','08013','Spain'),(12,'Carrer Marina',90,1,'1B','Barcelona','08018','Spain');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `id_brand` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `id_supplier` int NOT NULL,
  PRIMARY KEY (`id_brand`),
  KEY `id_supplier` (`id_supplier`),
  CONSTRAINT `brand_ibfk_1` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Ray-Ban',1),(2,'Oakley',1),(3,'Vogue',2),(4,'Gucci',3);
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id_customer` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `id_address` int NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  `registration_date` date NOT NULL,
  `id_customer_referrer` int DEFAULT NULL,
  PRIMARY KEY (`id_customer`),
  KEY `id_address` (`id_address`),
  KEY `id_customer_referrer` (`id_customer_referrer`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`id_address`) REFERENCES `address` (`id_address`),
  CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`id_customer_referrer`) REFERENCES `customer` (`id_customer`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Laura Garcia',4,'600100001','laura@email.com','2025-01-10',NULL),(2,'Carlos Martinez',5,'600100002','carlos@email.com','2025-03-15',1),(3,'Ana Lopez',6,'600100003','ana@email.com','2025-06-20',1);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id_employee` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Maria Sanchez'),(2,'David Perez'),(3,'Laura Martin');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `glasses`
--

DROP TABLE IF EXISTS `glasses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glasses` (
  `id_glasses` int NOT NULL AUTO_INCREMENT,
  `id_brand` int NOT NULL,
  `right_prescription` double NOT NULL,
  `left_prescription` double NOT NULL,
  `frame_type` enum('floating','plastic','metal') NOT NULL,
  `frame_color` varchar(45) NOT NULL,
  `right_lens_color` varchar(45) NOT NULL,
  `left_lens_color` varchar(45) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id_glasses`),
  KEY `id_brand` (`id_brand`),
  CONSTRAINT `glasses_ibfk_1` FOREIGN KEY (`id_brand`) REFERENCES `brand` (`id_brand`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `glasses`
--

LOCK TABLES `glasses` WRITE;
/*!40000 ALTER TABLE `glasses` DISABLE KEYS */;
INSERT INTO `glasses` VALUES (1,1,-1.5,-1.25,'plastic','Black','Transparent','Transparent',120),(2,1,2,1.75,'metal','Gold','Brown','Brown',150),(3,2,-2,-2,'floating','Black','Grey','Grey',180),(4,3,1.25,1,'plastic','Red','Transparent','Transparent',110),(5,4,-0.75,-1,'metal','Gold','Green','Green',250);
/*!40000 ALTER TABLE `glasses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale` (
  `id_sale` int NOT NULL AUTO_INCREMENT,
  `id_customer` int NOT NULL,
  `id_glasses` int NOT NULL,
  `id_employee` int NOT NULL,
  `sale_date` date NOT NULL,
  PRIMARY KEY (`id_sale`),
  KEY `id_customer` (`id_customer`),
  KEY `id_glasses` (`id_glasses`),
  KEY `id_employee` (`id_employee`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`),
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`id_glasses`) REFERENCES `glasses` (`id_glasses`),
  CONSTRAINT `sale_ibfk_3` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
INSERT INTO `sale` VALUES (1,1,1,1,'2025-02-10'),(2,1,3,2,'2025-05-15'),(3,2,2,1,'2025-06-20'),(4,2,4,3,'2025-09-10'),(5,3,5,1,'2025-11-05'),(6,3,1,2,'2026-01-15');
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id_supplier` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `id_address` int NOT NULL,
  `phone` varchar(45) NOT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `nif` varchar(20) NOT NULL,
  PRIMARY KEY (`id_supplier`),
  UNIQUE KEY `id_address` (`id_address`),
  CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`id_address`) REFERENCES `address` (`id_address`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Vision Supplies',1,'933001001','933001002','B12345678'),(2,'Optical World',2,'933002001','933002002','B87654321'),(3,'Lens Distribution',3,'933003001',NULL,'B11223344');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-06 18:21:32
