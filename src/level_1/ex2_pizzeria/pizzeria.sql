CREATE DATABASE  IF NOT EXISTS `pizzeria` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pizzeria`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pizzeria
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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id_customer` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `id_locality` int NOT NULL,
  PRIMARY KEY (`id_customer`),
  KEY `fk_customer_locality1_idx` (`id_locality`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Ana','ana@email.com',1),(2,'Laura','laura@email.com',2);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id_employee` int NOT NULL,
  `nif` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `workstation` enum('delivery_driver','cook') NOT NULL,
  `id_restaurant` int NOT NULL,
  PRIMARY KEY (`id_employee`),
  KEY `fk_employee_restaurant1_idx` (`id_restaurant`),
  CONSTRAINT `fk_employee_restaurant1` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id_restaurant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'12345678P','Carlos','García','60010000','cook',1),(2,'87654321M','Javier','Medina','610000007','delivery_driver',2);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locality`
--

DROP TABLE IF EXISTS `locality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locality` (
  `id_locality` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `id_province` int NOT NULL,
  PRIMARY KEY (`id_locality`),
  KEY `fk_locality_Province_idx` (`id_province`),
  CONSTRAINT `fk_locality_Province` FOREIGN KEY (`id_province`) REFERENCES `province` (`id_province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locality`
--

LOCK TABLES `locality` WRITE;
/*!40000 ALTER TABLE `locality` DISABLE KEYS */;
INSERT INTO `locality` VALUES (1,'Barcelona',1),(2,'Girona',2);
/*!40000 ALTER TABLE `locality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id_order` int NOT NULL,
  `date` datetime NOT NULL,
  `price` double NOT NULL,
  `home_delivery` enum('yes','no') NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `id_customer` int DEFAULT NULL,
  `id_restaurant` int DEFAULT NULL,
  `id_delivery` int DEFAULT NULL,
  PRIMARY KEY (`id_order`),
  KEY `fk_order_customer1_idx` (`id_customer`),
  KEY `fk_order_restaurant1_idx` (`id_restaurant`),
  KEY `fk_order_id_delivery_idx` (`id_delivery`),
  CONSTRAINT `fk_order_customer1` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`),
  CONSTRAINT `fk_order_id_delivery` FOREIGN KEY (`id_delivery`) REFERENCES `employee` (`id_employee`),
  CONSTRAINT `fk_order_restaurant1` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id_restaurant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2026-08-01 00:00:00',25.5,'no',NULL,1,1,NULL),(2,'2026-12-09 10:00:00',32.75,'yes','2026-12-02 00:00:00',2,2,2),(3,'2026-11-02 12:00:00',6,'yes','2026-12-02 00:00:00',2,2,2);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id_product` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `images` varchar(255) NOT NULL,
  `id_product_category` int NOT NULL,
  PRIMARY KEY (`id_product`),
  KEY `fk_product_product_category1_idx` (`id_product_category`),
  CONSTRAINT `fk_product_product_category1` FOREIGN KEY (`id_product_category`) REFERENCES `product_category` (`id_product_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Pizza Margarita','Pizza with tomato and mozzarella',10.5,'pizza_margarita.jpg',1),(2,'Pizza Carbonara','Pizza with cheese, bacon and carbonara sauce',12.5,'pizza-carbonara.jpg',1),(3,'Orange Juice','Orange juice, glass bottle, 330ml',3,'orange-juice-glass.jpg',2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id_product_category` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_product_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'Pizzas'),(2,'Drinks');
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `province` (
  `id_province` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
INSERT INTO `province` VALUES (1,'Barcelona'),(2,'Girona');
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantity_product`
--

DROP TABLE IF EXISTS `quantity_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quantity_product` (
  `quantity` int NOT NULL,
  `id_order` int NOT NULL,
  `id_product` int NOT NULL,
  PRIMARY KEY (`id_product`,`id_order`),
  KEY `fk_quantity_product_order1_idx` (`id_order`),
  KEY `fk_quantity_product_product1_idx` (`id_product`),
  CONSTRAINT `fk_quantity_product_order1` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`),
  CONSTRAINT `fk_quantity_product_product1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantity_product`
--

LOCK TABLES `quantity_product` WRITE;
/*!40000 ALTER TABLE `quantity_product` DISABLE KEYS */;
INSERT INTO `quantity_product` VALUES (2,1,1),(3,2,3);
/*!40000 ALTER TABLE `quantity_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `id_restaurant` int NOT NULL,
  `address` varchar(45) NOT NULL,
  `postcode` varchar(45) NOT NULL,
  `id_locality` int NOT NULL,
  PRIMARY KEY (`id_restaurant`),
  KEY `fk_id_locality_idx` (`id_locality`),
  CONSTRAINT `fk_id_locality` FOREIGN KEY (`id_locality`) REFERENCES `locality` (`id_locality`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Carrer de Mallorca 100','08036',1),(2,'Carrer de Girona 2','08076',2);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-06 18:23:30
