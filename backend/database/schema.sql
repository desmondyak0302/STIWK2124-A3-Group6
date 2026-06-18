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
CREATE TABLE `author` (
  `authorID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`authorID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `author` WRITE;
INSERT INTO `author` VALUES (1,'Robert C. Martin','American'),
  (2,'Jakob Nielsen','Danish'),
  (3,'Andrew S. Tanenbaum','Dutch'),
  (4,'Donald Knuth','American'),
  (5,'Margaret Hamilton','American');
UNLOCK TABLES;

DROP TABLE IF EXISTS `book`;
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

LOCK TABLES `book` WRITE;
INSERT INTO `book` VALUES (1,'Clean Code','A Handbook of Agile Software Craftsmanship','en-US','2008-08-01',1,1,4),
  (2,'Introduction to Algorithms','The Bible of computer algorithms','en-US','2009-07-31',4,3,1),
  (3,'Computer Networks','A systems approach to networking','en-US','2010-10-07',3,2,1),
  (4,'Usability Engineering','A classic guide to user interface design','en-GB','1993-09-01',2,1,3),
  (5,'The Art of Computer Programming','Comprehensive volumes on programming','en-US','1968-01-01',4,5,1),
  (6,'Agile Principles','Practices and patterns for better software','en-US','2005-03-20',1,2,4),
  (7,'HCI Essentials','The 3 waves of Human-Computer Interaction','en-US','2015-11-12',2,3,3),
  (8,'Calculus: Early Transcendentals','Foundation for technical science','en-US','2012-01-15',5,4,2),
  (9,'Modern Operating Systems','Detailed concepts of OS design','en-US','2014-03-20',3,3,1),
  (10,'Design Thinking 101','Practical methods for UX designers','en-US','2018-05-10',2,1,3),
  (11,'IPv6 Configuration Guide','Mastering the next generation protocol','en-US','2021-06-30',3,5,1),
  (12,'The Mythical Man-Month','Essays on Software Engineering','en-GB','1975-01-01',1,2,4),
  (13,'Discrete Mathematics','Logic and induction for CS students','en-US','2019-09-05',4,4,2),
  (14,'Data Mining Concepts','Techniques for massive datasets','en-US','2011-02-18',5,5,5),
  (15,'UX Strategy','How to devise innovative digital products','en-US','2015-05-22',2,1,3),
  (16,'TCP/IP Illustrated','Visual guide to network protocols','en-US','2011-11-15',3,2,1),
  (17,'Refactoring','Improving the design of existing code','en-US','1999-07-08',1,3,4),
  (18,'Deep Learning','Neural networks and AI fundamentals','en-US','2016-11-10',5,1,5),
  (19,'Linear Algebra','Foundational math for data science','en-US','2017-04-01',4,4,2),
  (20,'Software Quality Assurance','Principles of testing and standards','en-GB','2020-08-12',1,5,4);
UNLOCK TABLES;

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `categoryID` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `category` WRITE;
INSERT INTO `category` VALUES (1,'Computer Science','Technical books on programming and networking'),
  (2,'Mathematics','Calculus, Logic, and Discrete Math'),
  (3,'User Experience','HCI, Design Thinking, and Psychology'),
  (4,'Software Engineering','Methodologies like Agile and Waterfall'),
  (5,'Data Science','Statistics, Machine Learning, and Big Data');
UNLOCK TABLES;

DROP TABLE IF EXISTS `user`;
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

LOCK TABLES `user` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `vendor`;
CREATE TABLE `vendor` (
  `vendorID` int NOT NULL AUTO_INCREMENT,
  `vendorName` varchar(255) NOT NULL,
  `contactNumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vendorID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `vendor` WRITE;
INSERT INTO `vendor` VALUES (1,'Amazon Books','+1-800-201-7575'),
  (2,'O-Reilly Media','+1-707-827-7000'),
  (3,'Pearson Education','+44-20-7010-2000'),
  (4,'Local Campus Bookstore','+60-12-345-6789'),
  (5,'TechLibrary Online','+1-555-0199');
UNLOCK TABLES;

INSERT INTO 'user' ('username','email', 'password', 'role')
VALUES ('root', 'admin@ar了.com',$2a$10$8.UnVuG9HHgffuDAlk8q6uy596HW19SYVqVpSYVpS1pC356XlW1XlW1XvTWhC','ADMIN');
