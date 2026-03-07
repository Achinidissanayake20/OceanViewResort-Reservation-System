CREATE DATABASE  IF NOT EXISTS `ocean_view_resort` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ocean_view_resort`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: ocean_view_resort
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `help_section`
--

DROP TABLE IF EXISTS `help_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_section` (
  `help_id` int NOT NULL AUTO_INCREMENT,
  `topic` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`help_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_section`
--

LOCK TABLES `help_section` WRITE;
/*!40000 ALTER TABLE `help_section` DISABLE KEYS */;
INSERT INTO `help_section` VALUES (1,'Add Reservation','To add a reservation, choose option 1. Enter the reservation number, guest details, room type, and check-in/out dates.'),(2,'View Reservation','To view reservation details, choose option 2 and enter the reservation number.'),(3,'Calculate Bill','To calculate a guest bill, choose option 3 and enter the reservation number.'),(4,'Exit System','To exit, choose option 4. Make sure all data is saved.');
/*!40000 ALTER TABLE `help_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `reservation_no` varchar(20) NOT NULL,
  `guest_name` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `room_type` enum('Single','Double','Suite') NOT NULL,
  `check_in` date DEFAULT NULL,
  `check_out` date DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  UNIQUE KEY `reservation_no` (`reservation_no`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1,'1','John Suz','123 Baker Street, London','+44 7700 900077','Suite','2026-03-10','2026-03-15'),(2,'2','Nimal Siriwardena','No 45, Galle Road, Colombo 03','0771122334','Double','2026-03-05','2026-03-07'),(3,'3','Elena Rodriguez','Madrid, Spain','+34 912 345 678','Single','2026-03-12','2026-03-14'),(4,'4','David Chen','Singapore','+65 8123 4567','Suite','2026-04-01','2026-04-10'),(5,'5','Kamal Silva','Kandy, Sri Lanka','0812233445','Double','2026-03-20','2026-03-22'),(11,'6','Shamali Siriwardena','No 45, Avissawella Road, Colombo','0771122379','Double','2026-03-10','2026-03-18'),(12,'7','Ayaa Nakashi','Hukuoka,Japan','+34 912 345 678','Single','2026-03-17','2026-03-18'),(13,'8','Madara Methamalee','Badulla','0712255465','Suite','2026-04-08','2026-04-10'),(14,'9','Sajini Piumika','Kandy, Sri Lanka','0812233445','Double','2026-03-25','2026-03-28'),(15,'10','Liam Wilson','Sydney, Australia','+61 2 9876 5432','Suite','2026-03-15','2026-03-22'),(16,'11','Priya Sharma','Mumbai, India','+91 22 1234 5678','Double','2026-03-18','2026-03-20'),(17,'12','Hans Müller','Berlin, Germany','+49 30 1122 3344','Single','2026-03-22','2026-03-25'),(18,'13','Fatima Al-Sayed','Dubai, UAE','+971 4 555 6677','Suite','2026-03-25','2026-03-30'),(19,'14','Aruni Jayawardena','Kurunegala, Sri Lanka','0372223344','Double','2026-03-28','2026-03-29'),(20,'15','Yuki Tanaka','Tokyo, Japan','+81 3 4455 6677','Single','2026-04-05','2026-04-10'),(21,'16','Robert Brown','New York, USA','+1 212 555 0199','Suite','2026-04-12','2026-04-18'),(22,'17','Kasun Perera','Negombo, Sri Lanka','0315566778','Single','2026-04-15','2026-04-16'),(23,'18','Chloe Lefebvre','Paris, France','+33 1 42 68 53 00','Double','2026-04-20','2026-04-25'),(24,'19','Min-jun Kim','Seoul, South Korea','+82 2 1588 0001','Suite','2026-05-01','2026-05-05'),(25,'20','Sanduni Fernando','Matara, Sri Lanka','0412233445','Double','2026-05-10','2026-05-12'),(26,'21','Oliver Smith','London, UK','+44 20 7946 0000','Single','2026-05-15','2026-05-20'),(27,'22','Isabella Rossi','Rome, Italy','+39 06 1234567','Double','2026-05-22','2026-05-25'),(28,'23','Nuwan Gunawardena','Jaffna, Sri Lanka','0212223344','Suite','2026-06-01','2026-06-07'),(30,'25','Shamali Siriwardana','No 100, Maliyadewa Mawatha\r\nAnuradhapura','0775721855','Single','2026-04-11','2026-04-17');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_rates`
--

DROP TABLE IF EXISTS `room_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_rates` (
  `room_type` enum('Single','Double','Suite') NOT NULL,
  `rate_per_night` decimal(10,2) NOT NULL,
  PRIMARY KEY (`room_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_rates`
--

LOCK TABLES `room_rates` WRITE;
/*!40000 ALTER TABLE `room_rates` DISABLE KEYS */;
INSERT INTO `room_rates` VALUES ('Single',110.00),('Double',150.00),('Suite',350.00);
/*!40000 ALTER TABLE `room_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin123','admin','Saman Kumara','saman@oceanview.com','0771234567'),(3,'sahan_gm','pass123','admin','Sahan Jayawardena','sahan.j@oceanview.lk','0777123456'),(5,'achini','1234','staff','Achini Dissanayake','achini0320kaveesha@gmail.com','0111234567'),(10,'admin1','123','staff','Achini Dissanayake','achini0kaveesha@gmail.com','0764450340');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-07 12:32:13
