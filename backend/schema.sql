-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: arl_db
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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `authorID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`authorID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Robert C. Martin','American'),(2,'Jakob Nielsen','Danish'),(3,'Andrew S. Tanenbaum','Dutch'),(4,'Donald Knuth','American'),(5,'Margaret Hamilton','American');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `bookID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `short_description` text,
  `language` varchar(10) DEFAULT 'en-US',
  `publicationDate` date DEFAULT NULL,
  `authorID` int DEFAULT NULL,
  `vendorID` int DEFAULT NULL,
  `categoryID` int DEFAULT NULL,
  PRIMARY KEY (`bookID`),
  KEY `fk_author` (`authorID`),
  KEY `fk_vendor` (`vendorID`),
  KEY `fk_category` (`categoryID`),
  CONSTRAINT `fk_author` FOREIGN KEY (`authorID`) REFERENCES `author` (`authorID`) ON DELETE SET NULL,
  CONSTRAINT `fk_category` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`) ON DELETE SET NULL,
  CONSTRAINT `fk_vendor` FOREIGN KEY (`vendorID`) REFERENCES `vendor` (`vendorID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'Clean Code','A Handbook of Agile Software Craftsmanship','en-US','2008-08-01',1,1,4),(2,'Introduction to Algorithms','The Bible of computer algorithms','en-US','2009-07-31',4,3,1),(3,'Computer Networks','A systems approach to networking','en-US','2010-10-07',3,2,1),(4,'Usability Engineering','A classic guide to user interface design','en-GB','1993-09-01',2,1,3),(5,'The Art of Computer Programming','Comprehensive volumes on programming','en-US','1968-01-01',4,5,1),(6,'Agile Principles','Practices and patterns for better software','en-US','2005-03-20',1,2,4),(7,'HCI Essentials','The 3 waves of Human-Computer Interaction','en-US','2015-11-12',2,3,3),(8,'Calculus: Early Transcendentals','Foundation for technical science','en-US','2012-01-15',5,4,2),(9,'Modern Operating Systems','Detailed concepts of OS design','en-US','2014-03-20',3,3,1),(10,'Design Thinking 101','Practical methods for UX designers','en-US','2018-05-10',2,1,3),(11,'IPv6 Configuration Guide','Mastering the next generation protocol','en-US','2021-06-30',3,5,1),(12,'The Mythical Man-Month','Essays on Software Engineering','en-GB','1975-01-01',1,2,4),(13,'Discrete Mathematics','Logic and induction for CS students','en-US','2019-09-05',4,4,2),(14,'Data Mining Concepts','Techniques for massive datasets','en-US','2011-02-18',5,5,5),(15,'UX Strategy','How to devise innovative digital products','en-US','2015-05-22',2,1,3),(16,'TCP/IP Illustrated','Visual guide to network protocols','en-US','2011-11-15',3,2,1),(17,'Refactoring','Improving the design of existing code','en-US','1999-07-08',1,3,4),(18,'Deep Learning','Neural networks and AI fundamentals','en-US','2016-11-10',5,1,5),(19,'Linear Algebra','Foundational math for data science','en-US','2017-04-01',4,4,2),(20,'Software Quality Assurance','Principles of testing and standards','en-GB','2020-08-12',1,5,4);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryID` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Computer Science','Technical books on programming and networking'),(2,'Mathematics','Calculus, Logic, and Discrete Math'),(3,'User Experience','HCI, Design Thinking, and Psychology'),(4,'Software Engineering','Methodologies like Agile and Waterfall'),(5,'Data Science','Statistics, Machine Learning, and Big Data');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'STUDENT',
  `bookID` int DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_user_book` (`bookID`),
  CONSTRAINT `fk_user_book` FOREIGN KEY (`bookID`) REFERENCES `book` (`bookID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `vendorID` int NOT NULL AUTO_INCREMENT,
  `vendorName` varchar(255) NOT NULL,
  `contactNumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vendorID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES (1,'Amazon Books','+1-800-201-7575'),(2,'O-Reilly Media','+1-707-827-7000'),(3,'Pearson Education','+44-20-7010-2000'),(4,'Local Campus Bookstore','+60-12-345-6789'),(5,'TechLibrary Online','+1-555-0199');
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-01 21:53:32
