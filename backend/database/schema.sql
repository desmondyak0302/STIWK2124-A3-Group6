CREATE DATABASE IF NOT EXISTS `arl_db`;
USE `arl_db`;

-- ------------------------------------------------------
-- 1. CLEANUP OLD TABLES
-- ------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `book`;
DROP TABLE IF EXISTS `author`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `vendor`;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------
-- 2. NEW SIMPLIFIED TABLES
-- ------------------------------------------------------

CREATE TABLE `book` (
  `bookID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `short_description` text,
  `author` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  PRIMARY KEY (`bookID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'STUDENT',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ------------------------------------------------------
-- 3. SEED DATA (Pre-filled with your flat data)
-- ------------------------------------------------------


INSERT INTO `book` (`bookID`, `title`, `short_description`, `author`, `category`) VALUES 
(1, 'Clean Code', 'A Handbook of Agile Software Craftsmanship', 'Robert C. Martin', 'Software Engineering'),
(2, 'Introduction to Algorithms', 'The Bible of computer algorithms', 'Donald Knuth', 'Computer Science'),
(3, 'Computer Networks', 'A systems approach to networking', 'Andrew S. Tanenbaum', 'Computer Science'),
(4, 'Usability Engineering', 'A classic guide to user interface design', 'Jakob Nielsen', 'User Experience'),
(5, 'The Art of Computer Programming', 'Comprehensive volumes on programming', 'Donald Knuth', 'Computer Science'),
(6, 'Agile Principles', 'Practices and patterns for better software', 'Robert C. Martin', 'Software Engineering'),
(7, 'HCI Essentials', 'The 3 waves of Human-Computer Interaction', 'Jakob Nielsen', 'User Experience'),
(8, 'Calculus: Early Transcendentals', 'Foundation for technical science', 'Margaret Hamilton', 'Mathematics'),
(9, 'Modern Operating Systems', 'Detailed concepts of OS design', 'Andrew S. Tanenbaum', 'Computer Science'),
(10, 'Design Thinking 101', 'Practical methods for UX designers', 'Jakob Nielsen', 'User Experience'),
(11, 'IPv6 Configuration Guide', 'Mastering the next generation protocol', 'Andrew S. Tanenbaum', 'Computer Science'),
(12, 'The Mythical Man-Month', 'Essays on Software Engineering', 'Robert C. Martin', 'Software Engineering'),
(13, 'Discrete Mathematics', 'Logic and induction for CS students', 'Donald Knuth', 'Mathematics'),
(14, 'Data Mining Concepts', 'Techniques for massive datasets', 'Margaret Hamilton', 'Data Science'),
(15, 'UX Strategy', 'How to devise innovative digital products', 'Jakob Nielsen', 'User Experience'),
(16, 'TCP/IP Illustrated', 'Visual guide to network protocols', 'Andrew S. Tanenbaum', 'Computer Science'),
(17, 'Refactoring', 'Improving the design of existing code', 'Robert C. Martin', 'Software Engineering'),
(18, 'Deep Learning', 'Neural networks and AI fundamentals', 'Margaret Hamilton', 'Data Science'),
(19, 'Linear Algebra', 'Foundational math for data science', 'Donald Knuth', 'Mathematics'),
(20, 'Software Quality Assurance', 'Principles of testing and standards', 'Robert C. Martin', 'Software Engineering');

INSERT INTO `user` (`username`, `email`, `password`, `role`) VALUES 
('admin', 'admin@arl.com', '$2a$10$coD18wZ/2.Yq53KsmrMshOGr6B4vXpG.7I3jS7jGcoXQzB/Y0Mym2', 'ADMIN');