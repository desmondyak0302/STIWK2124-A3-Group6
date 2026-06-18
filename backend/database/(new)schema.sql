-- Disable foreign key checks to force the cleanup[cite: 10]
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `book`;
SET FOREIGN_KEY_CHECKS = 1;

-- Create the simplified flat table[cite: 10, 16]
CREATE TABLE `book` (
  `bookID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `short_description` varchar(255),
  PRIMARY KEY (`bookID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert the full dataset using VALUES (plural)
INSERT INTO `book` (`bookID`, `title`, `author`, `category`, `short_description`) VALUES 
(1, 'Clean Code', 'Robert C. Martin', 'Software Engineering', 'A Handbook of Agile Software Craftsmanship'),
(2, 'Introduction to Algorithms', 'Donald Knuth', 'Computer Science', 'The Bible of computer algorithms'),
(3, 'Computer Networks', 'Andrew S. Tanenbaum', 'Computer Science', 'A systems approach to networking'),
(4, 'Usability Engineering', 'Jakob Nielsen', 'User Experience', 'A classic guide to user interface design'),
(5, 'The Art of Computer Programming', 'Donald Knuth', 'Computer Science', 'Comprehensive volumes on programming'),
(6, 'Agile Principles', 'Robert C. Martin', 'Software Engineering', 'Practices and patterns for better software'),
(7, 'HCI Essentials', 'Jakob Nielsen', 'User Experience', 'The 3 waves of Human-Computer Interaction'),
(8, 'Calculus: Early Transcendentals', 'Margaret Hamilton', 'Mathematics', 'Foundation for technical science'),
(9, 'Modern Operating Systems', 'Andrew S. Tanenbaum', 'Computer Science', 'Detailed concepts of OS design'),
(10, 'Design Thinking 101', 'Jakob Nielsen', 'User Experience', 'Practical methods for UX designers'),
(11, 'IPv6 Configuration Guide', 'Andrew S. Tanenbaum', 'Computer Science', 'Mastering the next generation protocol'),
(12, 'The Mythical Man-Month', 'Robert C. Martin', 'Software Engineering', 'Essays on Software Engineering'),
(13, 'Discrete Mathematics', 'Donald Knuth', 'Mathematics', 'Logic and induction for CS students'),
(14, 'Data Mining Concepts', 'Margaret Hamilton', 'Data Science', 'Techniques for massive datasets'),
(15, 'UX Strategy', 'Jakob Nielsen', 'User Experience', 'How to devise innovative digital products'),
(16, 'TCP/IP Illustrated', 'Andrew S. Tanenbaum', 'Computer Science', 'Visual guide to network protocols'),
(17, 'Refactoring', 'Robert C. Martin', 'Software Engineering', 'Improving the design of existing code'),
(18, 'Deep Learning', 'Margaret Hamilton', 'Data Science', 'Neural networks and AI fundamentals'),
(19, 'Linear Algebra', 'Donald Knuth', 'Mathematics', 'Foundational math for data science'),
(20, 'Software Quality Assurance', 'Robert C. Martin', 'Software Engineering', 'Principles of testing and standards');
